import 'package:muslim_vision/views/common_widgets/convert_to_bangla_number.dart';

class DoaScreenfunctions {
  String cutStringAfterDot(String originalString) {
    // Find the index of the first occurrence of "."
    int indexOfDot = originalString.indexOf('.');

    if (indexOfDot != -1) {
      // If "." is found
      // Cut the string after the first occurrence of "."
      String cutString =
          originalString.substring(indexOfDot + 1); // +1 to exclude the "."
      return cutString;
    } else {
      return originalString; //when not found . in this string
    }
  }
  String getDuaId(String originalString) {
    int indexOfDot = originalString.indexOf('.');

      String cutString =
          originalString.substring(0,indexOfDot);
      // +1 to exclude the "."
      return convertToEnglishNumber(cutString) ;
    }
  }

