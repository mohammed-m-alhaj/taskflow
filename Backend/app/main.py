from fastapi import FastAPI
from sqlalchemy import inspect

from app.database import Base, engine, create_database
from app.models import (
    User,
    UserSettings,
    Category,
    Task,
    Subtask,
    RecurrenceRule,
    Reminder,
    CalendarEvent
)
from app.routers.auth import router as auth_router
from app.routers.tasks import router as tasks_router
from app.routers.subtasks import router as subtasks_router
from app.routers.settings import router as settings_router
from app.routers.reminders import router as reminders_router
from app.routers.categories import router as categories_router

app = FastAPI(
    title="TaskFlow API",
    version="1.0.0"
)

app.include_router(auth_router)
app.include_router(tasks_router)
app.include_router(subtasks_router)
app.include_router(settings_router)
app.include_router(reminders_router)
app.include_router(categories_router)


@app.on_event("startup")
def startup():
    print("=" * 60)
    print("                 TaskFlow Backend")
    print("=" * 60)

    create_database()

    Base.metadata.create_all(bind=engine)

    tables = inspect(engine).get_table_names()

    print("[OK] Database connection verified")
    print('[OK] Database: "taskflow"')
    print(f"[OK] Tables found: {len(tables)}")

    for table in tables:
        print(f"[OK] Table created/verified: {table}")

    print("[OK] TaskFlow backend started")
    print("=" * 60)


@app.get("/")
def root():
    return {
        "success": True,
        "message": "TaskFlow API is running"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }