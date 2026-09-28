<div align="center">

<img src="screenshots/hero.jpg" alt="TaskFlow — Intelligent Task & Productivity Manager" width="100%"/>

<br/><br/>

<h1>⚡ TaskFlow</h1>
<h3>Intelligent, Offline-First Task & Productivity Manager powered by Google Gemini AI & FastAPI</h3>

<br/>

[![Download APK](https://img.shields.io/badge/⬇️_Download-APK_Direct-2563EB?style=for-the-badge&logo=android&logoColor=white)](https://github.com/mohammed-m-alhaj/taskflow/releases/latest)
[![Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=for-the-badge&color=yellow&label=⭐_Stars)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)
[![Arabic Version](https://img.shields.io/badge/العربية-README--AR.md-059669?style=for-the-badge)](README-AR.md)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://sqlite.org)
[![Gemini AI](https://img.shields.io/badge/Google_Gemini-AI_Enabled-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)](https://aistudio.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

<br/>

**Organize goals, break complex projects into actionable steps, and track daily progress effortlessly — online or completely offline.**

<br/>

[📱 Download](#-download-apk-android) •
[✨ Key Features](#-key-features) •
[🤖 AI Assistant](#1--hybrid-ai-task-planner-gemini--local-nlp) •
[🏛️ Architecture](#-system-architecture--tech-stack) •
[🔌 API Endpoints](#-restful-api-specification) •
[🚀 Quick Start](#-quick-start-local-setup) •
[💼 For Tech Interviews](#-engineering-highlights--interview-cheat-sheet)

</div>

---

## 🎯 Overview

**TaskFlow** is a modern, production-grade **Full-Stack productivity application** tailored for native Arabic RTL support with an **Offline-First architecture**. 

Unlike standard to-do applications that fail when disconnected from the internet, TaskFlow persists all tasks, categories, and reminders directly into a high-performance local **SQLite** database. When online, it seamlessly syncs with a **FastAPI** backend backed by **PostgreSQL** with secure **JWT** authentication.

### Why TaskFlow Stands Out
- 🇸🇦 **Native Arabic RTL Design**: Built from the ground up for Arabic typography (**Thmanyah Sans**) and seamless RTL layout across all 12 screens.
- 🧠 **Dual-Engine AI Task Decomposition**: Powered by **Google Gemini API** for structured JSON task breakdown, with an automated **Local Rule-Based NLP Fallback Engine** that works with zero internet connectivity.
- ⚡ **Zero-Latency Offline-First**: Immediate UI response with optimistic local storage and background synchronization.
- 🛡️ **Enterprise-Grade Security**: Bcrypt password hashing and stateless JWT bearer tokens with expiration handling.

---

## 📲 Download APK (Android)

> **Supports Android 6.0 (API 23) and higher.**

| Variant | Target Architecture | Size | Recommendation |
|:-------|:-------------------:|:----:|:---------------|
| [⬇️ **Optimized Build**](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) | **ARM64-v8a** | **~19.4 MB** | **Recommended** — for 95%+ of modern smartphones (smaller size, fast install) |
| [⬇️ **Universal Build**](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) | **Universal (All)** | **~54.5 MB** | For older devices or ARMv7/x86_64 architectures |

#### Installation in 3 Steps:
1. Download the APK file matching your device above.
2. Open the downloaded file from your file manager and tap **Install**.
3. If prompted, enable **"Allow installation from this source"** in device security settings, then launch **TaskFlow** 🚀

---

## ✨ Key Features

<div align="center">
  <img src="screenshots/features.jpg" alt="TaskFlow Core Features" width="100%"/>
</div>

<br/>

### 1. 🤖 Hybrid AI Task Planner (Gemini + Local NLP)
Type any goal or unstructured thought in natural language (Arabic or English), and the AI instantly generates a structured action plan:
- Automatically detects title, category, priority level, and due date.
- Decomposes the high-level goal into an actionable checklist of subtasks.
- **One-Click Import**: Add the generated plan directly to your task list.
- **Offline Resilience**: Automatically falls back to the embedded local NLP engine when offline.

```
💬 AI Interaction Demo:

User Input:
  "I want to prepare for my Cloud Computing final exam next Thursday"

TaskFlow AI Output:
  📌 Title: Prepare for Cloud Computing Final Exam
  🏷️ Category: Study
  ⚡ Priority: High | 📅 Due Date: Next Thursday
  
  Actionable Subtasks:
  ├── [ ] Review service architectures summary (IaaS, PaaS, SaaS)
  ├── [ ] Solve practice exams and past questions for chapters 1-4
  ├── [ ] Summarize VPC, security groups, and IAM policies
  └── [ ] Final comprehensive revision and adequate sleep before exam day

  [ ➕ Add Plan Directly to My Tasks ]
```

### 2. ⚡ Offline-First Architecture (SQLite)
- Complete offline capability via **SQLite (sqflite)**. Create, update, toggle, and delete tasks anywhere without network dependency.

### 3. 🔄 Scalable Cloud Backend (FastAPI + PostgreSQL)
- High-performance RESTful API built with **FastAPI** and **SQLAlchemy 2.0**.
- Relational integrity, cascade deletion, and multi-user isolation on **PostgreSQL**.
- Secure authentication via **JWT** tokens and **Bcrypt** password hashing.

### 4. 📅 Interactive Calendar & Scheduling
- Visual calendar view mapping tasks to scheduled days.
- Local and cloud-synced reminders for crucial deadlines.
- Extensible recurrence engine for recurring daily, weekly, and monthly tasks.

### 5. 🏷️ Custom Categories & Checklists
- Color-coded categories (Work, Study, Personal, Shopping, Health).
- Subtasks with instant completion checkboxes and progress tracking.

### 6. 🎨 Polished Material 3 Experience
- Automatic Dark Mode and Light Mode support.
- Modern Arabic font (**Thmanyah Sans**) with shimmer loading states.

---

## 🏛️ System Architecture & Tech Stack

```
┌───────────────────────────────────────────────────────────────────────────────────┐
│                                 📱 FLUTTER CLIENT                                 │
│                                                                                   │
│  Presentation Layer (12 Screens):                                                 │
│  Splash · Login · Register · Home · TaskDetail · AddTask · AIAssistant            │
│  Calendar · Categories · Notifications · Profile · Settings                       │
│                                      │                                            │
│  State Management Layer (5 Providers):                                            │
│  • AuthProvider       • TaskProvider       • CategoryProvider                     │
│  • ReminderProvider   • SettingsProvider                                          │
│                                      │                                            │
│  Service & Data Layer (4 Services):                                               │
│  ┌───────────────────────┬─────────────────────────┬───────────────────────────┐  │
│  │   AiService           │    ApiService           │   DatabaseHelper          │  │
│  │   (Gemini + Local)    │    (Dio + Interceptors) │   (SQLite / Local DB)     │  │
│  └───────────────────────┴────────────┬────────────┴───────────────────────────┘  │
│                                       │ StorageService (Tokens / SharedPreferences)│
└───────────────────────────────────────┼───────────────────────────────────────────┘
                                        │
                                        │ HTTPS / JSON (RESTful API)
                                        │
┌───────────────────────────────────────▼───────────────────────────────────────────┐
│                              ⚙️ FASTAPI BACKEND                                   │
│                                                                                   │
│  Routers & Endpoints:                                                             │
│  • /auth              ── Register, Login, JWT verification, Current User (/me)    │
│  • /tasks             ── Full CRUD, Filtering, Ordering                          │
│  • /tasks/{id}/subtasks── Subtasks bound to parent task with cascade lifecycle    │
│  • /categories        ── User-isolated custom categories                          │
│  • /reminders         ── Scheduled time-based reminders                           │
│  • /users/settings    ── Theme, Language, and Notification preferences            │
│                                                                                   │
│  Domain & Persistence Layer:                                                      │
│  • Pydantic v2        ── Strict payload validation & serialization contracts      │
│  • SQLAlchemy 2.0 ORM ── Atomic transactions & relational modeling                │
│  • Psycopg 3 Driver   ── High-throughput binary PostgreSQL connection             │
│  • Database Auto-Init ── Automated database & table provisioning on startup       │
└───────────────────────────────────────────────────────────────────────────────────┘
```

### Technology Breakdown

| Component | Technology | Rationale & Responsibility |
|:----------|:-----------|:---------------------------|
| **Frontend Framework** | **Flutter 3.x (Dart 3)** | Native 60fps performance, excellent RTL rendering, and cross-platform readiness |
| **State Management** | **Provider 6** | Lightweight MultiProvider pattern avoiding unnecessary widget tree rebuilds |
| **Local Database** | **SQLite (sqflite)** | Robust embedded SQL database ensuring zero-latency and 100% offline uptime |
| **Networking** | **Dio 5** | Interceptors for automated token injection and graceful network failure handling |
| **Cloud AI** | **Google Gemini API** | High-precision Arabic NLP understanding with structured JSON schema output |
| **Local AI Engine** | **Rule-Based Matcher** | Deterministic fallback planner when network or API key is unavailable |
| **Backend Framework** | **FastAPI** | High-throughput asynchronous Python web framework with auto-generated OpenAPI docs |
| **ORM & Relational DB** | **SQLAlchemy 2.0 + PostgreSQL** | Strict relational integrity with foreign keys and cascade delete rules |
| **DB Driver** | **Psycopg 3** | Latest PostgreSQL adapter for modern Python applications |
| **Data Validation** | **Pydantic v2** | Type-safe request/response validation schemas |
| **Authentication** | **JWT + Bcrypt (Passlib)** | Stateless, secure bearer token architecture |

---

## 🗄️ Database Schema & Entity Relationships

The schema is normalized across both SQLite (client-side) and PostgreSQL (server-side) across 8 core relational entities:

```sql
┌──────────────┐       1:N       ┌──────────────┐       1:N       ┌──────────────┐
│    users     ├────────────────>│    tasks     ├────────────────>│   subtasks   │
└──────┬───────┘                 └──────┬───────┘                 └──────────────┘
       │                                │
       │ 1:N                            │ 1:N
       ├───────────────┐                ├───────────────┐
       │               │                │               │
       ▼               ▼                ▼               ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│  categories  │ │user_settings │ │  reminders   │ │recurrence_r. │
└──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘
       ▲                                │
       │ 1:N                            │ 1:N
       └────────────────────────────────┴───────────────> ┌──────────────┐
                                                          │calendar_event│
                                                          └──────────────┘
```

1. **`users`**: User identity records (`id`, `name`, `email`, `password_hash`, `created_at`).
2. **`tasks`**: Master task entity (`title`, `description`, `priority`, `status`, `due_date`, `category_id`, `is_completed`).
3. **`subtasks`**: Step-by-step checklist items linked to `tasks` via foreign key with `CASCADE` delete.
4. **`categories`**: User-scoped classification labels with unique color codes.
5. **`reminders`**: Scheduled time alerts associated with specific tasks.
6. **`recurrence_rules`**: Frequency rules for repeated tasks (daily, weekly, monthly).
7. **`calendar_events`**: Date-mapped events synchronized with the calendar module.
8. **`user_settings`**: 1:1 user preferences (`theme`, `language`, `timezone`, `notifications_enabled`).

---

## 🔌 RESTful API Specification

All protected endpoints require an `Authorization: Bearer <token>` header:

| Endpoint | Method | Description |
|:---------|:------:|:------------|
| `POST /auth/register` | `POST` | Register a new user with Bcrypt password hashing |
| `POST /auth/login` | `POST` | Authenticate and obtain JWT Bearer access token |
| `GET /auth/me` | `GET` | Retrieve authenticated user profile |
| `GET /tasks` | `GET` | List all tasks for current user, ordered by creation date |
| `POST /tasks` | `POST` | Create a new task with priority and optional category |
| `GET /tasks/{id}` | `GET` | Get details for a specific task |
| `PUT /tasks/{id}` | `PUT` | Update task fields or toggle completion status |
| `DELETE /tasks/{id}` | `DELETE` | Delete task and cascade delete its subtasks & reminders |
| `GET /tasks/{id}/subtasks` | `GET` | List all subtasks for a specific parent task |
| `POST /tasks/{id}/subtasks` | `POST` | Create a subtask linked to a parent task |
| `PUT /subtasks/{id}` | `PUT` | Update subtask title or toggle completion |
| `DELETE /subtasks/{id}` | `DELETE` | Delete a specific subtask |
| `GET /categories` | `GET` | List all categories created by current user |
| `POST /categories` | `POST` | Create a new custom category |
| `GET /categories/{id}` | `GET` | Get details of a single category |
| `PUT /categories/{id}` | `PUT` | Update category name |
| `DELETE /categories/{id}` | `DELETE` | Delete category |
| `GET /reminders` | `GET` | Fetch all upcoming reminders for current user |
| `POST /tasks/{id}/reminders` | `POST` | Schedule a reminder for a specific task |
| `DELETE /reminders/{id}` | `DELETE` | Cancel / delete a reminder |
| `GET /users/settings` | `GET` | Get current user UI and notification preferences |
| `PUT /users/settings` | `PUT` | Update user settings (theme, language, timezone) |
| `GET /health` | `GET` | Health check endpoint verifying database connectivity |
| `GET /` | `GET` | Root greeting and API status confirmation |

---

## 🚀 Quick Start (Local Setup)

### Prerequisites
- **Flutter SDK**: `3.10+` (Dart 3.x)
- **Python**: `3.9+` (Tested on Python 3.11)
- **PostgreSQL**: `14+` running locally on port `5432`

---

<details>
<summary><b>⚙️ 1. Setup & Run FastAPI Backend</b> — Click to expand</summary>

```bash
# 1. Navigate to the backend directory
cd Backend

# 2. Create and activate a virtual environment
python -m venv venv

# Windows (PowerShell):
venv\Scripts\activate
# Linux / macOS:
# source venv/bin/activate

# 3. Install verified dependencies
pip install -r requirements.txt

# 4. Start the development server
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

> **Automatic DB Provisioning:** On launch, the server automatically verifies the PostgreSQL connection, creates the `taskflow` database if it does not exist, and synchronizes all tables.
>
> **Interactive API Docs:**
> - Swagger UI: `http://localhost:8000/docs`
> - ReDoc UI: `http://localhost:8000/redoc`

</details>

<details>
<summary><b>📱 2. Setup & Run Flutter Client</b> — Click to expand</summary>

```bash
# 1. Return to project root
cd ..

# 2. Install Flutter packages
flutter pub get

# 3. Run on connected device or emulator
flutter run

# 4. Build release APKs:
flutter build apk --split-per-abi   # Lightweight optimized APK
flutter build apk --release          # Universal APK
```

</details>

<details>
<summary><b>🤖 3. Enable Google Gemini AI</b> — Click to expand</summary>

1. Get a free API key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Launch **TaskFlow** on your phone or emulator.
3. Navigate to **Settings → AI API Key**.
4. Paste your key and tap **Save**.
5. *Note:* If no key is provided, TaskFlow smoothly continues operating using its **embedded local NLP engine**.

</details>

---

## 🧪 Automated Verification & Testing

The repository contains an end-to-end integration test suite verifying all database relations, cascade operations, and endpoints:

```bash
cd Backend
python test_backend.py
```

Test coverage includes:
- `GET /` and `GET /health` server connectivity verification.
- CRUD lifecycle of users, tasks, subtasks, and categories.
- Relational foreign key constraints and cascade deletions.

---

## 💼 Engineering Highlights & Interview Cheat Sheet

Key architectural decisions to discuss in technical interviews:

1. **How is Offline-First achieved?**
   - The application applies a **Repository Pattern** inside `TaskProvider`. All user mutations write immediately to local **SQLite**, ensuring zero UI latency. `ApiService` synchronizes changes with FastAPI in the background using `Dio Interceptors` to gracefully handle network drops without blocking the user.
2. **How does the Dual-Engine AI work?**
   - `AiService` evaluates network connectivity and key availability. When online, it sends structured prompts to **Google Gemini** requiring strict JSON output. When offline, it automatically routes through a local rule-based NLP matcher using regex patterns to parse dates, categories, priorities, and standard subtasks.
3. **How is user data secured?**
   - Passwords are never stored in plaintext; they are hashed with `Bcrypt` with cryptographic salt. Sessions use stateless `JWT Bearer` tokens with expiration timestamps, stored securely via `SharedPreferences`.
4. **How are orphaned records prevented?**
   - The relational schema implements explicit `ondelete="CASCADE"` constraints between `tasks` and `subtasks`, guaranteeing that child items are purged atomically when a parent task is deleted.

---

## 🗺️ Roadmap

- [x] ✅ Full Flutter Client (12 production screens).
- [x] ✅ Full Arabic RTL support with Thmanyah font & Material 3.
- [x] ✅ Offline-First SQLite local persistence.
- [x] ✅ Dual-engine AI (Gemini API + Local Rule-based NLP).
- [x] ✅ FastAPI backend with PostgreSQL and JWT authentication.
- [x] ✅ Categories, reminders, and subtask management.
- [ ] 📊 Weekly productivity analytics and progress charts.
- [ ] 🔄 Background synchronization worker.
- [ ] 📌 Android Home Screen Widget.
- [ ] 🍏 iOS deployment and testing.
- [ ] 🌐 English UI localization toggle in settings.

---

## 🤝 Contributing

Contributions are welcome! To contribute:

1. **Fork** the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m "feat: Add AmazingFeature"`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a **Pull Request**.

- 🐛 **Report a bug:** [Open an Issue](https://github.com/mohammed-m-alhaj/taskflow/issues)
- 💡 **Request a feature:** [Submit Feature Request](https://github.com/mohammed-m-alhaj/taskflow/issues/new)

---

## 📄 License

This project is licensed under the **MIT License** — feel free to use, modify, and distribute it. See the [LICENSE](LICENSE) file for details.

---

<div align="center">

**If TaskFlow helped you or serves as a great reference — consider starring ⭐ the repository!**

<br/>

[![GitHub Profile](https://img.shields.io/badge/GitHub-mohammed--m--alhaj-181717?style=for-the-badge&logo=github)](https://github.com/mohammed-m-alhaj)
&nbsp;
[![Report Issue](https://img.shields.io/badge/Report_Issue-red?style=for-the-badge&logo=github)](https://github.com/mohammed-m-alhaj/taskflow/issues)

<br/>

*Built with passion ❤️ using Flutter · FastAPI · PostgreSQL · Google Gemini*

</div>