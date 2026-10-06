# Finanzas

App de finanzas personales para un solo usuario: ingresos, gastos, tarjetas de crédito, deudas y
presupuesto quincenal. Todo se guarda localmente (SQLite vía Drift), sin servidor ni cuentas.

## Requisitos

- Flutter 3.47.6 (stable) / Dart 3.13.5
- Xcode para iOS y macOS. Android requiere instalar el Android SDK.

## Comandos

```bash
flutter pub get
dart run build_runner build      # regenera *.g.dart y *.freezed.dart tras cambiar modelos/providers
flutter run -d <dispositivo>     # iOS Simulator, macos o chrome
flutter test                     # pruebas unitarias y de widgets
flutter test integration_test -d macos   # flujo completo con la base de datos real
```

## Estructura

```
lib/
  app/        tema (paletas, tipografía, tokens), router y barra de navegación
  core/       base de datos, dominio compartido (Quincena), servicios y widgets reutilizables
  features/   una carpeta por funcionalidad, cada una con data/ domain/ presentation/
```

- Montos siempre en centavos (`int`).
- Quincenas de calendario: del 1 al 15 y del 16 al fin de mes.
- Web: `web/sqlite3.wasm` y `web/drift_worker.js` vienen de la release `drift-2.35.1`;
  hay que actualizarlos si se actualiza `drift`.

La fuente Inter se distribuye bajo la SIL Open Font License (`assets/fonts/OFL.txt`).
