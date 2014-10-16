library pump;
import 'dart:async';

StreamController _eventBus = new StreamController.broadcast();

/// A [Message] is automatically sent to every [Service]
/// It has a [type] in the form of a [Symbol], and some [content].
class Message<T> {

  Symbol type;
  T content;
  bool detected = false;

  Message(this.type, this.content) {
    _eventBus.add(this);
    // After 3 seconds, if the message hasn't been recieved, alert us with an #err Message.
    new Timer(new Duration(seconds: 3), () {
      if (detected == false) {
        new Message(#err, 'Message containing, "${this.content}" not Consumed!');
        this.detected = true;
      }
    });
  }

}


/// A [Service] reacts to every [Message], triggering a processor [Function] on it.
class Service {
  Service(List<Symbol> types, Function processor) {
    _eventBus.stream.where((Message thisMessage) {
      return types.contains(thisMessage.type);
    }).listen((Message event) {
      event.detected = true;
      processor(event);
    });
  }
}
