import os
import psycopg
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "2911")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME", "taskflow")

SERVER_URL = os.getenv(
    "SERVER_URL",
    f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/postgres"
)
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    f"postgresql+psycopg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)


def create_database():
    print("=" * 60)
    print("                 TaskFlow Backend")
    print("=" * 60)
    print("[INFO] Checking PostgreSQL connection...")

    with psycopg.connect(SERVER_URL, autocommit=True) as connection:
        print("[OK] Connected to PostgreSQL")

        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT 1 FROM pg_database WHERE datname = %s",
                (DB_NAME,)
            )

            if cursor.fetchone():
                print(f'[OK] Database "{DB_NAME}" already exists')
            else:
                print(f'[INFO] Database "{DB_NAME}" does not exist')
                cursor.execute(f'CREATE DATABASE "{DB_NAME}"')
                print(f'[OK] Database "{DB_NAME}" created successfully')


create_database()

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(
    bind=engine,
    autocommit=False,
    autoflush=False
)

Base = declarative_base()


def get_db():
    with SessionLocal() as db:
        yield db