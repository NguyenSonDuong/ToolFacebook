
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
      width: 300,
      height: 100,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
            width: 260,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.fromLTRB(100, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                        child: Text(
                          data["title"],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900
                          ),
                        )
                    ),
                    Expanded(
                      flex: 5,
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
                                color: Colors.indigoAccent,
                              )
                              ,
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 130,
            height: 130,
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
