<div align="center">

<img src="screenshots/hero.jpg" alt="TaskFlow — تطبيق إدارة المهام والإنتاجية الذكي" width="100%"/>

<br/><br/>

<h1>⚡ TaskFlow</h1>
<h3>تطبيق إدارة المهام والإنتاجية الذكي — عربي كامل — مدعوم بالذكاء الاصطناعي — Offline-First</h3>

<br/>

[![Download APK](https://img.shields.io/badge/⬇️_تحميل_التطبيق-APK_مباشر-2563EB?style=for-the-badge&logo=android&logoColor=white)](https://github.com/mohammed-m-alhaj/taskflow/releases/latest)
[![Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=for-the-badge&color=yellow&label=⭐_النجوم)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)
[![English Version](https://img.shields.io/badge/English-README.md-2563EB?style=for-the-badge)](README.md)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://sqlite.org)
[![Gemini AI](https://img.shields.io/badge/Google_Gemini-AI_Enabled-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)](https://aistudio.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

<br/>

**نظّم أهدافك، قسّم مشاريعك لمهام تنفيذية، وتابع إنجازك اليومي بسلاسة فائقة — سواء كنت متصلاً بالإنترنت أو في وضع الأوفلاين التام.**

<br/>

[📱 تحميل التطبيق](#-تحميل-التطبيق-مباشرة-android) •
[✨ المميزات الرئيسية](#-المميزات-الرئيسية) •
[🤖 مساعد الذكاء الاصطناعي](#1--مساعد-الذكاء-الاصطناعي-ai-task-assistant) •
[🏛️ المعمارية الهندسية](#-المعمارية-الهندسية-والقرارات-التقنية-architecture) •
[🔌 نقاط الـ API](#-دليل-نقاط-النهاية-للـ-api-restful-endpoints) •
[🚀 التشغيل المحلي](#-التشغيل-المحلي-quick-start) •
[💼 للمقابلات التقنية](#-دليل-المقابلات-التقنية-technical-interview-highlights)

</div>

---

<div dir="rtl">

## 🎯 نظرة عامة على المشروع (Executive Summary)

**TaskFlow** هو تطبيق إنتاجية وإدارة مهام حديث مبني وفق معمارية برمجية إنتاجية احترافية (**Production-Grade Full-Stack Architecture**). تم تصميمه خصيصاً ليحل معضلة شائعة في تطبيقات الإنتاجية العربية: **الاعتماد الكلي على الاتصال السحابي**.

يعتمد التطبيق نمط **أولوية العمل دون إنترنت (Offline-First)**؛ حيث تحفظ جميع المهام والتصنيفات والتذكيرات محلياً في قاعدة بيانات **SQLite** فائقة السرعة على الهاتف، مع توفير خادم سحابي مبني بـ **FastAPI** وقاعدة بيانات **PostgreSQL** للمزامنة والمصادقة وتعدد الأجهزة.

### لماذا يعتبر TaskFlow نموذجاً برمجياً مميزاً؟
- 🇸🇦 **تجربة عربية أصلية بالكامل**: اتجاه كامل من اليمين لليسار (RTL Native)، مع خط طباعي حديث عالي المقروئية (**Thmanyah Sans**).
- 🧠 **محرك ذكاء اصطناعي ثنائي (Hybrid AI Engine)**: يربط مع **Google Gemini API** لتحليل الأهداف وتوليد خطط عمل تنفيذية، ويحتوي على **محرك NLP محلي ذكي** مدمج يعمل تلقائياً دون إنترنت.
- ⚡ **أداء عالي واستهلاك منخفض للموارد**: واجهات Material 3 خفيفة، وتأثيرات Shimmer سلسة، واستجابة فورية دون شاشات انتظار بيضاء.
- 🛡️ **أمان متكامل**: تشفير لكلمات المرور عبر خوارزمية **Bcrypt** وإصدار توكنات وصول مشفرة عبر **JWT**.

---

## 📲 تحميل التطبيق مباشرة (Android)

> **متوافق مع جميع أجهزة أندرويد بنظام Android 6.0 (API 23) فما فوق.**

| النسخة | المعمارية المدعومة | الحجم | متى تختارها؟ |
|:-------|:-------------------:|:-----:|:-------------|
| [⬇️ **النسخة الخفيفة (Optimized)**](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) | **ARM64-v8a** | **~19.4 MB** | **الخيار الموصى به** — لمعظم الهواتف الحديثة، خفيفة وسريعة التثبيت |
| [⬇️ **النسخة الشاملة (Universal)**](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) | **Universal (All)** | **~54.5 MB** | للأجهزة الأقدم أو التي تعمل بمعالجات ARMv7 أو x86_64 |

### خطوات التثبيت في 30 ثانية:
1. اضغط على رابط النسخة المناسبة لجهازك أعلاه لبدء التحميل.
2. افتح الملف من مجلد التنزيلات (Downloads) في جهازك.
3. اضغط على **تثبيت (Install)** — في حال ظهر تحذير أمني اضغط **السماح بالتثبيت من هذا المصدر**.
4. افتح **TaskFlow** وابدأ تنظيم يومك فوراً بدون أي تعقيد 🚀

---

## ✨ المميزات الرئيسية

<div align="center">
  <img src="screenshots/features.jpg" alt="مميزات TaskFlow الرئيسية" width="100%"/>
</div>

<br/>

### 1. 🤖 مساعد الذكاء الاصطناعي (AI Task Assistant)
حوّل أي فكرة غير مرتبة أو مشروع ضخم إلى خطة عمل تنفيذية مجدولة خلال ثوانٍ.
- **تحديد ذكي**: يستخرج تلقائياً عنوان المهمة، التصنيف الملائم، مستوى الأولوية (منخفضة/متوسطة/عالية/طارئة)، وتاريخ الاستحقاق.
- **تفتيت المهام (Subtasks Decomposition)**: يفكك الهدف الكبير إلى قائمة إجراءات صغيرة قابلة للإنجاز.
- **إضافة بنقرة واحدة**: زر مخصص يضيف الخطة المولدة مباشرة إلى قاعدة بيانات التطبيق.
- **دعم المحركين**: يعمل عبر سحابة **Google Gemini** عند وجود اتصال، أو عبر **المحرك المحلي المدمج** عند انعدام الشبكة.

```
💬 مثال تطبيقي من داخل التطبيق:

أنت تكتب:  "أريد الاستعداد لاختبار الحوسبة السحابية يوم الخميس القادم"

رد المساعد الفوري:
  📌 العنوان: الاستعداد لاختبار الحوسبة السحابية
  🏷️ التصنيف: دراسة
  ⚡ الأولوية: عالية جداً | 📅 الاستحقاق: الخميس القادم
  
  قائمة المهام الفرعية المقترحة:
  ├── [ ] مراجعة ملخص معماريات الخدمات (IaaS, PaaS, SaaS)
  ├── [ ] حل النماذج والاختبارات السابقة للفصول 1 إلى 4
  ├── [ ] تلخيص مفاهيم الأمان والشبكات الافتراضية (VPC & IAM)
  └── [ ] مراجعة شاملة ليلة الاختبار وأخذ قسط كافٍ من النوم

  [ ➕ إضافة الخطة إلى مهامي الآن ]
```

### 2. ⚡ أولوية العمل دون إنترنت (Offline-First SQLite)
- قاعدة بيانات محلية مدمجة (**SQLite via sqflite**) تخزن كافة الحسابات والمهام والتصنيفات محلياً.
- تصفح وإضافة وتعديل وحذف المهام بسرعة فائقة ودون انتظار استجابة السيرفر.

### 3. 🔄 خادم سحابي عالي الأداء (FastAPI + PostgreSQL)
- خادم RESTful API قوي مبني بأحدث معايير **FastAPI** و **SQLAlchemy 2.0**.
- دعم كامل لقواعد بيانات **PostgreSQL** الإنتاجية مع إدارة العلاقات والروابط العلائقية المتشعبة.
- مصادقة مستخدمين متقدمة بـ **JWT** وتشفير **Bcrypt**.

### 4. 📅 تقويم تفاعلي وجدولة ذكية
- استعراض المهام بحسب الأيام والأسابيع في واجهة تقويم مخصصة.
- إمكانية جدولة تذكيرات وتنبيهات زمنية دقيقة لكل مهمة.
- جاهزية لقواعد التكرار التلقائي للمهام الدورية (يومي، أسبوعي، شهري).

### 5. 🏷️ تصنيفات مخصصة ومهام فرعية
- تقسيم المهام حسب مجالات الحياة (عمل، دراسة، شخصي، تسوق، لياقة).
- إمكانية إضافة Checklists متعددة داخل كل مهمة ومتابعة نسبة الإنجاز اللحظية.

### 6. 🎨 تصميم بصري متقن (Material 3 & Dark Mode)
- واجهات متناسقة تدعم الوضع الداكن (Dark Mode) والوضع الفاتح (Light Mode).
- خط عربي عصري ومقروء (**Thmanyah Sans**).
- حركات انتقال سلسة وتأثيرات Shimmer أثناء معالجة البيانات.

---

## 🏛️ المعمارية الهندسية والقرارات التقنية (Architecture)

تم بناء **TaskFlow** باتباع مبادئ هندسة البرمجيات النظيفة (**Clean Architecture Principles**) لضمان قابلية التوسع والصيانة وسهولة الاختبار.

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
│  • /auth              ── تسجيل، دخول، جلب بيانات المستخدم الحالي (/me)            │
│  • /tasks             ── إدارة المهام (CRUD كامل + فلترة بالأحدث)                 │
│  • /tasks/{id}/subtasks── المهام الفرعية المرتبطة بكل مهمة                        │
│  • /categories        ── التصنيفات المخصصة لكل مستخدم                             │
│  • /reminders         ── جدولة التذكيرات الزمنية للمهام                           │
│  • /users/settings    ── تفضيلات الثيم واللغة والإشعارات                          │
│                                                                                   │
│  Domain & Persistence Layer:                                                      │
│  • Pydantic v2        ── التحقق الصارم من صحة الحمولات (Validation Schemas)       │
│  • SQLAlchemy 2.0 ORM ── إدارة الجداول والعلاقات والعمليات الذرية (Transactions)   │
│  • Psycopg 3 Driver   ── اتصال مباشر عالي الأداء مع قاعدة PostgreSQL              │
│  • Database Auto-Init ── فحص وإنشاء قاعدة بيانات "taskflow" والجداول تلقائياً    │
└───────────────────────────────────────────────────────────────────────────────────┘
```

### أبرز التقنيات والمكتبات المستخدمة

| الطبقة البرمجية | التقنية المختارة | سبب الاختيار والدور في النظام |
|:----------------|:-----------------|:------------------------------|
| **Mobile Core** | **Flutter 3.x / Dart 3** | أداء أصيل (Native Performance)، دعم استثنائي للـ RTL، وسرعة البناء |
| **State Management**| **Provider 6** | نمط خفيف وفعال يمنع إعادة البناء غير الضرورية (Rebuild Optimization) |
| **Local Cache & Storage** | **SQLite (sqflite)** | حل محلي متين يضمن العمل بنسبة 100% في وضع عدم الاتصال (Offline-First) |
| **Network Engine** | **Dio 5** | دعم متقدم للـ Interceptors لإدارة الـ Auth Headers والتعامل الذكي مع انقطاع الشبكة |
| **Artificial Intelligence** | **Google Gemini 1.5/2.0 API** | فهم عميق ودقيق للغة العربية والقدرة على هيكلة المخرجات بصيغة JSON قابلة للتحليل |
| **Backend Framework** | **FastAPI** | أسرع أطر عمل بايثون (Asynchronous)، مع توثيق Swagger تلقائي |
| **ORM & Relational DB** | **SQLAlchemy 2.0 + PostgreSQL** | إدارة علاقات 1:N و 1:1 المتشعبة، مع دعم Cascades والحذف المتسلسل |
| **Validation Layer** | **Pydantic v2** | أداء فائق في التحقق من البيانات والأنماط (Type Safety) |
| **Security** | **JWT + Bcrypt (Passlib)** | تشفير قياسي لكلمات المرور وعزل جلسات المستخدمين عبر Stateless Tokens |

---

## 🗄️ المخطط الهيكلي لقاعدة البيانات (Entity Relationship)

يتطابق المخطط الهيكلي في كل من قاعدة البيانات المحلية (SQLite) والسحابية (PostgreSQL) عبر 8 نماذج علائقية:

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

1. **`users`**: الحسابات الشخصية (الرقم التعريفي، الاسم، البريد، الهاش المشفر).
2. **`tasks`**: المهام الرئيسية (العنوان، الوصف، الأولوية، الموعد، حالة الإنجاز، والتصنيف المرتبط).
3. **`subtasks`**: الخطوات الفرعية المربوطة بمفتاح أجنبي `task_id` مع حذف متسلسل (Cascade Delete).
4. **`categories`**: التصنيفات المخصصة المعزولة لكل مستخدم على حدة.
5. **`reminders`**: التنبيهات المجدولة بوقت دقيق مرتبطة بالمهمة.
6. **`recurrence_rules`**: قواعد تكرار المهام (يومي، أسبوعي، شهري).
7. **`calendar_events`**: الأحداث المستوردة أو المتزامنة مع التقويم.
8. **`user_settings`**: تفضيلات المستخدم الخاصة (الثيم، اللغة، المنطقة الزمنية).

---

## 🔌 دليل نقاط النهاية للـ API (RESTful Endpoints)

جميع المسارات تتطلب ترويسة `Authorization: Bearer <token>` باستثناء مسارات التسجيل والدخول وفحص الحالة:

| المسار (Endpoint) | الطريقة | الوصف البرمجي |
|:------------------|:-------:|:--------------|
| `POST /auth/register` | `POST` | تسجيل حساب جديد وتشفير كلمة المرور عبر Bcrypt |
| `POST /auth/login` | `POST` | تسجيل الدخول وإرجاع Bearer Access Token |
| `GET /auth/me` | `GET` | استرجاع بيانات المستخدم الحالي المصدّق |
| `GET /tasks` | `GET` | استرجاع جميع مهام المستخدم الحالي مرتبة بالأحدث |
| `POST /tasks` | `POST` | إنشاء مهمة جديدة مع تحديد أولويتها وتصنيفها |
| `GET /tasks/{id}` | `GET` | جلب تفاصيل مهمة محددة |
| `PUT /tasks/{id}` | `PUT` | تحديث بيانات مهمة محددة أو تغيير حالتها |
| `DELETE /tasks/{id}` | `DELETE` | حذف المهمة وكافة المهام الفرعية والتذكيرات المرتبطة بها |
| `GET /tasks/{id}/subtasks` | `GET` | جلب كافة المهام الفرعية التابعة لمهمة معينة |
| `POST /tasks/{id}/subtasks` | `POST` | إنشاء مهمة فرعية جديدة داخل المهمة |
| `PUT /subtasks/{id}` | `PUT` | تحديث عنوان أو حالة إنجاز المهمة الفرعية |
| `DELETE /subtasks/{id}` | `DELETE` | حذف مهمة فرعية محددة |
| `GET /categories` | `GET` | جلب تصنيفات المستخدم المخصصة |
| `POST /categories` | `POST` | إضافة تصنيف جديد |
| `GET /categories/{id}` | `GET` | جلب تصنيف محدد |
| `PUT /categories/{id}` | `PUT` | تعديل اسم التصنيف |
| `DELETE /categories/{id}` | `DELETE` | حذف التصنيف |
| `GET /reminders` | `GET` | جلب جميع التذكيرات النشطة للمستخدم |
| `POST /tasks/{id}/reminders` | `POST` | جدولة تذكير زمني لمهمة محددة |
| `DELETE /reminders/{id}` | `DELETE` | إلغاء أو حذف تذكير محدد |
| `GET /users/settings` | `GET` | استرجاع إعدادات وتفضيلات المستخدم الحالية |
| `PUT /users/settings` | `PUT` | تحديث الإعدادات (الثيم، اللغة، الإشعارات) |
| `GET /health` | `GET` | فحص جاهزية الخادم والاتصال بقاعدة البيانات |
| `GET /` | `GET` | رسالة ترحيبية وتأكيد تشغيل الخدمة |

---

## 🚀 التشغيل المحلي (Quick Start)

### المتطلبات المسبقة:
- **Flutter SDK**: الإصدار `3.10` أو أحدث.
- **Python**: الإصدار `3.9+` (تم اختباره على Python 3.11).
- **PostgreSQL**: مثبت ويعمل محلياً على المنفذ الافتراضي `5432`.
- **محرر أكواد**: Android Studio أو Visual Studio Code.

---

<details>
<summary><b>⚙️ 1. إعداد وتشغيل خادم FastAPI</b> — اضغط لعرض الخطوات والأوامر</summary>

```bash
# 1. الدخول إلى مجلد الباك إند
cd Backend

# 2. إنشاء وتفعيل البيئة الافتراضية
python -m venv venv

# نظام ويندوز (PowerShell):
venv\Scripts\activate
# نظام لينكس / ماك:
# source venv/bin/activate

# 3. تثبيت المتطلبات المعتمدة
pip install -r requirements.txt

# 4. تشغيل خادم التطوير
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

> **ملاحظة ذكية:** عند تشغيل الخادم لأول مرة، يقوم تلقائياً بإنشاء قاعدة بيانات باسم `taskflow` في PostgreSQL وبناء كافة الجداول دون الحاجة لتنفيذ أوامر SQL يدوياً!
>
> **التوثيق الحي:**
> - Swagger UI: `http://localhost:8000/docs`
> - ReDoc UI: `http://localhost:8000/redoc`

</details>

<details>
<summary><b>📱 2. إعداد وتشغيل تطبيق Flutter</b> — اضغط لعرض الخطوات والأوامر</summary>

```bash
# 1. الانتقال للمجلد الرئيسي
cd ..

# 2. تحميل الحزم والمكتبات
flutter pub get

# 3. تشغيل التطبيق على محاكي أو جهاز متصل
flutter run

# 4. بناء نسخة الإنتاج (Production APK):
flutter build apk --split-per-abi   # للنسخة الخفيفة المحسنة
flutter build apk --release          # للنسخة الشاملة
```

</details>

<details>
<summary><b>🤖 3. تفعيل Gemini AI في التطبيق</b> — اضغط لعرض الخطوات</summary>

1. احصل على مفتاح API مجاني من [Google AI Studio](https://aistudio.google.com/app/apikey).
2. افتح تطبيق **TaskFlow** في هاتفك أو المحاكي.
3. توجه إلى **الإعدادات ← مفتاح الذكاء الاصطناعي (AI Key)**.
4. الصق المفتاح واضغط **حفظ**.
5. *ملاحظة:* إذا لم تقم بإدخال مفتاح، سيواصل التطبيق العمل بسلاسة عبر **المحرك الذكي المحلي الاحتياطي**.

</details>

---

## 🧪 التحقق والاختبارات الآلية (Automated Verification)

يحتوي المستودع على حزمة اختبارات تكاملية متقدمة تختبر نقاط الـ API وعلاقات الجداول:

```bash
cd Backend
python test_backend.py
```

نتائج التحقق تشمل:
- اختبار `GET /` و `GET /health` للتأكد من حالة الخادم.
- اختبار عمليات الإنشاء والتحديث والحذف للمستخدمين والمهام والتصنيفات.
- اختبار علاقات 1:N والـ Cascades والتأكد من حذف المهام الفرعية تلقائياً عند حذف المهمة الأب.

---

## 💼 دليل المقابلات التقنية (Technical Interview Highlights)

إذا كنت تستعرض هذا المشروع في مقابلة توظيف أو تقييم تقني، فإليك أبرز النقاط المعمارية الجاهزة للمناقشة:

1. **كيف تم حل مشكلة الـ Offline-First؟**
   - تم استخدام نمط **Repository Pattern** داخل `TaskProvider`؛ حيث يكتب التطبيق فورياً في قاعدة `SQLite` المحلية لضمان عدم توقف واجهة المستخدم، بينما تتولى طبقة `ApiService` إرسال التحديثات لخادم `FastAPI` مع معالجة أخطاء الانقطاع بلباقة عبر `Dio Interceptors`.
2. **كيف يعمل محرك الـ AI الهجين؟**
   - في `AiService`، يتم فحص توفر المفتاح والشبكة؛ فإذا كانت متاحة يتم طلب نموذج `Gemini` مع نظام توجيه Prompt يفرض إخراج البيانات بصيغة JSON محددة، وفي حال تعذر الاتصال يتم استخدام محرك محلي يستند إلى قواعد لغوية (Rule-Based & Regex Pattern Matching) لاستخراج العنوان والتصنيف والأولويات وتوليد مهام فرعية قياسية.
3. **كيف تم التعامل مع الأمان والمصادقة؟**
   - لا يتم تخزين كلمات المرور كنص صريح مطلقاً، بل تُشفّر عبر `Bcrypt` مع ملح عشوائي (Salt). الجلسات تُدار عبر توكنات `JWT Bearer` منتهية الصلاحية تُحفظ محلياً في `SharedPreferences` وتُحقن في ترويسات الطلبات عبر معترضات شبكية.
4. **كيف تم تصميم الجداول لمنع البيانات اليتيمة (Orphaned Rows)؟**
   - تم ربط جدول `subtasks` بجدول `tasks` عبر قيد مفتاح أجنبي مع تفعيل `ondelete="CASCADE"`، مما يضمن حذف أي خطوات فرعية تلقائياً بمجرد حذف المهمة الأصلية.

---

## 🗺️ خارطة طريق التطوير (Roadmap)

- [x] ✅ بناء تطبيق محمول متكامل بـ Flutter (12 شاشة).
- [x] ✅ دعم العربية و RTL مع خط Thmanyah وتصميم Material 3.
- [x] ✅ أولوية العمل دون إنترنت (Offline-First) عبر SQLite محلياً.
- [x] ✅ مساعد ذكي ثنائي (Gemini API + Local Rule-Based Engine).
- [x] ✅ خادم سحابي بـ FastAPI مع PostgreSQL ومصادقة JWT.
- [x] ✅ إدارة التصنيفات، التذكيرات، والمهام الفرعية.
- [ ] 📊 لوحة تقارير وإحصائيات الإنتاجية الأسبوعية والشهرية.
- [ ] 🔄 مزامنة سحابية تلقائية في الخلفية عند عودة الاتصال (Background Sync).
- [ ] 📌 إضافة ودجت الشاشة الرئيسية (Home Screen Widget) لنظام Android.
- [ ] 🍏 بناء واختبار نسخة متوافقة لنظام iOS.
- [ ] 🌐 دعم لغات إضافية وخيار التبديل للإنجليزية في الإعدادات.

---

## 🤝 المساهمة في المشروع (Contributing)

نرحب بكافة المساهمات من مجتمع المطورين! للمساهمة:

1. قم بعمل **Fork** للمستودع.
2. أنشئ فرعاً لميزتك الجديدة (`git checkout -b feature/AmazingFeature`).
3. سجّل تغييراتك مع رسالة واضحة (`git commit -m "feat: Add AmazingFeature"`).
4. ارفع الفرع لمستودعك على GitHub (`git push origin feature/AmazingFeature`).
5. افتح **Pull Request** للمراجعة والمناقشة.

- 🐛 **للإبلاغ عن مشكلة:** [فتح تذكرة خطأ (Issue)](https://github.com/mohammed-m-alhaj/taskflow/issues)
- 💡 **لاقتراح ميزة جديدة:** [تقديم طلب ميزة](https://github.com/mohammed-m-alhaj/taskflow/issues/new)

---

## 📄 الرخصة (License)

هذا المشروع مرخّص بالكامل تحت **MIT License** — وهو متاح للاستخدام التجاري، التعديل، وإعادة التوزيع بحرية كاملة. لمزيد من التفاصيل راجع ملف [LICENSE](LICENSE).

---

<div align="center">

**إذا أعجبك TaskFlow أو أفادك كمرجع برمجي — لا تتردد في دعمه بنجمة ⭐ على GitHub!**

<br/>

[![GitHub Profile](https://img.shields.io/badge/GitHub-mohammed--m--alhaj-181717?style=for-the-badge&logo=github)](https://github.com/mohammed-m-alhaj)
&nbsp;
[![Report Issue](https://img.shields.io/badge/أبلغ_عن_مشكلة-red?style=for-the-badge&logo=github)](https://github.com/mohammed-m-alhaj/taskflow/issues)

<br/>

*صُنع بكل إتقان وشغف ❤️ باستخدام Flutter · FastAPI · PostgreSQL · Google Gemini*

</div>

</div>