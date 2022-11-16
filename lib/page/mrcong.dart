
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tool_facebook/page/showimage.dart';

import '../service/api.dart';
import 'card_item_image.dart';

class MrCong extends StatefulWidget {
  const MrCong({Key? key}) : super(key: key);

  @override
  State<MrCong> createState() => _MrCongState();
}

class _MrCongState extends State<MrCong> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<dynamic> data = [];
  ScrollController _controllerScroll = ScrollController();
  bool preventCall = false;
  int page = 1;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controllerScroll.addListener(onScroll);
    API.GetListImageMRCong(this.page).then((value)
    {
      setData(value);
      this.page+=1;
    });
  }

  void setData(dynamic dataItem){
    setState(() {
      this.data.addAll(dataItem);
    });
  }


  void onScroll() {
    var position = _controllerScroll.position.pixels;
    if (position >= _controllerScroll.position.maxScrollExtent - 10) {
      if (!preventCall) {
        API.GetListImageMRCong(this.page).then((value)
        {
          setData(value);
          this.page+=1;
          preventCall = false;
        });
        preventCall = true;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.count(
          controller:  _controllerScroll,
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount:  this.data.length,
          itemBuilder: (BuildContext context, int index) {
            return CardImage(
                image:ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      this.data[index]["url_image"] == null ? "https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png" :this.data[index]["url_image"],
                    )
                ),
                header:Container(
                  child: Text(
                    this.data[index]["title"],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                body:Container(
                  child: Text(
                    this.data[index]["auth"],
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                footer: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    this.data[index]["viewer"],
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                onCLickCard: () {
                  if(this.data[index]["title"] == null)
                    return;
                  API.GetListImageMRCongPost(this.data[index]["link"]).then((value)
                  {
                    showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => ImageListStateful(value,(item) => API.GetListImageMRCongPost(this.data[index]["link"]+"/"+item.toString()), "image", "download"),
                    );
                  });
                }
            );

          }

      ),
    );
  }
}
