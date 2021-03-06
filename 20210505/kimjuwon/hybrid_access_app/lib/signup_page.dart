import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'file_manage.dart' as file;
import 'dart:math';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _pwdcheckcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  bool isLoading = false;

  _fetchSignUp() async {

    

    if (_pwdcontroller.text == _pwdcheckcontroller.text) {
        setState(() {
        isLoading = true;
      });

      final clientrandom = random();

      var publickey = await file.getKeyPair(_idcontroller.text);

      final response = await http.post(
        // Uri.parse("http://112.156.0.196:55555/app/signup"),
        Uri.parse("http://10.0.2.2:8000/app/signup"),
        headers: <String, String> {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'user_id' : _idcontroller.text,
          'user_pwd' : _pwdcontroller.text,
          'clientrandom' : clientrandom.toString(),
          'publickey' : publickey.toString()
        }
        ,
      );

      if(response.statusCode == 200){

        if (response.body == "401") {

          _showDialogIdFail();

        } else {

          setState(() {
          file.genesisWrite(_idcontroller.text, _pwdcontroller.text, clientrandom.toString());
          isLoading = false;
          Navigator.pop(context);

          });

        }

        
      } else{
        _showNetworkFail();
        //throw Exception("failed to load data");

      }

    } else {
      _showDialogPwdFail();
    }

  }

  void _showDialogIdFail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("???????????? ??????"),
          content: new Text("????????? ??????????????????!!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("??????"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    _idcontroller.text = "";
    _pwdcontroller.text = "";
    _pwdcheckcontroller.text = "";

  }

  void _showDialogPwdFail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("???????????? ??????"),
          content: new Text("??????????????? ????????????!!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("??????"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    _pwdcontroller.text = "";
    _pwdcheckcontroller.text = "";

  }

  void _showNetworkFail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("??????"),
          content: new Text("??????????????? ????????? ????????????."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("??????"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    _pwdcontroller.text = "";
    _pwdcheckcontroller.text = "";

  }

  random() {
    return Random.secure().hashCode;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("????????????", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          leading: Container(),
          
        ),

        body:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Center(
                child:
                  TextFormField(
                    controller: _idcontroller,
                    autofocus: true,
                    decoration:
                      InputDecoration(
                        icon: Icon(Icons.security_rounded),
                        border: InputBorder.none,
                        labelText: "?????????",
                        counterText: ''
                      ),
                    maxLength: 10
                  ),
              ),
              Center(
                child:
                  TextFormField(
                    controller: _pwdcontroller,
                    obscureText: true,
                    autofocus: true,
                    decoration:
                      InputDecoration(
                        icon: Icon(Icons.security_rounded),
                        border: InputBorder.none,
                        labelText: "????????????",
                        counterText: ''
                      ),
                    maxLength: 10
                  ),
              ),
              Center(
                child:
                  TextFormField(
                    controller: _pwdcheckcontroller,
                    obscureText: true,
                    autofocus: true,
                    decoration:
                      InputDecoration(
                        icon: Icon(Icons.account_circle),
                        border: InputBorder.none,
                        labelText: "???????????? ??????",
                        counterText: ''
                      ),
                    maxLength: 10,
                  ),
              ),
              Center(
                child:
                  TextButton(
                    child:
                      Text("????????????"),
                    style:
                      TextButton.styleFrom(primary:Colors.blue),
                    onPressed: (){
                      _fetchSignUp();
                    }
                  )
                    
              ),
            ]
          )
          
      ),
    );
  }
}