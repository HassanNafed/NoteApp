// ignore_for_file: sized_box_for_whitespace

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
//import 'package:noteapp/app/auth/signup.dart';
//import 'package:noteapp/app/homeAppNote1.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
import '../components/costemtextform.dart';
import '../components/crud.dart';
import '../components/valid.dart';


class Login extends StatefulWidget {
const Login({Key? key}) : super(key: key);

@override
State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final Crud _crud =Crud();
   bool isloding=false;
  TextEditingController email=TextEditingController();
   TextEditingController password=TextEditingController();
 final GlobalKey<FormState> _formkey=GlobalKey();

login()async{
  if(_formkey.currentState!.validate()){
      isloding=true;
        setState(() {
          
        });
     var response= await _crud.postRequest(linkLogin,{
    "email":email.text,
    "password":password.text,

 });
  isloding=false;
        setState(() {
          
        });
  if (response['status']=="success") {
    sharedPref.setString("id", response['data']['id'].toString());
    sharedPref.setString("username", response['data']['username']);
    sharedPref.setString("email", response['data']['email']);
            
             Navigator.of(context).pushNamedAndRemoveUntil("homeAppNote2",(route)=>false);
        }
  else{
          AwesomeDialog(
            context: context,
            //btnCancel: Text("Cancel"),
            title:"تنبيه",
            body:const Text(" البريد الاكنرونى او كلمة المرور  خطأ او الحساب غير موجود",style: TextStyle(fontSize: 15),),).show();
        }
  }

}

@override
Widget build(BuildContext context) {
	return Scaffold(
	
	body: isloding==true?const Center(child:CircularProgressIndicator(),):SingleChildScrollView(
		child: Column(
		children: <Widget>[
			Padding(
			padding: const EdgeInsets.only(top: 80.0),
			child: Center(
			  child: Container(
			  width: 300,
			  height: 100,
			  
			  child: Image.asset('images/bg2.png'),
			  ),
			),
			),
			Padding(
			padding: const EdgeInsets.symmetric(horizontal: 15),
			child: Padding(
			  padding: const EdgeInsets.all(12.0),
			  child: Form(
			    key: _formkey,
			    child: Column(
			      crossAxisAlignment: CrossAxisAlignment.start,
			      children: <Widget>[
			     CustTextFromSign(
                valid: (val){
                  return validinput(val!, 5, 20);
                },
                mycontroller: email,
                hint:"Enter Email",
                label: "Email",),
			        
			      CustTextFromSign(
                valid: (val){
                  return validinput(val!, 5, 20);
                },
                mycontroller: password,
                hint:"Enter Password",
                label: "Password",),
      
      
      
			      Padding(
			        padding: const EdgeInsets.all(28.0),
			        child: Container(
			        width: MediaQuery.of(context).size.width,
			        height: 50,
			        child: ElevatedButton(
			          child: const Text(
			          'Login',
			          style: TextStyle(
			            color: Colors.white, fontSize: 22),
			          ),
			          onPressed: () async{
			           await login();
			          },
			          
			        ),
			        ),
			      ),
      
      
			    
			      Center(
			        child: Container(
			        padding: const EdgeInsets.only(top: 50),
			        child: MaterialButton(
                           onPressed: (){
                            Navigator.of(context).pushNamed("signup");
                           },
                              child: const Text(
                                'SIGN UP!',
                                style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.lightBlue,
                                ),
                              ),
                            ),
			        ),
			      )
			      ]),
			  )),
			),
		],
		),
	),
	);
}
}


