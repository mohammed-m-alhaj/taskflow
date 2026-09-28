import 'dart:convert';
import 'package:dio/dio.dart';

class AiTaskPlan {
  final String title;
  final String categoryName;
  final String priority;
  final DateTime dueDate;
  final String explanation;
  final List<String> subtasks;

  AiTaskPlan({
    required this.title,
    required this.categoryName,
    required this.priority,
    required this.dueDate,
    required this.explanation,
    required this.subtasks,
  });
}

class AiChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final AiTaskPlan? taskPlan;

  AiChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.taskPlan,
  });
}

class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;
  AiService._internal();

  String? _customApiKey;
  bool get isUsingGemini => _customApiKey != null && _customApiKey!.isNotEmpty;
  String? get apiKey => _customApiKey;

  void setApiKey(String key) {
    _customApiKey = key.trim();
  }

  Future<AiChatMessage> processMessage(String userPrompt) async {
    final query = userPrompt.trim();

    if (_customApiKey != null && _customApiKey!.isNotEmpty) {
      try {
        final onlineResult = await _queryGemini(query, _customApiKey!);
        if (onlineResult != null) return onlineResult;
      } catch (_) {}
    }

    return _generateSmartLocalResponse(query);
  }

  Future<List<String>> generateSubtasksForTask(String taskTitle) async {
    final plan = _extractPlanFromPrompt(taskTitle);
    return plan.subtasks;
  }

  Future<AiChatMessage?> _queryGemini(String prompt, String apiKey) async {
    final sysPrompt =
        'أنت مساعد ذكي لتطبيق إدارة المهام تاسك فلو. قم بتحليل طلب المستخدم وإرجاع نص إرشادي وخطة مهام دقيقة بصيغة JSON تحتوي على: title, categoryName, priority, daysUntilDue, explanation, subtasks (قائمة نصوص).';

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 6),
        receiveTimeout: const Duration(seconds: 6),
      ),
    );

    final response = await dio.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey',
      data: {
        'contents': [
          {
            'parts': [
              {'text': '$sysPrompt\nطلب المستخدم: $prompt'}
            ]
          }
        ]
      },
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : jsonDecode(response.data.toString()) as Map<String, dynamic>;
      final rawText =
          data['candidates']?[0]?['content']?['parts']?[0]?['text'] as String?;
      if (rawText != null) {
        final plan = _tryParseJsonPlan(rawText, prompt);
        return AiChatMessage(
          text: plan?.explanation ?? rawText,
          isUser: false,
          timestamp: DateTime.now(),
          taskPlan: plan,
        );
      }
    }
    return null;
  }

  AiTaskPlan? _tryParseJsonPlan(String raw, String fallbackTitle) {
    try {
      final start = raw.indexOf('{');
      final end = raw.lastIndexOf('}');
      if (start != -1 && end != -1 && end > start) {
        final jsonStr = raw.substring(start, end + 1);
        final map = jsonDecode(jsonStr);
        final subtasksRaw = map['subtasks'] as List? ?? [];
        return AiTaskPlan(
          title: map['title'] ?? fallbackTitle,
          categoryName: map['categoryName'] ?? 'عام',
          priority: map['priority'] ?? 'medium',
          dueDate: DateTime.now().add(Duration(days: map['daysUntilDue'] ?? 3)),
          explanation: map['explanation'] ?? '',
          subtasks: subtasksRaw.map((e) => e.toString()).toList(),
        );
      }
    } catch (_) {}
    return null;
  }

  AiChatMessage _generateSmartLocalResponse(String prompt) {
    final clean = prompt.toLowerCase();

    if (_isProductivityQuestion(clean)) {
      return _generateProductivityAdvice(clean);
    }

    final plan = _extractPlanFromPrompt(prompt);

    final responseText =
        'لقد قمت بتحليل هدفك بدقة ووضعت لك استراتيجية تنفيذية مجزأة إلى خطوات واضحة ومحددة. يمكنك مراجعة الخطة والضغط على الزر أدناه لإضافتها فوراً إلى قائمة مهامك.';

    return AiChatMessage(
      text: responseText,
      isUser: false,
      timestamp: DateTime.now(),
      taskPlan: plan,
    );
  }

  bool _isProductivityQuestion(String text) {
    return text.contains('كيف') ||
        text.contains('ما هي') ||
        text.contains('ما هو') ||
        text.contains('نصيحة') ||
        text.contains('طريقة') ||
        text.contains('بومودورو') ||
        text.contains('أيزنهاور') ||
        text.contains('تنظيم الوقت') ||
        text.contains('تشتت');
  }

  AiChatMessage _generateProductivityAdvice(String text) {
    String advice;
    AiTaskPlan? plan;

    if (text.contains('بومودورو') || text.contains('pomodoro')) {
      advice =
          'تقنية بومودورو (Pomodoro Technique) تعتمد على العمل المركز لمدة 25 دقيقة متبوعة باستراحة 5 دقائق، وبعد 4 جلسات تأخذ استراحة أطول (15-30 دقيقة). هذا الأسلوب يمنع الإجهاد الذهني ويحافظ على أعلى درجات التركيز.';
      plan = AiTaskPlan(
        title: 'تطبيق جلسات بومودورو المركزة',
        categoryName: 'شخصي',
        priority: 'medium',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        explanation: 'خطة تدريبية لتطبيق تقنية بومودورو اليوم',
        subtasks: [
          'تحديد مهمة واحدة محددة للتركيز عليها',
          'إغلاق جميع المشتتات ووضع الهاتف على الصامت',
          'بدء الجلسة الأولى (25 دقيقة تركيز تام)',
          'أخذ استراحة قصيرة مدتها 5 دقائق للمشي وشرب الماء',
          'إتمام 4 جلسات متتالية وتسجيل مقدار الإنجاز',
        ],
      );
    } else if (text.contains('أيزنهاور') || text.contains('eisenhower')) {
      advice =
          'مصفوفة أيزنهاور تقسم مهامك إلى 4 مربعات:\n1. عاجل ومهم: نفذه فوراً.\n2. مهم وغير عاجل: خطط له وجدوله (أهم مربع للنجاح).\n3. عاجل وغير مهم: فوضه لغيرك.\n4. غير عاجل وغير مهم: احذفه وتخلص منه.';
      plan = AiTaskPlan(
        title: 'تصنيف وتصفية المهام بمصفوفة أيزنهاور',
        categoryName: 'عمل',
        priority: 'high',
        dueDate: DateTime.now().add(const Duration(days: 2)),
        explanation: 'إعادة ترتيب الأولويات وفق الأهمية والإلحاح',
        subtasks: [
          'كتابة جميع الأفكار والمهام العالقة في ورقة',
          'فرز المهام العاجلة والمهمة وبدء تنفيذها اليوم',
          'جدولة المهام الاستراتيجية طويلة المدى للأسبوع القادم',
          'التخلص من الأنشطة المستهلكة للوقت بدون فائدة',
        ],
      );
    } else if (text.contains('تشتت') || text.contains('تركيز')) {
      advice =
          'للتغلب على التشتت: حدد مهمة واحدة فقط في اللحظة (Mono-tasking)، نظف بيئة العمل من الفوضى، واستخدم قاعدة الـ 5 دقائق (ابدأ المهمة لمدة 5 دقائق فقط وسيتلاشى حاجز البدء النفسي).';
    } else {
      advice =
          'أفضل استراتيجية لإدارة الوقت هي قاعدة الـ 20/80 (مبدأ باريتو): 20% من مجهودك يحقق 80% من نتائجك. ركز دائماً على المهام ذات التأثير الأكبر أولاً في بداية يومك.';
    }

    return AiChatMessage(
      text: advice,
      isUser: false,
      timestamp: DateTime.now(),
      taskPlan: plan,
    );
  }

  AiTaskPlan _extractPlanFromPrompt(String prompt) {
    final clean = prompt.toLowerCase();

    String priority = 'medium';
    if (clean.contains('عاجل') ||
        clean.contains('ضروري') ||
        clean.contains('امتحان') ||
        clean.contains('اختبار') ||
        clean.contains('مهم جدا') ||
        clean.contains('فوري') ||
        clean.contains('حرج') ||
        clean.contains('اليوم')) {
      priority = 'high';
    } else if (clean.contains('لاحق') ||
        clean.contains('بسيط') ||
        clean.contains('فراغ') ||
        clean.contains('اختياري')) {
      priority = 'low';
    }

    DateTime dueDate = DateTime.now().add(const Duration(days: 3));
    if (clean.contains('اليوم')) {
      dueDate = DateTime.now().add(const Duration(hours: 6));
    } else if (clean.contains('غدا') || clean.contains('بكرة')) {
      dueDate = DateTime.now().add(const Duration(days: 1));
    } else if (clean.contains('أسبوع') || clean.contains('اسبوع')) {
      dueDate = DateTime.now().add(const Duration(days: 7));
    } else if (clean.contains('شهر')) {
      dueDate = DateTime.now().add(const Duration(days: 30));
    }

    String categoryName = 'عام';
    List<String> subtasks;

    if (clean.contains('مذاكرة') ||
        clean.contains('اختبار') ||
        clean.contains('امتحان') ||
        clean.contains('دراسة') ||
        clean.contains('كتاب') ||
        clean.contains('فصل') ||
        clean.contains('محاضرة')) {
      categoryName = 'دراسة';
      subtasks = [
        'قراءة الفهرس وتحديد الموضوعات الأكثر أهمية في المقرر',
        'تلخيص المفاهيم والمصطلحات الأساسية في نقاط مركزة',
        'حل التمارين والمسائل ونماذج الاختبارات السابقة',
        'مراجعة الأخطاء وتثبيت القوانين والنقاط غير المفهومة',
        'عمل اختبار تجريبي ذاتي في بيئة هادئة ومماثلة للامتحان',
        'مراجعة سريعة شاملة قبل موعد الامتحان بـ 24 ساعة',
      ];
    } else if (clean.contains('مشروع') ||
        clean.contains('تخرج') ||
        clean.contains('برمجة') ||
        clean.contains('تطبيق') ||
        clean.contains('موقع') ||
        clean.contains('flutter') ||
        clean.contains('api') ||
        clean.contains('كود')) {
      categoryName = 'العمل';
      subtasks = [
        'تحليل المتطلبات الوظيفية وهندسة معمارية البرمجيات',
        'تصميم مخطط قاعدة البيانات ERD والعلاقات بين الجداول',
        'بناء واجهات المستخدم التفاعلية والتحقق من تجربة الاستخدام',
        'تطوير الواجهة الخلفية وخدمات API والربط مع قاعدة البيانات',
        'إجراء اختبارات الوحدة وفحص الأمان والتحقق من حالات الخطأ',
        'إعداد التوثيق البرمجي النهائي وتجهيز العرض التقديمي للمناقشة',
      ];
    } else if (clean.contains('رياضة') ||
        clean.contains('تمرين') ||
        clean.contains('جيم') ||
        clean.contains('وزن') ||
        clean.contains('صحة') ||
        clean.contains('حمية') ||
        clean.contains('دايت')) {
      categoryName = 'صحة';
      subtasks = [
        'شرب كوب ماء والإحماء الديناميكي لمدة 10 دقائق',
        'تمارين المقاومة والقوة للمجموعات العضلية المستهدفة',
        'تمارين الكارديو لتحسين اللياقة ورفع معدل الحرق',
        'تمارين الإطالة العضلية والتبريد لمنع الشد العضلي',
        'تناول وجبة متوازنة تحتوي على البروتين والكربوهيدرات الصحية',
        'الحصول على قسط كافٍ من النوم للتعافي والاستشفاء',
      ];
    } else if (clean.contains('تسوق') ||
        clean.contains('شراء') ||
        clean.contains('مشتريات') ||
        clean.contains('سوق') ||
        clean.contains('متجر')) {
      categoryName = 'تسوق';
      subtasks = [
        'حصر الاحتياجات الأساسية وكتابة قائمة التسوق بدقة',
        'تحديد الميزانية المالية الإجمالية لمنع الإسراف',
        'مقارنة الأسعار والعروض واختيار المتاجر الأفضل',
        'التأكد من جودة المنتجات وتاريخ الصلاحية قبل الشراء',
        'مطابقة المشتريات مع الفاتورة وحفظ الإيصالات',
      ];
    } else if (clean.contains('سفر') ||
        clean.contains('رحلة') ||
        clean.contains('حجز') ||
        clean.contains('طيران') ||
        clean.contains('فندق')) {
      categoryName = 'شخصي';
      subtasks = [
        'فحص صلاحية جواز السفر والأوراق الثبوتية والتأشيرات',
        'تأكيد حجوزات الطيران والإقامة في الوجهة المستهدفة',
        'تجهيز حقيبة السفر والملابس المناسبة لطقس الرحلة',
        'شحن الأجهزة الإلكترونية وأخذ الشواحن والمحولات المطلوبة',
        'تجهيز المبالغ النقدية وتفعيل البطاقات المصرفية الدولية',
        'ترتيب وسيلة الانتقال إلى المطار قبل موعد الرحلة بـ 3 ساعات',
      ];
    } else if (clean.contains('مقابلة') ||
        clean.contains('وظيفة') ||
        clean.contains('توظيف') ||
        clean.contains('سيرة ذاتية') ||
        clean.contains('cv')) {
      categoryName = 'العمل';
      subtasks = [
        'تحديث السيرة الذاتية (CV) ومطابقتها مع متطلبات الوظيفة الشاغرة',
        'البحث عن الشركة ونشاطها وقيمها ومشاريعها الحديثة',
        'التدرب على الإجابة عن الأسئلة التقنية والسلوكية (STAR Method)',
        'تجهيز قائمة بالأسئلة الذكية الموجهة للمحاور في نهاية المقابلة',
        'تجهيز الزي الرسمي المناسب والتأكد من المظهر العام والمستندات',
        'الوصول إلى مقر المقابلة أو الدخول للاجتماع قبل الموعد بـ 15 دقيقة',
      ];
    } else if (clean.contains('عرض') ||
        clean.contains('بوربوينت') ||
        clean.contains('بريزنتيشن') ||
        clean.contains('slides') ||
        clean.contains('presentation')) {
      categoryName = 'دراسة';
      subtasks = [
        'تحديد الفكرة الرئيسية والجمهور المستهدف والرسالة الجوهرية للعرض',
        'تصميم الشرائح بصرياً مع تقليل النصوص واستخدام المخططات والأيقونات',
        'كتابة بطاقات الملاحظات لنقاط الحديث والشروحات لكل شريحة',
        'التدرب على الإلقاء ونبرة الصوت ولغة الجسد أمام المرآة أو مسجل',
        'ضبط زمن الإلقاء للتأكد من عدم تجاوز الوقت المحدد المسموح',
        'فحص ملف العرض على جهاز القاعة والتأكد من توافق الخطوط ومؤشر التحكم',
      ];
    } else if (clean.contains('عادة') ||
        clean.contains('عادات') ||
        clean.contains('روتين') ||
        clean.contains('صباح')) {
      categoryName = 'شخصي';
      subtasks = [
        'تحديد العادة المستهدفة وربطها بمحفز يومي موجود مسبقاً (Habit Stacking)',
        'البدء بخطوة صغيرة جداً لا تستغرق أكثر من دقيقتين (قاعدة الدقيقتين)',
        'الامتناع التام عن تصفح الهاتف والشاشات خلال أول 30 دقيقة من اليوم',
        'ممارسة نشاط حركي خفيف وشرب الماء والتعرض لضوء الشمس الطبيعي',
        'تسجيل الالتزام في جدول تتبع العادات اليومي لتعزيز الاستمرارية',
      ];
    } else if (clean.contains('قراءة') || clean.contains('كتاب')) {
      categoryName = 'شخصي';
      subtasks = [
        'اختيار الكتاب المستهدف وتحديد مكان ووقت هادئ وثابت للقراءة',
        'تقسيم صفحات الكتاب إلى عدد صفحات يومي مناسب (مثل 15-20 صفحة)',
        'تدوين الملاحظات والاقتباسات الملهمة في دفتر خاص أو في الهوامش',
        'كتابة ملخص مكون من 3 نقاط جوهرية بعد إنهاء كل فصل',
        'مشاركة أهم الأفكار المستفادة مع صديق أو تطبيقها في الحياة الواقعية',
      ];
    } else {
      categoryName = 'عام';
      subtasks = [
        'توضيح الهدف بدقة وتحديد النتيجة النهائية المرجوة',
        'جمع المراجع والأدوات اللازمة للشروع في العمل',
        'تحديد العقبات المتوقعة ووضع خطة بديلة لتفاديها',
        'تنفيذ الجزء الأول والأساسي من المهمة دون تأجيل',
        'مراجعة ما تم تنفيذه وإجراء التحسينات الضرورية',
        'إتمام المهمة وتوثيق النتائج وتحديث قائمة الإنجازات',
      ];
    }

    return AiTaskPlan(
      title: prompt,
      categoryName: categoryName,
      priority: priority,
      dueDate: dueDate,
      explanation:
          'تم إعداد هذه الخطة بواسطة خوارزمية الذكاء الاصطناعي لتحويل هدفك إلى 6 خطوات عملية قابلة للقياس والتنفيذ المباشر.',
      subtasks: subtasks,
    );
  }
}
