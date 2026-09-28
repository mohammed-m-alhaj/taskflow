from datetime import datetime
from pydantic import BaseModel


class SubtaskCreate(BaseModel):
    title: str
    is_completed: bool = False


class SubtaskUpdate(BaseModel):
    title: str | None = None
    is_completed: bool | None = None


class SubtaskResponse(BaseModel):
    id: int
    task_id: int
    title: str
    is_completed: bool
    created_at: datetime | None = None
    updated_at: datetime | None = None

    class Config:
        from_attributes = True
