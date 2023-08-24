

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/AppNote2/components/costemtextform.dart';
import 'package:noteapp/AppNote2/components/crud.dart';
import 'package:noteapp/AppNote2/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
import 'package:image_picker/image_picker.dart';


class AddNotes2 extends StatefulWidget {
 const AddNotes2({Key? key}) : super(key: key);

@override
State<AddNotes2> createState() => _AddNotes2State();
}

class _AddNotes2State extends State<AddNotes2> with Crud {  
  File? myfile;
  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  
  TextEditingController title=TextEditingController();
  TextEditingController content=TextEditingController();
bool isloading=false;

addNotes ()async{
 if (myfile==null) return AwesomeDialog(context: context,title:"هام",body:const Text("الرجاء اضافة الصورة الخاصة بالملاحظة"))..show(); {
  
 }
 if (_formkey.currentState!.validate()) {
  isloading=true;
  setState(() {
    
  });
   var response=await postRequestWithFile(linkAddNotes, {
    "title":title.text,
    "content":content.text,
    "id":sharedPref.getString("id"),
  
  },  myfile!);
   isloading=false;
  setState(() {
    
  });
  
  if (response['status']=="success") {
           Navigator.of(context).pushReplacementNamed("homeAppNote2");
        }
         else{
          print("add notes faild");
        }  
 }
}

  @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Add Notes")),
      body:isloading==true?const Center(child: CircularProgressIndicator(),)
      : Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: ListView(
          children: [
            CustTextFromSign(
              hint: "title",
              label: "Title",
               mycontroller: title, 
               valid: (val){
                return validinput(val!, 1, 50);

               }
               ),

             CustTextFromSign(
              hint: "content",
              label: "content",
               mycontroller: content, 
               valid: (val){
                return validinput(val!, 1, 200);

               }
               ),
                Container(height: 20,),


               MaterialButton(
                
                onPressed: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context)=> SizedBox(
                      height: 150,
                      child: Column(children: [
                        InkWell(
                          onTap: ()async {
                            XFile? xfile =  await ImagePicker().pickImage(source:ImageSource.gallery);
                             Navigator.of(context).pop();
                              myfile=File(xfile!.path);
                              setState(() {
                                  
                                });
                          },
                          child: Container(
                            width: double.infinity, 
                          padding: const EdgeInsets.all(10),
                          child: const Center(child: Text("Chosse Image From Gallery",
                          style: TextStyle(fontSize: 20,color: Colors.blue),)),
                        ),
                        ),

                         InkWell(
                          onTap: ()async {
                              XFile? xfile=await ImagePicker().pickImage(source:ImageSource.camera);
                             Navigator.of(context).pop();

                                myfile=File(xfile!.path);
                                setState(() {
                                  
                                });
                          }, 
                          child: Container(
                            width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: const Center(child: Text("Chosse Image From Camera",
                          style: TextStyle(fontSize: 20,color: Colors.blue),)),
                        ),
                        ),
                      ]),


                   )
                   );
                  
               

                },
                textColor: Colors.white,
                color: myfile==null ? Colors.blue:Colors.green,
                
                child: const Text("Choose Image"),
                
               )  ,

               Container(height: 20,),
               MaterialButton(
                onPressed: ()async{
                  await addNotes();
                },
                textColor: Colors.white,
                color: Colors.blue,
                child: const Text("Add"),
               ) 
          ],
      ),
        )),
    );
   }

  

}