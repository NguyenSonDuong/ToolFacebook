import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tool_facebook/page/image.dart';
import 'package:tool_facebook/service/api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';

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
  double downloadPecen = 0;
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
        "url": item["id"],
        "pics":item["pics"]
      });
    }
  }

  setProgress(double per){
    setState(() {
      this.downloadPecen = per;
    });
  }

  setData(data) {
    setState(() {
      this.data.add(data);
    });
  }
  setClean() {
    setState(() {
      this.data.clear();
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
              "url": item["id"],
              "pics":item["pics"]
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
        onPressed: ()  {
          API.PictureGet(1).then((value)
          {
            setClean();
            var comments = jsonDecode(value);
            for(final item in comments["data"]["statuses"]){
              setData({
                "img": item["bmiddle_pic"],
                "title":item["text"], //  == null ? item["text"] :  (item["page_info"]["page_title"] == null ? "" : item["page_info"]["page_title"]),
                "url": item["id"],
                "pics":item["pics"]
              });
            }
          });
        },
        backgroundColor: Colors.redAccent,
        child:
        const Icon(
            Icons.refresh
        ),
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
                          if(this.data[index]["pics"] == null)
                            return;
                          showMaterialModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: ListView.builder(
                                        itemCount:  this.data[index]["pics"].length,
                                        itemBuilder: (context,index2){
                                          return Container(
                                            padding: EdgeInsets.all(10),
                                            child: Stack(
                                              children: [
                                                Image.network(this.data[index]["pics"][index2]["url"]),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextButton(
                                                      onPressed:  () async {
                                                        try{
                                                          await ImageDownloader.downloadImage(this.data[index]["pics"][index2]["large"]["url"]);
                                                          Fluttertoast.showToast(
                                                              msg: "Download suceess",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.green,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                        }catch(e){
                                                          Fluttertoast.showToast(
                                                              msg: "Download error",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.redAccent,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white70,
                                                            borderRadius: BorderRadius.circular(17)),
                                                        padding: EdgeInsets.all(10),
                                                        child: Icon(
                                                            CupertinoIcons.arrow_down_circle_fill
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                        onPressed:  () async {
                                          try{
                                            BuildContext context2 = context;
                                            showDialog(context: context2,
                                                barrierDismissible: false,
                                                builder: (BuildContext context3) {
                                                  context2 = context3;
                                              return Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: const [
                                                    CircularProgressIndicator()
                                                  ]);
                                            });
                                            for(var item in this.data[index]["pics"]){
                                              await ImageDownloader.downloadImage(item["large"]["url"]);
                                            }
                                            Navigator.pop(context2,false);
                                            Fluttertoast.showToast(
                                                msg: "Download all image suceess",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }catch(e){
                                            Fluttertoast.showToast(
                                                msg: "Download error",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.redAccent,
                                                textColor: Colors.white,
                                                fontSize: 16.0
                                            );
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius: BorderRadius.circular(17)),
                                          padding: EdgeInsets.all(10),
                                          child: Icon(

                                              CupertinoIcons.square_arrow_down_on_square_fill
                                          ),
                                        )),
                                  ),

                                ],
                              ),
                            ),
                          );
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
