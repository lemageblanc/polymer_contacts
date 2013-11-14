library contacts;

class Contact implements Comparable {
  String name;
  String tel;
  String e_mail;
  String description;

  Contact(names, tels, e_mails, descriptions) {
    this.name = names;
    this.tel = tels;
    this.e_mail = e_mails;
    this.description = descriptions;

  }

  Contact.fromJson(Map<String, Object> contactMap) {
    name = contactMap['name'];
    tel = contactMap['tel'];
    e_mail = contactMap['e_mail'];
    description = contactMap['description'];

  }

  Map<String, Object> toJson() {
    var contactMap = new Map<String, Object>();
    contactMap['name'] = name;
    contactMap['tel'] = tel;
    contactMap['e_mail'] = e_mail;
    contactMap['description'] = description;

    return contactMap;
  }

  String toString() {
    return '{name: ${name}, tel: ${tel}, e_mail: ${e_mail}, description: ${description}}';
  }

  /**
   * Compares two contacts based on their names.
   * If the result is less than 0 then the first contact is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(Contact contact) {
    if (name != null && contact.name != null) {
      return name.compareTo(contact.name);
    } else {
      throw new Exception('a contact name must be present');
    }
  }
}

class Contacts {
  var _list = new List<Contact>();

  Iterator<Contact> get iterator => _list.iterator;
  bool get isEmpty => _list.isEmpty;

  List<Contact> get internalList => _list;
  set internalList(List<Contact> observableList) => _list = observableList;

  bool add(Contact newContact) {
    if (newContact == null) {
      throw new Exception('a new contact must be present');
    }
    for (Contact contact in this) {
      if (newContact.name == contact.name) return false;
    }
    _list.add(newContact);
    return true;
  }

  Contact find(String name) {
    for (Contact contact in _list) {
      if (contact.name == name) return contact;
    }
    return null;
  }

  bool remove(Contact contact) {
    return _list.remove(contact);
  }

  sort() {
    _list.sort();
  }
}

class Model {
  var contacts = new Contacts();

  // singleton design pattern: http://en.wikipedia.org/wiki/Singleton_pattern
  static Model model;
  Model.private();
  static Model get one {
    if (model == null) {
      model = new Model.private();
    }
    return model;
  }
  // singleton

  init() {
 
    var contact1 = new Contact("Jean-Pierre ASSO", "418 655 4675", "j_pierre@yahoo.ca", "Gestionnaire Approvisionneur");
    var contact2 = new Contact("Didier LAURENT", "418 655 6775", "laurent.didier@gmail.com", "Développeur de logiciel");
    var contact3 = new Contact("Patick LABERGE", "418 655 7875", "patrickl@hotmail.com", "Docteur vétérinaire");    
    var contact4 = new Contact("Fox DESCHAMPS", "418 655 2475", "fox.dps@love.com", "Artiste plasticien");
  
    Model.one.contacts..add(contact1)..add(contact2)..add(contact3)..add(contact4);
  }

  List<Map<String, Object>> toJson() {
    var contactList = new List<Map<String, Object>>();
    for (Contact contact in contacts) {
      contactList.add(contact.toJson());
    }
    return contactList;
  }

  fromJson(List<Map<String, Object>> contactList) {
    if (!contacts.isEmpty) {
      throw new Exception('contacts are not empty');
    }
    for (Map<String, Object> contactMap in contactList) {
      Contact contact = new Contact.fromJson(contactMap);
      contacts.add(contact);
    }
  }
}
