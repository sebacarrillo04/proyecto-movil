import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildDetailView extends StatefulWidget {
  const ChildDetailView({super.key});

  @override
  State<ChildDetailView> createState() => _ChildDetailViewState();
}

class _ChildDetailViewState extends State<ChildDetailView> {
  bool _editing = false;
  late Child? _child;
  final _form = GlobalKey<FormState>();

  // controllers for edit
  final _nombre = TextEditingController();
  final _apellido = TextEditingController();
  final _peso = TextEditingController();
  final _altura = TextEditingController();
  final _edad = TextEditingController();

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _peso.dispose();
    _altura.dispose();
    _edad.dispose();
    super.dispose();
  }

  void _loadData(String id, ChildController controller) {
    _child = controller.getById(id);
    if (_child != null) {
      _nombre.text = _child!.nombre;
      _apellido.text = _child!.apellido;
      _peso.text = _child!.peso.toString();
      _altura.text = _child!.altura.toString();
      _edad.text = _child!.edad.toString();
    }
  }

  void _saveEdit(ChildController controller) {
    if (!(_form.currentState?.validate() ?? false)) return;
    final updated = Child(
      id: _child!.id,
      nombre: _nombre.text.trim(),
      apellido: _apellido.text.trim(),
      identificacion: _child!.identificacion,
      nombrePadres: _child!.nombrePadres,
      peso: double.tryParse(_peso.text.trim()) ?? _child!.peso,
      altura: double.tryParse(_altura.text.trim()) ?? _child!.altura,
      perimetroBraquial: _child!.perimetroBraquial,
      perimetroAbdominal: _child!.perimetroAbdominal,
      edad: int.tryParse(_edad.text.trim()) ?? _child!.edad,
      estadoNutricional: '',
      activo: _child!.activo,
    );
    controller.updateChild(_child!.id, updated);
    setState(() => _editing = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registro actualizado')));
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final controller = Provider.of<ChildController>(context);

    if (_child == null) {
      // load once
      _loadData(id, controller);
    }

    if (_child == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: Text('Registro no encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${_child!.nombre} ${_child!.apellido}'),
        actions: [
          IconButton(
            icon: Icon(_editing ? Icons.cancel : Icons.edit),
            onPressed: () => setState(() => _editing = !_editing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: _editing
            ? _buildEditForm(controller)
            : _buildDetailView(controller),
      ),
    );
  }

  Widget _buildDetailView(ChildController controller) {
    final c = _child!;
    final imc = controller.computeIMC(c);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre: ${c.nombre} ${c.apellido}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text('Identificación: ${c.identificacion}'),
        const SizedBox(height: 8),
        Text('Edad: ${c.edad} años'),
        const SizedBox(height: 8),
        Text('Peso: ${c.peso} kg'),
        const SizedBox(height: 8),
        Text('Altura: ${c.altura} m'),
        const SizedBox(height: 8),
        Text('IMC: ${imc.toStringAsFixed(2)}'),
        const SizedBox(height: 8),
        Text('Estado nutricional: ${c.estadoNutricional}'),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            // ejemplo de una alerta
            if (c.estadoNutricional == 'desnutricion') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ALERTA: niño en riesgo de desnutrición'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Estado dentro de rangos esperados'),
                ),
              );
            }
          },
          child: const Text('Evaluar / Enviar alerta'),
        ),
      ],
    );
  }

  Widget _buildEditForm(ChildController controller) {
    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            controller: _nombre,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
          ),
          TextFormField(
            controller: _apellido,
            decoration: const InputDecoration(labelText: 'Apellido'),
            validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
          ),
          TextFormField(
            controller: _peso,
            decoration: const InputDecoration(labelText: 'Peso (kg)'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _altura,
            decoration: const InputDecoration(labelText: 'Altura (m)'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _edad,
            decoration: const InputDecoration(labelText: 'Edad'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _saveEdit(controller),
                child: const Text('Guardar'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => setState(() => _editing = false),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
