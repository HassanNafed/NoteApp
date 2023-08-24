

  import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/AppNote2/components/costemtextform.dart';
import 'package:noteapp/AppNote2/components/crud.dart';
import 'package:noteapp/AppNote2/components/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

class EditNotes2 extends StatefulWidget {
  final notes;
 const EditNotes2({Key? key,this.notes}) : super(key: key);

@override
State<EditNotes2> createState() => _EditNotes2State();
}

class _EditNotes2State extends State<EditNotes2> with Crud{  
  File? myfile;
 final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  
  TextEditingController title=TextEditingController();
  TextEditingController content=TextEditingController();
bool isloading=false;

editNotes ()async{
 if (_formkey.currentState!.validate()) {
  isloading=true;
  setState(() {
    
  });
   var response;
   if (myfile==null) {
      response=await postRequest(linkEditNotes, {
    "title":title.text,
    "content":content.text,
    "id":widget.notes['notes_id'].toString(),
    "imagename":widget.notes['notes_image'],


  });
   }else{
    response=await postRequestWithFile(linkEditNotes, {
    "title":title.text,
    "content":content.text,
    "id":widget.notes['notes_id'].toString(),
    "imagename":widget.notes['notes_image'],

  },myfile!);
    
   }



  isloading=false;
  setState(() {
    
  });
  if (response['status']=="success") {
           Navigator.of(context).pushReplacementNamed("homeAppNote2");
        }
         else{
          print("Edit notes faild");
        } 

   
 }
}
   @override
   void initState(){
    title.text=widget.notes['notes_title'];
    content.text=widget.notes['notes_content'];
    super.initState();

   }
  



  @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Notes")),
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
                  await editNotes();
                },
                textColor: Colors.white,
                color: Colors.blue,
                child: const Text("Edit"),
               ) 
          ],
      ),
        )),
    );
   }

  

}