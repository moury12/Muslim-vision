part of 'medicine_alert_bloc.dart';
abstract class MedicineAlertEvent {

}
class AddMedicine extends MedicineAlertEvent{
  final MedicineReminder medicineReminder;

  AddMedicine({required this.medicineReminder});
}
class LoadMedicineEvent extends MedicineAlertEvent{
}
class DeleteMedicine extends MedicineAlertEvent{
  final String medicineName;
  final DateTime time;

  DeleteMedicine({required this.medicineName,required this.time});
}
class DeleteAllMedicine extends MedicineAlertEvent{

}