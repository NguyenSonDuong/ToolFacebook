
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

typedef void OnClick();

class CardImage extends StatefulWidget {


  CardImage({this.image,this.header, this.body, this.footer, required this.onCLickCard});

  dynamic image;
  dynamic header;
  dynamic body;
  dynamic footer;
  final OnClick onCLickCard;

  @override
  State<CardImage> createState() => _CardImageState(image,header,body,footer, onCLickCard);

}

class _CardImageState extends State<CardImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  dynamic image;
  dynamic header;
  dynamic body;
  dynamic footer;
  final OnClick onCLickCard;


  _CardImageState(this.image,this.header, this.body, this.footer, this.onCLickCard);

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(3),
        child: TextButton(
            onPressed: onCLickCard,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  image,
                  header,
                  body,
                  footer
                ]
            )),
      ),
    );
  }
}
