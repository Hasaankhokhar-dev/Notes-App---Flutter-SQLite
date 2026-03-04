class Note {
  int? id;
  String title;
  String content;
  String date;
// this is a constructor
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });
  // map for database
  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'content':content,
      'date':date,
    };
  }
  // get data from database
  factory Note.fromMap(Map<String,dynamic> map){
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}
