import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {

  var data;
  Future<void> getUserApi() async{
    final response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());
    }
    else{}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Example Four")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Expanded(child: Center(child: CircularProgressIndicator()));
                  }
                  else{
                    return ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (context, index){
                          return Card(
                            child: Column(
                              children: [
                                RowComponent(title: 'Name', value: data[index]['name'].toString()),
                                RowComponent(title: 'Username', value: data[index]['username'].toString()),
                                RowComponent(title: 'Street', value: data[index]['address']['street']),
                                RowComponent(title: 'latitude', value: data[index]['address']['geo']['lat']),
                                RowComponent(title: 'longitude', value: data[index]['address']['geo']['lng']),
                              ],
                            ),
                          );
                        }
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

class RowComponent extends StatelessWidget {

  String title , value;

  RowComponent({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}