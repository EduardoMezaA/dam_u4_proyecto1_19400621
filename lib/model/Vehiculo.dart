//Clase Modelo

class Vehiculo{
  String placa;
  String tipo;
  String numeroserie;
  String combustible;
  int tanque;
  String trabajador;
  String depto;
  String resguardadopor;
  String? id;

  Vehiculo({
    required this.placa,
    required this.tipo,
    required this.numeroserie,
    required this.combustible,
    required this.tanque,
    required this.trabajador,
    required this.depto,
    required this.resguardadopor,
    //this.id,
  });

  Map<String, dynamic> toMap(){
    return{
      'placa': placa,
      'tipo': tipo,
      'numeroserie': numeroserie,
      'combustible': combustible,
      'tanque': tanque,
      'trabajador': trabajador,
      'depto': depto,
      'resguardadopor': resguardadopor,
      //'id': id,
    };
  }

  @override
  String toString() {
    return 'Vehiculo{placa: $placa, tipo: $tipo, numeroserie: $numeroserie, combustible: $combustible, tanque: $tanque,'
        'trabajador: $trabajador, depto: $depto, resguardadopor: $resguardadopor,}';
  }
}