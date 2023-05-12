import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ConsultaBitacora extends StatefulWidget {
  const ConsultaBitacora({Key? key}) : super(key: key);

  @override
  State<ConsultaBitacora> createState() => _ConsultaBitacoraState();
}

class _ConsultaBitacoraState extends State<ConsultaBitacora> {
  TextEditingController idController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    idController.text = arguments['id'];
    return Scaffold(
      appBar: AppBar(title: const Text("Bitacoras de Vehículo por PLACA", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, brightness: Brightness.dark, centerTitle: true,),
      body: FutureBuilder(
          future: getBitacorasPlacosas(idController.text),
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
    );
  }
}
