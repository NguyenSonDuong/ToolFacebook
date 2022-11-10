import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:tool_facebook/page/image.dart';
import 'package:tool_facebook/service/api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_html/flutter_html.dart';

class HomeStatelessWidget extends StatelessWidget {

  String listComment;

  HomeStatelessWidget(this.listComment);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeStatefulWidget(listComment);
  }
}

class HomeStatefulWidget extends StatefulWidget {
  String listComment;

  HomeStatefulWidget(this.listComment);

  @override
  State<StatefulWidget> createState() => HomeState(listComment);
}

class HomeState extends State<HomeStatefulWidget> {
  List<dynamic> data = [];
  var abc = "";
  String listComment;
  int page = 1;
  HomeState(this.listComment);
  var _controller = ScrollController();
  var preventCall = false;
  @override
  void initState() {
    _controller.addListener(onScroll);
    var comments = jsonDecode(listComment);
    for(final item in comments["data"]["statuses"]){
      data.add({
        "img": item["bmiddle_pic"],
        "title":item["text"], //  == null ? item["text"] :  (item["page_info"]["page_title"] == null ? "" : item["page_info"]["page_title"]),
        "url": item["id"]
      });
    }
  }

  setData(data) {
    setState(() {
      this.data.add(data);
    });
  }
  void onScroll() {
    var position = _controller.position.pixels;
    if (position >= _controller.position.maxScrollExtent - 10) {
      if (!preventCall) {
        API.PictureGet(this.page).then((value)
        {
          var comments = jsonDecode(value);
          for(final item in comments["data"]["statuses"]){
            setData({
              "img": item["bmiddle_pic"],
              "title":item["text"], //  == null ? item["text"] :  (item["page_info"]["page_title"] == null ? "" : item["page_info"]["page_title"]),
              "url": item["id"]
            });
          }
          this.page+=1;
          preventCall = false;
        });
        preventCall = true;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeStatelessWidget("")))
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (detail) {
            // if (detail.delta.dx > 0) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => HomeStatelessWidget("")));
            // }
            //
            // // Swiping in left direction.
            // if (detail.delta.dx < 0) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => HomeStatelessWidget("page + 1")));
            // }
          },
          child: MasonryGridView.count(
            controller:  _controller,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount:  this.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ImageStatelessWidget(
                          //             this.data[index]['url'], 1)));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                  this.data[index]["img"] == null ? "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png" :this.data[index]["img"],
                              )
                            )
                            ,
                            Container(
                              child: Html(
                                data: this.data[index]["title"],
                              ),
                            )
                            // Container(
                            //   padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                            //   child: Text(
                            //       this.data[index]["title"],
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold
                            //     ),
                            //
                            //   ),

                          ]
                        )),
                  ),
                );
              }

          )
          ,
        ),
      ),
    );

    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Text(abc),
    //   ),
    // );
  }
}
