library venti;
import 'dart:async';

/**
 *  EventRouter is the combination of an EventConsumer and an EventEmitter.
 *  It emits everyting it consumes. Can funciton as an Event Bus.
 * 
*/
class EventRouter extends EventEmitter with EventConsumer{}

/**
 * An EventRouter that only accepts certain types of Events.
*/
class EventFilter extends EventRouter{
  List types = [];
  EventFilter(type) {
   types.add(type); 
  }
  
  EventFilter.fromList(this.types);
  
  consume(EventEmitter other) {
    other.events.listen( (var e)  {
      if (this.types.contains(e.runtimeType)) 
        _internal.add(e);
    }); 
  }  
}

/**
 * An EventRouter that transforms Events.
 * Provide a transformation function in the constructor.
*/
class EventTransformer extends EventRouter{
  var type;
  Function transform;
  EventTransformer(this.transform);
  consume(EventEmitter other) {
    other.events.listen( (var e)  {
      _internal.add(transform(e));
    }); 
  }  
}


/**
 * An object that emits Events.
 * 
*/
class EventEmitter {
  StreamController _internal = new StreamController.broadcast();
  Stream get events => _internal.stream;
  /// Send an event to this object's listeners.
  emit(var event) {
    _internal.add(event);
  }
}


/**
 * An object that consumes Events.
 * 
*/
class EventConsumer {
  StreamController _internal = new StreamController.broadcast();
  Stream get events => _internal.stream;
  consume(EventEmitter other) {
    other.events.listen(_internal.add); 
  }
}
