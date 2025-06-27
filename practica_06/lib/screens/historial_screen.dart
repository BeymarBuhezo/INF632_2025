// lib/screens/historial_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica_06/services/data_base_helper.dart';
import '../models/transaccion.dart';
import 'new_transaccion_screen.dart'; // Para la edición

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  List<Transaccion> _transacciones = [];
  String _filtroTipo = 'todos'; // 'ingreso', 'gasto', 'todos'
  DateTime? _filtroFechaInicio;
  DateTime? _filtroFechaFin;

  @override
  void initState() {
    super.initState();
    _loadTransacciones();
  }

  Future<void> _loadTransacciones() async {
    final dbHelper = DatabaseHelper();
    List<Transaccion> loadedTransacciones;

    if (_filtroTipo == 'todos') {
      loadedTransacciones = await dbHelper.getTransacciones();
    } else {
      loadedTransacciones = await dbHelper.getTransaccionesPorTipo(_filtroTipo);
    }

    // Aplicar filtro por rango de fechas si están definidos
    if (_filtroFechaInicio != null && _filtroFechaFin != null) {
      loadedTransacciones =
          loadedTransacciones.where((t) {
            return t.fecha.isAfter(
                  _filtroFechaInicio!.subtract(const Duration(days: 1)),
                ) &&
                t.fecha.isBefore(_filtroFechaFin!.add(const Duration(days: 1)));
          }).toList();
    }

    setState(() {
      _transacciones = loadedTransacciones;
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange:
          _filtroFechaInicio != null && _filtroFechaFin != null
              ? DateTimeRange(start: _filtroFechaInicio!, end: _filtroFechaFin!)
              : null,
      locale: const Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _filtroFechaInicio = picked.start;
        _filtroFechaFin = picked.end;
      });
      _loadTransacciones();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'es_BO',
      symbol: 'Bs.',
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Transacciones'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _filtroTipo = value;
              });
              _loadTransacciones();
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'todos',
                    child: Text('Mostrar Todos'),
                  ),
                  const PopupMenuItem(
                    value: 'ingreso',
                    child: Text('Mostrar Ingresos'),
                  ),
                  const PopupMenuItem(
                    value: 'gasto',
                    child: Text('Mostrar Gastos'),
                  ),
                ],
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () => _selectDateRange(context),
          ),
          if (_filtroFechaInicio != null || _filtroFechaFin != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _filtroFechaInicio = null;
                  _filtroFechaFin = null;
                });
                _loadTransacciones();
              },
              tooltip: 'Limpiar filtro de fecha',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadTransacciones,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _filtroFechaInicio != null && _filtroFechaFin != null
                    ? 'Filtrando desde: ${DateFormat.yMd('es').format(_filtroFechaInicio!)} hasta: ${DateFormat.yMd('es').format(_filtroFechaFin!)}'
                    : 'Mostrando todas las fechas',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            Expanded(
              child:
                  _transacciones.isEmpty
                      ? const Center(
                        child: Text(
                          'No hay transacciones que coincidan con los filtros.',
                        ),
                      )
                      : ListView.builder(
                        itemCount: _transacciones.length,
                        itemBuilder: (context, index) {
                          final transaccion = _transacciones[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: Icon(
                                transaccion.tipo == 'ingreso'
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color:
                                    transaccion.tipo == 'ingreso'
                                        ? Colors.green
                                        : Colors.red,
                              ),
                              title: Text(transaccion.descripcion),
                              subtitle: Text(
                                '${transaccion.categoria} - ${DateFormat.yMd('es').format(transaccion.fecha)}',
                              ),
                              trailing: Text(
                                currencyFormat.format(transaccion.monto),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      transaccion.tipo == 'ingreso'
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => NewTransaccionScreen(
                                          transaccion: transaccion,
                                        ),
                                  ),
                                );
                                if (result == true) {
                                  _loadTransacciones();
                                }
                              },
                              onLongPress: () {
                                _confirmDeleteTransaccion(transaccion);
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteTransaccion(Transaccion transaccion) async {
    final bool? confirm = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Eliminar Transacción'),
            content: Text(
              '¿Estás seguro de que quieres eliminar la transacción de "${transaccion.descripcion}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Eliminar'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await DatabaseHelper().deleteTransaccion(transaccion.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transacción eliminada con éxito.')),
      );
      _loadTransacciones();
    }
  }
}
