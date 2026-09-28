from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database import get_db
from app.models.subtask import Subtask
from app.models.task import Task
from app.models.user import User
from app.schemas.subtask import SubtaskCreate, SubtaskResponse, SubtaskUpdate
from app.services.auth_service import get_current_user

router = APIRouter(tags=["Subtasks"])


@router.get("/tasks/{task_id}/subtasks", response_model=list[SubtaskResponse])
def get_subtasks(
    task_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    task = db.query(Task).filter(Task.id == task_id, Task.user_id == current_user.id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    return db.query(Subtask).filter(Subtask.task_id == task_id).order_by(Subtask.created_at.asc()).all()


@router.post("/tasks/{task_id}/subtasks", response_model=SubtaskResponse, status_code=status.HTTP_201_CREATED)
def create_subtask(
    task_id: int,
    data: SubtaskCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    task = db.query(Task).filter(Task.id == task_id, Task.user_id == current_user.id).first()
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")

    subtask = Subtask(
        task_id=task_id,
        title=data.title,
        is_completed=data.is_completed
    )
    db.add(subtask)
    db.commit()
    db.refresh(subtask)
    return subtask


@router.put("/subtasks/{subtask_id}", response_model=SubtaskResponse)
def update_subtask(
    subtask_id: int,
    data: SubtaskUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    subtask = db.query(Subtask).join(Task).filter(
        Subtask.id == subtask_id,
        Task.user_id == current_user.id
    ).first()

    if not subtask:
        raise HTTPException(status_code=404, detail="Subtask not found")

    update_data = data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(subtask, key, value)

    db.commit()
    db.refresh(subtask)
    return subtask


@router.delete("/subtasks/{subtask_id}")
def delete_subtask(
    subtask_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    subtask = db.query(Subtask).join(Task).filter(
        Subtask.id == subtask_id,
        Task.user_id == current_user.id
    ).first()

    if not subtask:
        raise HTTPException(status_code=404, detail="Subtask not found")

    db.delete(subtask)
    db.commit()
    return {"success": True, "message": "Subtask deleted successfully"}
