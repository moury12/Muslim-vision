class SalahReminderModel {
  int id;
  String waqtName;
  bool isEnabled;

  SalahReminderModel(
      {required this.id, required this.waqtName, required this.isEnabled});

  factory SalahReminderModel.fromJson(Map<dynamic, dynamic> json) =>
      SalahReminderModel(
        id: json["id"],
        waqtName: json["waqtName"],
        isEnabled: json["isEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "waqtName": waqtName,
        "isEnabled": isEnabled,
      };

  @override
  String toString() {
    return 'SalahReminderModel{id: $id, waqtName: $waqtName, isEnabled: $isEnabled}';
  }
}
