class Bitacora{
  String? fecha;
  String? evento;
  String? recursos;
  String? verifico;
  String? fechaverificacion;
  String? id;
  String? idVehiculo;

  Bitacora({
    this.fecha,
    this.evento,
    this.recursos,
    this.verifico,
    this.fechaverificacion,
    this.idVehiculo,
  });

  Map<String, dynamic> toMap(){
    return{
      'fecha': fecha,
      'evento': evento,
      'recursos': recursos,
      'verifico': verifico,
      'fechaverificacion': fechaverificacion,
      'idVehiculo': idVehiculo,
    };
  }

  @override
  String toString() {
    return 'Bitacora{fecha: $fecha, evento: $evento, recursos: $recursos, verifico: $verifico, fechaverificacion: $fechaverificacion}';
  }
}