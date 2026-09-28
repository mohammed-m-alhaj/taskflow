from datetime import datetime
from pydantic import BaseModel


class ReminderCreate(BaseModel):
    reminder_time: datetime
    is_enabled: bool = True


class ReminderResponse(BaseModel):
    id: int
    task_id: int
    reminder_time: datetime
    is_enabled: bool
    created_at: datetime | None = None

    class Config:
        from_attributes = True
