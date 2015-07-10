import 'package:transmit/transmit.dart';
import 'dart:async';
import 'dart:html';

main() {
  Service printService = new Service(['printer'], print);

  new Timer.periodic(new Duration(seconds:3), (_) {
    transmit('printer', 'dartworld');
    jsTransmit.apply(['printer', 'dart:js world']);
  });

  document.onClick.listen((_) {
    printService.callback = window.console.warn;
  });
}