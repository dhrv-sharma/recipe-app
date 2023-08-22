import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_reciepe/model.dart';

import 'package:http/http.dart';
import 'dart:developer' as dev; // for log

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
/*
 InkWell - used to detect such gesture tap ,DoubleTap ,Hover , etc ,
 Gesture detector have the same functionlaity and can also 

 card -- "Card" is a material design-inspired widget that represents a visually distinct area containing content. Cards are often used to group related information together and provide a structured and organized layout for displaying content. They have a shadow effect to make them appear elevated above the background, giving a sense of depth.

 ClipRRect - ClipRRect is a Flutter widget that's used to clip its child widget into a rounded rectangle shape. It's a combination of two concepts: "clip" (which means to cut off or restrict) and "RRect" (which stands for rounded rectangle) circular frame

 Clippath - custom frame 

 positioned - A widget that controls where a child of a Stack is positioned.

A Positioned widget must be a descendant of a Stack, and the path from the Positioned widget to its enclosing Stack must contain only StatelessWidgets or StatefulWidgets (not other kinds of widgets, like RenderObjectWidgets)
 */

// Stack( // stack is used to keep childern overlapping in z axis direction assume it coming from phone
//           children: [
//             Container(
//               color: Colors.orange,
//             ),
//             Container(
//               color: Colors.green,
//               height: 45,
//             ),
//             Column(
//               children: const [
//                 Text("this is dhruv sharma"),
//                 Text("cse core ")
//               ],
//             )
//           ],
//         ),

class _HomeState extends State<Home> {
  List<recipeModel> reciepeList = <recipeModel>[];
  TextEditingController contrl = new TextEditingController();
  List reciptCatList = [{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"},{"imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db", "heading": "Chilli Food"}];

  void getReciepe(String query) async {
    // api data fetching
    String url =
        "https://api.edamam.com/search?q=$query&app_id=88efa4aa&app_key=525529fd656402164a352aecd61e9670&from=0&to=3&calories=591-722&health=alcohol-free";

    Response res = await get(Uri.parse(url));
    Map data = jsonDecode(res.body);

    // print statement have limited length of string so use log log can be from math  as well as developer package so it is important to use metntion as i did
    //       input { map ,object ,string ,any} => [model] =>  output return {map ,object, string ,any}

    // dev.log(data.toString());

    // hits have map
    data['hits'].forEach((elent) {
      // you can give any name in place of elemenent
      recipeModel recp = new recipeModel();
      recp = recipeModel.fromMap(elent[
          'recipe']); // left side will return an instance of recipeModel by using fromMap which return an instance of recipe Model with values from map
      reciepeList.add(recp);
      // dev.log(recp.label.toString());
    });

    reciepeList.forEach((element) {
      // forEach is a method to iterate the list where every child  is represented as element
      print(element.label);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReciepe("ladoo"); // default mai ladoo search ho rha hai
  }

  @override
  Widget build(BuildContext context) {
    //  listview takes the list and start genrating the widget genration of all at same time
    // listview.builder do simialar task from listvire but it start generating the widget as you start scolling
    // listview.seprator also can genrate between the different widget as between the child
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff071938),
    ));
    return SafeArea(
      child: Scaffold(
          body: Stack(
        // stack is used to keep childern overlapping in z axis direction assume it coming from phone
        children: [
          Container(
            width: MediaQuery.of(context)
                .size
                .width, // MediaQuery can detect the height and width of phone automatically
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff213A50), Color(0xff071938)])),
          ),
          SingleChildScrollView(
            // this is applied on the column so that it can become scrollable
            child: Column(
              children: [
                // search bar
                Container(
                  // search bar
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          8), // in symetric type of styling either horzizontal or vertically  or both from both sides
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Row(children: <Widget>[
                    GestureDetector(
                      // it has two argmunets one is onTap() which tell when gesture detcted what to do and another is child on which this functionality get applied
                      // to enable the function on it detects the gesture on its child
                      onTap: () {
                        // search button is pressed
                        if ((contrl.text).replaceAll(" ", "") == "") {
                          print("blank screen");
                        } else {
                          getReciepe(contrl.text);
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
                            // used to set the style in active search bar
                            fontFamily: AutofillHints.email,
                            fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                            border: InputBorder
                                .none, // border decoration of text field
                            hintText: "Let cook Something ...", // hint
                            hintStyle: TextStyle(
                                fontFamily: AutofillHints.email,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "What Do You Want To Cook Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: "poppino"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lets Cook New Something Today",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "poppino"),
                        )
                      ]),
                ),
                Container(
                  height: 100,
                  // building a listview builder
                  child: ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // it set that this is not permitted to not get scroll on its own
                    itemCount: reciepeList.length, // how many items
                    shrinkWrap:
                        true, // it is important because When you set the shrinkWrap property of a scrolling widget to true, it indicates that the scrollable widget should only take up as much space as needed to display its content without any extra empty space. In other words, the scrollable widget "shrinks" to fit its content, and it won't take up more space than necessary. other wise it will take the size of its parent
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          margin: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                // Card widget in Flutter takes the size of its child content, but it's important to clarify what that means. The Card widget itself does not automatically determine the size of its child content; rather, the child content determines the size of the Card.
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  reciepeList[index].appImageurl.toString(),
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
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
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
                                              fontWeight: FontWeight.bold),
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
                                            reciepeList[index].label.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ),
                      ); // using a custom widget
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

// creating a custom widget
Widget box_dish() {
  return const Text("this is dhruv sharma");
}
