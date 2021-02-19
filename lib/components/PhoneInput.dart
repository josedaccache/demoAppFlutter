import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contactus/contact_us_form_bloc.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput(
      {Key key, this.focusNode, this.unfocusedColor, this.controller})
      : super(key: key);

  final FocusNode focusNode;
  final unfocusedColor;
  final controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            labelText: 'Phone',
            labelStyle: TextStyle(
                color: focusNode.hasFocus
                    ? Theme.of(context).accentColor
                    : unfocusedColor),
            errorText: state.phone.invalid
                ? 'Please enter a valid phone number'
                : null,
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          focusNode: focusNode,
          onChanged: (value) {
            context.read<ContactUsFormBloc>().add(PhoneChanged(phone: value));
          },
        );
      },
    );
  }
}
