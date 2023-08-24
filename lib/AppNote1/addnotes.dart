import 'package:flutter/material.dart';
import 'package:noteapp/AppNote1/homeAppNote1.dart';
//import 'package:noteapp/app/homeAppNote1.dart';
import 'package:noteapp/appnote1/sqldb.dart';
class AddNotes extends StatefulWidget{
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb= SqlDb();
  GlobalKey<FormState>formstate=GlobalKey();
  TextEditingController note=TextEditingController();
  TextEditingController color=TextEditingController();
  TextEditingController title=TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(
            children: [
              Form(
                key: formstate,
                
                child:
               Column(children: [
                TextFormField(
                  controller: note,
                  decoration: const InputDecoration(
                    hintText: "note",
                  ) ,
                ),

                  TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: "title",
                  ) ,
                ),

                  TextFormField(
                  controller: color,
                  decoration: const InputDecoration(
                    hintText: "color",
                  ) ,
                ),


                Container(height: 20,),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: ()async {
                    int response=await sqlDb.insertData(
                      '''
                            INSERT INTO notes('note','title','color')
                            VALUES ("${note.text}","${title.text}","${color.text}")
                               '''); 
                               if(response>0){
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home1()), (route) => false);
                               }
                       print("response====================="); 
                       print(response); 

                  },
                  child:const Text("Add Note"),
                ),
                  




               ],))
            ],
          ),
        ),
      ),
    );
    }
}