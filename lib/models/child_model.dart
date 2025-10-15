class Child {
  final String id;
  final String nombre;
  final String apellido;
  final String identificacion;
  final String nombrePadres;
  final double peso;
  final double altura;
  final double perimetroBraquial;
  final double perimetroAbdominal;
  final int edad;
  final String estadoNutricional; // saludable, sobrepeso, desnutricion
  final bool activo;

  Child({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.identificacion,
    required this.nombrePadres,
    required this.peso,
    required this.altura,
    required this.perimetroBraquial,
    required this.perimetroAbdominal,
    required this.edad,
    required this.estadoNutricional,
    required this.activo,
  });
}
