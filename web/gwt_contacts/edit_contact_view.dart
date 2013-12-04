library edit_contact_view;

import "package:polymer/polymer.dart";
import "dart:html";
import "dart:async";
import "model.dart";

@CustomTag("edit-contact-view")
class EditContactView extends PolymerElement {
  @published Contact contact;
  Contact _originalContact;
  
  EditContactView.created() : super.created();
  
  enteredView() {
    super.enteredView();
    _originalContact = new Contact.copy(contact);
  }

  static const EventStreamProvider<CustomEvent> _EDITDONE_EVENT = const EventStreamProvider("editdone");
  Stream<CustomEvent> get onEditDone => _EDITDONE_EVENT.forTarget(this);
  static void _dispatchReadyEvent(Element element, {bool canceled}) {
    element.dispatchEvent(new CustomEvent("editdone", detail: canceled));
  }
  
  void save() {
    _dispatchReadyEvent(this, canceled: false);
  }
  
  void cancel() {
    contact.firstName = _originalContact.firstName;
    contact.lastName = _originalContact.lastName;
    contact.emailAddress = _originalContact.emailAddress;
    
    _dispatchReadyEvent(this, canceled: true);
  }
}