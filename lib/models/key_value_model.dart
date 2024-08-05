class KeyValue {
  int? id;
  String? key;
  String? value;

  KeyValue({this.id, this.key, this.value});
  
  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'key': key,
      'value': value
    };
  }
}
