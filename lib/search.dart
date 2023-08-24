import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_reciepe/model.dart';
import 'package:food_reciepe/recipeView.dart';

import 'package:http/http.dart';
import 'dart:developer' as dev; // for log

class search extends StatefulWidget {
  String? query;

  search({required this.query});

  @override
  State<search> createState() => searchState();
}

class searchState extends State<search> {
  bool isloading = true;
  List<recipeModel> reciepeList = <recipeModel>[];
  TextEditingController contrl = new TextEditingController();
  List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    }
  ];

  void getReciepe(String query) async {
    // api data fetching
    String url =
        "https://api.edamam.com/search?q=$query&app_id=88efa4aa&app_key=525529fd656402164a352aecd61e9670&from=0&to=3&calories=591-722&health=alcohol-free";

    Response res = await get(Uri.parse(url)); // to get data from api
    Map data = jsonDecode(res.body); // convert raw data in json format

    data['hits'].forEach((elent) {
      recipeModel recp = new recipeModel();
      recp = recipeModel.fromMap(elent['recipe']);
      reciepeList.add(recp);
    });

    reciepeList.forEach((element) {
      print(element.label);
    });
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getReciepe(widget.query.toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff071938),
    ));

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Row(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // search button is pressed
                        if ((contrl.text).replaceAll(" ", "") == "") {
                          print("blank screen");
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      search(query: contrl.text))));
                        }
                      },
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          )),
                    ),
                    Expanded(
                      child: TextField(
                        controller: contrl,
                        style: const TextStyle(
                            fontFamily: AutofillHints.email,
                            fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Let cook Something ...",
                            hintStyle: TextStyle(
                                fontFamily: AutofillHints.email,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ]),
                ),
                Container(
                  child: isloading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: reciepeList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeView(url: reciepeList[index].appUrl)));
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                margin: EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        reciepeList[index]
                                            .appImageurl
                                            .toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        width: 80,
                                        height: 40,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green[400],
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.local_fire_department,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                reciepeList[index]
                                                    .appCalories
                                                    .toString()
                                                    .substring(0, 6),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Positioned(
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black26,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  reciepeList[index]
                                                      .label
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
