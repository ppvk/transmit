library transmit;
import 'dart:async';
import 'dart:html';
import 'dart:js';

/// fire a message and trigger activated services.
transmit(String type, var content) {
  var event = new CustomEvent('PUMP_' + type, detail: content);
  document.dispatchEvent(event);
}

// for your dart:js callbacks
JsFunction get jsPump => context['pump'];

/// A [Service] reacts to every message transmitted of type in [types]
class Service {
  Service(List types, Function target) {
    for (String type in types) {
      document.addEventListener('PUMP_' + type,
          (CustomEvent event) => target(event.detail));
    }
  }
}
