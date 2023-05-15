import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async{
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : email,
            'password' : password
          }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print(data);
        print("log In Successfully");
      }
      else{
        print('Failed');
      }

    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Log_In")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "Password"
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue
                ),
                child: const Center(child: Text("Log In", style: TextStyle(fontSize: 20,color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
