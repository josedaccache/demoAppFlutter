import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';
import 'package:formz/formz.dart';
import 'package:flutter_app/apiresponses/ApiResponse.dart';
import 'package:dio/dio.dart';

import '../../network/APIClient.dart';

part 'contact_us_form_state.dart';
part 'contact_us_form_event.dart';

class ContactUsFormBloc extends Bloc<ContactUsFormEvent, ContactUsFormState> {
  ContactUsFormBloc() : super(const ContactUsFormState());

  final APIClient client = APIClient(Dio(BaseOptions(contentType: "application/json")));

  @override
  void onTransition(Transition<ContactUsFormEvent, ContactUsFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<ContactUsFormState> mapEventToState(ContactUsFormEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.phone, state.name, state.message]),
      );
    } else if (event is PhoneChanged) {
      final phone = Phone.dirty(event.phone);
      yield state.copyWith(
        phone: phone.valid ? phone : Phone.pure(event.phone),
        status: Formz.validate([state.email, phone, state.name, state.message]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.phone, state.name, state.message]),
      );
    } else if (event is PhoneUnfocused) {
      final phone = Phone.dirty(state.phone.value);
      yield state.copyWith(
        phone: phone,
        status: Formz.validate([state.email, phone]),
      );
    } else if (event is NameChanged){
      final name = Name.dirty(event.name);
      yield state.copyWith(
        name: name.valid ? name : Name.pure(event.name),
        status: Formz.validate([state.email, state.phone, name, state.message]),
      );
    } else if (event is NameUnfocused){
      final name = Name.dirty(state.name.value);
      yield state.copyWith(
        name: name,
        status: Formz.validate([state.email, state.phone, name, state.message]),
      );
    } else if (event is MessageChanged){
      final message = Name.dirty(event.message);
      yield state.copyWith(
        message: message.valid ? message : Name.pure(event.message),
        status: Formz.validate([state.email, state.phone, state.name, message]),
      );
    } else if (event is MessageUnfocused){
      final message = Name.dirty(state.message.value);
      yield state.copyWith(
        message: message,
        status: Formz.validate([state.email, state.phone, state.name, message]),
      );
    } else if (event is FormSubmittedSuccess) {
      final email = Email.dirty(state.email.value);
      final phone = Phone.dirty(state.phone.value);
      final name = Name.dirty(state.name.value);
      final message = Name.dirty(state.message.value);
      yield state.copyWith(
        email: email,
        phone: phone,
        name: name,
        message: message,
        status: Formz.validate([email, phone, name, message]),
      );
      if (state.status.isValidated) {
        try {
          yield Loading();
          ApiResponse response = await client.getSuccess();
          yield Success(success: response.message);
        }catch (e) {
          yield Fail(error: "Error: " + e.toString());
        }
      }
    } else if (event is FormSubmittedFailure) {
      final email = Email.dirty(state.email.value);
      final phone = Phone.dirty(state.phone.value);
      final name = Name.dirty(state.name.value);
      final message = Name.dirty(state.message.value);
      yield state.copyWith(
        email: email,
        phone: phone,
        name: name,
        message: message,
        status: Formz.validate([email, phone, name, message]),
      );

      if (state.status.isValidated) {
        try {
        yield Loading();
        ApiResponse response = await client.getFailure();
        yield Success(success: response.message);
        }catch (e) {
          yield Fail(error: "Error: " + e.toString());
        }
      }
    }
  }
}
