class Apis {
  static const String dmPathApi = 'https://w05.yeapps.com/dmpath/dmpath_muslim/get_dmpath';

  /*----------------------------------------------- IP & PORT ----------------------------------------*/
  //static const String _ip = '103.119.102.117';
  //static const String _port = '1002';

  /*----------------------------------------------- Apis ----------------------------------------*/

// <<<<<<< HEAD
//   static const String salatProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/namaj';
//   static const String nameOfAllahApi = 'http://$_ip:$_port/muslim-vision/names/allah';
//   static const String wuduProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/oju';
//   static const String janajaProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/janaja-salah';
//   static const String jummaProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/jumma-namaj-procedure';
//   static const String eidProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/eid-namaj-procedure';
//   static const String greetingsApi = 'http://$_ip:$_port/muslim-vision/greetings';
//   static const String shahadahApi = 'http://$_ip:$_port/muslim-vision/islamic-info/shahadah';
//   static const String doaApi = 'http://$_ip:$_port/muslim-vision/islamic-info/dua';
//   static const String boysNameApi = 'http://$_ip:$_port/muslim-vision/names/boys';
//   static const String girlsNameApi = 'http://$_ip:$_port/muslim-vision/names/girls';
// =======
  //static const String salatProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/namaj';
  //static const String nameOfAllahApi = 'http://$_ip:$_port/muslim-vision/names/allah';
  //static const String wuduProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/oju';
  //static const String janajaProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/janaja-salah';
  //static const String jummaProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/jumma-namaj-procedure';
  //static const String eidProcedureApi = 'http://$_ip:$_port/muslim-vision/procedure/jumma-namaj-procedure';
  //static const String greetingsApi = 'http://$_ip:$_port/muslim-vision/greetings';
  //static const String shahadahApi = 'http://$_ip:$_port/muslim-vision/islamic-info/shahadah';
  //static const String doaApi = 'http://$_ip:$_port/muslim-vision/islamic-info/dua';
  //static const String boysNameApi = 'http://$_ip:$_port/muslim-vision/names/boys';
  //static const String girlsNameApi = 'http://$_ip:$_port/muslim-vision/names/girls';5
  //static const String qurbaniApi = 'http://$_ip:$_port/muslim-vision/islamic-info/qurbani';

  static String salatProcedureApi(String baseUrl) => '$baseUrl/procedure/namaj';

  static String nameOfAllahApi(String baseUrl) => '$baseUrl/names/allah';

  static String wuduProcedureApi(String baseUrl) => '$baseUrl/procedure/oju';

  static String janajaProcedureApi(String baseUrl) => '$baseUrl/procedure/janaja-salah';

  static String jummaProcedureApi(String baseUrl) => '$baseUrl/procedure/jumma-namaj-procedure';

  static String eidProcedureApi(String baseUrl) => '$baseUrl/procedure/eid-namaj-procedure';

  static String greetingsApi(String baseUrl) => '$baseUrl/greetings';
  static String greetingBackgroundApi(String baseUrl) => '$baseUrl/assets/image/greetings-bg-images';

  static String shahadahApi(String baseUrl) => '$baseUrl/islamic-info/shahadah';

  static String doaApi(String baseUrl) => '$baseUrl/islamic-info/dua';

  static String boysNameApi(String baseUrl) => '$baseUrl/names/boys';

  static String girlsNameApi(String baseUrl) => '$baseUrl/names/girls';

  static String qurbaniApi(String baseUrl) => '$baseUrl/islamic-info/qurbani';

  static String syncApi(String baseUrl) => '$baseUrl/sync-app-data';
  // static String syncApi(String baseUrl) => 'http://192.168.100.245:8003/muslim-vision/sync-app-data';
}
