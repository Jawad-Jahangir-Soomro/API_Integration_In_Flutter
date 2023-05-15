import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice_api/Models/photos_model.dart';

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {

  List<PhotosModel> photoList = [];

  Future<List<PhotosModel>> getPostApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      photoList.clear();
      for(Map i in data){
        photoList.add(PhotosModel.fromJson(i));
      }
      return photoList;
    }
    else{
      return photoList;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Example Two")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context , snapshot){
                  if(!snapshot.hasData){
                    return const Text('Loading....!');
                  } else{
                    return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(photoList[index].url.toString()),
                                  ),
                                  title: Text(photoList[index].title.toString()),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}

