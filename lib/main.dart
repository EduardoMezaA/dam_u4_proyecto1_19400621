import 'package:dam_u4_proyecto1_19400621/CapturaBitacora.dart';
import 'package:dam_u4_proyecto1_19400621/CapturaVehiculo.dart';
import 'package:dam_u4_proyecto1_19400621/ConsultaBitacora.dart';
import 'package:dam_u4_proyecto1_19400621/EditarBitacora.dart';
import 'package:dam_u4_proyecto1_19400621/EditarVehiculo.dart';
import 'package:dam_u4_proyecto1_19400621/VehiculosDepto.dart';
import 'package:dam_u4_proyecto1_19400621/VehiculosFuera.dart';
import 'package:dam_u4_proyecto1_19400621/pantalla_principal.dart';
import 'package:flutter/material.dart';

//import firabase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Principal(),
        '/addV': (context) => const CapturaVehiculo(),
        '/editV': (context) => const EditarVehiculo(),
        '/addB': (context) => const CapturaBitacora(),
        '/editB': (context) => const EditarBitacora(),
        '/consultaB': (context) => const ConsultaBitacora(),
        '/consultaVD': (context) => const VehiculosDepto(),
        '/consultaVF': (context) => const VehiculosFuera()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}