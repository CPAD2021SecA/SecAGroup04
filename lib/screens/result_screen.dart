import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cpad_quiz_app/screens/home_screen.dart';
import 'package:cpad_quiz_app/ui/shared/color.dart';

class ResultScreen extends StatefulWidget {
  int score;
  ResultScreen(this.score, {Key? key,this.firstname, this.email}) : super(key: key);
  final String? firstname;
  final String? email;
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Congratulations",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Text(
            "You Score is",
            style: TextStyle(color: Colors.blue, fontSize: 34.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "${widget.score}",
            style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 85.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          FlatButton(
            onPressed: () {
              if(widget.firstname==null||widget.email==null){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              }else{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(firstname: widget.firstname,email: widget.email),
                    ));
              }

            },
            shape: StadiumBorder(),
            color: Colors.red,
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Go to Homepage",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}