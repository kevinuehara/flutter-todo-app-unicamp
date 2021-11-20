class TaskDB {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  bool? done;

  TaskDB.fromMap(map) {
    this.id = map["_id"];
    this.createdAt = map["createdAt"];
    this.description = map["description"];
    this.done = map["done"];
    this.title = map["title"];
  }

  TaskDB(id, title, description, createdAt, done) {
    if (this.id != null) this.id = id;
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