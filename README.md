<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=32&pause=1000&color=2563EB&center=true&vCenter=true&width=600&lines=TaskFlow+%F0%9F%9A%80;Smart+Task+Manager;Powered+by+AI+%E2%9C%A8;Flutter+%2B+FastAPI" alt="TaskFlow" />

# TaskFlow — تطبيق إدارة المهام الذكي

<p>
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/FastAPI-1.0.0-009688?style=for-the-badge&logo=fastapi&logoColor=white" />
  <img src="https://img.shields.io/badge/Gemini_AI-Powered-4285F4?style=for-the-badge&logo=google&logoColor=white" />
  <img src="https://img.shields.io/badge/SQLite-Local_DB-003B57?style=for-the-badge&logo=sqlite&logoColor=white" />
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" />
</p>

<p>
  <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" />
  <img src="https://img.shields.io/badge/Language-Arabic_UI-red?style=flat-square" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square" />
</p>

> **تطبيق موبايل متكامل لإدارة المهام بذكاء اصطناعي — يجمع بين بساطة الاستخدام وقوة التقنية**

</div>

---

## 📖 نبذة عن المشروع

**TaskFlow** هو تطبيق أندرويد مبني بـ Flutter يمكّنك من تنظيم مهامك اليومية بكفاءة عالية. يتميز بمساعد ذكاء اصطناعي مدمج يعمل بنموذج **Google Gemini**، ويدعم العمل أونلاين وأوفلاين معاً عبر قاعدة بيانات **SQLite** محلية.

المشروع مبني بمعمارية **Full-Stack** حقيقية:
- 📱 **Frontend** — Flutter (Dart) مع دعم RTL وعرض عربي كامل
- ⚙️ **Backend** — FastAPI (Python) مع RESTful API منظمة

---

## ✨ المميزات الرئيسية

| الأيقونة | الميزة | الوصف |
|----------|--------|-------|
| 🤖 | **مساعد AI ذكي** | يولّد خطط مهام مفصّلة باستخدام Gemini API، مع وضع احتياطي محلي عند انعدام الاتصال |
| 📋 | **إدارة مهام متكاملة** | إنشاء مهام مع مهام فرعية، أولويات، تواريخ استحقاق، وتكرار تلقائي |
| 🗂️ | **تصنيفات مخصصة** | إنشاء تصنيفات ملونة لتنظيم مهامك بشكل بصري واضح |
| 📅 | **عرض تقويمي** | شاشة تقويم تفاعلية تعرض المهام بحسب التاريخ |
| 🔔 | **تذكيرات ذكية** | نظام تذكيرات متكامل مربوط بكل مهمة |
| 🌙 | **الوضع المظلم** | دعم كامل للثيم الداكن والفاتح مع حفظ التفضيلات |
| 🔍 | **بحث وتصفية** | بحث فوري بالنص وفلترة حسب الحالة والأولوية |
| 📴 | **يعمل بدون إنترنت** | قاعدة بيانات SQLite محلية للعمل في أي وقت |
| 🔐 | **نظام مصادقة** | تسجيل دخول وتسجيل حساب مع إدارة الجلسة |

---

## 🏗️ معمارية المشروع

```
TaskFlow/
├── 📱 lib/                           # Flutter Frontend
│   ├── main.dart                     # نقطة الدخول + MultiProvider
│   ├── screens/                      # شاشات التطبيق (12 شاشة)
│   │   ├── splash_screen.dart        # شاشة البداية
│   │   ├── login_screen.dart         # تسجيل الدخول
│   │   ├── register_screen.dart      # إنشاء حساب
│   │   ├── home_screen.dart          # الشاشة الرئيسية
│   │   ├── add_task_screen.dart      # إضافة مهمة
│   │   ├── task_detail_screen.dart   # تفاصيل المهمة
│   │   ├── ai_assistant_screen.dart  # مساعد الذكاء الاصطناعي
│   │   ├── calendar_screen.dart      # التقويم
│   │   ├── categories_screen.dart    # التصنيفات
│   │   ├── notifications_screen.dart # الإشعارات
│   │   ├── settings_screen.dart      # الإعدادات
│   │   └── profile_screen.dart       # الملف الشخصي
│   ├── providers/                    # State Management (Provider)
│   │   ├── auth_provider.dart
│   │   ├── task_provider.dart
│   │   ├── category_provider.dart
│   │   ├── reminder_provider.dart
│   │   └── settings_provider.dart
│   ├── services/                     # Business Logic & APIs
│   │   ├── ai_service.dart           # Gemini AI Integration
│   │   ├── api_service.dart          # HTTP Client (Dio)
│   │   ├── database_helper.dart      # SQLite Local DB
│   │   └── storage_service.dart      # SharedPreferences
│   ├── models/                       # Data Models
│   │   ├── task.dart
│   │   ├── subtask.dart
│   │   ├── category.dart
│   │   └── reminder.dart
│   └── widgets/                      # Reusable Widgets
│
└── ⚙️ Backend/                       # FastAPI Backend
    └── app/
        ├── main.py                   # FastAPI App Entry
        ├── database.py               # SQLAlchemy Config
        ├── models/                   # ORM Models
        ├── schemas/                  # Pydantic Schemas
        ├── routers/                  # API Endpoints
        │   ├── auth.py               # /auth/*
        │   ├── tasks.py              # /tasks/*
        │   ├── subtasks.py           # /subtasks/*
        │   ├── categories.py         # /categories/*
        │   ├── reminders.py          # /reminders/*
        │   └── settings.py           # /settings/*
        └── services/                 # Business Logic
```

---

## 🛠️ التقنيات المستخدمة

### 📱 Frontend (Flutter)

| التقنية | الإصدار | الاستخدام |
|---------|---------|-----------|
| **Flutter** | 3.x | إطار تطوير التطبيق |
| **Dart** | 3.x | لغة البرمجة |
| **Provider** | ^6.1.5 | إدارة الحالة |
| **Dio** | ^5.11.1 | HTTP Client |
| **sqflite** | ^2.4.3 | قاعدة البيانات المحلية |
| **shared_preferences** | ^2.5.5 | التخزين المحلي |
| **flutter_localizations** | SDK | دعم RTL والعربية |
| **shimmer** | ^4.0.0 | تأثيرات التحميل |
| **intl** | ^0.20.2 | تنسيق التواريخ |
| **Thmanyah Font** | - | الخط العربي المخصص |

### ⚙️ Backend (Python)

| التقنية | الاستخدام |
|---------|-----------|
| **FastAPI** | إطار API |
| **SQLAlchemy** | ORM لقاعدة البيانات |
| **Pydantic** | التحقق من البيانات |
| **Uvicorn** | ASGI Server |

### 🤖 AI

| التقنية | الاستخدام |
|---------|-----------|
| **Google Gemini API** | توليد خطط المهام الذكية |
| **Local AI Engine** | وضع احتياطي بدون إنترنت |

---

## 🚀 تشغيل المشروع

### المتطلبات الأساسية

```bash
flutter --version   # يجب أن يكون 3.x أو أحدث
python --version    # يجب أن يكون 3.9+
```

### 📱 تشغيل تطبيق Flutter

```bash
# 1. استنسخ المشروع
git clone https://github.com/YOUR_USERNAME/taskflow.git
cd taskflow

# 2. ثبّت الحزم
flutter pub get

# 3. شغّل التطبيق
flutter run

# أو بناء APK للأندرويد
flutter build apk --release
```

### ⚙️ تشغيل Backend

```bash
# انتقل لمجلد الباكند
cd Backend

# أنشئ بيئة افتراضية
python -m venv venv
venv\Scripts\activate      # Windows
# source venv/bin/activate  # Linux/macOS

# ثبّت المتطلبات
pip install fastapi uvicorn sqlalchemy pydantic

# شغّل الخادم
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

> بعد التشغيل، افتح التوثيق التفاعلي على: **http://localhost:8000/docs**

---

## 📲 التحميل المباشر

| النسخة | الحجم | التفاصيل |
|--------|-------|---------|
| 📦 **Mobile Optimized APK** | ~19 MB | نسخة محسّنة للهواتف |
| 📦 **Universal APK** | ~55 MB | نسخة تدعم جميع المعماريات |

---

## 🔌 API Endpoints

| الطريقة | المسار | الوصف |
|---------|--------|-------|
| `POST` | `/auth/register` | تسجيل حساب جديد |
| `POST` | `/auth/login` | تسجيل الدخول |
| `GET` | `/tasks/` | جلب جميع المهام |
| `POST` | `/tasks/` | إنشاء مهمة |
| `PUT` | `/tasks/{id}` | تحديث مهمة |
| `DELETE` | `/tasks/{id}` | حذف مهمة |
| `GET` | `/tasks/{id}/subtasks` | المهام الفرعية |
| `GET` | `/categories/` | جلب التصنيفات |
| `POST` | `/reminders/` | إنشاء تذكير |
| `GET` | `/settings/` | إعدادات المستخدم |
| `GET` | `/health` | فحص حالة الخادم |

---

## 🤖 كيف يعمل مساعد الذكاء الاصطناعي؟

```
المستخدم يكتب طلباً
        ↓
AiService.processMessage()
        ↓
    هل يوجد Gemini API Key؟
   ↙                        ↘
 نعم                          لا
  ↓                            ↓
Gemini API                Local Smart Engine
(Google Cloud)            (بدون إنترنت)
  ↓                            ↓
  └──────→ خطة مهام مفصّلة ←──┘
                ↓
      يُعرض على المستخدم
                ↓
  يمكنه إضافة المهمة مباشرة للتطبيق
```

---

## 📊 هيكل قاعدة البيانات

```sql
Users           -- الحسابات والمصادقة
Tasks           -- المهام (مع الأولوية والتكرار)
Subtasks        -- المهام الفرعية
Categories      -- التصنيفات الملونة
Reminders       -- التذكيرات
RecurrenceRules -- قواعد التكرار التلقائي
CalendarEvents  -- أحداث التقويم
UserSettings    -- إعدادات المستخدم (الثيم، اللغة)
```

---

## 🗂️ هيكل State Management

```dart
// MultiProvider في main.dart
MultiProvider(
  providers: [
    AuthProvider,      // المصادقة وبيانات المستخدم
    TaskProvider,      // المهام والفلترة والبحث
    CategoryProvider,  // التصنيفات الملونة
    ReminderProvider,  // التذكيرات
    SettingsProvider,  // الثيم (داكن/فاتح) والإعدادات
  ],
)
```

---

## 🤝 المساهمة

المساهمات مرحّب بها دائماً! اتبع هذه الخطوات:

```bash
# 1. Fork المشروع من GitHub
# 2. أنشئ branch جديد
git checkout -b feature/amazing-feature

# 3. Commit تعديلاتك
git commit -m "feat: Add amazing feature"

# 4. Push للـ branch
git push origin feature/amazing-feature

# 5. افتح Pull Request
```

---

## 📋 خارطة الطريق

- [ ] 🌐 دعم اللغة الإنجليزية
- [ ] 📊 إحصائيات الإنتاجية والتقارير
- [ ] 🔄 مزامنة السحابة الكاملة
- [ ] 📌 Widget للشاشة الرئيسية
- [ ] 🍎 دعم iOS
- [ ] 🤖 تحسينات AI بنماذج Gemini أحدث

---

## 📄 الرخصة

هذا المشروع مرخّص تحت **MIT License** — يمكنك الاستخدام والتعديل والتوزيع بحرية.

---

<div align="center">

**صُنع بـ ❤️ وكثير من ☕**

[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github)](https://github.com/YOUR_USERNAME)
[![Email](https://img.shields.io/badge/Email-Contact-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:your@email.com)

---

*إذا أفادك هذا المشروع، لا تنسَ أن تعطيه ⭐ على GitHub!*

</div>
