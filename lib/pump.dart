library pump;
import 'dart:async';

StreamController _eventBus = new StreamController.broadcast();

/// A [Message] is automatically sent to every [Service]
/// It has a [type] which can be anything, and some [content].
class Message<T> {

  var type;
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
  Service(List types, Function target) {
    _eventBus.stream.where((Message thisMessage) {
      return types.contains(thisMessage.type);
    }).listen((Message event) {
      event.detected = true;
      target(event);
    });
  }
}
