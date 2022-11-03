import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:tool_facebook/page/image.dart';
import 'package:tool_facebook/service/api.dart';

class HomeStatelessWidget extends StatelessWidget {
  int page;

  HomeStatelessWidget(this.page);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomeStatefulWidget(page);
  }
}

class HomeStatefulWidget extends StatefulWidget {
  int page;

  HomeStatefulWidget(this.page);

  @override
  State<StatefulWidget> createState() => HomeState(page);
}

class HomeState extends State<HomeStatefulWidget> {
  List<dynamic> data = [];
  var abc = "";
  int page;

  HomeState(this.page);

  @override
  void initState() {
    API.Get(page).then((value) {
      final htmlDom = parse(value);
      // print();
      // var xpathB = xpath.query('//div[@class="post-thumbnail"]/a/img').elements;
      // var xpathA = htmlDom.queryXPath(r"//h2/a").elements;

      var xpathB = htmlDom.getElementsByClassName("post-thumbnail");
      var xpathA = htmlDom.getElementsByClassName("post-box-title");

      print(xpathB);
      print(xpathA);
      int i = 0;
      xpathA.forEach((element) {
        print(element.children[0].innerHtml);
        setData({
          "url": element.children[0].attributes["href"],
          "title": element.children[0].text,
          "image": xpathB[i].children[0].children[0].attributes["src"],
        });
        i++;
      });
    });
  }

  setData(data) {
    setState(() {
      this.data.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeStatelessWidget(0)))
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (detail) {
            if (detail.delta.dx > 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeStatelessWidget(page - 1)));
            }

            // Swiping in left direction.
            if (detail.delta.dx < 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeStatelessWidget(page + 1)));
            }
          },
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: this.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageStatelessWidget(
                                    this.data[index]['url'], 1)));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            this.data[index]["image"],
                            height: 100,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                  child: Text(
                                this.data[index]['title'],
                                textAlign: TextAlign.left,
                              )),
                              Expanded(
                                  child: Text(
                                this.data[index]['url'],
                                textAlign: TextAlign.left,
                              )),
                            ],
                          ))
                        ],
                      )),
                );
              }),
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
