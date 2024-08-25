import 'dart:io';

import 'package:daily_todo/database/todo_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@DriftDatabase(tables: [TodoTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<int> createTodo(TodoTableCompanion data) =>
      into(todoTable).insert(data);

  Stream<List<TodoTableData>> getStreamTodoByDate(DateTime date) {
    return (select(todoTable)..where((table) => table.date.equals(date)))
        .watch();
  }

  Future<int> updateTodoById(String id, TodoTableCompanion data) {
    return (update(todoTable)..where((table) => table.id.equals(id)))
        .write(data);
  }

  Future<int> removeTodoById(String id) {
    return (delete(todoTable)..where((table) => table.id.equals(id))).go();
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationCacheDirectory();

    final file = File(p.join(dbFolder.path, 'local_db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = await getTemporaryDirectory();

    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
