<div align="center">

# TaskFlow

**Intelligent, offline-first task and productivity manager with AI-assisted planning.**

<br/>

[![Release](https://img.shields.io/github/v/release/mohammed-m-alhaj/taskflow?include_prereleases&style=flat-square)](https://github.com/mohammed-m-alhaj/taskflow/releases)
[![Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=flat-square&color=yellow)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=flat-square&logo=sqlite&logoColor=white)](https://sqlite.org)
[![Arabic](https://img.shields.io/badge/Language-العربية-059669?style=flat-square)](README-AR.md)

<br/>

[Download](#download) • [Features](#features) • [Quick Start](#quick-start) • [Architecture](#architecture) • [Documentation](#documentation) • [العربية](README-AR.md)

</div>

---

**TaskFlow** is a modern full-stack task management application designed for speed, native Arabic RTL support, and total offline reliability.

It stores tasks locally in SQLite for instant responsiveness, synchronizes with a FastAPI and PostgreSQL backend when connected, and uses Google Gemini AI (with an offline NLP fallback) to break high-level goals into actionable task checklists.

---

## Features

- **⚡ Offline-First**: Immediate read/write via local SQLite (`sqflite`). Works 100% without an internet connection.
- **🤖 AI Task Decomposition**: Converts natural Arabic or English prompts into structured tasks, subtasks, priorities, and deadlines using Gemini AI or an offline rule-based NLP matcher.
- **🔄 Cloud Sync & Multi-User**: FastAPI backend with PostgreSQL, JWT authentication, and Bcrypt password security.
- **📅 Calendar & Reminders**: Visual scheduling, time-based alerts, and recurrence rules.
- **🏷️ Categories & Subtasks**: Flexible categorization with custom tags and atomic step-by-step checklists.
- **🇸🇦 Native RTL & Material 3**: Fluid Arabic typography (Thmanyah Sans) with Dark/Light themes.

---

## Download

Pre-built Android APKs for the latest release:

| Build | Architecture | Size | Download |
|:---|:---:|:---:|:---|
| **Optimized** *(Recommended)* | ARM64-v8a | ~19.4 MB | [⬇️ Download APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) |
| **Universal** | All devices | ~54.5 MB | [⬇️ Download APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) |

---

## Quick Start

### 1. Backend (FastAPI + PostgreSQL)

**Requirements:** Python 3.9+, PostgreSQL 14+ running on port `5432`

```bash
cd Backend
python -m venv venv

# Windows (PowerShell):
venv\Scripts\activate
# Linux / macOS:
# source venv/bin/activate

pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

> The server automatically verifies PostgreSQL, creates the `taskflow` database, and synchronizes tables on startup.
>
> Interactive API documentation: `http://localhost:8000/docs` (Swagger) or `http://localhost:8000/redoc`.

### 2. Frontend (Flutter)

**Requirements:** Flutter SDK 3.10+ (Dart 3.x), Android device or emulator

```bash
flutter pub get
flutter run

# Build production APK:
flutter build apk --split-per-abi
```

### 3. AI Setup (Optional)

Add a free Google Gemini API key in **Settings → AI Key**. When omitted or offline, TaskFlow automatically uses its embedded local NLP engine.

---

## Architecture

```
Flutter Client (12 Screens · 5 Providers · 4 Services)
      │
      ├── Local SQLite DB (Offline zero-latency persistence)
      │
      └── REST API (Dio) ──► FastAPI Backend ──► PostgreSQL (taskflow)
                                 │
                            JWT Auth · SQLAlchemy 2.0 · Pydantic v2
```

### Core Stack

| Layer | Technologies |
|---|---|
| **Client** | Flutter 3, Dart 3, Material Design 3, RTL native |
| **State** | Provider 6 (MultiProvider pattern) |
| **Local DB** | SQLite (`sqflite`) — 100% offline persistence |
| **Networking** | Dio 5 with Auth interceptors & offline fallback |
| **AI** | Google Gemini API + embedded local rule-based NLP |
| **Backend** | FastAPI, Uvicorn, SQLAlchemy 2.0, Psycopg 3 |
| **Database** | PostgreSQL 14+ with foreign key cascades |
| **Auth** | Stateless JWT tokens, Bcrypt password hashing |

---

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/auth/register` | Register user & hash password |
| `POST` | `/auth/login` | Login & receive JWT access token |
| `GET` | `/auth/me` | Fetch authenticated user profile |
| `GET` / `POST` | `/tasks` | List or create tasks |
| `GET` / `PUT` / `DELETE` | `/tasks/{id}` | Retrieve, update, or delete a task |
| `GET` / `POST` | `/tasks/{id}/subtasks` | List or add task subtasks |
| `PUT` / `DELETE` | `/subtasks/{id}` | Update or delete a subtask |
| `GET` / `POST` | `/categories` | List or create categories |
| `GET` / `PUT` / `DELETE` | `/categories/{id}` | Category operations |
| `GET` | `/reminders` | List active reminders |
| `POST` | `/tasks/{id}/reminders` | Schedule reminder for a task |
| `DELETE` | `/reminders/{id}` | Remove reminder |
| `GET` / `PUT` | `/users/settings` | Get or update user preferences |
| `GET` | `/health` | Server and database health check |

---

## Documentation

Comprehensive architecture manuals, screen breakdowns, and source code guides are available in [`docs/`](docs/):

- 📘 [TaskFlow Architecture Manual](docs/TaskFlow_Architecture_Manual.pdf)
- 📱 [Screens and Providers Guide](docs/TaskFlow_Screens_and_Providers_Guide.pdf)
- 💻 [Source Code Reference Guide](docs/TaskFlow_Lib_Source_Code_Manual.pdf)

---

## Testing

Run the automated integration test suite:

```bash
cd Backend
python test_backend.py
```

---

## Contributing

Contributions are welcome!

1. Fork the repository
2. Create your branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m "feat: add amazing feature"`)
4. Push to your branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

<br/>

<div align="center">

**Enjoying TaskFlow? Give it a ⭐ on [GitHub](https://github.com/mohammed-m-alhaj/taskflow)!**

</div>