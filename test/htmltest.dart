import 'package:transmit/transmit.dart';

main() {
  new Service(['printer'], print);


  transmit('printer', 'dartworld');
  jsTransmit.apply(['printer', 'dart:js world']);



}