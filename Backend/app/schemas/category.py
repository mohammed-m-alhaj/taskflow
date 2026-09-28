from datetime import datetime
from pydantic import BaseModel, ConfigDict


class CategoryCreate(BaseModel):
    name: str


class CategoryUpdate(BaseModel):
    name: str


class CategoryResponse(BaseModel):
    id: int
    user_id: int
    name: str
    created_at: datetime | None = None

    model_config = ConfigDict(from_attributes=True)
