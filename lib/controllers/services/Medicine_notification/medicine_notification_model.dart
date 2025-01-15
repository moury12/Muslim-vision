import 'dart:convert';

import 'package:intl/intl.dart';

class MedicineReminderModel {
  List<MedicineReminder> medicineReminders = [];
  MedicineReminderModel();
  initialization(int id, String name, takingTime, note, DateTime time, status) {
    medicineReminders.add(MedicineReminder(id: id, medicneName: name, time: time, takeTime: takingTime, note: note, status: status));
  }

  Map<String, dynamic> toJson() => {
        'medicineReminders': medicineReminders.map((e) => e.toJson()).toList(),
      };
  factory MedicineReminderModel.fromJson(Map<String, dynamic> json) {
    var list = json['medicineReminders'] as List;
    List<MedicineReminder> reminderList = list.map((i) => MedicineReminder.fromJson(i)).toList();

    return MedicineReminderModel()..medicineReminders = reminderList;
  }
}

class MedicineReminder {
  int id;
  String medicneName;
  String takeTime;
  DateTime time;
  String note;
  bool? status;
  MedicineReminder({this.status = true, required this.id, required this.medicneName, required this.takeTime, required this.time, required this.note});
  Map<String, dynamic> toJson() => {'id': id, 'medicneName': medicneName, 'takeTime': takeTime, 'time': DateFormat('yyyy-MM-dd HH:mm:ss').format(time), 'note': note, 'status': status};

  factory MedicineReminder.fromJson(Map<String, dynamic> json) {
    return MedicineReminder(
      id: json['id'],
      status: json['status'],
      medicneName: json['medicneName'],
      takeTime: json['takeTime'],
      time: DateTime.parse(json['time']),
      note: json['note'],
    );
  }
  String toPayload() {
    return jsonEncode(toJson());
  }

  factory MedicineReminder.fromPayload(String payload) {
    return MedicineReminder.fromJson(jsonDecode(payload));
  }
}
