from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.models.user import User
from app.models.user_settings import UserSettings
from app.schemas.settings import SettingsResponse, SettingsUpdate
from app.services.auth_service import get_current_user

router = APIRouter(prefix="/users/settings", tags=["Settings"])


@router.get("", response_model=SettingsResponse)
def get_user_settings(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    settings = db.query(UserSettings).filter(UserSettings.user_id == current_user.id).first()
    if not settings:
        settings = UserSettings(
            user_id=current_user.id,
            theme="light",
            language="ar",
            timezone="UTC",
            notifications_enabled=True
        )
        db.add(settings)
        db.commit()
        db.refresh(settings)

    return settings


@router.put("", response_model=SettingsResponse)
def update_user_settings(
    data: SettingsUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    settings = db.query(UserSettings).filter(UserSettings.user_id == current_user.id).first()
    if not settings:
        settings = UserSettings(
            user_id=current_user.id,
            theme="light",
            language="ar",
            timezone="UTC",
            notifications_enabled=True
        )
        db.add(settings)
        db.commit()
        db.refresh(settings)

    update_data = data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(settings, key, value)

    db.commit()
    db.refresh(settings)
    return settings
