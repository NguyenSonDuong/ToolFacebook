
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuggestCard extends StatefulWidget {
  SuggestCard(this.data);
  dynamic data;
  @override
  State<SuggestCard> createState() => _SuggestCardState(data);
}

class _SuggestCardState extends State<SuggestCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  dynamic data;

  _SuggestCardState(this.data);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 120,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
            width: 250,
            height: 120,
            decoration: BoxDecoration(
              color: Color.fromRGBO(230, 230, 230, 1),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.fromLTRB(70, 13, 13, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                        child: Text(
                          data["title"],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900
                          ),
                        )
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data["content"],
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              data["star"],
                              style: TextStyle(
                                  fontSize: 12
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.lightBlueAccent,
                              )
                              ,
                            )
                          ],
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ("\$"+data["point"]),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                color: Colors.lightBlueAccent
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              width: 25,
                              height: 25,
                              child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: (){

                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Colors.white,
                                  )
                              )
                              ,
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(10),
            child:  Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: AspectRatio(aspectRatio: 70/70,
                child: Container(
                  margin: EdgeInsets.all(3),
                  width: 70 ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          alignment: FractionalOffset.center,
                          image: Image.network(data["image"]).image
                      )
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
