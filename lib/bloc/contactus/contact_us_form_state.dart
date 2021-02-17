part of 'contact_us_form_bloc.dart';

class ContactUsFormState extends Equatable {
  const ContactUsFormState({
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.name = const Name.pure(),
    this.message = const Name.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Phone phone;
  final Name name;
  final Name message;
  final FormzStatus status;

  ContactUsFormState copyWith({
    Email email,
    Phone phone,
    Name name,
    Name message,
    FormzStatus status,
  }) {
    return ContactUsFormState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name?? this.name,
      message: message?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, phone, name, message, status];
}

class Empty extends ContactUsFormState {}

class Loading extends ContactUsFormState {}

class Success extends ContactUsFormState {
  final String success;
  Success({@required this.success}) : assert(success != null);
}

class Fail extends ContactUsFormState {
  final String error;
  Fail({@required this.error}) : assert(error != null);
}

