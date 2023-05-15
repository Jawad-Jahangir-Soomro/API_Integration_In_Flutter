import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/user_model.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserList() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){

      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }

      return userList;
    }
    else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Example Three")),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserList(),
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot){

                if(!snapshot.hasData){
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }
                else{
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                RowComponent(title: "Name", value: snapshot.data![index].name.toString()),
                                RowComponent(title: "Username", value: snapshot.data![index].username.toString()),
                                RowComponent(title: "Email", value: snapshot.data![index].email.toString()),
                                RowComponent(title: "Address", value: snapshot.data![index].address!.geo!.lat.toString()),
                              ],
                            ),
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
