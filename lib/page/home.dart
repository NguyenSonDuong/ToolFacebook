import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:tool_facebook/page/image.dart';
import 'package:tool_facebook/service/api.dart';

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

  HomeState(this.listComment);

  @override
  void initState() {

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
              MaterialPageRoute(builder: (context) => HomeStatelessWidget("")))
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
                      builder: (context) => HomeStatelessWidget("")));
            }

            // Swiping in left direction.
            if (detail.delta.dx < 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeStatelessWidget("page + 1")));
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ImageStatelessWidget(
                        //             this.data[index]['url'], 1)));
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
