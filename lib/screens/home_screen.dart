import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpad_quiz_app/model/user_model.dart';
import 'package:cpad_quiz_app/screens/take_quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.firstname, this.email}) : super(key: key);
  final String? firstname;
  final String? email;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController quizidController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.firstname == null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
    }
    if (this.loggedInUser.firstName == null) {
      this.loggedInUser.firstName = widget.firstname;
      this.loggedInUser.secondName = "";
    }
    if (this.loggedInUser.email == null) {
      this.loggedInUser.email = widget.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
                child: Image.asset("assets/logo.png", fit: BoxFit.contain),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              // Text("${loggedInUser.email}",
              //     style: TextStyle(
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     )),
              SizedBox(
                height: 10,
              ),
              ActionChip(
                  label: Text("Logout"),
                  onPressed: () {
                    logout(context);
                  }),
              SizedBox(
                height: 10,
              ),
              // TextFormField(
              //     autofocus: false,
              //     controller: quizidController,
              //     obscureText: true,
              //     validator: (value) {
              //       RegExp regex = new RegExp(r'^.{6,}$');
              //       if (value!.isEmpty) {
              //         return ("Password is required for login");
              //       }
              //       if (!regex.hasMatch(value)) {
              //         return ("Enter Valid Password(Min. 6 Character)");
              //       }
              //     },
              //     onSaved: (value) {
              //       quizidController.text = value!;
              //     },
              //     textInputAction: TextInputAction.done,
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.quiz),
              //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              //       hintText: "Enter Quiz ID",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     )),
              SizedBox(
                height: 10,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.redAccent,
                child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      if(widget.firstname==null||widget.email==null)
                      {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => QuizzScreen()));
                      }
                      else{
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => QuizzScreen(firstname: widget.firstname,email:widget.email)));
                      }
                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(builder: (context) => QuizzScreen()));
                    },
                    child: Text(
                      "Take Quiz",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Colors.redAccent,
                // child: MaterialButton(
                //     padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                //     minWidth: MediaQuery.of(context).size.width,
                //     onPressed: () {},
                //     child: Text(
                //       "Create New Quiz",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //           fontSize: 20,
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold),
                //     )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
    if (widget.firstname != null) {
      await _googleSignIn.signOut();
    }
  }
}
