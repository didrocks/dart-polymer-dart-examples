library contacts_view;

import "package:polymer/polymer.dart";
import "dart:html";
import "model.dart";
import 'data_service.dart';

@CustomTag("contacts-view")
class ContactsView extends PolymerElement {
  final List<Contact> contacts = toObservable([]);
  @observable Contact selectedContact;
  
  ContactsView.created() : super.created() {
    contacts.addAll(getContacts());
  }
  
  void add() {
    contacts.add(new Contact());
    selectedContact = contacts.last;
  }
  
  void delete() {
    List<InputElement> checkboxes = shadowRoot.querySelectorAll("input:checked");
    Iterable<String> ids = checkboxes.map((InputElement checkbox) {
      return checkbox.nextElementSibling.attributes["data-id"];
    });
    contacts.removeWhere((Contact contact) => ids.contains(contact.id));
  }
  
  void selectContact(MouseEvent event, var detail, SpanElement target) {
    String id = target.attributes["data-id"];
    selectedContact = contacts.firstWhere((Contact contact) => contact.id == id);
  }
  
  void editDone(CustomEvent event, bool canceled) {
    if (canceled && selectedContact.isEmpty) {
      contacts.remove(selectedContact);
    }
    
    selectedContact = null;
  }
}