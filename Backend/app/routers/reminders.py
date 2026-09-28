from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database import get_db
from app.models.reminder import Reminder
from app.models.task import Task
from app.models.user import User
from app.schemas.reminder import ReminderCreate, ReminderResponse
from app.services.auth_service import get_current_user

router = APIRouter(tags=["Reminders"])


@router.get("/reminders", response_model=list[ReminderResponse])
def get_all_user_reminders(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return db.query(Reminder).join(Task).filter(Task.user_id == current_user.id).order_by(Reminder.reminder_time.asc()).all()


@router.get("/tasks/{task_id}/reminders", response_model=list[ReminderResponse])
def get_reminders(
    task_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    task = db.query(Task).filter(Task.id == task_id, Task.user_id == current_user.id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    return db.query(Reminder).filter(Reminder.task_id == task_id).all()


@router.post("/tasks/{task_id}/reminders", response_model=ReminderResponse, status_code=status.HTTP_201_CREATED)
def create_reminder(
    task_id: int,
    data: ReminderCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    task = db.query(Task).filter(Task.id == task_id, Task.user_id == current_user.id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    reminder = Reminder(
        task_id=task_id,
        reminder_time=data.reminder_time,
        is_enabled=data.is_enabled
    )
    db.add(reminder)
    db.commit()
    db.refresh(reminder)
    return reminder


@router.delete("/reminders/{reminder_id}")
def delete_reminder(
    reminder_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    reminder = db.query(Reminder).join(Task).filter(
        Reminder.id == reminder_id,
        Task.user_id == current_user.id
    ).first()

    if not reminder:
        raise HTTPException(status_code=404, detail="Reminder not found")

    db.delete(reminder)
    db.commit()
    return {"success": True, "message": "Reminder deleted successfully"}
