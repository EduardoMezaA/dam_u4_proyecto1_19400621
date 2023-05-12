import 'package:dam_u4_proyecto1_19400621/model/Vehiculo.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditarVehiculo extends StatefulWidget {
  const EditarVehiculo({Key? key}) : super(key: key);

  @override
  State<EditarVehiculo> createState() => _EditarVehiculoState();
}

class _EditarVehiculoState extends State<EditarVehiculo> {

  TextEditingController placaController = TextEditingController(text: "");
  TextEditingController tipoController = TextEditingController(text: "");
  TextEditingController numeroserieController = TextEditingController(text: "");
  TextEditingController combustibleController = TextEditingController(text: "");
  TextEditingController tanqueController = TextEditingController(text: "");
  TextEditingController trabajadorController = TextEditingController(text: "");
  TextEditingController deptoController = TextEditingController(text: "");
  TextEditingController resguardadoporController = TextEditingController(text: "");
  TextEditingController idC = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    placaController.text = arguments['placa'];
    tipoController.text = arguments['tipo'];
    numeroserieController.text = arguments['numeroserie'];
    combustibleController.text = arguments['combustible'];
    tanqueController.text = arguments['tanque'].toString();
    trabajadorController.text = arguments['trabajador'];
    deptoController.text = arguments['depto'];
    resguardadoporController.text = arguments['resguardadopor'];
    idC.text = arguments['id'];

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Vehiculo", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, brightness: Brightness.dark, centerTitle: true,),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(controller: placaController),
          SizedBox(height: 10,),
          TextField(controller: tipoController),
          SizedBox(height: 10,),
          TextField(controller: numeroserieController),
          SizedBox(height: 10,),
          TextField(controller: combustibleController),
          SizedBox(height: 10,),
          TextField(controller: tanqueController),
          SizedBox(height: 10,),
          TextField(controller: trabajadorController),
          SizedBox(height: 10,),
          TextField(controller: deptoController),
          SizedBox(height: 10,),
          TextField(controller: resguardadoporController),
          SizedBox(height: 10,),

          FilledButton(onPressed: () async{
            Vehiculo v = Vehiculo(
                placa: placaController.text,
                tipo: tipoController.text,
                numeroserie: numeroserieController.text,
                combustible: combustibleController.text,
                tanque: int.parse(tanqueController.text),
                trabajador: trabajadorController.text,
                depto: deptoController.text,
                resguardadopor: resguardadoporController.text
            );

            await updateVehiculo(arguments['id'], v).then((value){
              Navigator.pop(context);
              Navigator.pop(context);
            });


          }, child: Text("Guardar Cambios")),
        ],
      ),

    );
  }
}
