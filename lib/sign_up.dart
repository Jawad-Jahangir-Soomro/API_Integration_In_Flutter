import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void login(String email, String password) async{
      try{
        Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {
            'email' : email,
            'password' : password
          }
        );

        if(response.statusCode == 200){
          var data = jsonDecode(response.body.toString());
          print(data['token']);
          print("Account Created Successfully");
        }
        else{
          print('Failed');
        }

      }
      catch(e){
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Sign_Up")),
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
                child: const Center(child: Text("Sign Up", style: TextStyle(fontSize: 20,color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
