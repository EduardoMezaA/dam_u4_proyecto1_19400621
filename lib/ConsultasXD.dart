import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_19400621/VehiculosDepto.dart';
import 'package:dam_u4_proyecto1_19400621/VehiculosFuera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ConsultasXD extends StatefulWidget {
  const ConsultasXD({Key? key}) : super(key: key);

  @override
  State<ConsultasXD> createState() => _ConsultasXDState();
}

class _ConsultasXDState extends State<ConsultasXD> {

  List<DropdownMenuItem<String>> _dropdownItems = [];
  String? _selectedItem;

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController deptoController = TextEditingController();

  List<String> _uniqueValues = [];

  @override
  void initState() {
    super.initState();
    // Realizar consulta a Firebase y obtener los documentos
    FirebaseFirestore.instance.collection('vehiculo').get().then((querySnapshot) {
      // Recorrer los documentos y crear los DropdownMenuItem a partir de los datos
      querySnapshot.docs.forEach((doc) {
        String fieldValue = doc.get('depto');
        if (!_uniqueValues.contains(fieldValue)) {
          _uniqueValues.add(fieldValue);
          _dropdownItems.add(
            DropdownMenuItem(
              value: doc['depto'], // El valor es el depto del vehiculo
              child: Text(doc['depto']), // El texto es el valor de un campo del documento
            ),
          );
        }
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
      body: ListView(
        padding: EdgeInsets.all(40),
        children: [
          SizedBox(height: 30,),

          Text("BUSQUEDA DE VEHICULOS EN USO", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          FilledButton(onPressed: (){
            Navigator.pushNamed(context, '/consultaVF');
          }, child: Text("Ver Vehiculos en uso")),

          SizedBox(height: 40,),

          Text("BUSQUEDA DE VEHICULOS POR DEPARTAMENTO", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.deepPurple),),

          SizedBox(height: 20,),

          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Selecciona Departamento',
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
                  deptoController.text = _selectedItem.toString();
                  print(deptoController.text);
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
          SizedBox(height: 20,),

          FilledButton(onPressed: (){
            Navigator.pushNamed(context, '/consultaVD',
            arguments: deptoController.text);
          }, child: Text("Ver Vehiculos por Departamento")),
        ],
      ),
    );
  }
}
