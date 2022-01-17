
class TodoInfo {
  String? id;
  String? userUID;
  String? title;
  String? description;
  int? coins;
  int? createdAt;
  int? notifyTime;
  int? deleteAt;

  TodoInfo(
      {required this.id,
      required this.title,
      required this.description,
      required this.coins,
      required this.createdAt,
      required this.userUID,
      required this.deleteAt,
      required this.notifyTime});
}

final todoData = [
  TodoInfo(
      deleteAt: 355353535,
      createdAt: 344343424,
      id: "wwrwrw",
      userUID: "sdsdsdsdsewewewewe",
      title: "Don't use Mobile ",
      description: "Don't use Mobile more than 3 hours",
      notifyTime: 134556878867,
      coins: 10),
  TodoInfo(
      deleteAt: 355353535,
      createdAt: 344343424,
      id: "wwrwrw",
      userUID: "sdsdsdsdsewewewewe",
      title: "Don't use Mobile ",
      description: "Don't use Mobile more than 3 hours",
      notifyTime: 134556878867,
      coins: 10),
  TodoInfo(
      deleteAt: 355353535,
      createdAt: 344343424,
      id: "wwrwrw",
      userUID: "sdsdsdsdsewewewewe",
      title: "Don't use Mobile ",
      description: "Don't use Mobile more than 3 hours",
      notifyTime: 134556878867,
      coins: 10),
];
