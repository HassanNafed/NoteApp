
import 'package:flutter/material.dart';
import 'package:noteapp/constant/linkapi.dart';

class cardNotes extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String content;
  final String noteimage;
  final void Function()? ondelete;
  const cardNotes({ Key? key,
  required this.ontap,
  required this.title,
  required this.noteimage,

  required this.content,
  required this.ondelete,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ontap,
        child: Card(
           shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80) ,
            bottomLeft: Radius.circular(80) ,
            topRight: Radius.circular(30) ,
            bottomRight: Radius.circular(30) ,

            
            ),//topRight:50 ,bottomLeft:80 ,bottomRight:50 ),
          //set border radius more than 50% of height and width to make circle
           ),
          color: const Color.fromARGB(255, 222, 217, 217),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
            Expanded(
              flex: 1,
              child:Image.network(
                "$LinkImageRoot/$noteimage",
                width: 70,
                height: 100,
                fit:BoxFit.fill ,) ),
            Expanded(
              flex: 2,
              child:ListTile(
                title:Text(title,style: const TextStyle(fontSize:18,color: Color.fromARGB(255, 108, 40, 9) ),) ,
                subtitle: Text("$content "),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: 
                    ondelete,

                 
                ),

              ))    
          ]),
        ),
      ),
    );
  }
}