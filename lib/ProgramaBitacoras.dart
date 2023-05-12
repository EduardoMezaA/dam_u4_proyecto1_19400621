import 'package:dam_u4_proyecto1_19400621/ConsultaBitacora.dart';
import 'package:dam_u4_proyecto1_19400621/ProgramaVehiculos.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ProgramaBitacoras extends StatefulWidget {
  const ProgramaBitacoras({Key? key}) : super(key: key);

  @override
  State<ProgramaBitacoras> createState() => _ProgramaBitacorasState();
}

class _ProgramaBitacorasState extends State<ProgramaBitacoras> {
  List<dynamic> aaa = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getBitacoras(),
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
                                await Navigator.pushNamed(context, '/editB', arguments: {
                                  "fecha": snapshot.data?[index]['fecha'],
                                  "evento": snapshot.data?[index]['evento'],
                                  "recursos": snapshot.data?[index]['recursos'],
                                  "verifico": snapshot.data?[index]['verifico'],
                                  "fechaverificacion": snapshot.data?[index]['fechaverificacion'],
                                  "idVehiculo": snapshot.data?[index]['idVehiculo'],
                                  "id": snapshot.data?[index]['id'],
                                });
                                setState(() { });
                              }, child: const Text("ACTUALIZAR")),
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("NADA")),
                            ],
                          );
                        });
                      },
                      child: ListTile(
                        title: Text(snapshot.data?[index]['evento']),
                        subtitle: Text(snapshot.data?[index]['recursos']),
                        trailing: Text((snapshot.data?[index]['fecha']).toString().substring(0, 16)),
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
        await Navigator.pushNamed(context, '/addB').then((value) {
          setState(() {
            ProgramaBitacoras();
          });
        },);
      },child: Icon(Icons.add), backgroundColor: Colors.blue,),
    );
  }

  void actualizarLista() async {
    List<dynamic> temporal = await consultaPlacosa();
    setState(() {
      aaa = temporal;
    });
  }
}
