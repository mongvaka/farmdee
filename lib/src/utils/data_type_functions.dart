class DataTypeHelper{
  static toDouble(dynamic value){
    try{
      return double.parse(value);
    }catch(e){
      return 0;
    }
  }
}