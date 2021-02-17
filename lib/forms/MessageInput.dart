import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contactus/contact_us_form_bloc.dart';

class MessageInput extends StatelessWidget {
  const MessageInput(
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
            labelText: 'Message',
            alignLabelWithHint: true,
            labelStyle: TextStyle(
                color: focusNode.hasFocus
                    ? Theme.of(context).accentColor
                    : unfocusedColor),
            errorText: state.message.invalid ? 'Message can\'t be empty' : null,
          ),
          focusNode: focusNode,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            context
                .read<ContactUsFormBloc>()
                .add(MessageChanged(message: value));
          },
          textInputAction: TextInputAction.newline,
          minLines: 6,
          maxLines: 6,
          maxLength: 200,
          maxLengthEnforced: true,
        );
      },
    );
  }
}
