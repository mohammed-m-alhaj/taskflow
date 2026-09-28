import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  final Map<String, List<Map<String, dynamic>>> _memoryStore = {
    'users': [],
    'categories': [],
    'tasks': [],
    'subtasks': [],
    'reminders': [],
    'user_settings': [],
  };
  int _memIdCounter = 100;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (kIsWeb) return null;
    if (_database != null) return _database!;
    try {
      _database = await _initDB('taskflow_local.db');
      return _database;
    } catch (_) {
      return null;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        name TEXT NOT NULL,
        color TEXT,
        icon TEXT,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        category_id INTEGER,
        title TEXT NOT NULL,
        description TEXT,
        priority TEXT,
        status TEXT,
        due_date TEXT,
        is_completed INTEGER DEFAULT 0,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE subtasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_id INTEGER,
        title TEXT NOT NULL,
        is_completed INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_id INTEGER,
        reminder_time TEXT NOT NULL,
        reminder_type TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE user_settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER UNIQUE,
        theme TEXT DEFAULT 'system',
        language TEXT DEFAULT 'ar',
        notifications_enabled INTEGER DEFAULT 1
      )
    ''');

    await db.insert('categories', {
      'user_id': 1,
      'name': 'العمل',
      'color': '#4A90E2',
      'icon': 'work',
      'created_at': DateTime.now().toIso8601String(),
    });

    await db.insert('categories', {
      'user_id': 1,
      'name': 'شخصي',
      'color': '#50E3C2',
      'icon': 'person',
      'created_at': DateTime.now().toIso8601String(),
    });

    await db.insert('categories', {
      'user_id': 1,
      'name': 'دراسة',
      'color': '#F5A623',
      'icon': 'school',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<int> insertUser(String name, String email, String password) async {
    final db = await database;
    final row = {
      'name': name,
      'email': email,
      'password_hash': password,
      'created_at': DateTime.now().toIso8601String(),
    };
    if (db != null) {
      return await db.insert('users', row, conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      _memIdCounter++;
      final memRow = Map<String, dynamic>.from(row)..['id'] = _memIdCounter;
      _memoryStore['users']!.add(memRow);
      return _memIdCounter;
    }
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    if (db != null) {
      final res = await db.query('users', where: 'email = ?', whereArgs: [email], limit: 1);
      return res.isNotEmpty ? res.first : null;
    } else {
      final match = _memoryStore['users']!.where((u) => u['email'] == email).toList();
      return match.isNotEmpty ? match.first : null;
    }
  }

  Future<int> insertTask(Map<String, dynamic> row) async {
    final db = await database;
    final cleanRow = Map<String, dynamic>.from(row);
    if (!cleanRow.containsKey('user_id') || cleanRow['user_id'] == null) {
      cleanRow['user_id'] = 1;
    }
    if (!cleanRow.containsKey('created_at')) {
      cleanRow['created_at'] = DateTime.now().toIso8601String();
    }
    if (cleanRow['is_completed'] is bool) {
      cleanRow['is_completed'] = cleanRow['is_completed'] ? 1 : 0;
    }
    if (db != null) {
      return await db.insert('tasks', cleanRow);
    } else {
      _memIdCounter++;
      cleanRow['id'] = _memIdCounter;
      _memoryStore['tasks']!.add(cleanRow);
      return _memIdCounter;
    }
  }

  Future<List<Map<String, dynamic>>> getTasks({int? userId}) async {
    final db = await database;
    if (db != null) {
      List<Map<String, dynamic>> res;
      if (userId != null) {
        res = await db.query('tasks', where: 'user_id = ? OR user_id IS NULL', whereArgs: [userId], orderBy: 'id DESC');
      } else {
        res = await db.query('tasks', orderBy: 'id DESC');
      }
      return res.map((item) {
        final m = Map<String, dynamic>.from(item);
        m['user_id'] = m['user_id'] ?? 1;
        m['is_completed'] = (m['is_completed'] == 1 || m['is_completed'] == true);
        return m;
      }).toList();
    } else {
      return _memoryStore['tasks']!.map((item) {
        final m = Map<String, dynamic>.from(item);
        m['user_id'] = m['user_id'] ?? 1;
        m['is_completed'] = (m['is_completed'] == 1 || m['is_completed'] == true);
        return m;
      }).toList().reversed.toList();
    }
  }

  Future<Map<String, dynamic>?> getTaskById(int id) async {
    final db = await database;
    if (db != null) {
      final res = await db.query('tasks', where: 'id = ?', whereArgs: [id], limit: 1);
      if (res.isEmpty) return null;
      final m = Map<String, dynamic>.from(res.first);
      m['user_id'] = m['user_id'] ?? 1;
      m['is_completed'] = (m['is_completed'] == 1 || m['is_completed'] == true);
      return m;
    } else {
      final match = _memoryStore['tasks']!.where((t) => t['id'] == id).toList();
      if (match.isEmpty) return null;
      final m = Map<String, dynamic>.from(match.first);
      m['user_id'] = m['user_id'] ?? 1;
      m['is_completed'] = (m['is_completed'] == 1 || m['is_completed'] == true);
      return m;
    }
  }

  Future<int> updateTask(int id, Map<String, dynamic> row) async {
    final db = await database;
    final cleanRow = Map<String, dynamic>.from(row);
    if (cleanRow.containsKey('is_completed') && cleanRow['is_completed'] is bool) {
      cleanRow['is_completed'] = cleanRow['is_completed'] ? 1 : 0;
    }
    if (db != null) {
      return await db.update('tasks', cleanRow, where: 'id = ?', whereArgs: [id]);
    } else {
      final idx = _memoryStore['tasks']!.indexWhere((t) => t['id'] == id);
      if (idx != -1) {
        _memoryStore['tasks']![idx].addAll(cleanRow);
        return 1;
      }
      return 0;
    }
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    if (db != null) {
      await db.delete('subtasks', where: 'task_id = ?', whereArgs: [id]);
      await db.delete('reminders', where: 'task_id = ?', whereArgs: [id]);
      return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
    } else {
      _memoryStore['subtasks']!.removeWhere((s) => s['task_id'] == id);
      _memoryStore['reminders']!.removeWhere((r) => r['task_id'] == id);
      _memoryStore['tasks']!.removeWhere((t) => t['id'] == id);
      return 1;
    }
  }

  Future<int> insertCategory(Map<String, dynamic> row) async {
    final db = await database;
    final cleanRow = Map<String, dynamic>.from(row);
    if (!cleanRow.containsKey('created_at')) {
      cleanRow['created_at'] = DateTime.now().toIso8601String();
    }
    if (db != null) {
      return await db.insert('categories', cleanRow);
    } else {
      _memIdCounter++;
      cleanRow['id'] = _memIdCounter;
      _memoryStore['categories']!.add(cleanRow);
      return _memIdCounter;
    }
  }

  Future<List<Map<String, dynamic>>> getCategories({int? userId}) async {
    final db = await database;
    if (db != null) {
      if (userId != null) {
        return await db.query('categories', where: 'user_id = ? OR user_id IS NULL', whereArgs: [userId]);
      }
      return await db.query('categories');
    } else {
      return _memoryStore['categories']!;
    }
  }

  Future<int> updateCategory(int id, Map<String, dynamic> row) async {
    final db = await database;
    if (db != null) {
      return await db.update('categories', row, where: 'id = ?', whereArgs: [id]);
    } else {
      final idx = _memoryStore['categories']!.indexWhere((c) => c['id'] == id);
      if (idx != -1) {
        _memoryStore['categories']![idx].addAll(row);
        return 1;
      }
      return 0;
    }
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    if (db != null) {
      return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
    } else {
      _memoryStore['categories']!.removeWhere((c) => c['id'] == id);
      return 1;
    }
  }

  Future<int> insertSubtask(Map<String, dynamic> row) async {
    final db = await database;
    final cleanRow = Map<String, dynamic>.from(row);
    if (cleanRow['is_completed'] is bool) {
      cleanRow['is_completed'] = cleanRow['is_completed'] ? 1 : 0;
    }
    if (db != null) {
      return await db.insert('subtasks', cleanRow);
    } else {
      _memIdCounter++;
      cleanRow['id'] = _memIdCounter;
      _memoryStore['subtasks']!.add(cleanRow);
      return _memIdCounter;
    }
  }

  Future<List<Map<String, dynamic>>> getSubtasks(int taskId) async {
    final db = await database;
    if (db != null) {
      final res = await db.query('subtasks', where: 'task_id = ?', whereArgs: [taskId]);
      return res.map((s) {
        final m = Map<String, dynamic>.from(s);
        m['is_completed'] = (m['is_completed'] == 1 || m['is_completed'] == true);
        return m;
      }).toList();
    } else {
      return _memoryStore['subtasks']!.where((s) => s['task_id'] == taskId).map((s) {
        final m = Map<String, dynamic>.from(s);
        m['is_completed'] = (m['is_completed'] == 1 || m['is_completed'] == true);
        return m;
      }).toList();
    }
  }

  Future<int> updateSubtask(int id, Map<String, dynamic> row) async {
    final db = await database;
    final cleanRow = Map<String, dynamic>.from(row);
    if (cleanRow.containsKey('is_completed') && cleanRow['is_completed'] is bool) {
      cleanRow['is_completed'] = cleanRow['is_completed'] ? 1 : 0;
    }
    if (db != null) {
      return await db.update('subtasks', cleanRow, where: 'id = ?', whereArgs: [id]);
    } else {
      final idx = _memoryStore['subtasks']!.indexWhere((s) => s['id'] == id);
      if (idx != -1) {
        _memoryStore['subtasks']![idx].addAll(cleanRow);
        return 1;
      }
      return 0;
    }
  }

  Future<int> deleteSubtask(int id) async {
    final db = await database;
    if (db != null) {
      return await db.delete('subtasks', where: 'id = ?', whereArgs: [id]);
    } else {
      _memoryStore['subtasks']!.removeWhere((s) => s['id'] == id);
      return 1;
    }
  }

  Future<int> insertReminder(Map<String, dynamic> row) async {
    final db = await database;
    if (db != null) {
      return await db.insert('reminders', row);
    } else {
      _memIdCounter++;
      final cleanRow = Map<String, dynamic>.from(row)..['id'] = _memIdCounter;
      _memoryStore['reminders']!.add(cleanRow);
      return _memIdCounter;
    }
  }

  Future<List<Map<String, dynamic>>> getReminders({int? taskId}) async {
    final db = await database;
    if (db != null) {
      if (taskId != null) {
        return await db.query('reminders', where: 'task_id = ?', whereArgs: [taskId]);
      }
      return await db.query('reminders');
    } else {
      if (taskId != null) {
        return _memoryStore['reminders']!.where((r) => r['task_id'] == taskId).toList();
      }
      return _memoryStore['reminders']!;
    }
  }

  Future<int> updateReminder(int id, Map<String, dynamic> row) async {
    final db = await database;
    if (db != null) {
      return await db.update('reminders', row, where: 'id = ?', whereArgs: [id]);
    } else {
      final idx = _memoryStore['reminders']!.indexWhere((r) => r['id'] == id);
      if (idx != -1) {
        _memoryStore['reminders']![idx].addAll(row);
        return 1;
      }
      return 0;
    }
  }

  Future<int> deleteReminder(int id) async {
    final db = await database;
    if (db != null) {
      return await db.delete('reminders', where: 'id = ?', whereArgs: [id]);
    } else {
      _memoryStore['reminders']!.removeWhere((r) => r['id'] == id);
      return 1;
    }
  }

  Future<void> close() async {
    final db = await database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
