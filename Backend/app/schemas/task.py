from datetime import datetime
from pydantic import BaseModel, ConfigDict


class TaskCreate(BaseModel):
    title: str
    description: str | None = None
    priority: str = "medium"
    status: str = "pending"
    due_date: datetime | None = None
    category_id: int | None = None


class TaskUpdate(BaseModel):
    title: str | None = None
    description: str | None = None
    priority: str | None = None
    status: str | None = None
    due_date: datetime | None = None
    category_id: int | None = None
    is_completed: bool | None = None


class TaskResponse(BaseModel):
    id: int
    user_id: int
    category_id: int | None
    title: str
    description: str | None
    priority: str
    status: str
    due_date: datetime | None
    is_completed: bool

    model_config = ConfigDict(from_attributes=True)
