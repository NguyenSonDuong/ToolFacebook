
import 'package:flutter/material.dart';
import 'package:tool_facebook/page/widget_item/suggest_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<dynamic> data = [
    {
      "image":"https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=2000",
      "title":"User Interface Design",
      "content":"24 lession",
      "star":"4.3",
      "point":"25"
    },
    {
      "image":"https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=2000",
      "title":"User Interface Design",
      "content":"24 lession",
      "star":"4.3",
      "point":"25"
    },
    {
      "image":"https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=2000",
      "title":"User Interface Design",
      "content":"24 lession",
      "star":"4.3",
      "point":"25"
    },
    {
      "image":"https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=2000",
      "title":"User Interface Design",
      "content":"24 lession",
      "star":"4.3",
      "point":"25"
    },
    {
      "image":"https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=2000",
      "title":"User Interface Design",
      "content":"24 lession",
      "star":"4.3",
      "point":"25"
    },
    {
      "image":"https://img.freepik.com/free-vector/happy-freelancer-with-computer-home-young-man-sitting-armchair-using-laptop-chatting-online-smiling-vector-illustration-distance-work-online-learning-freelance_74855-8401.jpg?w=2000",
      "title":"User Interface Design",
      "content":"24 lession",
      "star":"4.3",
      "point":"25"
    }
  ];
  
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
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.data.length,
          itemBuilder: (itemBuilder, int index){
        return SizedBox(
          width: 300,
          child: SuggestCard(this.data[index]),
        );
      }),
    );
  }
}
