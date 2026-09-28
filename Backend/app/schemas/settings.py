from datetime import datetime
from pydantic import BaseModel


class SettingsUpdate(BaseModel):
    theme: str | None = None
    language: str | None = None
    timezone: str | None = None
    notifications_enabled: bool | None = None


class SettingsResponse(BaseModel):
    id: int
    user_id: int
    theme: str
    language: str
    timezone: str
    notifications_enabled: bool
    created_at: datetime | None = None
    updated_at: datetime | None = None

    class Config:
        from_attributes = True
