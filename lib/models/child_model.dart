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
  final String estadoNutricional; // Saludable, Sobrepeso, Desnutricion
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

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json['id'] ?? '',
    nombre: json['nombre'] ?? '',
    apellido: json['apellido'] ?? '',
    identificacion: json['identificacion'] ?? '',
    nombrePadres: json['nombrePadres'] ?? '',
    peso: (json['peso'] ?? 0).toDouble(),
    altura: (json['altura'] ?? 0).toDouble(),
    perimetroBraquial: (json['perimetroBraquial'] ?? 0).toDouble(),
    perimetroAbdominal: (json['perimetroAbdominal'] ?? 0).toDouble(),
    edad: (json['edad'] ?? 0).toInt(),
    estadoNutricional: json['estadoNutricional'] ?? '',
    activo: json['activo'] ?? true,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'apellido': apellido,
    'identificacion': identificacion,
    'nombrePadres': nombrePadres,
    'peso': peso,
    'altura': altura,
    'perimetroBraquial': perimetroBraquial,
    'perimetroAbdominal': perimetroAbdominal,
    'edad': edad,
    'estadoNutricional': estadoNutricional,
    'activo': activo,
  };
}
