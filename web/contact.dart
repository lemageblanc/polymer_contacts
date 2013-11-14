import 'dart:html';
import 'dart:convert';
import 'package:polymer_contacts/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('t-contacts')
class TContacts extends PolymerElement {
  @published Contacts contacts = Model.one.contacts;

  TContacts.created() : super.created();

  add(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement tel = shadowRoot.querySelector("#tel");
    InputElement e_mail = shadowRoot.querySelector("#e_mail");
    InputElement description = shadowRoot.querySelector("#description");

    LabelElement message = shadowRoot.querySelector("#message");
    var error = false;
    message.text = '';
    if (name.value.trim() == '') error = true;
    if (!error) {
      var contact = new Contact(name.value, tel.value, e_mail.value, description.value);
      if (contacts.add(contact)) {
        contacts.sort();
        save();
      } else {
        message.text = 'The contact with that name already exists';
      }
    }
  }

  delete(Event e, var detail, Node target) {
    InputElement name = shadowRoot.querySelector("#name");
    InputElement tel = shadowRoot.querySelector("#tel");
    InputElement e_mail = shadowRoot.querySelector("#e_mail");
    InputElement description = shadowRoot.querySelector("#description");
    LabelElement message = shadowRoot.querySelector("#message");
    message.text = '';
    Contact contact = contacts.find(name.value);
    if (contact == null) {
      message.text = 'The contact with this name does not exist';
    } else {
      if (contacts.remove(contact)) save();
    }
  }

  save() {
    window.localStorage['polymer_contacts'] = JSON.encode(Model.one.toJson());
  }
}