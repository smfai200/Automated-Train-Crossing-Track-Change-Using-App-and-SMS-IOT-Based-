import 'package:traincrossing/model/lesson.dart';
import 'package:flutter/material.dart';
import 'trackchange.dart';
import 'gateopening.dart';
import 'Schedule.dart';
import '../bt_command.dart';
import '../MainPage.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TRAIN SCHEDULE',
      theme: new ThemeData(
          primaryColor: Color.fromRGBO(58, 66, 86, 1.0), fontFamily: 'Raleway'),
      home: new MENU(title: 'Train Schedule'),
      // home: DetailPage(),
    );
  }
}

class MENU extends StatefulWidget {
  MENU({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MENUState createState() => _MENUState();
}

class _MENUState extends State<MENU> {
  List lessons;

  BTController obj = new BTController();

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Lesson lesson, int option) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          
          title: Text(
            lesson.title,
            style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
          // trailing:
          //     Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            if(option == 1){
                Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GateOpening()),//GateOpening()),
                );
            }else if(option == 2){
              Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TrackChange()),
            );
            }else if(option == 4){
              Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
            );
            }else{
              Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListPage(title: 'Lessons')),
              );
            }
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => null));
          },
        );

    Card makeCard(Lesson lesson) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson, lesson.option),
          ),
        );

    final makeBody = Container(
      decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.home, color: Colors.white),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.blur_on, color: Colors.white),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.hotel, color: Colors.white),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: Icon(Icons.account_box, color: Colors.white),
            //   onPressed: () {},
            // )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text("MAIN MENU"),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.list),
        //   onPressed: () {},
        // )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

List getLessons() {
  return [
    Lesson(
        title: "Automated Gate Opening",option: 1),
    Lesson(
        title: "Automated Train Crossing", option: 2),
    Lesson(
        title: "Train Schedule", option: 3),
    Lesson(
        title: "TEST BUTTON", option: 4),
    ];
}