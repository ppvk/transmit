import 'dart:html' as html;
import 'dart:async';
import 'package:venti/venti.dart';



EventRouter E = new EventRouter();
main() {
  new Timer.periodic(new Duration(milliseconds:100), (_) {
    for (int i = 100000; i > 0 ; i--) { // Spawn 10000 events;
      E + new Event('yolo');
      }
    print('Event!');
  });    
}