

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';

typedef Future<dynamic> OnScrollEnd(int page);

class ImageListStateful extends StatefulWidget {

  ImageListStateful(this.images,this._controllerScroll,this.keyView,this.keyDownload);

  List<dynamic> images;
  String keyView;
  String keyDownload;
  OnScrollEnd _controllerScroll ;

  @override
  State<ImageListStateful> createState() => _ImageListStatefulState(images,_controllerScroll, keyView, keyDownload);
}

class _ImageListStatefulState extends State<ImageListStateful> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ScrollController _scrollController = ScrollController();
  OnScrollEnd _controllerScroll ;
  _ImageListStatefulState(this.listImage,this._controllerScroll,this.keyView,this.keyDownload);
  int page = 2;
  List<dynamic> listImage;
  String keyView;
  String keyDownload;
  bool preventCall = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onScroll(){
    var position = _scrollController.position.pixels;
    if (position >= _scrollController.position.maxScrollExtent - 10) {
      if (!preventCall) {
        _controllerScroll(this.page).then((value) {
          setState(() {
            listImage.addAll(value);
          });
          this.page++;
          preventCall = false;
        });
        preventCall = true;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              controller: _scrollController,
                itemCount:  listImage.length,
                itemBuilder: (context,index2){
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        TextButton(onPressed: (){
                          showDialog(context: context, builder: (builder){
                            return Stack(
                              children: [
                                Container(child: PhotoView(imageProvider: Image.network(listImage[index2][keyView]).image)),
                                TextButton(onPressed: (){
                                  Navigator.pop(builder);
                                },
                                  child: const Icon(Icons.cancel),),
                              ],
                            );
                          });
                        }, child: Image.network(listImage[index2][keyView])),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                              onPressed:  () async {
                                try{
                                  await ImageDownloader.downloadImage(listImage[index2][keyDownload]);
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
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
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
            padding: const EdgeInsets.all(10),
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
                      await ImageDownloader.downloadImage(item[keyDownload]);
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
                  padding: const EdgeInsets.all(10),
                  child: const Icon(

                      CupertinoIcons.square_arrow_down_on_square_fill
                  ),
                )),
          ),

        ],
      ),
    );
  }
}
