import 'package:pump/pump.dart';


main() {
  new Service([#err], handleError);
  new Message(#doThisSecond, 'There is no service for this.'); 
  new Message(#err, 'this will be caught by handleError');
}


handleError(Message event) {
  print('Error: ${event.content}');
}