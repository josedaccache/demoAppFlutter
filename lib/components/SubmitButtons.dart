import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/contactus/contact_us_form_bloc.dart';

class SubmitButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text('Send Success'),
                elevation: 5.0,
                color: Colors.blue,
                onPressed: state.status.isValidated
                    ? () => context.read<ContactUsFormBloc>().add(FormSubmittedSuccess())
                    : null,
              ),
              RaisedButton(
                child: Text('Send Failure'),
                elevation: 5.0,
                color: Colors.blue,
                onPressed: state.status.isValidated
                    ? () => context.read<ContactUsFormBloc>().add(FormSubmittedFailure())
                    : null,
              ),
            ],
          );
      },
    );
  }

}