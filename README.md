<div align="center">

# TaskFlow

### ⚡ The Production-Ready, Offline-First Task Management System Powered by Gemini AI & FastAPI

**A full-stack, enterprise-grade productivity app built with Flutter, FastAPI, and PostgreSQL — designed for native Arabic RTL and zero-latency offline performance.**

<br/>

[![GitHub Release](https://img.shields.io/github/v/release/mohammed-m-alhaj/taskflow?include_prereleases&style=flat-square&color=2563EB)](https://github.com/mohammed-m-alhaj/taskflow/releases)
[![GitHub Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=flat-square&color=yellow&label=⭐%20Stars)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![CI](https://github.com/mohammed-m-alhaj/taskflow/actions/workflows/ci.yml/badge.svg)](https://github.com/mohammed-m-alhaj/taskflow/actions)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=flat-square&logo=docker&logoColor=white)](docker-compose.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=flat-square&logo=sqlite&logoColor=white)](https://sqlite.org)
[![Gemini AI](https://img.shields.io/badge/Google_Gemini-AI_Enabled-8E75B2?style=flat-square&logo=googlegemini&logoColor=white)](https://aistudio.google.com)
[![Language: Arabic](https://img.shields.io/badge/Language-العربية-059669?style=flat-square)](README-AR.md)

<br/>

[📱 Download APK](#-download-apk-android) •
[✨ Why TaskFlow?](#-why-taskflow) •
[🤖 AI Task Planner](#-ai-task-planner-demo) •
[🏛️ Architecture](#-system-architecture--tech-stack) •
[🚀 Quick Start](#-quick-start-3-minutes) •
[📘 Documentation](#-documentation--manuals) •
[العربية](README-AR.md)

</div>

---

## 💡 Overview: Why TaskFlow?

Most task management apps fall into one of two extremes: they are either **basic toy projects** that lack scalability, or **cloud-only tools** that freeze when network connectivity drops.

**TaskFlow** bridges this gap as a **production-ready, full-stack productivity ecosystem**. Built for high reliability and real-world adoption, it gives users complete offline independence with a local SQLite engine, while providing seamless cloud sync with an asynchronous FastAPI and PostgreSQL server.

### Key Highlights for Users & Engineering Teams
- **⚡ 100% Offline-First (Zero Latency)**: Create, organize, schedule, and complete tasks with instant UI updates. All data is cached in SQLite (`sqflite`) and gracefully synced in the background.
- **🤖 Intelligent Dual-Engine AI**: Translates unstructured natural language goals into prioritized, date-stamped action plans with subtasks using **Google Gemini AI** (or an embedded local rule-based NLP matcher when offline).
- **🇸🇦 Native Arabic RTL Typography**: Built with first-class Right-to-Left (RTL) support and custom typography (**Thmanyah Sans**) conforming to Material 3 design tokens.
- **🛡️ Enterprise Security**: Passwords hashed with cryptographic **Bcrypt** salt; API secured via stateless **JWT** Bearer tokens with active session validation.
- **🏢 Modular Clean Architecture**: Strict separation of concerns across presentation (12 screens), state management (5 providers), and data access layers.

---

## 📲 Download APK (Android)

Get pre-built, production-ready APK packages for Android (Android 6.0+ / API 23+):

| Version | Target Architecture | File Size | Recommended For | Link |
|:---|:---:|:---:|:---|:---|
| **Optimized** | **ARM64-v8a** | **~19.4 MB** | **Most Modern Phones** (Faster download, lightweight) | [⬇️ Download APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) |
| **Universal** | **All Devices** | **~54.5 MB** | Older phones, emulators, or ARMv7/x86_64 devices | [⬇️ Download APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) |

---

## 🤖 AI Task Planner Demo

TaskFlow transforms unstructured goals into structured, actionable checklists.

```
💬 Natural Language Input:
   "Prepare for my university graduation project defense next week"

🤖 TaskFlow AI Plan:
   📌 Title: Graduation Project Defense Preparation
   🏷️ Category: Education / Study
   ⚡ Priority: High | 📅 Due Date: Next Thursday
   
   Actionable Subtasks:
   ├── [ ] Complete code freeze and run backend integration test suite
   ├── [ ] Prepare PowerPoint slides and practice project demo
   ├── [ ] Verify mobile APK installation on a test Android device
   └── [ ] Review anticipated defense committee questions and rehearse

   [ ➕ Add Plan Directly to Tasks ]
```

---

## 🏛️ System Architecture & Tech Stack

```
┌───────────────────────────────────────────────────────────────────┐
│                       📱 Flutter Mobile Client                    │
│                                                                   │
│   Screens (12)      ──► Providers (5)       ──► Services (4)      │
│   • Home / Calendar     • TaskProvider          • AiService       │
│   • AI Assistant        • AuthProvider            (Gemini/Local)  │
│   • Categories          • CategoryProvider      • ApiService      │
│   • Task Details        • ReminderProvider        (Dio / Network) │
│   • Settings            • SettingsProvider      • DbHelper (SQLite│
└─────────────────────────────────┬─────────────────────────────────┘
                                  │
                                  │ RESTful HTTP / JSON
                                  │ (Auth Interceptors + Offline Fallback)
                                  │
┌─────────────────────────────────▼─────────────────────────────────┐
│                      ⚙️ FastAPI Backend Service                   │
│                                                                   │
│   Routers:  /auth · /tasks · /subtasks · /categories · /settings  │
│   ORM:      SQLAlchemy 2.0 with PostgreSQL Psycopg 3 Driver       │
│   Schema:   Pydantic v2 Data Validation                           │
│   Security: Bcrypt Hash + Stateless JWT Tokens                    │
└───────────────────────────────────────────────────────────────────┘
```

### Technology Breakdown

| Domain | Technology | Purpose |
|:---|:---|:---|
| **Mobile Client** | **Flutter 3.x & Dart 3** | Cross-platform, high-performance UI with native RTL rendering |
| **State Management**| **Provider 6** | Predictable state flow with scoped multi-provider subscriptions |
| **Local Storage** | **SQLite (sqflite)** | Robust offline-first transactional SQL database on the device |
| **Network Client** | **Dio 5** | Interceptor-driven client handling token refreshes & network drops |
| **AI Integration** | **Google Gemini API** | Advanced NLP model decomposing user prompts into structured JSON |
| **Local AI Engine** | **Regex & Rule Matcher** | Zero-latency offline NLP fallback when internet is unavailable |
| **Backend API** | **FastAPI & Uvicorn** | High-throughput asynchronous Python web framework |
| **Database** | **PostgreSQL 14+** | Enterprise relational storage with cascading foreign keys |
| **ORM & Driver** | **SQLAlchemy 2.0 & Psycopg 3** | Type-safe query builder and database migration engine |
| **Data Validation** | **Pydantic v2** | Strict schema validation contracts across all endpoints |

---

## 🔌 RESTful API Specification

The backend provides 24 fully validated endpoints with interactive OpenAPI documentation:

| Method | Endpoint | Description |
|:---:|:---|:---|
| `POST` | `/auth/register` | Register new user account with Bcrypt password hashing |
| `POST` | `/auth/login` | Authenticate user and issue JWT bearer token |
| `GET` | `/auth/me` | Fetch authenticated user profile |
| `GET` / `POST` | `/tasks` | Retrieve user tasks or create a new task |
| `GET` / `PUT` / `DELETE`| `/tasks/{id}` | Read, update, or cascade delete a specific task |
| `GET` / `POST` | `/tasks/{id}/subtasks` | List or append subtask checklist items to a task |
| `PUT` / `DELETE` | `/subtasks/{id}` | Toggle subtask completion status or delete |
| `GET` / `POST` | `/categories` | List or create custom color-coded categories |
| `GET` / `PUT` / `DELETE`| `/categories/{id}` | Read, rename, or delete category |
| `GET` / `POST` | `/reminders` | Manage scheduled time-based alerts |
| `GET` / `PUT` | `/users/settings` | Read or update user UI preferences (theme, language) |
| `GET` | `/health` | Live health check verifying database connectivity |

---

## 🚀 Quick Start (3 Minutes)

### Option A: Run with Docker (Fastest)

```bash
docker compose up -d
```
> Automatically provisions PostgreSQL 15 and the FastAPI Backend on `http://localhost:8000`.
>
> - **Interactive Swagger Docs**: `http://localhost:8000/docs`
> - **ReDoc Documentation**: `http://localhost:8000/redoc`

### Option B: Run Locally Without Docker

#### 1. Start Backend (FastAPI + PostgreSQL)

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

> **Smart Database Auto-Init**: On startup, the backend automatically connects to PostgreSQL, creates the `taskflow` database if it doesn't exist, and verifies all 8 relational tables!

### 2. Run the Mobile App (Flutter)

```bash
flutter pub get
flutter run
```

### 3. Setup Gemini AI (Optional)

1. Obtain a free API key at [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Enter the key in the app under **Settings → AI Key**.
3. *If omitted, the app runs completely offline using its built-in local engine!*

---

## 📘 Documentation & Manuals

Comprehensive technical architecture manuals and source code references are bundled directly in the [`docs/`](docs/) directory:

- 🏛️ [TaskFlow Architecture & System Design Manual (PDF)](docs/TaskFlow_Architecture_Manual.pdf)
- 📱 [Screens, State Providers & Widgets Guide (PDF)](docs/TaskFlow_Screens_and_Providers_Guide.pdf)
- 💻 [Complete Source Code Reference (PDF)](docs/TaskFlow_Lib_Source_Code_Manual.pdf)

---

## 🧪 Testing & Verification

Execute the backend integration test suite to verify endpoints and database relations:

```bash
cd Backend
python test_backend.py
```

---

## 💼 Why Tech Recruiters & Hiring Managers Love This Project

TaskFlow is designed to demonstrate real-world, senior-level software engineering competencies:

1. **Not a Toy App**: Implements an **Offline-First Synchronization Pattern** using Dio Interceptors and local SQLite caching, solving real-world network instability.
2. **Dual-AI Resilience**: Does not break when external APIs fail — gracefully falls back to an offline rule-based NLP parser.
3. **Data Integrity**: Relational schema on PostgreSQL with `CASCADE` delete constraints, preventing orphaned database records.
4. **Clean Code & Security**: Strict Pydantic v2 validation, Bcrypt salt encryption, and stateless JWT tokens.

---

## 🤝 Contributing

Contributions, feedback, and feature suggestions are welcome!

1. Fork the repo and create your feature branch: `git checkout -b feature/cool-feature`
2. Commit your changes: `git commit -m "feat: add cool feature"`
3. Push to your branch: `git push origin feature/cool-feature`
4. Submit a **Pull Request**

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE) — free for personal, educational, and commercial use.

<br/>

<div align="center">

**If you found TaskFlow helpful, please give it a ⭐ on [GitHub](https://github.com/mohammed-m-alhaj/taskflow)! It helps more developers discover the project.**

<br/>

[![GitHub Profile](https://img.shields.io/badge/GitHub-mohammed--m--alhaj-181717?style=flat-square&logo=github)](https://github.com/mohammed-m-alhaj)
[![Report Issue](https://img.shields.io/badge/Report_Issue-red?style=flat-square&logo=github)](https://github.com/mohammed-m-alhaj/taskflow/issues)

<br/>

*Designed & engineered with precision by Mohammed M. Al-Haj*

</div>