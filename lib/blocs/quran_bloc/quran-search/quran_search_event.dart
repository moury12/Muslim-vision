part of 'quran_search_bloc.dart';

@immutable
abstract class QuranSearchEvent {

}
class QuranSearchLoadedEvent extends QuranSearchEvent{
 final String? value;


  QuranSearchLoadedEvent(this.value,);
}

