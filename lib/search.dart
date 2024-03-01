import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:recipe_application/model.dart';
import 'package:recipe_application/recipeView.dart';

class Search extends StatefulWidget {

  String query = "";
  String search = "";
  Search(this.query, this.search);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  bool isLoading = true;
  final String _appid = "725bb9cf";
  final String _apiKey = "936b84bbbff6f14e9e10313da82b6081";

  List recipeCatList = [{"imgUrl" : "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "heading" : "Food Bowl"}];

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=$_appid&app_key=$_apiKey";
    Response response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      //element me milega hume map because hits list ke andar maps sotre hai

      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
      // log(recipeList.toString());
    });

    recipeList.forEach((Recipe) {
      print(Recipe.appLabel);
      print(Recipe.appCalories);
    });
  }

  @override
  void initState() {
    searchController.clear();
    getRecipe(widget.query);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pink.shade100,
                  Colors.red.shade100,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      //Search Box

                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if ((searchController.text).replaceAll(" ", "") ==
                                  "") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Empty Search")));
                              } else {
                                widget.search = searchController.text;
                                Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => Search(searchController.text,widget.search)));
                              }
                            },
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                )),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value){
                                if(value == ""){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Empty Search")));
                                }
                                else{
                                  widget.search = searchController.text;
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text,widget.search),));
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Recipies",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  child: isLoading ? Container(height: MediaQuery.of(context).size.height - 200,child: Center(child: CircularProgressIndicator())) :  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(child: Text("Search Result for : ${widget.search}"),),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: recipeList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>RecipeView(recipeList[index].appUrl)));
                              },
                              child: Card(
                                margin: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                          recipeList[index].appImageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 200),
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                          ),
                                          child: Text(
                                            recipeList[index].appLabel,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20),
                                          )),
                                    ),
                                    Positioned(
                                        width: 80,
                                        height: 40,
                                        right: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10)),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.local_fire_department,
                                                    size: 16,
                                                  ),
                                                  Text(recipeList[index]
                                                      .appCalories
                                                      .toString()
                                                      .substring(0, 6)),
                                                ],
                                              ),
                                            ))),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
