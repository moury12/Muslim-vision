import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  Box<dynamic> get dmPath => Hive.box('DMPath');
  Box<dynamic> get themeBox => Hive.box('themeBox');

  Box<dynamic> get procedureBox => Hive.box('procedureBox');

  Box<dynamic> get tasbeehBox => Hive.box('tasbeehBox');

  Box<dynamic> get zakatBox => Hive.box('zakatBox');

  Box<dynamic> get namesOfAllahBox => Hive.box('namesOfAllahBox');

  Box<dynamic> get utilsBox => Hive.box('utilsBox');

  Box<dynamic> get syncBox => Hive.box('syncDataBox');

  Box<dynamic> get adhanNotificationBox => Hive.box('adhanNotificationBox');

  Box<dynamic> get greetingsBox => Hive.box('greetingsBox'); //greetings box

  Box<dynamic> get fivePillarsDataBox => Hive.box('fivePillarsDataBox');

  Box<dynamic> get doaBox => Hive.box('doabox'); //doa box
  Box<dynamic> get namesDataBox => Hive.box('names');

  Box<dynamic> get qurbaniDataBox => Hive.box('qurbaniDataBox');

  Box<dynamic> get salahReminderBox => Hive.box('salahReminderBox');
  Box<dynamic> get quranBox => Hive.box('QuranBox');
  Box<dynamic> get medicineBox => Hive.box('MedicineBox');
}

class BoxNames {
  String medicineBox = 'MedicineBox';
}
