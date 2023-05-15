import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

    File? image;
    final _picker = ImagePicker();
    bool showSpinner = false;

    Future getImage()async{
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

      if(pickedFile !=null){
        image = File(pickedFile.path);
        setState(() {

        });
      }
      else{
        print("No Image Selected");
      }
    }

    Future<void> uploadImage() async{
      setState(() {
        showSpinner = true;
      });

      var stream = new http.ByteStream(image!.openRead());
      stream.cast();

      var length = await image!.length();
      var uri = Uri.parse('https://fakestoreapi.com/products');
      var request = new http.MultipartRequest('POST', uri);

      request.fields['title'] = "Static title";

      var multiport = new http.MultipartFile('image', stream, length);

      var response = await request.send();
      print(response.stream.toString());

      if(response.statusCode == 200){

        print("Image Uploaded Successfully");
        setState(() {
          showSpinner = false;
        });
      }
      else{

        print("Failed");
        setState(() {
          showSpinner = false;
        });
      }
    }

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Upload Image")),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null ?
                const Center(
                  child: Text("Pick an Image", style: TextStyle(fontSize: 25),),
                )
                    :
                Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(child: Text("Upload Image", style: TextStyle(fontSize: 25, color: Colors.white ),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
