import 'package:venti/venti.dart' as vti;
import 'dart:async';


class Person extends vti.EventConsumer{
  String name; 
  Person(this.name){
    this.events.listen((data) => print('$name consumes event $data'));
  }  
}




main() {
  busTest();
  filterTest();
  transformTest();
}

busTest() {
  // Testing Bus functionality
  vti.EventRouter eventbus = new vti.EventRouter();
  
  Person sal = new Person('Sal');
  sal.consume(eventbus);
  
  Person bob = new Person('Bob');
  bob.consume(eventbus);
  
  Person steve = new Person('Steve');
  steve.consume(eventbus);
  
  Person ralf = new Person('Ralf');
  ralf.consume(eventbus);
  
  eventbus.emit('icecream');
  // Console should record a reply from each Person.
}

filterTest() {
  
  vti.EventEmitter emitter = new vti.EventEmitter();
  
  vti.EventFilter numbers = new vti.EventFilter.fromList([double, int]);
  numbers.consume(emitter);
  
  vti.EventFilter strings = new vti.EventFilter(String);
  strings.consume(emitter);
  
  // only recieves events from numbers or strings
  vti.EventConsumer printer = new vti.EventConsumer();
  printer
    ..consume(numbers)
    ..consume(strings);
  
  // will print any events that come to it
  printer.events.listen(print);
  
  // Add events the the emitter.
  emitter
    ..emit('hello world') // will print
    ..emit(3/2) // will print
    ..emit(false); // will not print  
}

transformTest() {
  vti.EventEmitter counter = new vti.EventEmitter();
  
  vti.EventTransformer transformer = new vti.EventTransformer(chibify);
  transformer.consume(counter); // consumes counter and transforms it
  
  vti.EventConsumer printer = new vti.EventConsumer();
  printer.consume(transformer);
  printer.events.listen(print);
  
  
  int count = 0;
  Timer t = new Timer.periodic(new Duration(seconds:1), (_) {
    count++;
    counter.emit(count);
  });
  
  
}

// A test Transformer
String chibify(int x){
  return '<(o.o)> $x';
}

