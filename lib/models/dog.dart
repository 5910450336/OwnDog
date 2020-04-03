class Dog {
  //Field
  String name;
  String detail;
  String imagePath;

  //Constructor
  Dog({
    this.name,
    this.detail,
    this.imagePath,
  });

  //Method

  Dog.fromMap(Map<String, dynamic> map) {
    name = map['name']; // dynamic คือ จะเป็น interger หรือ string ก้ได้
    detail = map['detail']; // 'name' คือ Field ใน database
    // imagePath = map['imagePath'];
    imagePath = map['imagePath'];
  }
}
