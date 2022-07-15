import 'package:being_u/common_widgets/custom_text_field.dart';
import 'package:being_u/screens/forgot_pwd_success.dart';
import 'package:flutter/material.dart';
import 'package:being_u/common.dart';

class ForgotPwd extends StatefulWidget {
  final String? _userEmail;
  ForgotPwd(this._userEmail);

  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  TextEditingController _email = new TextEditingController();

  void initialization(){
    if(widget._userEmail != ""){
      setState(() {
        _email.text = widget._userEmail!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forgot Password?", style:
                Theme.of(context).textTheme.headline6,),
                SizedBox(height: 10,),
                Text("Enter the email associated with your account. We will send an email with instructions",
                  style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(height: 20,),
                CustomTextField(_email,
                    "Registered Email",
                    "",
                    _email.text, false,
                    TextInputType.emailAddress, false, false),
                SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: (){
                    fAuth.sendPasswordResetEmail(email: _email.text);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(
                            builder: (context) => ForgotPwdSuccess())
                    );
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}