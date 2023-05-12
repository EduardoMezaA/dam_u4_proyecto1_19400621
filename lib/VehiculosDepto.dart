import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_19400621/ProgramaVehiculos.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class VehiculosDepto extends StatefulWidget {
  const VehiculosDepto({Key? key}) : super(key: key);

  @override
  State<VehiculosDepto> createState() => _VehiculosDeptoState();
}

class _VehiculosDeptoState extends State<VehiculosDepto> {
  TextEditingController deptoController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final String arguments = ModalRoute.of(context)!.settings.arguments as String;
    deptoController.text = arguments;
    return Scaffold(
        appBar: AppBar(title: const Text("Vehiculos por Departamento", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.deepOrange, brightness: Brightness.dark),
      body: FutureBuilder(
          future: getVehiculosDeptos(deptoController.text),
          builder: ((context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (builder){
                        return AlertDialog(
                          title: Text("ATENCIÓN"),
                          content: Text("¿QUE DESEA HACER CON ESTE VEHICULO?"),
                          actions: [
                            TextButton(onPressed: () async{
                              await Navigator.pushNamed(context, '/editV', arguments: {
                                "placa": snapshot.data?[index]['placa'],
                                "tipo": snapshot.data?[index]['tipo'],
                                "numeroserie": snapshot.data?[index]['numeroserie'],
                                "combustible": snapshot.data?[index]['combustible'],
                                "tanque": snapshot.data?[index]['tanque'],
                                "trabajador": snapshot.data?[index]['trabajador'],
                                "depto": snapshot.data?[index]['depto'],
                                "resguardadopor": snapshot.data?[index]['resguardadopor'],
                                "id": snapshot.data?[index]['id'],
                              });
                              setState(() { });
                            }, child: const Text("ACTUALIZAR")),
                            TextButton(onPressed: () async{
                              await deleteVehiculo(snapshot.data?[index]['id']).then((value){
                                setState(() {
                                  Navigator.pop(context);
                                  VehiculosDepto();
                                });
                              });
                            }, child: const Text("ELIMINAR")),
                            TextButton(onPressed: () async{
                              await Navigator.pushNamed(context, '/consultaB', arguments: {
                                "id": snapshot.data?[index]['id'],
                              });
                              setState(() { });
                            }, child: const Text("BITACORAS")),
                          ],
                        );
                      });

                    },
                    child: ListTile(
                      title: Text(snapshot.data?[index]['placa'] + ' - ' + snapshot.data?[index]['numeroserie']),
                      subtitle: Text(snapshot.data?[index]['tipo'] + ' - ' + snapshot.data?[index]['combustible'] + ' - ' + snapshot.data?[index]['tanque'].toString()),
                      trailing: Text(snapshot.data?[index]['depto']),
                    ),
                  );
                },);
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
      ),
    );
  }
}
