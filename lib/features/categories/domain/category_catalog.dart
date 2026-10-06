import 'package:flutter/material.dart';

import '../../transactions/domain/movement.dart';

/// Íconos y colores disponibles para las categorías, más las categorías
/// iniciales. Los íconos se guardan por clave (no por código) para que un
/// cambio en la fuente de íconos no rompa los datos.
abstract final class CategoryCatalog {
  static const Map<String, IconData> icons = {
    'restaurant': Icons.restaurant_rounded,
    'shopping_cart': Icons.shopping_cart_rounded,
    'local_cafe': Icons.local_cafe_rounded,
    'local_bar': Icons.local_bar_rounded,
    'directions_car': Icons.directions_car_rounded,
    'local_gas_station': Icons.local_gas_station_rounded,
    'directions_bus': Icons.directions_bus_rounded,
    'local_taxi': Icons.local_taxi_rounded,
    'flight': Icons.flight_rounded,
    'home': Icons.home_rounded,
    'bolt': Icons.bolt_rounded,
    'water_drop': Icons.water_drop_rounded,
    'wifi': Icons.wifi_rounded,
    'phone_iphone': Icons.phone_iphone_rounded,
    'subscriptions': Icons.subscriptions_rounded,
    'movie': Icons.movie_rounded,
    'sports_esports': Icons.sports_esports_rounded,
    'music_note': Icons.music_note_rounded,
    'local_hospital': Icons.local_hospital_rounded,
    'local_pharmacy': Icons.local_pharmacy_rounded,
    'fitness_center': Icons.fitness_center_rounded,
    'spa': Icons.spa_rounded,
    'checkroom': Icons.checkroom_rounded,
    'school': Icons.school_rounded,
    'menu_book': Icons.menu_book_rounded,
    'child_care': Icons.child_care_rounded,
    'pets': Icons.pets_rounded,
    'redeem': Icons.redeem_rounded,
    'celebration': Icons.celebration_rounded,
    'beach_access': Icons.beach_access_rounded,
    'build': Icons.build_rounded,
    'volunteer_activism': Icons.volunteer_activism_rounded,
    'receipt_long': Icons.receipt_long_rounded,
    'account_balance': Icons.account_balance_rounded,
    'work': Icons.work_rounded,
    'laptop': Icons.laptop_mac_rounded,
    'storefront': Icons.storefront_rounded,
    'payments': Icons.payments_rounded,
    'savings': Icons.savings_rounded,
    'trending_up': Icons.trending_up_rounded,
    'replay': Icons.replay_rounded,
    'more_horiz': Icons.more_horiz_rounded,
  };

  static IconData icon(String key) => icons[key] ?? Icons.category_rounded;

  /// Colores sólidos que se leen bien en modo claro y oscuro.
  static const List<int> colors = [
    0xFFEF4444, // rojo
    0xFFF97316, // naranja
    0xFFF59E0B, // ámbar
    0xFFEAB308, // amarillo
    0xFF84CC16, // lima
    0xFF22C55E, // verde
    0xFF14B8A6, // verde azulado
    0xFF06B6D4, // cian
    0xFF3B82F6, // azul
    0xFF6366F1, // índigo
    0xFFA855F7, // morado
    0xFFEC4899, // rosa
    0xFFF43F5E, // frambuesa
    0xFFA16207, // café
    0xFF64748B, // gris pizarra
  ];

  static const List<(String name, String icon, int color, MovementKind kind)> defaults = [
    ('Comida', 'restaurant', 0xFFF97316, MovementKind.expense),
    ('Súper', 'shopping_cart', 0xFF22C55E, MovementKind.expense),
    ('Transporte', 'directions_car', 0xFF3B82F6, MovementKind.expense),
    ('Gasolina', 'local_gas_station', 0xFFEAB308, MovementKind.expense),
    ('Hogar', 'home', 0xFFA16207, MovementKind.expense),
    ('Servicios', 'bolt', 0xFF06B6D4, MovementKind.expense),
    ('Suscripciones', 'subscriptions', 0xFFA855F7, MovementKind.expense),
    ('Salud', 'local_hospital', 0xFFEF4444, MovementKind.expense),
    ('Entretenimiento', 'movie', 0xFFEC4899, MovementKind.expense),
    ('Ropa', 'checkroom', 0xFF6366F1, MovementKind.expense),
    ('Educación', 'school', 0xFF14B8A6, MovementKind.expense),
    ('Mascotas', 'pets', 0xFF84CC16, MovementKind.expense),
    ('Regalos', 'redeem', 0xFFF43F5E, MovementKind.expense),
    ('Otros', 'more_horiz', 0xFF64748B, MovementKind.expense),
    ('Nómina', 'work', 0xFF22C55E, MovementKind.income),
    ('Freelance', 'laptop', 0xFF06B6D4, MovementKind.income),
    ('Ventas', 'storefront', 0xFFF97316, MovementKind.income),
    ('Reembolsos', 'replay', 0xFF6366F1, MovementKind.income),
    ('Otros ingresos', 'savings', 0xFF64748B, MovementKind.income),
  ];
}
