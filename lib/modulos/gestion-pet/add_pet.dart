import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPet extends StatefulWidget {
  const AddPet({Key? key}) : super(key: key);

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final _urlToImageController = TextEditingController();

  double v_padding = 20;

  @override
  void dispose(){
    _urlToImageController.dispose();
    super.dispose();
  }

  ImageProvider<Object> getPetImage(String url) {
    final image = Image.network(url, errorBuilder: (context, object, trace) {
      setState(() {
        Fluttertoast.showToast(msg: "msg");
      });
      return Image(image: NetworkImage('https://img.freepik.com/vector-gratis/pata-diseno-logotipo-mascota-vector-negocio-tienda-animales_53876-136741.jpg'));
    },).image;
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Pet")),
        body:
        Column(
          children: [
            SizedBox(height: v_padding,),
            const Flexible(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            const Flexible(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            const Flexible(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Age",
                  filled: true,
                ),
              ),),),
            SizedBox(height: v_padding,),
            const Flexible(child:           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Attention",
                  filled: true,
                ),
              ),),),

            SizedBox(height: v_padding,),

            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (text){setState(() {
                  _urlToImageController.text;
                });},
                controller: _urlToImageController,
                decoration: const InputDecoration(
                  hintText: "Image Url",
                  filled: true,
                ),
              ),),
            SizedBox(height: v_padding,),
            Container(

              child: CachedNetworkImage(
                imageUrl: _urlToImageController.text,
                imageBuilder: (context, imageProvider) => Container(
                    width: _urlToImageController.text == "" ? 0 : 250,
                    height: _urlToImageController.text == "" ? 0 : 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(125)),
                      border: Border.all(color: Colors.blueAccent, width: 2),
                      image:
                      DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,),
                    )

                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error){
                  Fluttertoast.showToast(msg: "Invalid Url.");
                  return const Icon(Icons.error);},
              ),

              // ),
            ),
            SizedBox(height: v_padding,),
            ElevatedButton(onPressed: (){
              Fluttertoast.showToast(msg: "Pet added successful.");
            }, child: Text("Save", style: TextStyle(fontSize: 20),))

          ],
        )
      );
  }
}
