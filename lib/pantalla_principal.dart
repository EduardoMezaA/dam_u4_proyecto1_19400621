import 'package:dam_u4_proyecto1_19400621/CapturaVehiculo.dart';
import 'package:dam_u4_proyecto1_19400621/ConsultasXD.dart';
import 'package:dam_u4_proyecto1_19400621/ProgramaBitacoras.dart';
import 'package:dam_u4_proyecto1_19400621/ProgramaVehiculos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _indice = 0;

  void _cambiarIndice(int indice){
    setState(() {
      _indice = indice;
    });
  }

  final List<Widget> _paginas = [
    ProgramaVehiculos(),
    ProgramaBitacoras(),
    ConsultasXD(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Image.network('https://www.tepic.tecnm.mx/images/escudo_itt_grande.png'), title: Text(
        'CocheTec', style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 32),
      ), centerTitle: true, backgroundColor: Colors.deepOrange, actions: [
        IconButton(onPressed: (){
          showDialog(context: context, builder: (builder){
            return AlertDialog(
              title: Text("ATENCIÓN"),
              content: Image.network(
                'https://images3.memedroid.com/images/UPLOADED317/5ff4a44b8d29f.jpeg',
                width: 200, // ancho de la imagen
                height: 200, // alto de la imagen
                fit: BoxFit.cover, // ajuste de la imagen
              ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Llorar")),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("OK")),
              ],
            );
          });
        }, icon: Icon(Icons.fastfood))
        ],),
      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.car_crash), label: "Vehiculos"),
          BottomNavigationBarItem(icon: Icon(Icons.app_registration), label: "Bitacoras"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Consultas"),
        ],
        currentIndex: _indice,
        onTap: _cambiarIndice,
        iconSize: 30,
        backgroundColor: CupertinoColors.systemBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
      ),

    );
  }

}
