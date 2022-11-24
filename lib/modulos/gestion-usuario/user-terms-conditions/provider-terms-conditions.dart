import 'package:appfront/modulos/gestion-usuario/ui/dbUsers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:appfront/modulos/gestion-usuario/models/user-accept-terms.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:appfront/modulos/gestion-usuario/models/index.dart' as globals;


class ProviderTermsConditions extends StatefulWidget {
  const ProviderTermsConditions({Key? key}) : super(key: key);

  @override
  _ProviderTermsConditionsState createState() => _ProviderTermsConditionsState();
}

class _ProviderTermsConditionsState extends State<ProviderTermsConditions> {
  DbUser databaseuser = DbUser();

  void getUser() async {
    //late userAcceptTermsList item;
    //  List<UserAcceptTermsList> userAcceptTermsList();
//int ola=1;
    if(globals.index==0) {

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ?? 0;

      UserAcceptTermsList item = UserAcceptTermsList(globals.index, userId);
      item.userId = userId;
      databaseuser.insertItem(item);
    }
    else{
      globals.index=globals.index+1;

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ?? 0;

      UserAcceptTermsList item = UserAcceptTermsList(globals.index, userId);
      item.userId = userId;
      databaseuser.insertItem(item);
    }
  }

  static const termsConditions = """<h1>Términos y Condiciones</h1>
<p>Última actualización: 23 de noviembre de 2022</p>
<p>Lea atentamente estos términos y condiciones antes de utilizar Nuestro Servicio.</p>
<h1>Interpretación y Definiciones</h1>
<h2>Interpretación</h2>
<p>Las palabras cuya letra inicial está en mayúscula tienen significados definidos bajo las siguientes condiciones. Las siguientes definiciones tendrán el mismo significado independientemente de que aparezcan en singular o en plural.</p>
<h2>Definiciones</h2>
<p>A los efectos de estos Términos y Condiciones:</p>
<ul>
<li>
<p><strong>Aplicación</strong> significa el programa de software proporcionado por la Compañía descargado por Usted en cualquier dispositivo electrónico, denominado AdoptMe ya</p>
</li>
<li>
<p><strong>Tienda de aplicaciones</strong> hace referencia al servicio de distribución digital operado y desarrollado por Apple Inc. (Apple App Store) o Google Inc. (Google Play Store) en el que se ha descargado la Aplicación.</p>
</li>
<li>
<p><strong>Afiliado</strong> significa una entidad que controla, es controlada o está bajo el control común de una parte, donde &quot;control&quot; significa la propiedad del 50 % o más de las acciones, participación accionaria u otros valores con derecho a voto para la elección de directores u otra autoridad administrativa.</p>
</li>
<li>
<p><strong>País</strong> se refiere a: Perú</p>
</li>
<li>
<p><strong>Empresa</strong> (referida como "la Empresa", "Nosotros", "Nos" o "Nuestro" en este Acuerdo) se refiere a AdoptMe ya.</p>
</li>
<li>
<p><strong>Dispositivo</strong> significa cualquier dispositivo que pueda acceder al Servicio, como una computadora, un teléfono celular o una tableta digital.</p>
</li>
<li>
<p><strong>Servicio</strong> hace referencia a la Aplicación.</p>
</li>
<li>
<p><strong>Términos y Condiciones</strong> (también denominados "Términos") se refieren a estos Términos y Condiciones que forman el acuerdo completo entre Usted y la Compañía con respecto al uso del Servicio. Este acuerdo de Términos y condiciones se ha creado con la ayuda del <a href="https://www.freeprivacypolicy.com/free-terms-and-conditions-generator/" target="_blank">Generador gratuito de términos y condiciones </a>.</p>
</li>
<li>
<p><strong>Servicio de redes sociales de terceros</strong> hace referencia a cualquier servicio o contenido (incluidos datos, información, productos o servicios) proporcionado por un tercero que el Servicio puede mostrar, incluir o poner a disposición. </p>
</li>
<li>
<p><strong>Usted</strong> se refiere a la persona que accede o utiliza el Servicio, o la empresa u otra entidad legal en nombre de la cual dicha persona accede o utiliza el Servicio, según corresponda.</p>
</li>
</ul>
<h1>Reconocimiento</h1>
<p>Estos son los Términos y Condiciones que rigen el uso de este Servicio y el acuerdo que opera entre Usted y la Compañía. Estos Términos y Condiciones establecen los derechos y obligaciones de todos los usuarios con respecto al uso del Servicio.</p>
<p>Su acceso y uso del Servicio está condicionado a Su aceptación y cumplimiento de estos Términos y condiciones. Estos Términos y condiciones se aplican a todos los visitantes, usuarios y otras personas que accedan o utilicen el Servicio.</p>
<p>Al acceder o utilizar el Servicio, usted acepta estar sujeto a estos Términos y condiciones. Si no está de acuerdo con alguna parte de estos Términos y condiciones, no podrá acceder al Servicio.</p>
<p>Usted declara que es mayor de 18 años. La Compañía no permite que los menores de 18 años utilicen el Servicio.</p>
<p>Su acceso y uso del Servicio también está condicionado a Su aceptación y cumplimiento de la Política de Privacidad de la Compañía. Nuestra Política de privacidad describe Nuestras políticas y procedimientos sobre la recopilación, el uso y la divulgación de Su información personal cuando utiliza la Aplicación o el Sitio web y le informa sobre Sus derechos de privacidad y cómo la ley lo protege. Lea atentamente Nuestra Política de Privacidad antes de utilizar Nuestro Servicio.</p>
<h1>Enlaces a otros sitios web</h1>
<p>Nuestro Servicio puede contener enlaces a sitios web o servicios de terceros que no son propiedad ni están controlados por la Compañía.</p>
<p>La Compañía no tiene control ni asume ninguna responsabilidad por el contenido, las políticas de privacidad o las prácticas de los sitios web o servicios de terceros. Además, reconoce y acepta que la Compañía no será responsable, directa o indirectamente, de ningún daño o pérdida causados ​​o presuntamente causados ​​por o en relación con el uso o la confianza en dicho contenido, bienes o servicios disponibles en o a través de dichos sitios web o servicios.</p>
<p>Le recomendamos encarecidamente que lea los términos y condiciones y las políticas de privacidad de cualquier sitio web o servicio de terceros que visite.</p>
<h1>Terminación</h1>
<p>Podemos rescindir o suspender Su acceso de inmediato, sin previo aviso ni responsabilidad, por cualquier motivo, incluido, entre otros, si incumple estos Términos y condiciones.</p>
<p>Después de la rescisión, Su derecho a utilizar el Servicio cesará inmediatamente.</p>
<h1>Limitación de responsabilidad</h1>
<p>Sin perjuicio de los daños y perjuicios en los que pueda incurrir, la responsabilidad total decae en el usuario""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminos y condiciones'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Card(
                    elevation: 50,
                    shadowColor: Colors.black,

                    child:Html(
                      data: termsConditions,
                      style: {
                        'html' : Style(
                            backgroundColor: Colors.white12
                        ),
                        'table': Style(
                            backgroundColor: Colors.grey.shade200
                        ),
                        'td': Style(
                          backgroundColor: Colors.grey.shade400,
                          padding: EdgeInsets.all(10),
                        ),
                        'th': Style(
                            padding: EdgeInsets.all(10),
                            color: Colors.black
                        ),
                        'tr': Style(
                            backgroundColor: Colors.grey.shade300,
                            border: Border(bottom: BorderSide(color: Colors.greenAccent))
                        ),
                      },
                    ),

                  ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 120,

              child: Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 50.0),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(

                      onPressed: () {
                        globals.termsConditions = true;
                        getUser();
                        Navigator.pop(context, true);
                      },
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blue)),
                      child: Padding(

                        padding: const EdgeInsets.all(4),
                        child: Row(

                          children: const [
                            Icon(Icons.check),
                            Text('Aceptar')
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(

                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Debe aceptar los términos y condiciones."),
                        ));
                      },
                      style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                          MaterialStateProperty.all(Colors.red)),
                      child: Padding(

                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: const [
                            Icon(Icons.close),
                            Text('Rechazar')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


