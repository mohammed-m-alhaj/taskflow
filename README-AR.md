<div align="center">

# TaskFlow

### ⚡ نظام إدارة المهام والإنتاجية الذكي بمبدأ Offline-First ومدعوم بذكاء Gemini الاصطناعي و FastAPI

**تطبيق Full-Stack متكامل بمستوى إنتاجي مبني بـ Flutter و FastAPI و PostgreSQL — يدعم اللغة العربية RTL أصيلاً ويعمل بدون إنترنت كلياً.**

<br/>

[![GitHub Release](https://img.shields.io/github/v/release/mohammed-m-alhaj/taskflow?include_prereleases&style=flat-square&color=2563EB)](https://github.com/mohammed-m-alhaj/taskflow/releases)
[![GitHub Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=flat-square&color=yellow&label=⭐%20النجوم)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=flat-square&logo=sqlite&logoColor=white)](https://sqlite.org)
[![Gemini AI](https://img.shields.io/badge/Google_Gemini-AI_Enabled-8E75B2?style=flat-square&logo=googlegemini&logoColor=white)](https://aistudio.google.com)
[![Language: English](https://img.shields.io/badge/Language-English-2563EB?style=flat-square)](README.md)

<br/>

[📱 تحميل التطبيق](#-تحميل-التطبيق-apk-أندرويد) •
[✨ لماذا TaskFlow؟](#-نظرة-شاملة-لماذا-taskflow) •
[🤖 تجربة الذكاء الاصطناعي](#-تجربة-مساعد-الذكاء-الاصطناعي) •
[🏛️ المعمارية التقنية](#-المعمارية-الهندسية-والبنية-التقنية) •
[🚀 التشغيل السريع](#-التشغيل-السريع-في-3-دقائق) •
[📘 أدلة التوثيق](#-أدلة-التوثيق-الهندسية-pdf) •
[English Version](README.md)

</div>

---

<div dir="rtl">

## 💡 نظرة شاملة: لماذا TaskFlow؟

معظم تطبيقات إدارة المهام تقع في أحد فخين: إما أن تكون **تطبيقات تجريبية بسيطة** تفتقر للمعايير البرمجية، أو **تطبيقات سحابية بحتة** تتجمد وتتوقف عن الاستجابة بمجرد انقطاع شبكة الإنترنت.

يأتي **TaskFlow** كحل هندسي متكامل ومبني بمعايير إنتاجية (**Production-Grade Full-Stack Ecosystem**). يمنح المستخدم حرية تامة للعمل بدون إنترنت عبر قاعدة بيانات **SQLite** محلية على الهاتف، مع توفير خادم سحابي حديث مبني بـ **FastAPI** وقاعدة بيانات **PostgreSQL** لإدارة الحسابات والمزامنة عبر أجهزة متعددة.

### أبرز المزايا للمستخدمين والشركات البرمجية:
- **⚡ أولوية العمل دون إنترنت بنسبة 100%**: حفظ وتعديل وجدولة وحذف المهام باستجابة فورية دون أي شاشات انتظار، مع مزامنة سحابية هادئة في الخلفية.
- **🤖 محرك ذكاء اصطناعي هجين ثنائي**: تحليل الأهداف المكتوبة باللغة الطبيعية (العامية أو الفصحى) وتفكيكها إلى خطة عمل مجدولة ومهام فرعية عبر **Google Gemini AI** أو محرك ذكاء محلي يعمل دون إنترنت.
- **🇸🇦 واجهة عربية كاملة RTL**: تصميم أصيل يدعم الاتجاه من اليمين لليسار، بخط عربي أنيق (**Thmanyah Sans**) متوافق مع معايير Material 3.
- **🛡️ أمان ومصادقة قياسية**: تشفير كلمات المرور بخوارزمية **Bcrypt** وإدارة الجلسات عبر توكنات **JWT Bearer**.
- **🏢 معمارية نظيفة معيارية**: فصل محكم بين طبقات العرض (12 شاشة)، ومزودات الحالة (5 Providers)، والخدمات البرمجية.

---

## 📲 تحميل التطبيق (APK أندرويد)

احصل على نسخ APK جاهزة للتثبيت الفوري (تدعم أندرويد 6.0 فما فوق):

| النسخة | المعمارية المدعومة | الحجم | الاستخدام الموصى به | رابط التحميل |
|:---|:---:|:---:|:---|:---|
| **النسخة الخفيفة المحسّنة** | **ARM64-v8a** | **~19.4 MB** | **لأغلب الهواتف الحديثة** (سريعة التحميل وخفيفة) | [⬇️ تحميل APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) |
| **النسخة الشاملة** | **All Devices** | **~54.5 MB** | للأجهزة الأقدم أو معالجات ARMv7 و x86_64 | [⬇️ تحميل APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) |

---

## 🤖 تجربة مساعد الذكاء الاصطناعي

يحوّل TaskFlow أهدافك غير المنظمة إلى خطط عمل قابلة للتنفيذ الفوري:

```
💬 المدخل باللغة الطبيعية:
   "أريد الاستعداد لمناقشة مشروع التخرج الجامعي الأسبوع القادم"

🤖 خطة TaskFlow الذكية:
   📌 العنوان: الاستعداد لمناقشة مشروع التخرج
   🏷️ التصنيف: دراسة وتعليم
   ⚡ الأولوية: عالية | 📅 الموعد: الخميس القادم
   
   قائمة المهام الفرعية المقترحة:
   ├── [ ] تجميد الكود البرمجي وإجراء اختبارات التكامل النهائية
   ├── [ ] تصميم وتجهيز شرائح العرض التقديمي (PowerPoint) وبروفة الإلقاء
   ├── [ ] اختبار تثبيت ملف الـ APK النهائي على هاتف محايد
   └── [ ] مراجعة وتجهيز الإجابات للأسئلة المتوقعة من لجنة المناقشة

   [ ➕ أضف الخطة إلى مهامي الآن ]
```

---

## 🏛️ المعمارية الهندسية والبنية التقنية

```
┌───────────────────────────────────────────────────────────────────┐
│                       📱 عميل Flutter المحمول                      │
│                                                                   │
│   الشاشات (12)      ──► مزودات الحالة (5)   ──► الخدمات البرمجية (4)│
│   • الرئيسية / التقويم   • TaskProvider          • AiService       │
│   • مساعد AI الذكي       • AuthProvider            (Gemini/محلي)   │
│   • التصنيفات            • CategoryProvider      • ApiService      │
│   • تفاصيل المهمة        • ReminderProvider        (Dio / شبكة)    │
│   • الإعدادات            • SettingsProvider      • DbHelper (SQLite│
└─────────────────────────────────┬─────────────────────────────────┘
                                  │
                                  │ بروتوكول HTTP / JSON
                                  │ (معترضات التوكن + معالجة الانقطاع)
                                  │
┌─────────────────────────────────▼─────────────────────────────────┐
│                      ⚙️ خادم FastAPI السحابي                       │
│                                                                   │
│   الموجهات: /auth · /tasks · /subtasks · /categories · /settings  │
│   الـ ORM:  SQLAlchemy 2.0 مع مشغل PostgreSQL Psycopg 3           │
│   التحقق:   Pydantic v2 للتحقق الصارم من الحمولات والبيانات       │
│   الأمان:   تشفير Bcrypt + توكنات الوصول JWT                      │
└───────────────────────────────────────────────────────────────────┘
```

### التقنيات المستخدمة

| المجال | التقنية | الدور البرمجي |
|:---|:---|:---|
| **تطبيق الهاتف** | **Flutter 3.x & Dart 3** | واجهات مستخدم سريعة وعالية الأداء مع دعم أصيل للـ RTL |
| **إدارة الحالة** | **Provider 6** | نمط MultiProvider منظم يمنع إعادة البناء غير الضرورية للواجهة |
| **قاعدة البيانات المحلية** | **SQLite (sqflite)** | تخزين علائقي محلي فائق السرعة يضمن العمل 100% أوفلاين |
| **محرك الشبكة** | **Dio 5** | معترضات للتوكن ومعالجة ذكية لانقطاع الاتصال بالسيرفر |
| **الذكاء الاصطناعي** | **Google Gemini API** | تحليل وتوليد خطط المهام وهيكلتها بصيغة JSON دقيقة |
| **المحرك المحلي الاحتياطي**| **Rule-Based Matcher** | محرك ذكاء محلي مدمج يعمل أوفلاين عند غياب الشبكة أو المفتاح |
| **خادم الـ API** | **FastAPI & Uvicorn** | خادم بايثون غير متزامن فائق السرعة مع توثيق OpenAPI تلقائي |
| **قاعدة البيانات السحابية**| **PostgreSQL 14+** | قاعدة بيانات إنتاجية مع قيود الحذف المتسلسل (Cascades) |
| **مشغل قاعدة البيانات** | **SQLAlchemy 2.0 & Psycopg 3** | أحدث إصدارات مشغلات ومحولات بايثون لقواعد PostgreSQL |
| **التحقق من البيانات** | **Pydantic v2** | التحقق الدقيق والآمن من صحة المدخلات والمخرجات البرمجية |

---

## 🔌 نقاط نهاية الـ API (RESTful Endpoints)

يوفّر الباك إند 24 نقطة نهاية موثقة بالكامل عبر Swagger و ReDoc:

| الطريقة | المسار | الوصف البرمجي |
|:---:|:---|:---|
| `POST` | `/auth/register` | تسجيل حساب جديد وتشفير كلمة المرور بـ Bcrypt |
| `POST` | `/auth/login` | تسجيل الدخول واستخراج JWT Bearer Access Token |
| `GET` | `/auth/me` | استرجاع بيانات المستخدم الحالي المصدّق |
| `GET` / `POST` | `/tasks` | جلب مهام المستخدم أو إنشاء مهمة جديدة |
| `GET` / `PUT` / `DELETE`| `/tasks/{id}` | جلب، تحديث، أو حذف مهمة معينة |
| `GET` / `POST` | `/tasks/{id}/subtasks` | استعراض أو إضافة مهام فرعية لمهمة محددة |
| `PUT` / `DELETE` | `/subtasks/{id}` | تغيير حالة إنجاز مهمة فرعية أو حذفها |
| `GET` / `POST` | `/categories` | استعراض أو إنشاء تصنيفات ملونة مخصصة |
| `GET` / `PUT` / `DELETE`| `/categories/{id}` | قراءة أو تعديل اسم تصنيف أو حذفه |
| `GET` / `POST` | `/reminders` | إدارة التذكيرات والتنبيهات المجدولة بالوقت |
| `GET` / `PUT` / `users/settings` | قراءة أو تحديث إعدادات المستخدم (الثيم، اللغة) |
| `GET` | `/health` | فحص جاهزية الخادم والاتصال بقاعدة البيانات |

---

## 🚀 التشغيل السريع (في 3 دقائق)

### 1. تشغيل خادم الباك إند (FastAPI + PostgreSQL)

```bash
cd Backend
python -m venv venv

# نظام ويندوز (PowerShell):
venv\Scripts\activate
# نظام لينكس / ماك:
# source venv/bin/activate

pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

> **الإنشاء التلقائي لقاعدة البيانات**: عند الإقلاع، يتصل الخادم بـ PostgreSQL تلقائياً، وينشئ قاعدة بيانات `taskflow` إن لم تكن موجودة، ويتحقق من كافة الجداول الـ 8!
> 
> - **التوثيق التفاعلي (Swagger UI)**: `http://localhost:8000/docs`
> - **توثيق ReDoc**: `http://localhost:8000/redoc`

### 2. تشغيل تطبيق الهاتف (Flutter)

```bash
flutter pub get
flutter run
```

### 3. إعداد الذكاء الاصطناعي (اختياري)

1. احصل على مفتاح API مجاني من [Google AI Studio](https://aistudio.google.com/app/apikey).
2. افتح التطبيق وتوجه إلى **الإعدادات ← مفتاح الذكاء الاصطناعي**.
3. الصق المفتاح واحفظ. *إذا لم تُدخل مفتاحاً، سيعمل التطبيق بالمحرك المحلي المدمج دون الحاجة لإنترنت!*

---

## 📘 أدلة التوثيق الهندسية (PDF)

كافة ملفات التوثيق المعماري وهندسة النظام والكود المصدري متوفرة كملفات PDF رسمية في مجلد [`docs/`](docs/):

- 🏛️ [دليل معمارية النظام وتصميمه الهندسي (PDF)](docs/TaskFlow_Architecture_Manual.pdf)
- 📱 [دليل الشاشات ومزودات الحالة والودجت (PDF)](docs/TaskFlow_Screens_and_Providers_Guide.pdf)
- 💻 [مرجع الكود المصدري الشامل للفرونت إند (PDF)](docs/TaskFlow_Lib_Source_Code_Manual.pdf)

---

## 🧪 الاختبارات الآلية

نفّذ حزمة اختبارات التكامل لفحص كافة نقاط النهاية وعلاقات قاعدة البيانات:

```bash
cd Backend
python test_backend.py
```

---

## 💼 لماذا يُمثّل هذا المشروع إضافة مميزة في ملفات التوظيف والتقييمات؟

تم بناء TaskFlow ليعكس خبرة عملية متقدمة في هندسة البرمجيات:
1. **تطبيق واقعي متين (ليس مجرد Demo)**: يحل مشكلة انقطاع الشبكة في العالم الحقيقي عبر معمارية **Offline-First** مع التخزين المحلي في SQLite والتزامن الذكي عبر معترضات Dio.
2. **مرونة الذكاء الاصطناعي**: لا يتوقف التطبيق عند تعطل الخدمات الخارجية، بل يتحول تلقائياً لمحرك NLP محلي مبني بالقواعد اللغوية.
3. **سلامة وتماسك البيانات العلائقية**: قيود المفاتيح الأجنبية مع `CASCADE` على PostgreSQL تمنع بقاء أي بيانات يتيمة.
4. **كود نظيف وحماية متقدمة**: استخدام Pydantic v2 لضمان صحة البيانات، وتشفير Bcrypt لكلمات المرور، وجلسات JWT آمنة.

---

## 🤝 المساهمة في المشروع

نرحب بكافة المساهمات والمقترحات:

1. قم بعمل Fork للمستودع.
2. أنشئ فرعاً لميزتك (`git checkout -b feature/cool-feature`).
3. سجّل تغييراتك (`git commit -m "feat: add cool feature"`).
4. ارفع الفرع لمستودعك (`git push origin feature/cool-feature`).
5. افتح Pull Request.

---

## 📄 الرخصة

هذا المشروع مرخّص بالكامل تحت [MIT License](LICENSE) — ومتاح للاستخدام الشخصي والتعليمي والتجاري.

<br/>

<div align="center">

**إذا أعجبك تطبيق TaskFlow أو ساعدك في مشاريعك — لا تنسَ دعمه بنجمة ⭐ على [GitHub](https://github.com/mohammed-m-alhaj/taskflow)!**

<br/>

[![ملف المطور على GitHub](https://img.shields.io/badge/GitHub-mohammed--m--alhaj-181717?style=flat-square&logo=github)](https://github.com/mohammed-m-alhaj)
[![الإبلاغ عن مشكلة](https://img.shields.io/badge/أبلغ_عن_مشكلة-red?style=flat-square&logo=github)](https://github.com/mohammed-m-alhaj/taskflow/issues)

<br/>

*صُمم وهُندس بكل إتقان بواسطة محمد الحاج*

</div>

</div>