class TodoInfo {
  String? id;
  String? userUID;
  String? title;
  String? description;
  int? availableCoins;
  int? createdAt;
  int? notifyTime;
  int? deleteAt;

  TodoInfo(
      {required this.id,
      required this.title,
      required this.description,
      required this.availableCoins,
      required this.createdAt,
      required this.userUID,
      required this.deleteAt,
      required this.notifyTime});

  factory TodoInfo.fromJson(Map<String, dynamic> json) {
    return TodoInfo(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        availableCoins: json['availableCoins'],
        createdAt: json['createdAt'],
        userUID: json['userUID'],
        deleteAt: json['deleteAt'],
        notifyTime: json['notifyTime']);
  }
}

// final todoData = [
//   TodoInfo(
//       deleteAt: 355353535,
//       createdAt: 344343424,
//       id: "wwrwrw",
//       userUID: "sdsdsdsdsewewewewe",
//       title: "Don't use Mobile ",
//       description: "Don't use Mobile more than 3 hours",
//       notifyTime: 134556878867,
//       coins: 10),
//   TodoInfo(
//       deleteAt: 355353535,
//       createdAt: 344343424,
//       id: "wwrwrw",
//       userUID: "sdsdsdsdsewewewewe",
//       title: "Don't use Mobile ",
//       description: "Don't use Mobile more than 3 hours",
//       notifyTime: 134556878867,
//       coins: 10),
//   TodoInfo(
//       deleteAt: 355353535,
//       createdAt: 344343424,
//       id: "wwrwrw",
//       userUID: "sdsdsdsdsewewewewe",
//       title: "Don't use Mobile ",
//       description: "Don't use Mobile more than 3 hours",
//       notifyTime: 134556878867,
//       coins: 10),
// ];
