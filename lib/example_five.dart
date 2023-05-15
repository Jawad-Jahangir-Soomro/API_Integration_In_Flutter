import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Products_model.dart';

class ExampleFive extends StatefulWidget {
  const ExampleFive({Key? key}) : super(key: key);

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {

  Future<ProductsModel> getProductsApi() async{
    final response = await http.get(Uri.parse('https://webhook.site/f4d2d958-ec72-41b6-adba-770def22d0fe'));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }
    else{
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Example Five")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getProductsApi(),
                  builder: (context, snapshot){

                  if(!snapshot.hasData){
                    return const Expanded(child: Center(child: CircularProgressIndicator()));
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.data![index].images!.length,
                                    itemBuilder: (context, position){
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10,bottom: 10),
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * .25,
                                          width: MediaQuery.of(context).size.width * .5,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                            )
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                              ListTile(
                                title: Text(snapshot.data!.data![index].categories!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].categories!.type.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].categories!.image.toString()),
                                ),
                              ),
                              ListTile(
                                title: Text(snapshot.data!.data![index].subcat!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].subcat!.type.toString()),
                              ),
                              Icon(snapshot.data!.data![index].inWishlist! == true ? Icons.favorite : Icons.favorite_outline, color: Colors.red,)
                            ],
                          );
                        }
                    );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
