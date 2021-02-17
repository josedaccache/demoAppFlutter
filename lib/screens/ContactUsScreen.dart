import 'package:flutter/material.dart';
import '../bloc/contactus/contact_us_form_bloc.dart';
import 'package:flutter_app/forms/EmailInput.dart';
import 'package:flutter_app/forms/MessageInput.dart';
import 'package:flutter_app/forms/NameInput.dart';
import 'package:flutter_app/forms/PhoneInput.dart';
import 'package:flutter_app/forms/SubmitButtons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactUsFormBloc(),
      child: ContactUsForm(),
    );
  }
}

class ContactUsForm extends StatefulWidget {
  @override
  _ContactUsFormState createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  final _unfocusedColor = Colors.grey[600];

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<ContactUsFormBloc>().add(NameUnfocused());
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<ContactUsFormBloc>().add(EmailUnfocused());
      }
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        context.read<ContactUsFormBloc>().add(PhoneUnfocused());
      }
    });
    _messageFocusNode.addListener(() {
      if (!_messageFocusNode.hasFocus) {
        context.read<ContactUsFormBloc>().add(MessageUnfocused());
      }
    });
  }

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

  _clearAllFields() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactUsFormBloc, ContactUsFormState>(
      listener: (context, state) {
        if (state is Loading) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Submitting...')),
            );
        }
        if (state is Success) {
          String msg =
              state.success != null ? state.success : "Api call success";
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(msg)),
            );
          _clearAllFields();
        }
        if (state is Fail) {
          String msg = state.error != null ? state.error : "Api call error";
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(msg)),
            );
          _clearAllFields();
        }
      },
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            SizedBox(height: 20.0),
            NameInput(
                focusNode: _nameFocusNode,
                unfocusedColor: _unfocusedColor,
                controller: _nameController),
            SizedBox(height: 12.0),
            EmailInput(
              focusNode: _emailFocusNode,
              unfocusedColor: _unfocusedColor,
              controller: _emailController,
            ),
            SizedBox(height: 12.0),
            PhoneInput(
              focusNode: _phoneFocusNode,
              unfocusedColor: _unfocusedColor,
              controller: _phoneController,
            ),
            SizedBox(height: 12.0),
            MessageInput(
              focusNode: _messageFocusNode,
              unfocusedColor: _unfocusedColor,
              controller: _messageController,
            ),
            SizedBox(height: 12.0),
            SubmitButtons(),
          ],
        ),
      ),
    );
  }
}
