import 'package:dam_u4_proyecto1_19400621/model/Vehiculo.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter/material.dart';

class CapturaVehiculo extends StatefulWidget {
  const CapturaVehiculo({Key? key}) : super(key: key);

  @override
  State<CapturaVehiculo> createState() => _CapturaVehiculoState();
}

class _CapturaVehiculoState extends State<CapturaVehiculo> {
  final placaController = TextEditingController();
  final tipoController = TextEditingController();
  final numeroserieController = TextEditingController();
  final combustibleController = TextEditingController();
  final tanqueController = TextEditingController();
  final trabajadorController = TextEditingController();
  final deptoController = TextEditingController();
  final resguardadoporController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capturar Vehiculo", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange, brightness: Brightness.dark, centerTitle: true,),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            decoration: InputDecoration(labelText: "PLACA"),
            controller: placaController, autofocus: true,
          ),
          TextField(
            decoration: InputDecoration(labelText: "TIPO"),
            controller: tipoController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "NUMERO DE SERIE"),
            controller: numeroserieController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "TIPO DE COMBUSTIBLE"),
            controller: combustibleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "CAPACIDAD DE TANQUE"),
            controller: tanqueController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "TRABAJADOR"),
            controller: trabajadorController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "DEPARTAMENTO"),
            controller: deptoController,
          ),
          TextField(
            decoration: InputDecoration(labelText: "RESGUARDADO POR"),
            controller: resguardadoporController,
          ),
          SizedBox(height: 30,),

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

            await addVehiculo(v).then((_){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("SE INSERTÓ!"))
              );
              Navigator.pop(context);
            });
            placaController.text = "";
            tipoController.text = "";
            numeroserieController.text = "";
            combustibleController.text = "";
            tanqueController.text = "";
            trabajadorController.text = "";
            deptoController.text = "";
            resguardadoporController.text = "";

          }, child: const Text("Guardar"))
        ],
      )
    );
  }
}
