import '../../constant/massage.dart';

validinput(String val,int min,int max){
  if (val.length>max){
    
    return "$messageInputMax $max";
  }
  if(val.isEmpty){
    return messageInputEmpty;
  }

  if (val.length<min){
    
    return "$messageInputMin $min";
  }
  
}