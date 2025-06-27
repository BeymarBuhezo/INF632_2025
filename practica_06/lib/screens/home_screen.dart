// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:practica_06/services/data_base_helper.dart';
import '../models/transaccion.dart';
import 'package:intl/intl.dart'; // Para formatear moneda

import 'new_transaccion_screen.dart';
import 'historial_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _totalIngresos = 0.0;
  double _totalGastos = 0.0;
  double _saldoActual = 0.0;
  List<Transaccion> _ultimasTransacciones = [];

  @override
  void initState() {
    super.initState();
    _loadSummaryData();
    _loadUltimasTransacciones();
  }

  Future<void> _loadSummaryData() async {
    final dbHelper = DatabaseHelper();
    final allTransactions = await dbHelper.getTransacciones();

    double ingresos = 0.0;
    double gastos = 0.0;

    for (var t in allTransactions) {
      if (t.tipo == 'ingreso') {
        ingresos += t.monto;
      } else {
        gastos += t.monto;
      }
    }

    setState(() {
      _totalIngresos = ingresos;
      _totalGastos = gastos;
      _saldoActual = ingresos - gastos;
    });
  }

  Future<void> _loadUltimasTransacciones() async {
    final dbHelper = DatabaseHelper();
    final allTransactions = await dbHelper.getTransacciones();
    setState(() {
      _ultimasTransacciones =
          allTransactions.take(5).toList(); // Mostrar las 5 últimas
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'es_BO',
      symbol: 'Bs.',
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Resumen Financiero')),
      body: RefreshIndicator(
        onRefresh: () async {
          await _loadSummaryData();
          await _loadUltimasTransacciones();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCard(
                  title: 'Ingresos Totales',
                  amount: _totalIngresos,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(
                  title: 'Gastos Totales',
                  amount: _totalGastos,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(
                  title: 'Saldo Actual',
                  amount: _saldoActual,
                  color: _saldoActual >= 0 ? Colors.blue : Colors.orange,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Últimas Transacciones',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistorialScreen(),
                          ),
                        );
                        _loadSummaryData(); // Actualizar datos al volver
                        _loadUltimasTransacciones();
                      },
                      child: const Text('Ver Todo'),
                    ),
                  ],
                ),
                _ultimasTransacciones.isEmpty
                    ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text('No hay transacciones registradas.'),
                      ),
                    )
                    : ListView.builder(
                      shrinkWrap:
                          true, // Importante para ListView anidados en SingleChildScrollView
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _ultimasTransacciones.length,
                      itemBuilder: (context, index) {
                        final transaccion = _ultimasTransacciones[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
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
                              // Implementar edición de transacción aquí si se desea
                              // Navegar a una pantalla de edición similar a new_transaccion_screen
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
                                _loadSummaryData();
                                _loadUltimasTransacciones();
                              }
                            },
                            onLongPress: () {
                              _confirmDeleteTransaccion(transaccion);
                            },
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NewTransaccionScreen(),
            ),
          );
          if (result == true) {
            _loadSummaryData(); // Actualizar datos al volver
            _loadUltimasTransacciones();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
  }) {
    final currencyFormat = NumberFormat.currency(
      locale: 'es_BO',
      symbol: 'Bs.',
      decimalDigits: 2,
    );
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currencyFormat.format(amount),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
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
      _loadSummaryData();
      _loadUltimasTransacciones();
    }
  }
}
