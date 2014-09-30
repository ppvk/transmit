library pump;
import 'dart:async';

// Stream Management
StreamController _pump = new StreamController.broadcast();

trigger(Symbol type, content) {
  new Moment(type, content);
}

/// A [Moment] is a particular event that is noticed by every active [Service]
/// It has a type in the form of a [Symbol], and a [content].
class Moment<T> {
  Symbol type;
  T content;
  bool detected = false;
  Moment(this.type, this.content) {
    _pump.add(this);
    // After 3 seconds consume the event and print a warning.
    new Timer(new Duration(seconds: 3), () {
      if (detected == false) {
        new Moment(#err, '${type.toString().replaceAll('Symbol', 'Moment')} not Consumed!');
        this.detected = true;
      }
    });
  }

  /// Checks to see if the event is the proper type, automatically flags it as [detected] if so.
  isType(Symbol type) {
    if (this.type == type) {
      this.detected = true;
      return true;
    } else return false;
  }

  @override
  toString() {
    return '${type.toString().replaceAll('Symbol', 'Moment')} => $content';
  }
}

class Service {
  Service(Function processor) {
    _pump.stream.listen((Moment event) {
      processor(event);
    });
  }
}

/// [errService] prints out the content of any [Moment] typed #err
Service errService = new Service((Moment event) {
  if (event.isType(#err)) print('err: ${event.content}');
  return;
});
