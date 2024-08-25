import 'package:drift/drift.dart';

class TodoTable extends Table {
  TextColumn get id => text()();

  DateTimeColumn get date => dateTime()();

  TextColumn get content => text()();

  BoolColumn get isCompleted => boolean()();
}
