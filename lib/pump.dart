library pump;
import 'dart:async';

/**
 *  Pumps direct traffic among themselves.
 *  It publishes everyting it hears. Can funciton as an event bus.
 *  override the 'process' method to modify the returned data.
*/
class Pump {
  // Stream Management
  StreamController _internal = new StreamController.broadcast();
  Stream get events => _internal.stream;
  List _listeners = [];
  int get listeners =>_listeners.length;
  
  
  /// publishes an event to the internal stream, which is detected by anyone listening to this object.
  publish(event) {
    if (event != null && listeners > 0)
      _internal.add(event);
  }
  /// Adds an event to the Router, equivalent to saying 'publish(event)'
  operator +(event) { // Shorthand for publish
    publish(event);
  }
  /// Detects the events emitted by the 'other'
  listen(other) {
    if (other is Pump) {
      other._listeners.add(this);
      other.events.listen((event) => publish(process(event))); // Emit the processed event
    }
    else if (other is Stream) {
      other.listen((event) => publish(process(event)));  
    }
  }
  /// equivalent to saying 'listen(other)'
  operator <(other) { // Shorthand
    listen(other);
  }
  /// equivalent to saying 'other.listen(this)'
  operator >(other) { // Shorthand
    other.listen(this);
  }
  /// lets both parties subscribe to each other, Should override process to stop loops.
  operator &(Pump other) {// Shorthand
    listen(other);
    other.listen(this);
  }
  /// Processes the event before it's added to the internal stream.
  process(event) {
    return event; // By default, no processing is actually done
  }
}