
import 'package:flutter/material.dart';
import 'package:noteapp/AppNote2/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import '../components/costemtextform.dart';
import '../components/crud.dart';



class Signup extends StatefulWidget {
const Signup({Key? key}) : super(key: key);

@override
State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey=GlobalKey();
    Crud crud =Crud();
    bool isloding=false;
    TextEditingController username=TextEditingController();
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
    
 signup()async{
  if(_formkey.currentState!.validate()){
          isloding=true;
        setState(() {
          
        });  
       var response=await crud.postRequest(linkSignUp, {
            "username":username.text,
            "email":email.text,
            "password":password.text,
          });

        isloding=false;
        setState(() {
       
        });   
        if (response['status']=="success") {
           Navigator.of(context).pushNamedAndRemoveUntil("success",(route)=>false);
        }
        else{
          print("sginup fail");
        } 
  }
  
}



@override
Widget build(BuildContext context) {
	return Scaffold(
	
	body:isloding==true?const Center(child:CircularProgressIndicator(),): SingleChildScrollView(
		child: Column(
		children: <Widget>[
			Padding(
			padding: const EdgeInsets.only(top: 80.0),
			child: Center(
			  child: SizedBox(
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
                mycontroller: username,
                hint:"Enter Username",
                label: "Username",
                ),
            
             CustTextFromSign(
                valid: (val){
                  return validinput(val!, 6, 40);
                },
                mycontroller: email,
                hint:"Enter Email",
                label: "Email",
                ),
      

			     CustTextFromSign(
                valid: (val){
                  return validinput(val!, 6, 15);
                },
                mycontroller: password,
                hint:"Enter Password",
                label: "Password",
                ),
			        
			     
      
      
			      Padding(
			        padding: const EdgeInsets.all(28.0),
			        child: SizedBox(
			        width: MediaQuery.of(context).size.width,
			        height: 50,
			        child: ElevatedButton(
			          child: const Text(
			          'SignUp',
			          style: TextStyle(
			            color: Colors.white, fontSize: 22),
			          ),
			          onPressed: ()async {
			           await signup();
			          },
			          
			          
			        ),
			        ),
			      ),
      
      
			    
			   Center(
			        child: Container(
			        padding: const EdgeInsets.only(top: 50),
			        child: MaterialButton(
                           onPressed: (){
                            Navigator.of(context).pushReplacementNamed("login");
                           },
                              child: const Text(
                                'LOGIN !',
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


