// lib/screens/new_transaccion_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica_06/services/data_base_helper.dart';
import '../models/transaccion.dart';

class NewTransaccionScreen extends StatefulWidget {
  final Transaccion? transaccion; // Para edición, opcional

  const NewTransaccionScreen({super.key, this.transaccion});

  @override
  State<NewTransaccionScreen> createState() => _NewTransaccionScreenState();
}

class _NewTransaccionScreenState extends State<NewTransaccionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _tipo;
  late TextEditingController _montoController;
  late TextEditingController _descripcionController;
  late String _categoria;
  late DateTime _fecha;

  final List<String> _tipos = ['ingreso', 'gasto'];
  final List<String> _categoriasIngreso = [
    'Salario',
    'Freelance',
    'Regalo',
    'Inversión',
    'Otros',
  ];
  final List<String> _categoriasGasto = [
    'Alimentos',
    'Transporte',
    'Vivienda',
    'Entretenimiento',
    'Educación',
    'Salud',
    'Servicios',
    'Ropa',
    'Otros',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.transaccion != null) {
      // Modo edición
      _tipo = widget.transaccion!.tipo;
      _montoController = TextEditingController(
        text: widget.transaccion!.monto.toString(),
      );
      _descripcionController = TextEditingController(
        text: widget.transaccion!.descripcion,
      );
      _categoria = widget.transaccion!.categoria;
      _fecha = widget.transaccion!.fecha;
    } else {
      // Modo nueva transacción
      _tipo = 'gasto'; // Valor por defecto
      _montoController = TextEditingController();
      _descripcionController = TextEditingController();
      _categoria = _categoriasGasto.first; // Categoría por defecto
      _fecha = DateTime.now();
    }
  }

  @override
  void dispose() {
    _montoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('es', 'ES'), // Establecer idioma del DatePicker
    );
    if (picked != null && picked != _fecha) {
      setState(() {
        _fecha = picked;
      });
    }
  }

  void _saveTransaccion() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newTransaccion = Transaccion(
        id: widget.transaccion?.id, // Si es edición, mantén el ID
        tipo: _tipo,
        monto: double.parse(_montoController.text),
        descripcion: _descripcionController.text,
        categoria: _categoria,
        fecha: _fecha,
      );

      final dbHelper = DatabaseHelper();
      if (widget.transaccion == null) {
        // Es una nueva transacción
        await dbHelper.insertTransaccion(newTransaccion);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transacción registrada con éxito.')),
        );
      } else {
        // Es una edición
        await dbHelper.updateTransaccion(newTransaccion);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transacción actualizada con éxito.')),
        );
      }
      Navigator.pop(
        context,
        true,
      ); // Regresar a la pantalla anterior y indicar éxito
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transaccion == null
              ? 'Nueva Transacción'
              : 'Editar Transacción',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _tipo,
                decoration: const InputDecoration(
                  labelText: 'Tipo de Transacción',
                ),
                items:
                    _tipos.map((tipo) {
                      return DropdownMenuItem(
                        value: tipo,
                        child: Text(tipo == 'ingreso' ? 'Ingreso' : 'Gasto'),
                      );
                    }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _tipo = newValue!;
                    // Resetear categoría al cambiar el tipo
                    _categoria =
                        (newValue == 'ingreso'
                                ? _categoriasIngreso
                                : _categoriasGasto)
                            .first;
                  });
                },
              ),
              TextFormField(
                controller: _montoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items:
                    (_tipo == 'ingreso' ? _categoriasIngreso : _categoriasGasto)
                        .map((categoria) {
                          return DropdownMenuItem(
                            value: categoria,
                            child: Text(categoria),
                          );
                        })
                        .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _categoria = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Fecha: ${DateFormat.yMd('es').format(_fecha)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveTransaccion,
                child: Text(
                  widget.transaccion == null
                      ? 'Guardar Transacción'
                      : 'Actualizar Transacción',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
