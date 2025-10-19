import 'package:flutter/material.dart';
import '../models/child_model.dart';
import 'dart:math';

/// Controlador simple para gestionar lista de niños en memoria.
/// Reemplazar persistencia por Firebase/REST cuando se integre backend.
class ChildController extends ChangeNotifier {
  final List<Child> _children = [];

  List<Child> get children => List.unmodifiable(_children);

  // Buscar por id
  Child? getById(String id) {
    try {
      return _children.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // Agregar niño (genera id si viene vacío)
  void addChild(Child child) {
    final id = child.id.isNotEmpty ? child.id : _generateId();
    final newChild = Child(
      id: id,
      nombre: child.nombre,
      apellido: child.apellido,
      identificacion: child.identificacion,
      nombrePadres: child.nombrePadres,
      peso: child.peso,
      altura: child.altura,
      perimetroBraquial: child.perimetroBraquial,
      perimetroAbdominal: child.perimetroAbdominal,
      edad: child.edad,
      estadoNutricional: _classifyEstadoNutricional(
        child.peso,
        child.altura,
        child.edad,
      ),
      activo: child.activo,
    );
    _children.add(newChild);
    notifyListeners();
  }

  // Editar (reemplaza por id)
  void updateChild(String id, Child updated) {
    final idx = _children.indexWhere((c) => c.id == id);
    if (idx == -1) return;
    _children[idx] = Child(
      id: id,
      nombre: updated.nombre,
      apellido: updated.apellido,
      identificacion: updated.identificacion,
      nombrePadres: updated.nombrePadres,
      peso: updated.peso,
      altura: updated.altura,
      perimetroBraquial: updated.perimetroBraquial,
      perimetroAbdominal: updated.perimetroAbdominal,
      edad: updated.edad,
      estadoNutricional: _classifyEstadoNutricional(
        updated.peso,
        updated.altura,
        updated.edad,
      ),
      activo: updated.activo,
    );
    notifyListeners();
  }

  // Eliminar
  void removeChild(String id) {
    _children.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  // IMC
  double computeIMC(Child c) {
    if (c.altura <= 0) return 0;
    return c.peso / (c.altura * c.altura);
  }

  // Clasificación simple (placeholder)
  String _classifyEstadoNutricional(double peso, double altura, int edad) {
    if (altura <= 0) return 'Indeterminado';
    final imc = peso / (altura * altura);
    // Reglas simplificadas (usar tablas OMS para rigidez)
    if (imc < 14) return 'Desnutricion';
    if (imc >= 14 && imc < 18) return 'Saludable';
    return 'Sobrepeso';
  }

  String _generateId() {
    final r = Random().nextInt(1000000);
    return "${DateTime.now().millisecondsSinceEpoch}_$r";
  }

  // Método de inicialización demo
  void loadSampleData() {
    if (_children.isNotEmpty) return;
    addChild(
      Child(
        id: '',
        nombre: 'Juan',
        apellido: 'Pérez',
        identificacion: '12345678',
        nombrePadres: 'María Pérez',
        peso: 14.0,
        altura: 0.95,
        perimetroBraquial: 14.0,
        perimetroAbdominal: 50.0,
        edad: 2,
        estadoNutricional: 'Saludable',
        activo: true,
      ),
    );
    addChild(
      Child(
        id: '',
        nombre: 'Ana',
        apellido: 'Gómez',
        identificacion: '87654321',
        nombrePadres: 'Carlos Gómez',
        peso: 9.5,
        altura: 0.9,
        perimetroBraquial: 12.5,
        perimetroAbdominal: 48.0,
        edad: 2,
        estadoNutricional: 'Desnutricion',
        activo: true,
      ),
    );
  }
}
