import 'package:flutter/material.dart';

import 'package:noteapp/AppNote2/auth/login.dart';
import 'package:noteapp/AppNote2/auth/signup.dart';
import 'package:noteapp/AppNote2/auth/success.dart';
import 'package:noteapp/AppNote2/homeAppNote2.dart';
import 'package:noteapp/AppNote2/notes/add.dart';
import 'package:noteapp/AppNote2/notes/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref=await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: sharedPref.getString("id")==null?"login":"home",
      initialRoute: "login",
      routes: {
        "login":(context)=>const Login(),
        "signup":(context)=>const Signup(),
        "homeAppNote2":(context)=>const Home2(),
        "success":(context)=>const Success(),
        "addnotes2":(context)=>const AddNotes2(),
        "editnotes2":(context)=>const EditNotes2(),




      },
   );
    
  }

}
  