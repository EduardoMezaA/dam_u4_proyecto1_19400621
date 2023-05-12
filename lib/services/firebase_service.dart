import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_19400621/model/Bitacora.dart';
import 'package:dam_u4_proyecto1_19400621/model/Vehiculo.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVehiculos() async{
  List vehiculos = [];
  CollectionReference colVehiculos = db.collection('vehiculo');

  QuerySnapshot queryVehiculo = await colVehiculos.get();

  for(var doc in queryVehiculo.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final vehiculo = {
      "placa": data['placa'],
      "tipo": data['tipo'],
      "numeroserie": data['numeroserie'],
      "combustible": data['combustible'],
      "tanque": data['tanque'],
      "trabajador": data['trabajador'],
      "depto": data['depto'],
      "resguardadopor": data['resguardadopor'],
      "id": doc.id,
    };
    vehiculos.add(vehiculo);
  }
  return vehiculos;
}

Future<void> addVehiculo(Vehiculo v) async{
  await db.collection('vehiculo').add(v.toMap());
}

Future<void> updateVehiculo(String id, Vehiculo v) async{
  await db.collection('vehiculo').doc(id).set(v.toMap());
}

Future<void> deleteVehiculo(String id) async{
  await db.collection('vehiculo').doc(id).delete();
}







//Bitacoras xdxdxd
Future<List> getBitacoras() async{
  List bitacoras = [];
  //CollectionReference colVehiculos = db.collection('vehiculo');
  //DocumentReference docVehiculo = colVehiculos.doc('5zjCuvxhRSx9Fvf1H7OY');
  //CollectionReference colBitacoras = docVehiculo.collection('bitacora');

  CollectionReference colBitacora = db.collection('bitacora');
  QuerySnapshot queryBitacora = await colBitacora.get();

  //QuerySnapshot queryBitacoras = await colBitacoras.get();

  for(var doc in queryBitacora.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bitacora = {
      "fecha": data['fecha'],
      "evento": data['evento'],
      "recursos": data['recursos'],
      "verifico": data['verifico'],
      "fechaverificacion": data['fechaverificacion'],
      "idVehiculo": data['idVehiculo'],
      "id": doc.id,
    };
    bitacoras.add(bitacora);
  }
  return bitacoras;
}

Future<void> addBitacora(Bitacora b) async{
  await db.collection('bitacora').add(b.toMap());
}

Future<void> updateBitacora(String id, Bitacora b) async{
  await db.collection('bitacora').doc(id).set(b.toMap());
}

Future<void> deleteBitacora(String id) async{
  await db.collection('bitacora').doc(id).delete();
}

Future<List> consultaPlacosa() async{
  List nigga = [];
  CollectionReference colVehiculos = db.collection('vehiculo');

  QuerySnapshot queryVehiculo = await colVehiculos.get();

  for(var doc in queryVehiculo.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final vehiculo = {
      "placa": data['placa'],
      "id": doc.id,
    };
    nigga.add(vehiculo);
  }
  return nigga;
}

//CONSULTAS DEL WARZON TEPACHE
Future<List> getBitacorasPlacosas(String idVehiculo) async{
  List bitacoras = [];


  QuerySnapshot queryBitacora = await db.collection('bitacora').where('idVehiculo', isEqualTo: idVehiculo).get();

  for(var doc in queryBitacora.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bitacora = {
      "fecha": data['fecha'],
      "evento": data['evento'],
      "recursos": data['recursos'],
      "verifico": data['verifico'],
      "fechaverificacion": data['fechaverificacion'],
      "idVehiculo": data['idVehiculo'],
      "id": doc.id,
    };
    bitacoras.add(bitacora);
  }
  return bitacoras;
}

Future<List> getVehiculosUso() async{
  List bitacoras = [];
  QuerySnapshot queryBitacora = await db.collection('bitacora').where('fechaverificacion', isEqualTo: "xd").get();

  for(var doc in queryBitacora.docs){
    String id = doc.get('idVehiculo');
    bitacoras.add(id);
  }

  List vehiculos = [];

  for(var element in bitacoras){
    //QuerySnapshot queryVehiculo = await db.collection('vehiculo').where(FieldPath.documentId, isEqualTo: element).get();
    QuerySnapshot queryVehiculo = await db.collection('vehiculo').get();

    for(var doc in queryVehiculo.docs){
      if(doc.id == element){
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final vehiculo = {
          "placa": data['placa'],
          "tipo": data['tipo'],
          "numeroserie": data['numeroserie'],
          "combustible": data['combustible'],
          "tanque": data['tanque'],
          "trabajador": data['trabajador'],
          "depto": data['depto'],
          "resguardadopor": data['resguardadopor'],
          "id": doc.id,
        };
        vehiculos.add(vehiculo);
      }
    }
  }
  return vehiculos;
}


Future<List> getVehiculosDeptos(String depto) async{
  List vehiculos = [];

  QuerySnapshot queryVehiculo = await db.collection('vehiculo').where('depto', isEqualTo: depto).get();

  for(var doc in queryVehiculo.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final vehiculo = {
      "placa": data['placa'],
      "tipo": data['tipo'],
      "numeroserie": data['numeroserie'],
      "combustible": data['combustible'],
      "tanque": data['tanque'],
      "trabajador": data['trabajador'],
      "depto": data['depto'],
      "resguardadopor": data['resguardadopor'],
      "id": doc.id,
    };
    vehiculos.add(vehiculo);
  }
  return vehiculos;
}