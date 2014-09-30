import 'dart:async';
import 'package:pump/pump.dart';

main() {
  new Service(print);
  errService;
  
  new Timer.periodic(new Duration(milliseconds:1), (_) {
    trigger(#err,'Testing Errors');
  });    
}