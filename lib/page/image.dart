import 'package:flutter/material.dart';
import 'package:tool_facebook/page/home.dart';
import 'package:tool_facebook/page/login.dart';
import 'package:tool_facebook/service/api.dart';
import 'package:html/parser.dart';


class ImageStatelessWidget extends StatelessWidget{

  var link;
  int page;

  ImageStatelessWidget(this.link,this.page);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ImageStatefulWidget(link,page);
  }

}


class ImageStatefulWidget extends StatefulWidget{

  var link;
  int page;


  ImageStatefulWidget(this.link,this.page);

  @override
  State<StatefulWidget> createState() => ImageState(link,page);
}

class ImageState extends State<ImageStatefulWidget>{

  List<dynamic> data = [];
  var abc = "";
  var link;
  int page;

  ImageState(this.link, this.page);

  @override
  void initState() {
    API.GetLink(link+"/"+page.toString()).then((value) {
      print(value);
      // final htmlDom = parse(value).documentElement!;
      // var xpathA  = xpath.query("//h2[@class='post-box-title']//a").elements;
      final htmlDom = parse(value);
      // print();
      // var xpathB = xpath.query('//div[@class="post-thumbnail"]/a/img').elements;
      // var xpathA = htmlDom.queryXPath(r"//h2/a").elements;

      var xpathA = htmlDom.querySelectorAll("img[class=aligncenter]");

      // print(xpathB);
       print(xpathA);
      int i=0;
      xpathA.forEach((element) {
        setData(
          {
            "url":element.attributes["src"]
          }
        );
      });

    });

  }

  setData(data){
    setState(() {
      this.data.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>{
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeStatelessWidget(0)))
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
      body: GestureDetector(
        onPanUpdate: (details){
          if (details.delta.dx > 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageStatelessWidget(link,page-1)));
          }

          // Swiping in left direction.
          if (details.delta.dx < 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageStatelessWidget(link,page+1)));
          }
        },
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Expanded(
                  child: Image.network(this.data[index]["url"]),
                ),
              );
            }
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