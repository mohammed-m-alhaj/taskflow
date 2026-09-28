<div align="center">

# ⚡ TaskFlow
### مدير مهامك الذكي — مجاني وبدون إنترنت

<br>

[![Download](https://img.shields.io/badge/⬇️%20%20تحميل%20التطبيق-APK%20مجاني-2563EB?style=for-the-badge)](https://github.com/mohammed-m-alhaj/taskflow/releases/latest)
[![Stars](https://img.shields.io/github/stars/mohammed-m-alhaj/taskflow?style=for-the-badge&color=yellow&label=⭐%20النجوم)](https://github.com/mohammed-m-alhaj/taskflow/stargazers)

<br>

> نظّم يومك، تتبّع مهامك، واستخدم الذكاء الاصطناعي لتخطيط كل شيء — كل ذلك من هاتفك

<br>

---

</div>

## 📲 تحميل التطبيق

| النسخة | الحجم | الرابط |
|--------|-------|--------|
| **الإصدار العادي** — موصى به | ~19 MB | [⬇️ تحميل](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Mobile_Optimized.apk) |
| **الإصدار الشامل** — لجميع الأجهزة | ~55 MB | [⬇️ تحميل](https://github.com/mohammed-m-alhaj/taskflow/releases/download/v1.0.0/TaskFlow_Universal.apk) |

> **ملاحظة:** بعد التحميل اذهب لـ الإعدادات ← الأمان ← السماح بتثبيت تطبيقات من مصادر غير معروفة

---

## ✨ ماذا يقدم لك TaskFlow؟

<table>
<tr>
<td width="50%">

### 🤖 مساعد AI مدمج
اكتب هدفك بالعربية — والتطبيق يحوّله لخطة مهام متكاملة مع مواعيد وأولويات

**مثال:** اكتب *"أذاكر مادة قواعد البيانات"* فيعطيك خطة خطوة بخطوة

</td>
<td width="50%">

### 📴 يعمل بدون إنترنت
كل بياناتك محفوظة على هاتفك مباشرة — لا حسابات سحابة، لا انقطاع

</td>
</tr>
<tr>
<td>

### 🗂️ تنظيم ذكي
- مهام وتحتها مهام فرعية
- أولويات: عالية / متوسطة / منخفضة
- تصنيفات ملونة تصنعها أنت
- تكرار تلقائي للمهام اليومية

</td>
<td>

### 📅 تقويم + تذكيرات
تصفح مهامك بالتاريخ واضبط تذكيرات لكل مهمة حتى لا يفوتك شيء

</td>
</tr>
<tr>
<td>

### 🌙 وضع ليلي
ثيم داكن كامل يحمي عينيك في الظلام

</td>
<td>

### 🔍 بحث فوري
ابحث في مهامك بالكلمات أو صفّها حسب الحالة والأولوية

</td>
</tr>
</table>

---

## 📸 لقطات من التطبيق

> *(أضف صور حقيقية للتطبيق هنا — هذا يزيد التحميلات بشكل كبير)*

---

## 🚀 كيف أبدأ؟

### التحميل والتثبيت
1. حمّل الـ APK من الجدول أعلاه
2. افتح الملف من التنزيلات
3. اضغط **تثبيت** ← **السماح** إذا طلب الإذن
4. افتح **TaskFlow** وسجّل حسابك

### استخدام مساعد AI
1. افتح التطبيق واضغط أيقونة الروبوت 🤖
2. اكتب ما تريد تحقيقه بالعربية
3. اضغط **إرسال** — ستحصل على خطة جاهزة
4. اضغط **أضف للمهام** لحفظها مباشرة

> 💡 **لتجربة AI كاملة:** أدخل [Gemini API Key](https://aistudio.google.com/app/apikey) مجانية من Google في إعدادات التطبيق

---

## 🛠️ للمطورين — تشغيل المشروع

<details>
<summary>اضغط لعرض تعليمات التطوير</summary>

### المتطلبات
- Flutter 3.x
- Python 3.9+
- Android Studio / VS Code

### تشغيل الـ Frontend

```bash
git clone https://github.com/mohammed-m-alhaj/taskflow.git
cd taskflow
flutter pub get
flutter run
```

### تشغيل الـ Backend

```bash
cd Backend
python -m venv venv
venv\Scripts\activate        # Windows
# source venv/bin/activate   # Linux/macOS

pip install fastapi uvicorn sqlalchemy pydantic
uvicorn app.main:app --reload
```

التوثيق التفاعلي: **http://localhost:8000/docs**

### التقنيات المستخدمة

**Frontend:** Flutter · Dart · Provider · Dio · SQLite · Shimmer

**Backend:** FastAPI · SQLAlchemy · Pydantic · Uvicorn

**AI:** Google Gemini API + محرك ذكاء اصطناعي محلي احتياطي

</details>

---

## 🗺️ القادم قريباً

- [ ] 📊 تقارير إنتاجيتك الأسبوعية
- [ ] 🔄 مزامنة عبر أجهزة متعددة
- [ ] 📌 ودجت للشاشة الرئيسية
- [ ] 🍎 إصدار iOS
- [ ] 🌐 واجهة إنجليزية

---

## 🤝 هل تريد المساهمة؟

كل مساهمة مرحّب بها — سواء كانت إصلاح خطأ أو ميزة جديدة أو حتى تحسين الترجمة.

1. اعمل **Fork** للمستودع
2. أنشئ branch جديد: `git checkout -b feature/اسم-الميزة`
3. Commit تعديلاتك: `git commit -m "feat: وصف التعديل"`
4. افتح **Pull Request** — وسأراجعه بأسرع وقت

---

<div align="center">

**إذا أفادك TaskFlow — نجمة ⭐ تساعد كثيراً في نشره للناس!**

<br>

صُنع بـ ❤️ · [الإبلاغ عن مشكلة](https://github.com/mohammed-m-alhaj/taskflow/issues) · [طلب ميزة](https://github.com/mohammed-m-alhaj/taskflow/issues/new)

</div>
