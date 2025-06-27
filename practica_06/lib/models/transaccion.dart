// lib/models/transaccion.dart
class Transaccion {
  final int? id;
  final String tipo; // "ingreso" o "gasto"
  final double monto;
  final String descripcion;
  final String categoria;
  final DateTime fecha;

  Transaccion({
    this.id,
    required this.tipo,
    required this.monto,
    required this.descripcion,
    required this.categoria,
    required this.fecha,
  });

  // Convertir un objeto Transaccion a un mapa para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'monto': monto,
      'descripcion': descripcion,
      'categoria': categoria,
      'fecha': fecha.toIso8601String(), // Guardar la fecha como String ISO 8601
    };
  }

  // Crear un objeto Transaccion desde un mapa de la base de datos
  factory Transaccion.fromMap(Map<String, dynamic> map) {
    return Transaccion(
      id: map['id'],
      tipo: map['tipo'],
      monto: map['monto'],
      descripcion: map['descripcion'],
      categoria: map['categoria'],
      fecha: DateTime.parse(map['fecha']),
    );
  }
}
