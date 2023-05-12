import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_19400621/model/Bitacora.dart';
import 'package:dam_u4_proyecto1_19400621/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CapturaBitacora extends StatefulWidget {
  const CapturaBitacora({Key? key}) : super(key: key);

  @override
  State<CapturaBitacora> createState() => _CapturaBitacoraState();
}

class _CapturaBitacoraState extends State<CapturaBitacora> {

  final fechaController = TextEditingController();
  final eventoController = TextEditingController();
  final recursosController = TextEditingController();
  final verificoController = TextEditingController(text: "xd");
  final fechaverificacionController = TextEditingController(text: "xd");
  final idVehiculoController = TextEditingController();

  String _selectedDate = 'Seleccione fecha de salida';

  List<DropdownMenuItem<String>> _dropdownItems = [];
  String? _selectedItem;

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Realizar consulta a Firebase y obtener los documentos
    FirebaseFirestore.instance.collection('vehiculo').get().then((querySnapshot) {
      // Recorrer los documentos y crear los DropdownMenuItem a partir de los datos
      querySnapshot.docs.forEach((doc) {
        _dropdownItems.add(
          DropdownMenuItem(
            value: doc.id, // El valor es el ID del documento
            child: Text(doc['placa']), // El texto es el valor de un campo del documento
          ),
        );
      });

      // Actualizar el estado con los nuevos elementos de DropdownMenuItem
      setState(() {});
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Capturar Bitacora", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.deepOrange, brightness: Brightness.dark, centerTitle: true,),
        body: ListView(
          padding: EdgeInsets.fromLTRB(30, 60, 30, 60),
          children: [

            Text("PLACAS DEL VEHICULO", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

            SizedBox(height: 20,),

            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Selecciona Placa',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                value: _selectedItem,
                items: _dropdownItems,
                onChanged: (newValue) {
                  // Actualizar el estado con el nuevo elemento seleccionado
                  setState(() {
                    _selectedItem = newValue;
                    idVehiculoController.text = _selectedItem.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  height: 40,
                  width: 200,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            SizedBox(height: 40,),

            Text("FECHA DE SALIDA DEL VEHICULO", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

            SizedBox(height: 10,),

            OutlinedButton(onPressed: (){
              _selectDate(context);
            }, child: Text(_selectedDate)),

            SizedBox(height: 30,),

            TextField(
              decoration: InputDecoration(labelText: "EVENTO"),
              controller: eventoController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "RECURSOS"),
              controller: recursosController,
            ),

            SizedBox(height: 40,),

            FilledButton(onPressed: () async{
              Bitacora b = Bitacora(
                  fecha: fechaController.text,
                  evento: eventoController.text,
                  recursos: recursosController.text,
                  verifico: verificoController.text,
                  fechaverificacion: fechaverificacionController.text,
                  idVehiculo: idVehiculoController.text
              );

              await addBitacora(b).then((_){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("SE INSERTÓ!"))
                );
                Navigator.pop(context);
              });
            }, child: const Text("Guardar"))
          ],
        )
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2010),
      maxTime: DateTime(2025),
      onConfirm: (date) {
        setState(() {
          fechaController.text = date.toString();
          _selectedDate = date.toString();
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es,
    );
  }
}

