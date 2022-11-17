
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tool_facebook/page/widget_item/suggest_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<dynamic> listCategory = [
    {
      "name":"UI/UX",
      "name2":"UI/UX",

    },
    {
      "name":"UI/UX",
      "name2":"UI/UX",

    },
    {
      "name":"UI/UX",
      "name2":"UI/UX",

    },
    {
      "name":"UI/UX",
      "name2":"UI/UX",

    },
    {
      "name":"UI/UX",
      "name2":"UI/UX",

    },
    {
      "name":"UI/UX",
      "name2":"UI/UX",

    }
  ];

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
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Choose your",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black54
                        ),
                      ),
                      Text("Design Course",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
            Container(

              margin: EdgeInsets.fromLTRB(0, 40, 100, 40),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsetsDirectional.fromSTEB(35, 20, 35, 20),
                  suffixIcon: Icon(
                      Icons.search,
                    color: Colors.black54,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search for course",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                  "Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                itemCount: listCategory.length,
                  itemBuilder: (itemBuilder, int index){
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                    margin: EdgeInsets.all(5),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){

                      },
                      child: Text(
                          this.listCategory[index]["name"],
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  );
              }),
            ),
            Container(
              height: 150,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.data.length,
              itemBuilder: (itemBuilder, int index){
                return SizedBox(
                  width: 300,
                  child: SuggestCard(this.data[index]),
                );
              })
            )

          ],
        ),
      ),
    );
  }
}
