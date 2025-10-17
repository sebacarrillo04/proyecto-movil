import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddChildView extends StatefulWidget {
  const AddChildView({super.key});

  @override
  State<AddChildView> createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  final _form = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _ident = TextEditingController();
  final _padres = TextEditingController();
  final _peso = TextEditingController();
  final _altura = TextEditingController();
  final _perBraquial = TextEditingController();
  final _perAbdominal = TextEditingController();
  final _edad = TextEditingController();

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _ident.dispose();
    _padres.dispose();
    _peso.dispose();
    _altura.dispose();
    _perBraquial.dispose();
    _perAbdominal.dispose();
    _edad.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_form.currentState?.validate() ?? false)) return;

    final child = Child(
      id: '',
      nombre: _nombre.text.trim(),
      apellido: _apellido.text.trim(),
      identificacion: _ident.text.trim(),
      nombrePadres: _padres.text.trim(),
      peso: double.tryParse(_peso.text.trim()) ?? 0.0,
      altura: double.tryParse(_altura.text.trim()) ?? 0.0,
      perimetroBraquial: double.tryParse(_perBraquial.text.trim()) ?? 0.0,
      perimetroAbdominal: double.tryParse(_perAbdominal.text.trim()) ?? 0.0,
      edad: int.tryParse(_edad.text.trim()) ?? 0,
      estadoNutricional: '',
      activo: true,
    );

    Provider.of<ChildController>(context, listen: false).addChild(child);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Niño agregado')));
    Navigator.pop(context);
  }

  String? _req(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Requerido' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar niño')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombre,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: _req,
                  ),
                  TextFormField(
                    controller: _apellido,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                    validator: _req,
                  ),
                  TextFormField(
                    controller: _ident,
                    decoration: const InputDecoration(
                      labelText: 'Identificación',
                    ),
                  ),
                  TextFormField(
                    controller: _padres,
                    decoration: const InputDecoration(
                      labelText: 'Nombre padres / acudiente',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _peso,
                          decoration: const InputDecoration(
                            labelText: 'Peso (kg)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _altura,
                          decoration: const InputDecoration(
                            labelText: 'Altura (m)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _perBraquial,
                          decoration: const InputDecoration(
                            labelText: 'Per. braquial (cm)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: _perAbdominal,
                          decoration: const InputDecoration(
                            labelText: 'Per. abdominal (cm)',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _edad,
                    decoration: const InputDecoration(labelText: 'Edad (años)'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _save,
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
