import 'dart:html';
import 'dart:convert';
import 'package:polymer_contacts/contacts.dart';
import 'package:polymer/polymer.dart';

@CustomTag('t-contacts')
class TContacts extends PolymerElement {
  @published Contacts contacts = Model.one.contacts;
  @published var ajout='Ajouter';

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
        if(ajout=='Ajouter')
        message.text = 'The contact with that name already exists';
        else
        { Contact alpha = contacts.find(name.value);
          if(contacts.remove(alpha))
          {
            contacts.sort();
            save();
          }
          if(contacts.add(contact)){
            contacts.sort();
            save();
            window.alert("Modification effectuee avec succes");
            }
        }
      }
    }
    window.location.reload();
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

  modif(Event e, var detail, Node target) {
    //(event.target as ImageElement).id; 
    //window.alert((event.target as ImageElement).id);
    // var id = (e.target as ImageElement).id;
     var BoutonModif = (e.target as ButtonElement).title;
     
     
     InputElement name = shadowRoot.querySelector("#name");
     InputElement tel = shadowRoot.querySelector("#tel");
     InputElement e_mail = shadowRoot.querySelector("#e_mail");
     InputElement description = shadowRoot.querySelector("#description");
     LabelElement message = shadowRoot.querySelector("#message");

     var contac = contacts.find(BoutonModif);
     
     name.value=contac.name;
     tel.value=contac.tel;
     e_mail.value=contac.e_mail;
     description.value=contac.description;
     
     ajout='Modifier';
     
  }
  
  supprim(Event e, var detail, Node target) {
    //(event.target as ImageElement).id; 
    //window.alert((event.target as ImageElement).id);
    LabelElement message = shadowRoot.querySelector("#message");
    message.text = '';
    
    
    //var id = (e.target as ImageElement).title;
    //Contact contact = contacts.find(id);
    
    var BoutonSupp = (e.target as ButtonElement).title;
    var contact = contacts.find(BoutonSupp);
    
    if (contact == null) {
      message.text = 'web contact with this name does not exist';
    } else {
      if (window.confirm("Confirmez la suppression?"))
      {
        if (contacts.remove(contact)) save();
        window.location.reload();
      } 
    }
  }
  
  save() {
    window.localStorage['polymer_contacts'] = JSON.encode(Model.one.toJson());
  }
}