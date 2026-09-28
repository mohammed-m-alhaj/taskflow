import sys
sys.stdout.reconfigure(encoding='utf-8')
from app.database import SessionLocal
from app.models.task import Task
from app.models.user import User

db = SessionLocal()
tasks = db.query(Task).all()
print(f"Total tasks in PostgreSQL: {len(tasks)}")
for t in tasks:
    user = db.query(User).filter(User.id == t.user_id).first()
    user_email = user.email if user else "unknown"
    print(f"ID: {t.id} | User: {user_email} (ID={t.user_id}) | Title: {t.title} | Priority: {t.priority} | Status: {t.status} | Due: {t.due_date} | Completed: {t.is_completed}")
db.close()
