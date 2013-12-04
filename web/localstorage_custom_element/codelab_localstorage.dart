import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';
import 'dart:convert';

@CustomTag('codelab-localstorage')
class CodelabLocalstorage extends PolymerElement {
  @published String name;
  @published var value;
  @observable bool useRaw = false;
  @observable bool loaded = false;
  
  CodelabLocalstorage.created() : super.created();
  
  valueChanged(oldValue) {
    if (loaded) {
      save();
    }
  }
  
  @override
  void enteredView() {
    super.enteredView();
    print('codelab-localstorage inserted');
    
    // let the bindings complete, so run this async
    // TODO: should we use runAsync here?
    scheduleMicrotask(load);
  }
  
  void save() {
    window.localStorage[name] = useRaw ? value : JSON.encode(this.value);
  }
  
  void load() {
    var s = window.localStorage[name];
    if (s != null && !useRaw) {
      try {
        value = JSON.decode(s);
      } catch (x) {
        value = s;
      }
    } else {
      value = s;
    }
    loaded = true;
    //this.asyncFire('polymer-localstorage-load');
  }
}