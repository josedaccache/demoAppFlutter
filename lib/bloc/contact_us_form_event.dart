part of 'contact_us_form_bloc.dart';


abstract class ContactUsFormEvent extends Equatable {
  const ContactUsFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends ContactUsFormEvent {
  const EmailChanged({@required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends ContactUsFormEvent {}

class PhoneChanged extends ContactUsFormEvent {
  const PhoneChanged({@required this.phone});

  final String phone;

  @override
  List<Object> get props => [phone];
}

class PhoneUnfocused extends ContactUsFormEvent {}

class NameChanged extends ContactUsFormEvent {
  const NameChanged({@required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameUnfocused extends ContactUsFormEvent {}

class MessageChanged extends ContactUsFormEvent {
  const MessageChanged({@required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class MessageUnfocused extends ContactUsFormEvent {}

class FormSubmittedSuccess extends ContactUsFormEvent {}

class FormSubmittedFailure extends ContactUsFormEvent {}
