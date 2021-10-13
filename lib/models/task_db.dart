class TaskDB {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  bool? done;

  TaskDB.fromMap(map) {
    this.createdAt = map["createdAt"];
    this.description = map["description"];
    this.done = map["done"];
    this.id = map["id"];
    this.title = map["title"];
  }

  toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["id"] = id;
    map["done"] = done;
    map["createdAt"] = createdAt;
    map["description"] = description;

    return map;
  }
}