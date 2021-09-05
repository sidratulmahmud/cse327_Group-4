import 'package:cloud_firestore/cloud_firestore.dart';
import '../screen/login.dart';
import '../widgets/changescreen.dart';
import '../widgets/mybutton.dart';
import '../widgets/textField.dart';
import '../widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obscureText = true;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();

bool isMale = true;
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  void submit() async {
    UserCredential result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(result);
    } on PlatformException catch (error) {
      var message = "You don't have an Internet Connection";
      if (error.message != null) {
        message = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      print(error);
    }
    FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
      "UserName": userName.text,
      "UserId": result.user.uid,
      "UserEmail": email.text,
      "UserAddress": address.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Login()));
    setState(() {
      isLoading = false;
    });
  }

  void validation() async {
    if (
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please fill up"),
        ),
      );
    }
    else if (userName.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please type in your name"),
        ),
      );
    }
   else if (email.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Please type in your email"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is not valid"),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
    } else if (password.text.length <6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Password should be at least 6 characters"),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 digits"),
        ),
      );
    } else if (address.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Address must be filled"),
        ),
      );
    } else {
      submit();
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          MyTextFormField(
            name: "Full Name",
            controller: userName,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Email",
            controller: email,
          ),
          SizedBox(
            height: 10,
          ),
          PasswordTextFormField(
            obserText: obscureText,
            controller: password,
            name: "Password,must contain 6 characters or more",
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale == true ? "Male" : "Female",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Phone Number,must contain 11 digits",
            controller: phoneNumber,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Address",
            controller: address,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          SizedBox(
            height: 10,
          ),
          isLoading == false
              ? MyButton(
                  name: "SignUp",
                  onPressed: () {
                    validation();
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          ChangeScreen(
            name: "Login",
            whichAccount: "I already have an account",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            height: 200,
         
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Create an Account",
                  style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.greenAccent[700]),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: _buildBottomPart(),
          ),
        ],
      ),
    );
  }
}
