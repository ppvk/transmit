library transmit;
import 'dart:async';
import 'dart:html';
import 'dart:js';

/// fire a message and trigger activated services.
transmit(var channel, [var content]) {
  if (!(channel is String) && !(channel is int)) throw('channel must be a String or and int');
  var event = new CustomEvent('PUMP_' + channel, detail: content);
  document.dispatchEvent(event);
}

/// A [JsFunction] that calls 'transmit'.
/// Can be used as a JS callback in dart-wrapped JS libraries.
JsFunction get jsTransmit => context['transmit'];

/// A [Service] reacts to every message transmitted of type in [types]
class Service {
  Function callback;

  Service(final List channels, this.callback) {
    for (var channel in channels) {
      if (!(channel is String) && !(channel is int)) throw('channel must be a String or and int');
      document.addEventListener('PUMP_' + channel.toString(),
          (CustomEvent event) => callback(event.detail));
    }
  }
}
