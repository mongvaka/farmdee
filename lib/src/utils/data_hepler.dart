class DataHelper{
  static double toDouble(dynamic value){
    if(value==null){
      return 0.0;
    }
    try{
      return double.parse('$value');
    }catch(e){
      return 0.0;
    }
  }
  static int toInt(dynamic value){
    if(value==null){
      return 0;
    }
    try{
      return int.parse('$value');
    }catch(e){
      return 0 ;
    }
  }
}