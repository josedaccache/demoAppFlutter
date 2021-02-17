import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/contact_us_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInput  extends StatelessWidget{

  const EmailInput({Key key, this.focusNode, this.unfocusedColor, this.controller}) : super(key: key);

  final FocusNode focusNode;
  final unfocusedColor;
  final controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          // initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
                color: focusNode.hasFocus
                    ? Theme.of(context).accentColor
                    : unfocusedColor),
            errorText: state.email.invalid
                ? 'Please enter a valid email address'
                : null,
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<ContactUsFormBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

}