<div align="center">

<img src="screenshots/hero.jpg" alt="TaskFlow — تطبيق إدارة المهام والإنتاجية الذكي" width="100%"/>

<br/><br/>

# TaskFlow
### تطبيق إدارة المهام والإنتاجية الذكي — عربي كامل — مدعوم بالذكاء الاصطناعي — Offline-First

<br/>

[![Download APK](https://img.shields.io/badge/⬇️_تحميل_التطبيق-APK_مباشر-2563EB?style=for-the-badge)](https://github.com/mohammed-m-alhaj/taskflow/releases/latest)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://sqlite.org)
[![Gemini AI](https://img.shields.io/badge/Google_Gemini-AI_Enabled-8E75B2?style=for-the-badge&logo=googlegemini&logoColor=white)](https://aistudio.google.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

<br/>

**نظّم أهدافك، قسّم مشاريعك لمهام تنفيذية، وتابع إنجازك اليومي بسلاسة — سواء كنت متصلاً بالإنترنت أو أوفلاين كلياً.**

</div>

---

## 🎯 ما هو TaskFlow؟

**TaskFlow** هو تطبيق متكامل لإدارة المهام والإنتاجية (Full-Stack)، مصمم خصيصاً للمستخدم العربي ليعمل بمبدأ **أولوية العمل دون إنترنت (Offline-First)** مع المزامنة السحابية الذكية. 

يجمع التطبيق بين:
1. **واجهة هاتف ذكية بـ Flutter**: تدعم اللغة العربية والاتجاه من اليمين لليسار (RTL) مع خط عربي أنيق (Thmanyah) وتصميم Material Design 3 سلس ومريح للعين.
2. **مساعد ذكاء اصطناعي ثنائي المحرك**: يتكامل مع **Google Gemini API** لتحويل أهدافك إلى خطة عمل تنفيذية مجدولة، ويعتمد تلقائياً على **محرك ذكاء اصطناعي محلي (Local Fallback Engine)** في حال عدم توفر اتصال بالشبكة أو غياب المفتاح.
3. **خادم سحابي قوي بـ FastAPI & PostgreSQL**: يوفّر مصادقة آمنة عبر JWT، ومزامنة للمهام والمهام الفرعية والتذكيرات عبر RESTful API موثّق بالكامل.

---

## 📲 تحميل التطبيق مباشرة (Android)

> **يدعم أجهزة أندرويد بنظام Android 6.0 (Marshmallow) فما فوق.**

| النسخة | المعمارية | الحجم التقريبي | الاستخدام الموصى به |
|:-------|:----------:|:--------------:|:--------------------|
| [⬇️ **النسخة الخفيفة المحسّنة (Optimized)**](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) | ARM64-v8a | **~19.4 MB** | **موصى بها** — لأكثر من 95% من الهواتف الحديثة، أسرع في التحميل وأخف في الاستهلاك |
| [⬇️ **النسخة الشاملة (Universal)**](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) | All Architectures | **~54.5 MB** | للأجهزة القديمة، أو في حال عدم توافق النسخة الخفيفة مع جهازك |

#### خطوات التثبيت السريع:
1. حمّل ملف الـ APK المناسب لجهازك من الروابط أعلاه.
2. افتح الملف من مدير التنزيلات في هاتفك واضغط **تثبيت (Install)**.
3. في حال ظهور تنبيه الحماية: اضغط **الإعدادات ← تفعيل خيار السماح بالتثبيت من هذا المصدر**.
4. افتح **TaskFlow** وسجّل دخولك أو استخدم التطبيق مباشرة في الوضع المحلي بدون نت 🚀

---

## ✨ المميزات الرئيسية

<div align="center">
  <img src="screenshots/features.jpg" alt="مميزات TaskFlow الرئيسية" width="100%"/>
</div>

<br/>

### 1. 🤖 مساعد الذكاء الاصطناعي (AI Task Assistant)
اكتب هدفك أو مشروعك باللغة العامية أو الفصحى، وسيقوم المساعد بتحليله وتوليد خطة عمل ذكية تتضمن:
- العنوان والتصنيف المناسب تلقائياً.
- مستوى الأولوية وتاريخ الاستحقاق المقترح.
- تفتيت الهدف إلى مهام فرعية (Subtasks) جاهزة للتنفيذ.
- إمكانية إضافة الخطة كاملة إلى قائمة مهامك بضغطة زر واحدة.

> **محرك هجين:** عند الاتصال بالإنترنت يُستخدم نموذج **Google Gemini**، وفي حال غياب الاتصال بالإنترنت يتحول تلقائياً إلى **محرك ذكي محلي (Local Engine)** مدمج داخل كود التطبيق.

```
💬 تجربة حوارية:

أنت تكتب:  "أريد مراجعة وتجهيز مشروع تخرج تقنية المعلومات للمناقشة الأسبوع القادم"

التطبيق يحلل ويجيب فوراً:
  📌 العنوان: مناقشة مشروع تخرج تقنية المعلومات
  🏷️ التصنيف: دراسة
  ⚡ الأولوية: عالية جداً | 📅 الموعد: الخميس القادم
  
  قائمة المهام الفرعية:
  ├── [ ] التدقيق النهائي على كود الـ Backend واختبار الـ API
  ├── [ ] تصميم وتحضير شرائح العرض التقديمي (PowerPoint)
  ├── [ ] تصدير ملف الـ APK النهائي وتجربته على هاتف محايد
  └── [ ] إجراء بروفة تجريبية للإلقاء ومراجعة أسئلة اللجنة المتوقعة

  [ ➕ أضف هذه الخطة لمهامي مباشرة ]
```

### 2. ⚡ أولوية العمل المحلي (Offline-First Architecture)
- يعمل التطبيق بكفاءة 100% بدون إنترنت بفضل قاعدة بيانات **SQLite** محلية سريعة.
- تنشئ، تعدل، وتنجز المهام والتذكيرات في أي مكان دون انقطاع.

### 3. 🔄 خادم سحابي ومزامنة متكاملة (Cloud Backend)
- خادم مبني بأحدث إصدارات **FastAPI** و **SQLAlchemy 2.0**.
- دعم كامل لحفظ ومزامنة البيانات مع قاعدة بيانات سحابية **PostgreSQL**.
- مصادقة آمنة للمستخدمين عبر تشفير **Bcrypt** وتوكنات **JWT**.

### 4. 📅 تقويم تفاعلي وجدولة ذكية (Interactive Calendar)
- تصفّح مهامك مجدولة حسب الأيام في واجهة تقويم سلسة.
- نظام تذكيرات وتنبيهات مخصصة لمواعيد التسليم المهمة.
- دعم قواعد التكرار التلقائي للمهام الدورية.

### 5. 🏷️ تصنيفات ذكية ومهام فرعية (Categories & Subtasks)
- تنظيم المهام في فئات ملونة (دراسة، عمل، شخصي، تسوق، صحة).
- إمكانية تقسيم أي مهمة معقدة إلى قائمة مهام فرعية قابلة للشطب الفوري.

### 6. 🎨 تجربة مستخدم عربية أصيلة (Native Arabic UX)
- دعم كامل للاتجاه من اليمين لليسار (RTL).
- خط عربي حديث وعالي المقروئية (**Thmanyah Sans**).
- وضعان ليلي ونهاري متناسقان (Dark & Light Modes) وتأثيرات Shimmer أثناء التحميل.

---

## 👥 الفئات المستهدفة

| الفئة | كيف يخدمهم تطبيق TaskFlow؟ |
|:------|:---------------------------|
| 🎓 **الطلاب والباحثون** | تقسيم جداول المذاكرة ومشاريع التخرج لخطوات تنفيذية عبر الـ AI. |
| 💼 **المهنيون ورواد الأعمال** | إدارة المشاريع اليومية، متابعة الأولويات، وتحديد مواعيد التسليم بدقة. |
| 📱 **محبو الإنتاجية اليومية** | تنظيم المشتريات، المواعيد، والأهداف الشخصية دون إعلانات وبسرعة فائقة. |
| 👨‍💻 **المطورون والمهندسون** | كود مصدري مفتوح ونظيف لدراسة بناء تطبيقات Flutter + FastAPI + AI بمعايير حقيقية. |

---

## 🏗️ المعمارية التقنية (Architecture & Tech Stack)

```
┌────────────────────────────────────────────────────────────────────────┐
│                        📱 Flutter Mobile App                           │
│                                                                        │
│   12 Screens            5 State Providers        4 Core Services       │
│   ──────────            ─────────────────        ───────────────       │
│   • Splash              • AuthProvider           • AiService           │
│   • Login / Register    • TaskProvider             (Gemini + Local)    │
│   • Home                • CategoryProvider       • ApiService          │
│   • Task Details        • ReminderProvider         (Dio + Network)     │
│   • Add Task            • SettingsProvider       • DatabaseHelper      │
│   • AI Assistant                                   (SQLite / Sqflite)  │
│   • Calendar                                     • StorageService      │
│   • Categories & Tags                              (Prefs / Token)     │
│   • Notifications                                                      │
│   • Profile & Settings                                                 │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
                                    │ RESTful HTTP / JSON
                                    │ (Interceptor with Offline Fallback)
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│                       ⚙️ FastAPI Backend                               │
│                                                                        │
│   Routers:                                                             │
│   • /auth              (Register, Login, JWT Token, /me)               │
│   • /tasks             (Full CRUD + Filters + Sorting)                 │
│   • /subtasks          (Task-linked CRUD)                              │
│   • /categories        (User custom categories)                        │
│   • /reminders         (Scheduled time reminders)                      │
│   • /users/settings    (Theme, Language, Timezone)                     │
│                                                                        │
│   Database Layer:                                                      │
│   • PostgreSQL Engine via SQLAlchemy 2.0 ORM & Psycopg 3 Driver        │
│   • Auto-creates and verifies "taskflow" database on startup           │
└────────────────────────────────────────────────────────────────────────┘
```

### التقنيات المستخدمة

| النطاق | التقنية / المكتبة | الغرض البرمجي |
|:-------|:------------------|:--------------|
| **Mobile Framework** | **Flutter 3.x (Dart 3)** | بناء تطبيق محمول سريع ومتعدد المنصات بواجهات Material 3 |
| **State Management** | **Provider 6** | إدارة حالة التطبيق وفصل طبقات الأعمال عن الواجهات |
| **Local Database** | **SQLite (sqflite)** | تخزين محلي كامل للبيانات لضمان عمل التطبيق بدون إنترنت |
| **Network Client** | **Dio 5** | إرسال الطلبات للباك إند مع Interceptors لإدارة التوكن والانقطاع |
| **AI Processing** | **Google Gemini API** | محرك توليد وتنسيق خطط المهام الذكية |
| **Local AI Engine** | **Regex & Rule-Based Matcher** | محرك ذكاء محلي احتياطي يعمل دون أي اتصال بالشبكة |
| **Backend Framework** | **FastAPI** | خادم RESTful API فائق السرعة مبني بلغة بايثون |
| **Backend ORM** | **SQLAlchemy 2.0** | نمذجة الكائنات والربط مع قاعدة البيانات العلائقية |
| **Production DB** | **PostgreSQL** | قاعدة بيانات علائقية موثوقة لحفظ ومزامنة الحسابات والمهام |
| **Database Driver** | **Psycopg 3** | أحدث مشغّل ومحول كائنات بايثون لقواعد PostgreSQL |
| **Data Validation** | **Pydantic v2** | التحقق الدقيق من صحة حمولات الطلبات والردود (Schemas) |
| **Security & Auth** | **JWT + Bcrypt (Passlib)** | تشفير كلمات المرور وإصدار توكنات الوصول الآمنة |
| **Typography & Styling**| **Thmanyah Sans + Shimmer** | خط عربي متناسق مع مؤثرات بصرية مريحة أثناء التحميل |

---

## 🗄️ مخطط قاعدة البيانات (Database Schema)

يتطابق المخطط في كل من SQLite و PostgreSQL عبر 8 نماذج وجداول علائقية رئيسية:

```
[ users ] ────────┬───< [ tasks ] ─────────┬───< [ subtasks ]
                  │       │                │
                  │       ├───< [ categories ]
                  │       │
                  │       ├───< [ reminders ]
                  │       │
                  │       └───< [ recurrence_rules ]
                  │
                  ├───< [ calendar_events ]
                  │
                  └───1:1 [ user_settings ]
```

1. **`users`**: حسابات المستخدمين (المعرف، الاسم، البريد الإلكتروني، كلمة المرور المشفرة).
2. **`tasks`**: المهام الرئيسية (العنوان، الوصف، الأولوية [منخفضة، متوسطة، عالية، طارئة]، الحالة، الموعد، حالة الإنجاز).
3. **`subtasks`**: المهام الفرعية المرتبطة بكل مهمة مع حالة الإنجاز.
4. **`categories`**: التصنيفات المخصصة لكل مستخدم (مثل: عمل، دراسة، شخصي).
5. **`reminders`**: التذكيرات الزمنية المجدولة لكل مهمة.
6. **`recurrence_rules`**: قواعد التكرار التلقائي للمهام الدورية.
7. **`calendar_events`**: أحداث ومواعيد التقويم.
8. **`user_settings`**: تفضيلات المستخدم (الثيم، اللغة، المنطقة الزمنية، الإشعارات).

---

## 🔌 دليل نقاط النهاية للـ API (REST API Endpoints)

جميع نقاط النهاية محمية بـ JWT ما عدا التسجيل والدخول وفحص الحالة:

| المسار (Endpoint) | الطريقة (Method) | الوصف |
|:------------------|:----------------:|:------|
| `POST /auth/register` | `POST` | تسجيل حساب جديد وتشفير كلمة المرور |
| `POST /auth/login` | `POST` | تسجيل الدخول واستخراج JWT Bearer Token |
| `GET /auth/me` | `GET` | جلب بيانات المستخدم الحالي المصادق عليه |
| `GET /tasks` | `GET` | جلب جميع مهام المستخدم مرتبة بالأحدث |
| `POST /tasks` | `POST` | إنشاء مهمة جديدة وتحديد أولويتها وتصنيفها |
| `GET /tasks/{id}` | `GET` | جلب تفاصيل مهمة محددة |
| `PUT /tasks/{id}` | `PUT` | تحديث بيانات المهمة أو تغيير حالة الإنجاز |
| `DELETE /tasks/{id}` | `DELETE` | حذف المهمة وكافة المهام الفرعية التابعة لها |
| `GET /tasks/{id}/subtasks` | `GET` | جلب المهام الفرعية التابعة لمهمة معينة |
| `POST /tasks/{id}/subtasks` | `POST` | إضافة مهمة فرعية جديدة |
| `PUT /subtasks/{id}` | `PUT` | تعديل مهمة فرعية أو تحديدها كمكتملة |
| `DELETE /subtasks/{id}` | `DELETE` | حذف مهمة فرعية |
| `GET /categories` | `GET` | جلب كافة التصنيفات الخاصة بالمستخدم |
| `POST /categories` | `POST` | إضافة تصنيف جديد |
| `GET /categories/{id}` | `GET` | جلب تصنيف محدد |
| `PUT /categories/{id}` | `PUT` | تعديل اسم التصنيف |
| `DELETE /categories/{id}` | `DELETE` | حذف التصنيف |
| `GET /reminders` | `GET` | جلب جميع تذكيرات المستخدم القادمة |
| `POST /tasks/{id}/reminders` | `POST` | جدولة تذكير زمني لمهمة محددة |
| `DELETE /reminders/{id}` | `DELETE` | إلغاء أو حذف تذكير |
| `GET /users/settings` | `GET` | جلب إعدادات المستخدم (الثيم، اللغة، الإشعارات) |
| `PUT /users/settings` | `PUT` | تحديث إعدادات وتفضيلات المستخدم |
| `GET /health` | `GET` | فحص صحة وجاهزية الخادم وقاعدة البيانات |
| `GET /` | `GET` | رسالة ترحيب وفحص تشغيل الـ API |

---

## 🚀 تشغيل المشروع محلياً (Quick Start)

### المتطلبات الأساسية
- **Flutter SDK**: الإصدار `3.10` أو أحدث.
- **Python**: الإصدار `3.9+` (تم اختباره على Python 3.11).
- **PostgreSQL**: مثبت ويعمل محلياً على المنفذ `5432`.
- **محرر أكواد**: Android Studio أو VS Code.

---

### 1. ⚙️ تشغيل خادم FastAPI

```bash
# 1. الدخول إلى مجلد الباك إند
cd Backend

# 2. إنشاء وتفعيل البيئة الافتراضية
python -m venv venv
# لنظام ويندوز:
venv\Scripts\activate
# لأنظمة لينكس / ماك:
# source venv/bin/activate

# 3. تثبيت المتطلبات المعتمدة
pip install -r requirements.txt

# 4. تشغيل الخادم
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

> **ملاحظة:** عند الإقلاع، يقوم الخادم تلقائياً بالتحقق من وجود قاعدة بيانات باسم `taskflow` وإنشائها وتوليد كافة الجداول إن لم تكن موجودة.
> 
> يمكنك تصفح التوثيق التفاعلي للـ API عبر:
> - **Swagger UI:** `http://localhost:8000/docs`
> - **ReDoc:** `http://localhost:8000/redoc`

---

### 2. 📱 تشغيل تطبيق Flutter

```bash
# 1. العودة لمجلد المشروع الرئيسي
cd ..

# 2. جلب وتثبيت حزم فلاتر
flutter pub get

# 3. تشغيل التطبيق على المحاكي أو جهاز حقيقي متصل
flutter run

# 4. لبناء ملف APK للإنتاج:
# لبناء نسخة مخصصة خفيفة:
flutter build apk --split-per-abi
# أو لبناء نسخة شاملة:
flutter build apk --release
```

---

### 3. 🤖 تفعيل مساعد الذكاء الاصطناعي (Gemini AI)

1. توجه إلى [Google AI Studio](https://aistudio.google.com/app/apikey) واحصل على مفتاح API مجاني.
2. افتح تطبيق **TaskFlow** في هاتفك أو المحاكي.
3. انتقل إلى **الإعدادات ← مفتاح الذكاء الاصطناعي (AI Key)**.
4. الصق المفتاح واضغط **حفظ**.
5. *إذا لم تُدخل مفتاحاً، سيعمل التطبيق تلقائياً بالمحرك المحلي الاحتياطي لتقديم الخطط.*

---

## 🗺️ خارطة طريق التطوير (Roadmap)

- [x] ✅ بناء تطبيق محمول كامل بـ Flutter (12 شاشة متكاملة).
- [x] ✅ دعم العربية و RTL مع خط Thmanyah وتصميم Material 3.
- [x] ✅ أولوية العمل دون إنترنت (Offline-First) عبر SQLite محلياً.
- [x] ✅ مساعد ذكي ثنائي (Gemini API + Local Rule-Based Engine).
- [x] ✅ خادم سحابي بـ FastAPI مع PostgreSQL ومصادقة JWT.
- [x] ✅ إدارة التصنيفات، التذكيرات، والمهام الفرعية.
- [ ] 📊 لوحة تقارير وإحصائيات الإنتاجية الأسبوعية والشهرية.
- [ ] 🔄 مزامنة سحابية تلقائية في الخلفية عند عودة الاتصال (Background Sync).
- [ ] 📌 إضافة ودجت الشاشة الرئيسية (Home Screen Widget) لنظام Android.
- [ ] 🍏 بناء نسخة متوافقة لنظام iOS.
- [ ] 🌐 إضافة خيار واجهة باللغة الإنجليزية في الإعدادات.

---

## 🤝 المساهمة في المشروع (Contributing)

المشروع مفتوح المصدر ونرحب بأي مساهمات لتطويره:

1. قم بعمل **Fork** للمستودع.
2. أنشئ فرعاً لميزتك (`git checkout -b feature/AmazingFeature`).
3. سجّل تغييراتك (`git commit -m "feat: Add AmazingFeature"`).
4. ارفع الفرع لمستودعك (`git push origin feature/AmazingFeature`).
5. افتح **Pull Request** للمراجعة.

- 🐛 **للإبلاغ عن مشكلة:** [فتح تذكرة خطأ (Issue)](https://github.com/mohammed-m-alhaj/taskflow/issues)
- 💡 **لاقتراح ميزة جديدة:** [تقديم طلب ميزة](https://github.com/mohammed-m-alhaj/taskflow/issues/new)

---

## 📄 الرخصة (License)

هذا المشروع مرخّص تحت رخصة **MIT License** — يمكنك استخدامه، تعديله، وتوزيعه بحرية كاملة. لمزيد من التفاصيل راجع ملف [LICENSE](LICENSE).

---

<div align="center">

**إذا أعجبك تطبيق TaskFlow أو ساعدك في مشاريعك — لا تبخل بدعمنا بنجمة ⭐ على GitHub!**

<br/>

[![GitHub Profile](https://img.shields.io/badge/GitHub-mohammed--m--alhaj-181717?style=for-the-badge&logo=github)](https://github.com/mohammed-m-alhaj)
&nbsp;
[![Report Issue](https://img.shields.io/badge/أبلغ_عن_مشكلة-red?style=for-the-badge&logo=github)](https://github.com/mohammed-m-alhaj/taskflow/issues)

<br/>

*صُنع بكل إتقان ❤️ باستخدام Flutter · FastAPI · PostgreSQL · Google Gemini*

</div>
