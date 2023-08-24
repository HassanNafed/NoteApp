import 'package:flutter/material.dart';

class CustTextFromSign extends StatelessWidget{
  final String? hint;
  final String?label;
  final String? Function(String?)valid;
  final TextEditingController mycontroller;

  const CustTextFromSign({Key?key,required this.hint,required this.label,required this.valid,required this.mycontroller}):super(key: key);

  @override
  Widget build( BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
         validator: valid,
         controller: mycontroller,
        decoration: InputDecoration(
									hintText: hint,
									labelText: label,
								 
									errorStyle: const TextStyle(fontSize: 18.0),
									border: const OutlineInputBorder(
										borderSide:
											BorderSide(color: Colors.red),
										borderRadius: BorderRadius.all(
											Radius.circular(9.0))))


      ),
    );
  }
}