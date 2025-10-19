import 'package:alertas_tempranas/controllers/child_controller.dart';
import 'package:alertas_tempranas/models/child_model.dart';
import 'package:alertas_tempranas/widgets/theme/app_colors.dart';
import 'package:alertas_tempranas/widgets/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildDetailView extends StatefulWidget {
  const ChildDetailView({super.key});

  @override
  State<ChildDetailView> createState() => _ChildDetailViewState();
}

class _ChildDetailViewState extends State<ChildDetailView> {
  bool _editing = false;
  Child? _child;
  final _form = GlobalKey<FormState>();

  // controladores
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

  void _loadData(String id, ChildController controller) {
    final c = controller.getById(id);
    if (c != null) {
      _child = c;
      _nombre.text = c.nombre;
      _apellido.text = c.apellido;
      _ident.text = c.identificacion;
      _padres.text = c.nombrePadres;
      _peso.text = c.peso.toString();
      _altura.text = c.altura.toString();
      _perBraquial.text = c.perimetroBraquial.toString();
      _perAbdominal.text = c.perimetroAbdominal.toString();
      _edad.text = c.edad.toString();
    }
  }

  void _saveEdit(ChildController controller) {
    if (!(_form.currentState?.validate() ?? false)) return;

    final updated = Child(
      id: _child!.id,
      nombre: _nombre.text.trim(),
      apellido: _apellido.text.trim(),
      identificacion: _ident.text.trim(),
      nombrePadres: _padres.text.trim(),
      peso: double.tryParse(_peso.text.trim()) ?? 0.0,
      altura: double.tryParse(_altura.text.trim()) ?? 0.0,
      perimetroBraquial: double.tryParse(_perBraquial.text.trim()) ?? 0.0,
      perimetroAbdominal: double.tryParse(_perAbdominal.text.trim()) ?? 0.0,
      edad: int.tryParse(_edad.text.trim()) ?? 0,
      estadoNutricional: _child!.estadoNutricional,
      activo: true,
    );

    controller.updateChild(_child!.id, updated);
    setState(() {
      _editing = false;
      _child = updated;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro actualizado correctamente')),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'desnutricion':
        return Colors.redAccent;
      case 'sobrepeso':
        return Colors.orangeAccent;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final controller = Provider.of<ChildController>(context);

    if (_child == null) _loadData(id, controller);
    if (_child == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: Text('Niño no encontrado')),
      );
    }

    final imc = controller.computeIMC(_child!);
    final estadoColor = _getEstadoColor(_child!.estadoNutricional);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🟦 Encabezado
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
                        'DETALLES DEL NIÑO',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _editing ? Icons.cancel : Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => _editing = !_editing),
                  ),
                ],
              ),
            ),

            // 📋 Datos generales
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _field(
                          'Nombre',
                          _nombre,
                          Icons.person_outline,
                          enabled: _editing,
                        ),
                        _field(
                          'Apellido',
                          _apellido,
                          Icons.person_outline,
                          enabled: _editing,
                        ),
                        _field(
                          'Identificación',
                          _ident,
                          Icons.badge_outlined,
                          enabled: _editing,
                        ),
                        _field(
                          'Nombre padres / acudiente',
                          _padres,
                          Icons.family_restroom,
                          enabled: _editing,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _field(
                                'Peso (kg)',
                                _peso,
                                Icons.monitor_weight_outlined,
                                number: true,
                                enabled: _editing,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _field(
                                'Altura (m)',
                                _altura,
                                Icons.height,
                                number: true,
                                enabled: _editing,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _field(
                                'Per. braquial (cm)',
                                _perBraquial,
                                Icons.accessibility_new,
                                number: true,
                                enabled: _editing,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _field(
                                'Per. abdominal (cm)',
                                _perAbdominal,
                                Icons.accessibility,
                                number: true,
                                enabled: _editing,
                              ),
                            ),
                          ],
                        ),

                        _field(
                          'Edad (años)',
                          _edad,
                          Icons.cake_outlined,
                          number: true,
                          enabled: _editing,
                        ),

                        const SizedBox(height: 20),

                        // 💡 IMC destacado
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Índice de Masa Corporal (IMC)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                imc.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🎨 Estado nutricional
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: estadoColor.withOpacity(0.15),
                            border: Border.all(color: estadoColor, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: estadoColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _child!.estadoNutricional.isNotEmpty
                                    ? _child!.estadoNutricional.toUpperCase()
                                    : 'SIN CLASIFICAR',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: estadoColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 🔘 Botones inferiores
                        if (_editing)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  onPressed: () => _saveEdit(controller),
                                  label: const Text(
                                    'Guardar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      setState(() => _editing = false),
                                  child: const Text('Cancelar'),
                                ),
                              ),
                            ],
                          )
                        else
                          Center(
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.analytics_outlined,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () {
                                if (_child!.estadoNutricional ==
                                    'desnutricion') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        '⚠️ Niño en riesgo de desnutrición',
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        '✅ Estado dentro de rangos normales',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                              label: const Text(
                                'Evaluar / Enviar alerta',
                                style: TextStyle(color: Colors.white),
                              ),
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

  Widget _field(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool number = false,
    bool enabled = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
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
        keyboardType: number ? TextInputType.number : TextInputType.text,
        validator: (v) => (v == null || v.isEmpty) ? 'Campo requerido' : null,
      ),
    );
  }
}
