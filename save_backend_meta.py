import json

backend_files = [
    {
        'file_name': 'main.py',
        'file_path': 'Backend/app/main.py',
        'category': 'نواة الخادم (Core Server)',
        'role': 'نقطة الانطلاق الرئيسية لخادم FastAPI. يقوم بإنشاء تطبيق FastAPI، وضبط إعدادات CORS للسماح بالاتصال من الجوال والويب، وتضمين جميع مسارات وموجهات الـ API (Routers)، وبدء تشغيل قاعدة البيانات.',
        'key_items': 'FastAPI, CORSMiddleware, include_router, auth.router, tasks.router, categories.router, subtasks.router, reminders.router, settings.router.',
        'doctor_q': 'ما فائدة CORSMiddleware في main.py؟',
        'doctor_a': 'تسمح لتطبيقات الجوال والويب بالوصول إلى الـ API بحرية ومنع أخطاء تقييد المصدر المشترك (Cross-Origin Resource Sharing).'
    },
    {
        'file_name': 'database.py',
        'file_path': 'Backend/app/database.py',
        'category': 'قاعدة البيانات (Database Config)',
        'role': 'المسؤول عن الاتصال بقاعدة بيانات PostgreSQL. يحتوي على دالة create_database لإنشاء قاعدة taskflow تلقائياً إذا لم تكن موجودة، وإعداد create_engine و sessionmaker ودالة get_db كـ Dependency Injection.',
        'key_items': 'create_engine, sessionmaker, declarative_base, create_database(), get_db(), DATABASE_URL, SERVER_URL, psycopg.',
        'doctor_q': 'ما دور دالة get_db() وكيف تُستخدم؟',
        'doctor_a': 'تعتبر مولد جلسة (Session Generator) يُحقن في مسارات FastAPI عبر Depends(get_db)، حيث يفتح جلسة عمل مع PostgreSQL ويغلقها تلقائياً بعد انتهاء الطلب (Resource Management).'
    },
    {
        'file_name': 'services/auth_service.py',
        'file_path': 'Backend/app/services/auth_service.py',
        'category': 'خدمات الأمان والمصادقة (Auth Service)',
        'role': 'الطبقة المسؤولة عن أمان وكلمات مرور المستخدمين؛ تشفير كلمات المرور باستخدام خوارزمية Bcrypt، والتحقق منها، وتوليد والتحقق من رموز الـ JWT (JSON Web Tokens).',
        'key_items': 'CryptContext, bcrypt, create_access_token(), verify_password(), hash_password(), jwt.encode, jwt.decode, SECRET_KEY, ALGORITHM.',
        'doctor_q': 'لماذا نستخدم تشفير Bcrypt لكلمات المرور ولا نخزنها كنص عادي أو تشفير MD5؟',
        'doctor_a': 'لأن Bcrypt تستخدم التمليح العشوائي (Salt) والـ Slow Hashing، مما يجعلها مقاومة لهجمات القوة الغاشمة (Brute-force) وهجمات جداول قوس قزح (Rainbow Tables).'
    },
    {
        'file_name': 'models/user.py',
        'file_path': 'Backend/app/models/user.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول المستخدمين (users) في PostgreSQL؛ يحفظ معرف المستخدم، اسمه، بريده الإلكتروني الفريد، كلمة المرور المشفرة، وتاريخ الإنشاء، مع علاقاته بالمهام والتصنيفات.',
        'key_items': 'User Class, id, name, email, hashed_password, created_at, relationship(tasks), relationship(categories).',
        'doctor_q': 'لماذا تم وضع unique=True على حقل email في جدول User؟',
        'doctor_a': 'لمنع تسجيل أكثر من حساب بنفس البريد الإلكتروني على مستوى قاعدة البيانات (Database Constraint).'
    },
    {
        'file_name': 'models/task.py',
        'file_path': 'Backend/app/models/task.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول المهام (tasks) في PostgreSQL؛ يحفظ العنوان، الوصف، الأولوية (high, medium, low)، الحالة، تاريخ الاستحقاق، ومعرف المستخدم ومعرف التصنيف، وعلاقة بالمهام الفرعية والتذكيرات.',
        'key_items': 'Task Class, id, user_id, category_id, title, description, priority, status, due_date, is_completed, subtasks, reminders.',
        'doctor_q': 'ما هو نوع العلاقة بين جدول User وجدول Task؟',
        'doctor_a': 'علاقة One-to-Many (واحد إلى متعدد)؛ المستخدم الواحد يملك مهاماً متعددة، وترتبط عبر المفتاح الأجنبي user_id.'
    },
    {
        'file_name': 'models/subtask.py',
        'file_path': 'Backend/app/models/subtask.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول المهام الفرعية (subtasks)؛ يرتبط بالمهمة الرئيسية بمفتاح أجنبي task_id مع خاصية الحذف المتتالي (Cascade Delete).',
        'key_items': 'Subtask Class, id, task_id, title, is_completed, created_at, relationship(task).',
        'doctor_q': 'ماذا يحدث للمهام الفرعية إذا تم حذف المهمة الرئيسية من جدول المهام؟',
        'doctor_a': 'يتم حذفها تلقائياً بفضل خاصية الحذف المتعاقب cascade delete لمنع وجود سجلات يتيمة في قاعدة البيانات.'
    },
    {
        'file_name': 'models/category.py',
        'file_path': 'Backend/app/models/category.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول التصنيفات (categories)؛ يحفظ اسم التصنيف، لونه، وأيقونته التابع لمستخدم محدد.',
        'key_items': 'Category Class, id, user_id, name, color, icon, created_at, relationship(tasks).',
        'doctor_q': 'هل التصنيف يتبع مستخدم محدد أم عام للجميع؟',
        'doctor_a': 'يتبع مستخدم محدد عبر مفتاح أجنبي user_id لضمان خصوصية وعزل تصنيفات كل مستخدم.'
    },
    {
        'file_name': 'models/reminder.py',
        'file_path': 'Backend/app/models/reminder.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول التذكيرات (reminders)؛ يحفظ مواعيد التذكيرات المرتبطة بالمهام وتاريخ استحقاق التنبيه.',
        'key_items': 'Reminder Class, id, task_id, reminder_time, is_enabled, created_at.',
        'doctor_q': 'كيف يتم حفظ التاريخ والوقت في جدول التذكيرات في PostgreSQL؟',
        'doctor_a': 'يتم حفظه بنوع DateTime مع دعم المنطقة الزمنية لضمان التعامل الدقيق مع التوقيت.'
    },
    {
        'file_name': 'models/user_settings.py',
        'file_path': 'Backend/app/models/user_settings.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول إعدادات وتفضيلات المستخدم؛ يحفظ وضع المظهر المفضل (dark/light) وحالة الإشعارات.',
        'key_items': 'UserSettings Class, id, user_id, theme_mode, notifications_enabled, language.',
        'doctor_q': 'ما الفائدة من حفظ إعدادات المستخدم في السيرفر مع وجودها في الهاتف؟',
        'doctor_a': 'لمزامنة تفضيلات المستخدم عبر جميع أجهزته المختلفة إذا سجل دخوله من جهاز هاتف آخر أو متصفح الويب.'
    },
    {
        'file_name': 'models/calendar_event.py',
        'file_path': 'Backend/app/models/calendar_event.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول أحداث التقويم المتكاملة مع المهام المجدولة.',
        'key_items': 'CalendarEvent Class, id, user_id, title, start_time, end_time, is_all_day.',
        'doctor_q': 'ما دور نموذج CalendarEvent في الباك إند؟',
        'doctor_a': 'دعم عرض وإدارة المواعيد المجدولة على شكل أحداث تقويمية متسلسلة.'
    },
    {
        'file_name': 'models/recurrence_rule.py',
        'file_path': 'Backend/app/models/recurrence_rule.py',
        'category': 'جداول قاعدة البيانات (SQLAlchemy ORM)',
        'role': 'جدول قواعد تكرار المهام (يومياً، أسبوعياً، شهرياً).',
        'key_items': 'RecurrenceRule Class, id, task_id, frequency, interval, end_date.',
        'doctor_q': 'كيف تدعم المهام المتكررة معمارياً في قاعدة البيانات؟',
        'doctor_a': 'بفصل منطق وقواعد التكرار في جدول مستقل RecurrenceRule يرتبط بالمهمة دون تشويه الجدول الأساسي.'
    },
    {
        'file_name': 'schemas/auth.py',
        'file_path': 'Backend/app/schemas/auth.py',
        'category': 'مخططات التحقق (Pydantic Schemas)',
        'role': 'نماذج Pydantic للتحقق الصارم من مدخلات التسجيل وتسجيل الدخول واستجابة بيانات التوكن والمستخدم.',
        'key_items': 'UserRegister, UserLogin, Token, TokenData, UserResponse, EmailStr, BaseModel.',
        'doctor_q': 'ما الفرق بين موديلات SQLAlchemy ومخططات Pydantic في مشروعك؟',
        'doctor_a': 'موديلات SQLAlchemy مسؤولة عن تمثيل الجداول والتعامل مع قاعدة البيانات، بينما Pydantic Schemas مسؤولة عن التحقق من صحة البيانات القادمة من العميل وتنسيق الردود.'
    },
    {
        'file_name': 'schemas/task.py',
        'file_path': 'Backend/app/schemas/task.py',
        'category': 'مخططات التحقق (Pydantic Schemas)',
        'role': 'مخططات التحقق من إنشاء وتعديل واسترجاع المهام.',
        'key_items': 'TaskCreate, TaskUpdate, TaskResponse, TaskWithSubtasks, ConfigDict(from_attributes=True).',
        'doctor_q': 'ما معنى from_attributes=True في Pydantic v2؟',
        'doctor_a': 'تسمح للـ Schema بقراءة البيانات مباشرة من كائنات الـ ORM وتحويلها تلقائياً إلى قاموس JSON دون الحاجة لتحويل يدوي.'
    },
    {
        'file_name': 'schemas/subtask.py',
        'file_path': 'Backend/app/schemas/subtask.py',
        'category': 'مخططات التحقق (Pydantic Schemas)',
        'role': 'مخططات التحقق لإنشاء وتحديث واسترجاع المهام الفرعية.',
        'key_items': 'SubtaskCreate, SubtaskUpdate, SubtaskResponse.',
        'doctor_q': 'لماذا نجعل حقول التحديث Optional في SubtaskUpdate؟',
        'doctor_a': 'لدعم التحديث الجزئي (Partial Update)؛ حتى يستطيع العميل إرسال الحقل المراد تعديله فقط مثل is_completed.'
    },
    {
        'file_name': 'schemas/category.py',
        'file_path': 'Backend/app/schemas/category.py',
        'category': 'مخططات التحقق (Pydantic Schemas)',
        'role': 'مخططات التحقق من بيانات التصنيفات (اسم التصنيف، اللون، الأيقونة).',
        'key_items': 'CategoryCreate, CategoryUpdate, CategoryResponse.',
        'doctor_q': 'كيف تضمن عدم إرسال اسم تصنيف فارغ للباك إند؟',
        'doctor_a': 'من خلال قيود Pydantic للتحقق التلقائي وإرجاع 422 Unprocessable Entity في حال المخالفة.'
    },
    {
        'file_name': 'schemas/reminder.py',
        'file_path': 'Backend/app/schemas/reminder.py',
        'category': 'مخططات التحقق (Pydantic Schemas)',
        'role': 'مخططات التحقق لمواعيد التذكيرات وحالتها.',
        'key_items': 'ReminderCreate, ReminderResponse, reminder_time.',
        'doctor_q': 'ما هو نوع التحقق المستخدم على reminder_time؟',
        'doctor_a': 'نوع datetime لضمان أن القيمة القادمة تمثل تاريخاً ووقتاً صالحاً ومطابقاً للمعايير الدولية.'
    },
    {
        'file_name': 'schemas/settings.py',
        'file_path': 'Backend/app/schemas/settings.py',
        'category': 'مخططات التحقق (Pydantic Schemas)',
        'role': 'مخططات استلام وتحديث إعدادات التطبيق والمظهر للمستخدم.',
        'key_items': 'UserSettingsUpdate, UserSettingsResponse.',
        'doctor_q': 'كيف يتم التحقق من قيم theme_mode المدخلة؟',
        'doctor_a': 'يمكن تقييدها بقيم محددة مسبقاً (light, dark, system) لمنع إدخال نصوص عشوائية.'
    },
    {
        'file_name': 'routers/auth.py',
        'file_path': 'Backend/app/routers/auth.py',
        'category': 'موجهات المسارات (API Routers)',
        'role': 'مسارات المصادقة: /auth/register لتسجيل مستخدم جديد مع فحص تكرار الإيميل وتشفير الرمز، و /auth/login للتحقق من كلمة المرور وإرجاع JWT Token، و /auth/me لجلب بيانات المستخدم الحالي.',
        'key_items': 'register(), login(), get_current_user(), Depends(get_db), HTTP_400_BAD_REQUEST, HTTP_401_UNAUTHORIZED.',
        'doctor_q': 'كيف يتم تأمين مسار /auth/me؟',
        'doctor_a': 'عبر حقن التابع get_current_user؛ حيث يقوم باستخراج التوكن من الهيدر Authorization: Bearer وفك تشفيره والتأكد من صلاحيته وجلب المستخدم.'
    },
    {
        'file_name': 'routers/tasks.py',
        'file_path': 'Backend/app/routers/tasks.py',
        'category': 'موجهات المسارات (API Routers)',
        'role': 'مسارات إدارة المهام الكاملة (CRUD): جلب مهام المستخدم الحالي فقط، إنشاء مهمة جديدة، تعديل مهمة، وحذف مهمة بالـ ID.',
        'key_items': 'get_tasks(), create_task(), get_task(), update_task(), delete_task(), filter(Task.user_id == current_user.id).',
        'doctor_q': 'كيف تضمن عدم قدرة مستخدم على رؤية أو تعديل مهام مستخدم آخر؟',
        'doctor_a': 'بفلترة كل الاستعلامات بـ Task.user_id == current_user.id؛ فمعرف المستخدم يُستخرج بأمان من التوكن المفكك ولا يقبل التزوير.'
    },
    {
        'file_name': 'routers/subtasks.py',
        'file_path': 'Backend/app/routers/subtasks.py',
        'category': 'موجهات المسارات (API Routers)',
        'role': 'مسارات المهام الفرعية: جلب المهام الفرعية التابعة لمهمة معينة، إنشاء مهمة فرعية، تحديثها، وحذفها.',
        'key_items': 'get_subtasks(), create_subtask(), update_subtask(), delete_subtask().',
        'doctor_q': 'لماذا تم فصل مسارات المهام الفرعية في ملف مستقل؟',
        'doctor_a': 'للحفاظ على معمارية معيارية نظيفة وتسهيل صيانة وتطوير كل جزء بشكل مستقل.'
    },
    {
        'file_name': 'routers/categories.py',
        'file_path': 'Backend/app/routers/categories.py',
        'category': 'موجهات المسارات (API Routers)',
        'role': 'مسارات التصنيفات: جلب تصنيفات المستخدم الحالي، إنشاء تصنيف، وتعديل أو حذف تصنيف.',
        'key_items': 'get_categories(), create_category(), delete_category().',
        'doctor_q': 'ما هو رمز الاستجابة HTTP عند حذف تصنيف بنجاح؟',
        'doctor_a': 'رمز 204 No Content أو 200 OK مع رسالة تأكيد الحذف.'
    },
    {
        'file_name': 'routers/reminders.py',
        'file_path': 'Backend/app/routers/reminders.py',
        'category': 'موجهات المسارات (API Routers)',
        'role': 'مسارات التذكيرات: جلب جميع التذكيرات للمستخدم، جلب تذكيرات مهمة معينة، إنشاء تذكير، وحذف تذكير.',
        'key_items': 'get_all_reminders(), get_task_reminders(), create_reminder(), delete_reminder().',
        'doctor_q': 'كيف يتأكد مسار التذكيرات من ملكية المهمة قبل إضافة التذكير؟',
        'doctor_a': 'يقوم أولاً بالاستعلام عن المهمة والتأكد من أنها تخص current_user.id، فإذا لم تكن تخصه يعيد 404 Not Found أو 403 Forbidden.'
    },
    {
        'file_name': 'routers/settings.py',
        'file_path': 'Backend/app/routers/settings.py',
        'category': 'موجهات المسارات (API Routers)',
        'role': 'مسارات إعدادات المستخدم: جلب إعدادات المستخدم الحالي وتحديث المظهر أو حالة الإشعارات.',
        'key_items': 'get_settings(), update_settings().',
        'doctor_q': 'ماذا يفعل المسار إذا كان المستخدم جديداً ولم تُنشأ له إعدادات مسبقة؟',
        'doctor_a': 'يقوم بإنشاء سجل إعدادات افتراضي وحفظه في قاعدة البيانات وإرجاعه فوراً.'
    },
    {
        'file_name': 'check_db.py',
        'file_path': 'Backend/check_db.py',
        'category': 'أدوات التشخيص والصيانة (Utilities)',
        'role': 'سكريبت تشخيصي سريع لفحص الاتصال المباشر بـ PostgreSQL وطباعة أسماء الجداول وعدد المهام والمستخدمين للتأكد من سلامة النظام.',
        'key_items': 'psycopg, check_connection, table inspection.',
        'doctor_q': 'ما فائدة سكريبت check_db.py في المشروع؟',
        'doctor_a': 'أداة مساعدة للمطور لفحص جاهزية قاعدة البيانات وتشخيص أي مشاكل في الاتصال بسرعة دون تشغيل السيرفر بالكامل.'
    },
    {
        'file_name': 'test_backend.py',
        'file_path': 'Backend/test_backend.py',
        'category': 'الاختبارات الآلية (Automated Tests)',
        'role': 'مجموعة اختبارات تكاملية وشاملة لجميع مسارات الـ API (المصادقة، المهام، التصنيفات، التذكيرات، المهام الفرعية) للتأكد من عمل النظام بنسبة 100%.',
        'key_items': 'TestClient, pytest, test_register, test_login, test_tasks_crud, test_categories_crud, assertions.',
        'doctor_q': 'ما هي أهمية test_backend.py في المشاريع الاحترافية؟',
        'doctor_a': 'يضمن موثوقية وجودة النظام، ويتأكد من أن أي تعديل جديد لا يكسر الميزات السابقة.'
    }
]

with open('docs/backend_data.json', 'w', encoding='utf-8') as f:
    json.dump(backend_files, f, ensure_ascii=False, indent=2)

print(f'Exported {len(backend_files)} backend files metadata successfully.')
