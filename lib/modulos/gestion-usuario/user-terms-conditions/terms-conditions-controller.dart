import 'package:get/get.dart';
import 'package:appfront/modulos/gestion-usuario/models/index.dart' as globals;
class TermsConditionsController extends GetxController{
  String mensaje ='';
  void createCount(){

      if(globals.termsConditions == true){
        mensaje="Gracias por aceptar nuestros términos y condiciones";
        update();
      }
      else{
        mensaje="Debe aceptar nuestros términos y condiciones";
        update();
      }
    update();
  }

}