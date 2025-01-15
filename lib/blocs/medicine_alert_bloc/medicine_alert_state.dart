part of 'medicine_alert_bloc.dart';

class MedicineAlertState {
}
class MedicinesLoadedState  extends MedicineAlertState{
final List<MedicineReminder> medicineReminderModel;

  MedicinesLoadedState({required this.medicineReminderModel});

}