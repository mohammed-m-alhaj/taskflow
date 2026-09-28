from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base


class CalendarEvent(Base):
    __tablename__ = "calendar_events"

    id = Column(Integer, primary_key=True, index=True)
    task_id = Column(Integer, ForeignKey("tasks.id", ondelete="CASCADE"), unique=True, nullable=False)
    provider = Column(String(30), nullable=False)
    external_event_id = Column(String(255), nullable=False, unique=True)
    synced_at = Column(DateTime(timezone=True), server_default=func.now())

    task = relationship("Task", back_populates="calendar_event")
