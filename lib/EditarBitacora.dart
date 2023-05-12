import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_19400621/model/Bitacora.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EditarBitacora extends StatefulWidget {
  const EditarBitacora({Key? key}) : super(key: key);

  @override
  State<EditarBitacora> createState() => _EditarBitacoraState();
}

class _EditarBitacoraState extends State<EditarBitacora> {
  final fechaController = TextEditingController();
  final eventoController = TextEditingController();
  final recursosController = TextEditingController();
  final verificoController = TextEditingController();
  final fechaverificacionController = TextEditingController();
  final idVehiculoController = TextEditingController();
  final idC = TextEditingController();

  String _selectedDateV = 'Seleccione fecha de verificación';


  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    fechaController.text = (arguments['fecha']).toString();
    eventoController.text = arguments['evento'];
    recursosController.text = arguments['recursos'];
    //verificoController.text = arguments['verifico'];
    //fechaverificacionController.text = (arguments['fechaverificacion']).toString();



    idVehiculoController.text = arguments['idVehiculo'];
    idC.text = arguments['id'];
    return Scaffold(
        appBar: AppBar(title: const Text("Editar Bitacora", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.deepOrange, brightness: Brightness.dark, centerTitle: true,),
        body: ListView(
          padding: EdgeInsets.fromLTRB(30, 60, 30, 60),
          children: [

            TextField(
              decoration: InputDecoration(labelText: "VERIFICO"),
              controller: verificoController,
            ),


            SizedBox(height: 30,),

            Text("FECHA DE VERIFICACIÓN DEL VEHICULO", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),),

            SizedBox(height: 10,),

            OutlinedButton(onPressed: (){
              _selectDateV(context);
            }, child: Text(_selectedDateV)),

            SizedBox(height: 20,),


            FilledButton(onPressed: () async{
              Bitacora b = Bitacora(
                  fecha: fechaController.text,
                  evento: eventoController.text,
                  recursos: recursosController.text,
                  verifico: verificoController.text,
                  fechaverificacion: fechaverificacionController.text,
                  idVehiculo: idVehiculoController.text
              );

              await updateBitacora(arguments['id'], b).then((value){
                Navigator.pop(context);
                Navigator.pop(context);
              });


            }, child: const Text("Guardar Cambios"))
          ],
        )
    );
  }

  Future<void> _selectDateV(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2010),
      maxTime: DateTime(2025),
      onConfirm: (date) {
        setState(() {
          fechaverificacionController.text = date.toString();
          _selectedDateV = date.toString();
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
  }
}
