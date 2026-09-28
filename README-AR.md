<div align="center">

# TaskFlow

**تطبيق إدارة المهام والإنتاجية الذكي — يعمل بدون إنترنت مع مساعد تخطيط بالذكاء الاصطناعي.**

<br/>

[![Release](https://img.shields.io/github/v/release/mohammed-m-alhaj/taskflow?include_prereleases&style=flat-square)](https://github.com/mohammed-m-alhaj/taskflow/releases)
[![Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=flat-square&color=yellow)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-009688?style=flat-square&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-4169E1?style=flat-square&logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![SQLite](https://img.shields.io/badge/SQLite-Offline_First-003B57?style=flat-square&logo=sqlite&logoColor=white)](https://sqlite.org)
[![English](https://img.shields.io/badge/Language-English-2563EB?style=flat-square)](README.md)

<br/>

[التحميل](#التحميل) • [المميزات](#المميزات) • [التشغيل السريع](#التشغيل-السريع) • [المعمارية التقنية](#المعمارية-التقنية) • [ملفات التوثيق](#ملفات-التوثيق) • [English](README.md)

</div>

---

<div dir="rtl">

**TaskFlow** هو تطبيق لإدارة المهام والإنتاجية مصمم للسرعة، ودعم العربية الأصيل (RTL)، والاستقلالية التامة عن الإنترنت.

يحفظ التطبيق البيانات محلياً في **SQLite** لاستجابة فورية، ويتزامن مع خادم **FastAPI** وقاعدة بيانات **PostgreSQL** عند توفر الشبكة، مع مساعد ذكاء اصطناعي يعتمد على **Google Gemini** ومحرك ذكاء محلي لتفكيك الأهداف المعقدة إلى خطوات عمل بسيطة.

---

## المميزات

- **⚡ أولوية العمل دون إنترنت**: قراءة وكتابة فورية عبر **SQLite** المحلي دون انتظار استجابة السيرفر.
- **🤖 تفكيك المهام بالذكاء الاصطناعي**: تحويل أهدافك إلى مهام وأولويات ومهام فرعية عبر Gemini API أو المحرك المحلي الاحتياطي.
- **🔄 مزامنة سحابية متعددة المستخدمين**: خادم FastAPI مع PostgreSQL ومصادقة مشفرة بـ JWT و Bcrypt.
- **📅 تقويم وتذكيرات**: استعراض زمني للمهام وتنبيهات مجدولة وقواعد تكرار للمهام الدورية.
- **🏷️ تصنيفات وقوائم فرعية**: فئات مخصصة وقوائم تدقيق (Checklists) داخل كل مهمة.
- **🇸🇦 واجهة عربية كاملة**: دعم RTL كامل وتصميم Material 3 بخط ثمانية (Thmanyah Sans).

---

## التحميل

نسخ APK جاهزة ومباشرة لأجهزة أندرويد:

| النسخة | المعمارية | الحجم | رابط التحميل |
|:---|:---:|:---:|:---|
| **النسخة الخفيفة** *(موصى بها)* | ARM64-v8a | ~19.4 MB | [⬇️ تحميل APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) |
| **النسخة الشاملة** | لكافة الأجهزة | ~54.5 MB | [⬇️ تحميل APK](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) |

---

## التشغيل السريع

### 1. تشغيل الخادم (FastAPI + PostgreSQL)

**المتطلبات:** بايثون 3.9+ وقاعدة بيانات PostgreSQL تعمل على المنفذ `5432`.

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

> يقوم الخادم تلقائياً بالتحقق من قاعدة البيانات وإنشاء الجداول عند التشغيل.
>
> التوثيق التفاعلي للـ API: `http://localhost:8000/docs` أو `http://localhost:8000/redoc`.

### 2. تشغيل تطبيق Flutter

**المتطلبات:** Flutter SDK 3.10+ وجهاز أندرويد أو محاكي.

```bash
flutter pub get
flutter run

# لبناء ملف APK الإنتاجي:
flutter build apk --split-per-abi
```

### 3. إعداد الذكاء الاصطناعي (اختياري)

أضف مفتاح Gemini API من Google AI Studio في **الإعدادات ← مفتاح AI**. في حال عدم إدخال مفتاح، يعمل التطبيق بالمحرك المحلي المدمج.

---

## المعمارية التقنية

```
تطبيق Flutter (12 شاشة · 5 مزودي حالة Providers · 4 خدمات Services)
      │
      ├── قاعدة SQLite المحلية (حفظ فوري دون إنترنت)
      │
      └── واجهة REST API (Dio) ──► خادم FastAPI ──► قاعدة PostgreSQL (taskflow)
                                       │
                               مصادقة JWT · SQLAlchemy 2.0 · Pydantic v2
```

---

## ملفات التوثيق

أدلة المعمارية التفصيلية ودليل شاشات التطبيق والكود المصدري متوفرة بصيغة PDF داخل مجلد [`docs/`](docs/):

- 📘 [دليل معمارية النظام (TaskFlow Architecture Manual)](docs/TaskFlow_Architecture_Manual.pdf)
- 📱 [دليل الشاشات ومزودات الحالة (Screens & Providers Guide)](docs/TaskFlow_Screens_and_Providers_Guide.pdf)
- 💻 [دليل الكود المصدري (Source Code Manual)](docs/TaskFlow_Lib_Source_Code_Manual.pdf)

---

## الاختبارات

لتشغيل حزمة الاختبارات التكاملية للـ Backend وقاعدة البيانات:

```bash
cd Backend
python test_backend.py
```

---

## المساهمة

نرحب بمساهمات المطورين:

1. Fork للمستودع
2. إنشاء فرع لميزتك (`git checkout -b feature/amazing-feature`)
3. Commit لتعديلاتك (`git commit -m "feat: add amazing feature"`)
4. Push للفرع (`git push origin feature/amazing-feature`)
5. فتح Pull Request

---

## الرخصة

هذا المشروع مرخّص تحت رخصة **MIT** — راجع ملف [LICENSE](LICENSE) للتفاصيل.

<br/>

<div align="center">

**إذا أعجبك TaskFlow، شاركنا بدعمه بنجمة ⭐ على [GitHub](https://github.com/mohammed-m-alhaj/taskflow)!**

</div>

</div>