import 'package:flutter/material.dart';
import 'package:noteapp/AppNote1/addnotes.dart';
//import 'package:noteapp/app/auth/login.dart';
import 'package:noteapp/AppNote1/editnote.dart';
import 'package:noteapp/appnote1/sqldb.dart';


class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  SqlDb sqlDb= SqlDb();
  bool isLoading=true;
  List notes=[];
  Future readData()async{

    List<Map>response=await sqlDb.readData("SELECT* FROM notes ");
    notes.addAll(response);
    isLoading=false;
    if(mounted){
      setState(() {
      
    });}
    
  }



  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),
        
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const AddNotes()),

          );
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading==true?
     const Center(child: Text("Loading....")):
      Container(
       decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/bg.jpeg"),
        fit: BoxFit.cover),
  ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            const Center(child: Text("MY NOTES",style:
             TextStyle(fontSize: 25,fontWeight:FontWeight.w500 ,color: Colors.blue),)),
             Container(height: 10,),
            ListView.builder(
                    itemCount: notes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,i){
                      return Card(child: ListTile(
                        title:Text("${notes[i]['title']}") ,
                        subtitle:Text("${notes[i]['note']}") ,
                        trailing:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: ()async {
                          int response=await sqlDb.deleteData("DELETE FROM notes WHERE id=${notes[i]['id']}");
                          if(response>0){
                            notes.removeWhere((element) => element['id']==notes[i]['id']);
                            setState(() {
                              
                            });
                          }
                        },
                        icon: const Icon(Icons.delete,color: Colors.red,),
                        ),

                             IconButton(onPressed: () {
                           Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>EditNotes(
                                  color:notes[i]['color'],
                                  note:notes[i]['note'],
                                  title:notes[i]['title'],
                                  id:notes[i]['id'],
                           )));
                        },
                        icon: const Icon(Icons.edit,color: Colors.blue,),
                        ),
                          ],
                        ),
                        
                      ),);
                       
                    })
              
          ],),
        ),
      ),
    );
  }
}