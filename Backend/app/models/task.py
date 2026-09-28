from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func

from app.database import Base


class Task(Base):
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    category_id = Column(Integer, ForeignKey("categories.id", ondelete="SET NULL"), nullable=True)
    title = Column(String(200), nullable=False)
    description = Column(Text, nullable=True)
    priority = Column(String(20), nullable=False, default="medium")
    status = Column(String(20), nullable=False, default="pending")
    due_date = Column(DateTime(timezone=True), nullable=True)
    is_completed = Column(Boolean, nullable=False, default=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    user = relationship("User", back_populates="tasks")
    category = relationship("Category", back_populates="tasks")

    subtasks = relationship(
        "Subtask",
        back_populates="task",
        cascade="all, delete-orphan"
    )

    recurrence_rule = relationship(
        "RecurrenceRule",
        back_populates="task",
        uselist=False,
        cascade="all, delete-orphan"
    )

    reminders = relationship(
        "Reminder",
        back_populates="task",
        cascade="all, delete-orphan"
    )

    calendar_event = relationship(
        "CalendarEvent",
        back_populates="task",
        uselist=False,
        cascade="all, delete-orphan"
    )
