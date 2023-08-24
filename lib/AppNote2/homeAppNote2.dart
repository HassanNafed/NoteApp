import 'package:flutter/material.dart';
import 'package:noteapp/AppNote2/auth/login.dart';
import 'package:noteapp/AppNote2/components/cardnote.dart';
import 'package:noteapp/AppNote2/components/crud.dart';
import 'package:noteapp/AppNote2/notes/edit.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';



class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> with Crud{
  
  getnotes()async{
    var response=await postRequest(linkViewNotes, {
        "id":sharedPref.getString("id"),

    });
    return response;
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),
      actions: [
        IconButton(onPressed: (){
          sharedPref.clear();
           Navigator.push(context, MaterialPageRoute(builder: (context) => 
                                    const Login()));
        }, icon: const Icon(Icons.exit_to_app))
       ],),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("addnotes2");
        },
        child: const Icon(Icons.add),
      ),
      body:
     Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
          FutureBuilder(
            future: getnotes(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
            if (snapshot.hasData) {
              if (snapshot.data['status']=='faild') {
                return const Center(child: Text("لا يوجد ملاحظات"));
              }
              return ListView.builder(
                itemCount: snapshot.data['data'].length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:(context,i){
                return cardNotes(
                  ondelete: ()async{
                   var response =await postRequest(linkDeleteNotes,{
                    "id":snapshot.data['data'][i]['notes_id'].toString(),
                    "imagename":snapshot.data['data'][i]['notes_image'].toString(),

                   });
                   setState(() {
                     
                   });
                   if (response['status']=="succes") {
                     Navigator.of(context).pushNamed("home2");
                   }
                  },

                  ontap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>EditNotes2(
                        notes:snapshot.data['data'][i]
                      )));
                  }, 
                  title: "${snapshot.data['data'][i]['notes_title']}", 
                 content: "${snapshot.data['data'][i]['notes_content']}", 
                 noteimage: "${snapshot.data['data'][i]['notes_image']}", 
                 );
              });
            
            }
            if (snapshot.connectionState==ConnectionState.waiting) {
              return const Center(child: Text("loading..."));
            }
              return const Center(child: Text("loading......."));

          },
          )
            
          ],
        ),
      ),
     ),
    );

    
 }
}