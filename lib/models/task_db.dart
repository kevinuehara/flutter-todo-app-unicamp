class TaskDB {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  bool? done;

  TaskDB.fromMap(map) {
    this.id = map["id"];
    this.createdAt = map["createdAt"];
    this.description = map["description"];
    this.done = map["done"] == 1 ? true : false;
    this.title = map["title"];
  }

  TaskDB(id, title, description, createdAt, done) {
    this.title = title;
    this.description = description;
    this.createdAt = createdAt;
    this.done = done;
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["done"] = done == true ? 1 : 0;
    map["createdAt"] = createdAt;
    map["description"] = description;

    return map;
  }
}