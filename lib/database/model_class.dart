class Note{
  int? id;
  String title;
  String description;

  Note({required this.title, required this.description, this.id});
  //convert out data to map function
  Map<String, dynamic>  toMap(){
    return {'title':title,'description':description};
  }
}