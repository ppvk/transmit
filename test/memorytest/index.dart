import 'dart:html' as html;
import 'dart:async';
import 'package:pump/pump.dart';



Pump E = new Pump();
main() {
  new Timer.periodic(new Duration(milliseconds:100), (_) {
    for (int i = 100000; i > 0 ; i--) { // Spawn 10000 events;
      E + 'yolo';
      }
    print('Event!');
  });    
}