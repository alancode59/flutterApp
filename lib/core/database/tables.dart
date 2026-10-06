import 'package:drift/drift.dart';

/// Preferencias de la app como pares clave/valor. Evita una migración cada vez
/// que se agrega un ajuste nuevo.
@DataClassName('SettingsEntry')
class SettingsEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
