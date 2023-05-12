import 'package:dam_u4_proyecto1_19400621/ConsultaBitacora.dart';
import 'package:dam_u4_proyecto1_19400621/model/Vehiculo.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ProgramaVehiculos extends StatefulWidget {
  const ProgramaVehiculos({Key? key}) : super(key: key);

  @override
  State<ProgramaVehiculos> createState() => _ProgramaVehiculosState();
}

class _ProgramaVehiculosState extends State<ProgramaVehiculos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getVehiculos(),
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
                                    ProgramaVehiculos();
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
      floatingActionButton: FloatingActionButton(onPressed: () async{
          await Navigator.pushNamed(context, '/addV').then((value) {
            setState(() {
              ProgramaVehiculos();
            });
          },);
      },child: Icon(Icons.add), backgroundColor: Colors.blue,),
    );

  }
}
