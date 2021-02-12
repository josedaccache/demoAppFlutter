import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/apiresponses/ApiResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

import '../network/APIClient.dart';
import '../utils/Utils.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  final _unfocusedColor = Colors.grey[600];

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePhone = false;
  bool _validateMessage = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _messageFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      setState(() {
        if (!_nameFocusNode.hasFocus) {
          _nameController.text.isEmpty
              ? _validateName = true
              : _validateName = false;
        }
        //Redraw so that the username label reflects the focus state
      });
    });
    _emailFocusNode.addListener(() {
      setState(() {
        if (!_emailFocusNode.hasFocus) {
          (_emailController.text.isNotEmpty &&
                  !Utils.isValidEmail(_emailController.text))
              ? _validateEmail = true
              : _validateEmail = false;
        }
        //Redraw so that the password label reflects the focus state
      });
    });
    _phoneFocusNode.addListener(() {
      setState(() {
        if (!_phoneFocusNode.hasFocus) {
          (_phoneController.text.isNotEmpty &&
                  !Utils.isValidPhoneNumber(_phoneController.text))
              ? _validatePhone = true
              : _validatePhone = false;
        }
        //Redraw so that the password label reflects the focus state
      });
    });
    _messageFocusNode.addListener(() {
      setState(() {
        if (!_messageFocusNode.hasFocus) {
          _messageController.text.isEmpty
              ? _validateMessage = true
              : _validateMessage = false;
        }
        //Redraw so that the password label reflects the focus state
      });
    });
  }

  clearAllFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
  }

  bool checkValues() {
    setState(() {
      _nameController.text.isEmpty
          ? _validateName = true
          : _validateName = false;
      _emailController.text.isEmpty ||
              !Utils.isValidEmail(_emailController.text)
          ? _validateEmail = true
          : _validateEmail = false;
      _phoneController.text.isEmpty ||
              !Utils.isValidPhoneNumber(_phoneController.text)
          ? _validatePhone = true
          : _validatePhone = false;
      _messageController.text.isEmpty
          ? _validateMessage = true
          : _validateMessage = false;
    });

    if (_validateName || _validateEmail || _validatePhone || _validateMessage) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 20.0),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              labelText: 'Name',
              labelStyle: TextStyle(
                  color: _nameFocusNode.hasFocus
                      ? Theme.of(context).accentColor
                      : _unfocusedColor),
              errorText: _validateName ? 'Please enter a valid name' : null,
            ),
            focusNode: _nameFocusNode,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                  color: _emailFocusNode.hasFocus
                      ? Theme.of(context).accentColor
                      : _unfocusedColor),
              errorText:
                  _validateEmail ? 'Please enter a valid email address' : null,
            ),
            keyboardType: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              labelText: 'Phone',
              labelStyle: TextStyle(
                  color: _phoneFocusNode.hasFocus
                      ? Theme.of(context).accentColor
                      : _unfocusedColor),
              errorText:
                  _validatePhone ? 'Please enter a valid phone number' : null,
            ),
            keyboardType: TextInputType.phone,
            focusNode: _phoneFocusNode,
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              alignLabelWithHint: true,
              labelText: 'Message',
              labelStyle: TextStyle(
                  color: _messageFocusNode.hasFocus
                      ? Theme.of(context).accentColor
                      : _unfocusedColor),
              errorText: _validateMessage ? 'Message can\'t be empty' : null,
            ),
            keyboardType: TextInputType.multiline,
            focusNode: _messageFocusNode,
            minLines: 6,
            maxLines: 6,
            maxLength: 10,
            maxLengthEnforced: true,
            textInputAction: TextInputAction.newline,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text('Send Success'),
                elevation: 5.0,
                color: Colors.blue,
                onPressed: () async {
                  if (checkValues()) {
                    onButtonClicked(true);
                  } else {
                    return;
                  }
                },
              ),
              RaisedButton(
                child: Text('Send Failure'),
                elevation: 5.0,
                color: Colors.blue,
                onPressed: () async {
                  if (checkValues()) {
                    onButtonClicked(false);
                  } else {
                    return;
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onButtonClicked(bool isSuccess){
    final client = APIClient(Dio(BaseOptions(contentType: "application/json")));
    Future<ApiResponse> response = isSuccess? client.getSuccess(): client.getFailure();
    response.then((value) => _onResponse(value.message))
    .catchError((e) => _onResponse(e.message));
  }

  void _onResponse(String message){
    _showToast(message);
    clearAllFields();
  }

  void _showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
