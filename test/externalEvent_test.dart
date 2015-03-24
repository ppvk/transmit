import 'package:pump/pump.dart';


main() {
  Map type = {};
  
  new Service([#err], handleError);
  new Message(#doThisSecond, 'There is no service for this.'); 
  new Message(#err, 'this will be caught by handleError');
  
  registerPuke();
  new Message(#puke1, 'paul');
  
  new Message(#puke2,'paul2');
  
  new Service([Map], (_) => print('what? Maps as types?'));
  
  new Message(Map, 'paul');
  
}


handleError(Message event) {
  print('Error: ${event.content}');
}



registerPuke() {
  new Service([#puke1],puke);
  
  registerPuke2();
}

puke(Message event) {
  print('PUKE: ${event.content}');
}


registerPuke2() {
  new Service([#puke2],(Message event){print('PUKE2: ${event.content}');});
}