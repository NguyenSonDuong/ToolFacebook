import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tool_facebook/service/api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';


class HomeStatelessWidget extends StatelessWidget {

  String listComment;
  int pageStype;

  HomeStatelessWidget(this.listComment,this.pageStype);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeStatefulWidget(listComment,pageStype);
  }
}

class HomeStatefulWidget extends StatefulWidget {
  String listComment;
  int pageStype ;
  HomeStatefulWidget(this.listComment,this.pageStype);

  @override
  State<StatefulWidget> createState() {
    if(pageStype == 0)
      return HomeState(listComment);
    else
      return HomeState2(listComment);
  }
}

class HomeState extends State<HomeStatefulWidget> {

  List<dynamic> data = [];
  var abc = "";
  String listComment;
  int page = 1;
  double downloadPecen = 0;
  var _controller = ScrollController();
  var preventCall = false;

  HomeState(this.listComment);

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
                                                PhotoView(
                                                  imageProvider: Image.network(this.data[index]["pics"][index2]["url"]).image,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextButton(
                                                      onPressed: () async {
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

class HomeState2 extends State<HomeStatefulWidget> {

  List<dynamic> data = [];
  var abc = "";
  String listComment;
  int page = 2;
  double downloadPecen = 0;
  var _controller = ScrollController();
  var preventCall = false;

  HomeState2(this.listComment);

  @override
  void initState() {
    _controller.addListener(onScroll);
    var comments = jsonDecode(listComment);
    for(final item in comments["data"]["data"]){
      data.add({
        "img": item["cover2x"],
        "time":item["recommendTime"], //  == null ? item["text"] :  (item["page_info"]["page_title"] == null ? "" : item["page_info"]["page_title"]),
        "viewCount": item["viewCount"],
        "creator":{
          "username": item["creatorObj"]["username"],
          "pageUrl": item["creatorObj"]["pageUrl"],
          "avatar": item["creatorObj"]["avatar2x"],
        },
        "pageUrl":item["pageUrl"],
        "title": item["title"]
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
      this.page = 1;
    });
  }
  void onScroll() {
    var position = _controller.position.pixels;
    if (position >= _controller.position.maxScrollExtent - 10) {
      if (!preventCall) {
        API.ImageGetList(this.page).then((value)
        {
          try{
            var comments = jsonDecode(value);
            for(final item in comments["data"]["data"]){
              setData({
                "img": item["cover2x"],
                "time":item["recommendTime"], //  == null ? item["text"] :  (item["page_info"]["page_title"] == null ? "" : item["page_info"]["page_title"]),
                "viewCount": item["viewCount"],
                "creator":{
                  "username": item["creatorObj"]["username"],
                  "pageUrl": item["creatorObj"]["pageUrl"],
                  "avatar": item["creatorObj"]["avatar2x"],
                },
                "pageUrl":item["pageUrl"],
                "title": item["title"]
              });
            }
            this.page+=1;
            preventCall = false;
          }catch(e){
            Fluttertoast.showToast(msg: "Error load data");
          }

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
          API.ImageGetList(1).then((value)
          {
            setClean();
            try{
              var comments = jsonDecode(value);
              for(final item in comments["data"]["data"]){
                setData({
                  "img": item["cover2x"],
                  "time":item["recommendTime"], //  == null ? item["text"] :  (item["page_info"]["page_title"] == null ? "" : item["page_info"]["page_title"]),
                  "viewCount": item["viewCount"],
                  "creator":{
                    "username": item["creatorObj"]["username"],
                    "pageUrl": item["creatorObj"]["pageUrl"],
                    "avatar": item["creatorObj"]["avatar2x"],
                  },
                  "pageUrl":item["pageUrl"],
                  "title": item["title"]
                });
              }
              this.page+=1;
              preventCall = false;
            }catch(e){
              Fluttertoast.showToast(msg: "Error load data",gravity: ToastGravity.BOTTOM);
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
        child: MasonryGridView.count(
            controller:  _controller,
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount:  this.data.length,
            itemBuilder: (BuildContext context, int index) {
              DateTime now = DateTime.now();
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)
                ),
                color: Colors.white70,
                elevation: 7,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: TextButton(
                      onPressed: () {
                        if(this.data[index]["img"] == null)
                          return;
                        API.ImageGetListImage(this.data[index]["pageUrl"]).then((value)
                        {
                          var imageList = jsonDecode(value);
                          var listImage = imageList["props"]["pageProps"]["data"]["productImages"];
                          showMaterialModalBottomSheet(context: context, builder: (builder) =>
                              Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: ListView.builder(
                                          itemCount:  listImage.length,
                                          itemBuilder: (context,index2){
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              child: Stack(
                                                children: [
                                                  Image.network(listImage[index2]["url"]),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: TextButton(
                                                        onPressed:  () async {
                                                          try{
                                                            await ImageDownloader.downloadImage(listImage[index2]["urlBig"]);
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
                                              for(var item in listImage){
                                                await ImageDownloader.downloadImage(item["urlBig"]);
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
                        });

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
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10,0,0,0),
                                    child:  ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Image.network(
                                          this.data[index]["creator"]["avatar"] == null ? "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png" :this.data[index]["creator"]["avatar"],
                                          height: 30,
                                        )
                                    )
                                    ,
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.fromLTRB(10,0,0,0),
                                    child: Text(
                                      this.data[index]["creator"]["username"],

                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                              child: Text(
                                this.data[index]["title"],
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w100
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Text(
                                    this.data[index]["time"] == null ? now.hour.toString() + ":" + now.minute.toString() + ":" + now.second.toString() : this.data[index]["time"],
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                )

                              ],
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
    );

    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Text(abc),
    //   ),
    // );
  }
}
