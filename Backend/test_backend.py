import sys
import time
from datetime import datetime, timezone
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.database import SessionLocal, engine, Base
from app.main import app, startup
from app.models import (
    User,
    UserSettings,
    Category,
    Task,
    Subtask,
    RecurrenceRule,
    Reminder,
    CalendarEvent,
)


def test_api_endpoints():
    print("\n--- [1] Testing API Endpoints ---")
    with TestClient(app) as client:
        response = client.get("/")
        assert response.status_code == 200, f"Expected 200, got {response.status_code}"
        data = response.json()
        assert data["success"] is True
        assert data["message"] == "TaskFlow API is running"
        print("[PASS] GET / -> 200 OK with valid response")

        response = client.get("/health")
        assert response.status_code == 200, f"Expected 200, got {response.status_code}"
        assert response.json()["status"] == "healthy"
        print("[PASS] GET /health -> 200 OK healthy")


def test_database_models_and_relationships():
    print("\n--- [2] Testing Database Models & Relationships (1:1, 1:N, Cascades) ---")
    startup()

    db: Session = SessionLocal()
    test_email = f"test_runner_{int(time.time())}@taskflow.test"

    try:
        user = User(
            name="Test Engineer",
            email=test_email,
            password_hash="hashed_secret_123"
        )
        db.add(user)
        db.commit()
        db.refresh(user)
        assert user.id is not None
        print(f"[PASS] User created with ID={user.id}, Email={user.email}")

        settings = UserSettings(
            user=user,
            theme="dark",
            language="ar",
            timezone="Asia/Riyadh",
            notifications_enabled=True
        )
        db.add(settings)
        db.commit()
        db.refresh(user)
        assert user.settings is not None
        assert user.settings.theme == "dark"
        assert user.settings.user.name == "Test Engineer"
        print("[PASS] User -> UserSettings (1:1) relationship verified")

        cat_work = Category(name="Work", user=user)
        cat_personal = Category(name="Personal", user=user)
        db.add_all([cat_work, cat_personal])
        db.commit()
        db.refresh(user)
        assert len(user.categories) == 2
        category_names = [c.name for c in user.categories]
        assert "Work" in category_names and "Personal" in category_names
        print(f"[PASS] User -> Categories (1:N) verified with {len(user.categories)} categories: {category_names}")

        task1 = Task(
            title="Complete Flutter MCP Integration",
            description="Integrate Dart MCP and verify API communication",
            priority="high",
            status="in_progress",
            due_date=datetime.now(timezone.utc),
            user=user,
            category=cat_work
        )
        task2 = Task(
            title="Buy groceries",
            description="Milk, eggs, coffee",
            priority="low",
            status="pending",
            user=user,
            category=cat_personal
        )
        db.add_all([task1, task2])
        db.commit()
        db.refresh(user)
        assert len(user.tasks) == 2
        print(f"[PASS] User -> Tasks (1:N) verified with {len(user.tasks)} tasks")

        sub1 = Subtask(title="Check Dart MCP schema", task=task1)
        sub2 = Subtask(title="Run analyze_files", is_completed=True, task=task1)
        db.add_all([sub1, sub2])
        db.commit()
        db.refresh(task1)
        assert len(task1.subtasks) == 2
        print(f"[PASS] Task -> Subtasks (1:N) verified with {len(task1.subtasks)} subtasks")

        rec = RecurrenceRule(
            task=task1,
            frequency="daily",
            interval_value=1,
            start_date=datetime.now(timezone.utc)
        )
        db.add(rec)
        db.commit()
        db.refresh(task1)
        assert task1.recurrence_rule is not None
        assert task1.recurrence_rule.frequency == "daily"
        print(f"[PASS] Task -> RecurrenceRule (1:1) verified (freq={task1.recurrence_rule.frequency})")

        rem1 = Reminder(task=task1, reminder_time=datetime.now(timezone.utc), is_enabled=True)
        rem2 = Reminder(task=task1, reminder_time=datetime.now(timezone.utc), is_enabled=False)
        db.add_all([rem1, rem2])
        db.commit()
        db.refresh(task1)
        assert len(task1.reminders) == 2
        print(f"[PASS] Task -> Reminders (1:N) verified with {len(task1.reminders)} reminders")

        cal = CalendarEvent(
            task=task1,
            provider="google_calendar",
            external_event_id=f"gcal_evt_{user.id}_{task1.id}"
        )
        db.add(cal)
        db.commit()
        db.refresh(task1)
        assert task1.calendar_event is not None
        assert task1.calendar_event.provider == "google_calendar"
        print(f"[PASS] Task -> CalendarEvent (1:1) verified (provider={task1.calendar_event.provider})")

        user_id = user.id
        db.delete(user)
        db.commit()

        assert db.query(User).filter(User.id == user_id).first() is None
        assert db.query(UserSettings).filter(UserSettings.user_id == user_id).first() is None
        assert db.query(Category).filter(Category.user_id == user_id).first() is None
        assert db.query(Task).filter(Task.user_id == user_id).first() is None
        print("[PASS] User delete cascade verified: All related settings, categories, and tasks deleted")

    finally:
        db.close()


def test_security_isolation():
    print("\n--- [3] Testing Cross-User Security & Resource Isolation ---")
    startup()

    with TestClient(app) as client:
        unauth_resp = client.get("/tasks")
        assert unauth_resp.status_code == 401
        print("[PASS] Unauthenticated request to /tasks returned 401")

        ts = int(time.time() * 1000)
        email_a = f"user_a_{ts}@example.com"
        email_b = f"user_b_{ts}@example.com"

        reg_a = client.post("/auth/register", json={"name": "User A", "email": email_a, "password": "passwordA123"})
        assert reg_a.status_code == 200
        login_a = client.post("/auth/login", json={"email": email_a, "password": "passwordA123"})
        token_a = login_a.json()["access_token"]
        headers_a = {"Authorization": f"Bearer {token_a}"}

        reg_b = client.post("/auth/register", json={"name": "User B", "email": email_b, "password": "passwordB123"})
        assert reg_b.status_code == 200
        login_b = client.post("/auth/login", json={"email": email_b, "password": "passwordB123"})
        token_b = login_b.json()["access_token"]
        headers_b = {"Authorization": f"Bearer {token_b}"}

        cat_a = client.post("/categories", json={"name": "Cat A"}, headers=headers_a).json()
        task_a = client.post("/tasks", json={"title": "Task A", "priority": "high", "category_id": cat_a["id"]}, headers=headers_a).json()
        sub_a = client.post(f"/tasks/{task_a['id']}/subtasks", json={"title": "Sub A"}, headers=headers_a).json()
        rem_a = client.post(f"/tasks/{task_a['id']}/reminders", json={"reminder_time": "2026-10-01T12:00:00Z"}, headers=headers_a).json()

        assert client.get(f"/tasks/{task_a['id']}", headers=headers_b).status_code == 404
        assert client.put(f"/tasks/{task_a['id']}", json={"title": "Hacked"}, headers=headers_b).status_code == 404
        assert client.delete(f"/tasks/{task_a['id']}", headers=headers_b).status_code == 404
        print("[PASS] User B cannot read, update, or delete User A's Task")

        assert client.get(f"/tasks/{task_a['id']}/subtasks", headers=headers_b).status_code == 404
        assert client.post(f"/tasks/{task_a['id']}/subtasks", json={"title": "Illegal"}, headers=headers_b).status_code == 404
        assert client.put(f"/subtasks/{sub_a['id']}", json={"title": "Hacked Sub"}, headers=headers_b).status_code == 404
        assert client.delete(f"/subtasks/{sub_a['id']}", headers=headers_b).status_code == 404
        print("[PASS] User B cannot read, create, update, or delete User A's Subtasks")

        assert client.get(f"/tasks/{task_a['id']}/reminders", headers=headers_b).status_code == 404
        assert client.post(f"/tasks/{task_a['id']}/reminders", json={"reminder_time": "2026-10-02T12:00:00Z"}, headers=headers_b).status_code == 404
        assert client.delete(f"/reminders/{rem_a['id']}", headers=headers_b).status_code == 404
        print("[PASS] User B cannot read, create, or delete User A's Reminders")

        assert client.get(f"/categories/{cat_a['id']}", headers=headers_b).status_code == 404
        assert client.put(f"/categories/{cat_a['id']}", json={"name": "Hacked Cat"}, headers=headers_b).status_code == 404
        assert client.delete(f"/categories/{cat_a['id']}", headers=headers_b).status_code == 404
        print("[PASS] User B cannot read, update, or delete User A's Category")

        assert client.post("/tasks", json={"title": "Illegal Task", "category_id": cat_a["id"]}, headers=headers_b).status_code == 404
        print("[PASS] User B cannot associate task with User A's category")

        settings_b = client.get("/users/settings", headers=headers_b).json()
        assert settings_b["theme"] == "light"
        client.put("/users/settings", json={"theme": "dark"}, headers=headers_b)
        settings_a = client.get("/users/settings", headers=headers_a).json()
        assert settings_a["theme"] == "light"
        print("[PASS] UserSettings strictly isolated between User A and User B")

        me_a = client.get("/auth/me", headers=headers_a).json()
        me_b = client.get("/auth/me", headers=headers_b).json()
        assert me_a["email"] == email_a
        assert me_b["email"] == email_b
        print("[PASS] /auth/me returns authenticated user data correctly")


if __name__ == "__main__":
    print("=" * 60)
    print("      TaskFlow Backend & Database Verification Suite")
    print("=" * 60)
    try:
        test_api_endpoints()
        test_database_models_and_relationships()
        test_security_isolation()
        print("\n" + "=" * 60)
        print(" [SUCCESS] ALL BACKEND & DATABASE TESTS PASSED 100%!")
        print("=" * 60)
    except Exception as e:
        print(f"\n[FAIL] Test encountered error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        sys.exit(1)
