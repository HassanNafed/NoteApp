import 'package:flutter/material.dart';
import 'package:noteapp/AppNote1/homeAppNote1.dart';
//import 'package:noteapp/app/homeAppNote1.dart';
import 'package:noteapp/appnote1/sqldb.dart';
class EditNotes extends StatefulWidget{

  final note;
  final title;
  final color;
  final id;
  const EditNotes({Key?key,this.note,this.title,this.id,this.color}):super(key: key);
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb= SqlDb();



  GlobalKey<FormState>formstate=GlobalKey();
  TextEditingController note=TextEditingController();
  TextEditingController color=TextEditingController();
  TextEditingController title=TextEditingController();


  @override
  void initState() {
    note.text=widget.note;
    title.text=widget.title;
    color.text=widget.color;
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return 
    

             
    
    Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      
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
                    int response=await sqlDb.updateData(
                      '''
                           UPDATE notes SET 
                           note = "${note.text}",
                           title = "${title.text}",
                           color = "${color.text}"
                           WHERE   id = ${widget.id}
                               '''); 
                               if(response>0){
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context)=>const Home1()),
                                   (route) => false);
                               }
                       //print("response====================="); 
                      // print(response); 

                  },
                  child:const Text("Edit Note"),
                ),
                  




               ],))
            ],
          ),
        ),
      ),
    );
    
    }
}