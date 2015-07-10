import 'package:pump/pump.dart';

main() {
  new Service(['printer'], print);


  pump('printer', 'dartworld');

  jsPump.apply(['printer', 'dart:js world']);

}