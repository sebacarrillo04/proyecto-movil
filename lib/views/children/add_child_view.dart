import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:alertas_tempranas/widgets/theme/app_colors.dart';
import 'package:alertas_tempranas/widgets/theme/app_text_styles.dart';
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Niño registrado correctamente')),
    );

    Navigator.pop(context);
  }

  String? _req(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Requerido' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🟦 ENCABEZADO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 50,
                bottom: 20,
                left: 10,
                right: 10,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryLight, AppColors.primary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'REGISTRAR NIÑO',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // 📋 FORMULARIO
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        _input(_nombre, 'Nombre', Icons.person_outline),
                        _input(_apellido, 'Apellido', Icons.person_outline),
                        _input(_ident, 'Identificación', Icons.badge_outlined),
                        _input(
                          _padres,
                          'Nombre padres / acudiente',
                          Icons.family_restroom,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _input(
                                _peso,
                                'Peso (kg)',
                                Icons.monitor_weight_outlined,
                                number: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _input(
                                _altura,
                                'Altura (m)',
                                Icons.height,
                                number: true,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _input(
                                _perBraquial,
                                'Per. braquial (cm)',
                                Icons.accessibility_new,
                                number: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _input(
                                _perAbdominal,
                                'Per. abdominal (cm)',
                                Icons.accessibility,
                                number: true,
                              ),
                            ),
                          ],
                        ),

                        _input(
                          _edad,
                          'Edad (años)',
                          Icons.cake_outlined,
                          number: true,
                        ),
                        const SizedBox(height: 20),

                        // 🟩 BOTÓN GUARDAR
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            label: const Text(
                              'Guardar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: _save,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController c,
    String label,
    IconData icon, {
    bool number = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: _req,
        keyboardType: number ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
