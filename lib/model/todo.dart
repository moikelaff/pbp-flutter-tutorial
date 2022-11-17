import 'dart:convert';

List<todo> toDoFromJson(String str) => List<todo>.from(json.decode(str).map((x) => todo.fromJson(x)));

String toDoToJson(List<todo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class todo {
    todo({
        required this.userId,
        required this.id,
        required this.title,
        required this.completed,
    });

    int userId;
    int id;
    String title;
    bool completed;

    factory todo.fromJson(Map<String, dynamic> json) => todo(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}