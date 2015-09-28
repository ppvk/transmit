# Transmit

A very simple global message-passing library for dart/js interop, based on custom events.
It's particularly useful as a two way communication system between dart and Js contexts.

## Dart API
a `Service` receives all messages created by a following `transmit` with a matching `type`

```dart
Service(List<String> types, Function target);

transmit(String type, var content);
```

### Example

```dart
main() {
    new Service(['pokemon'], choose);
    new Service(['attack'], waterGun);

    // Messages trigger services that contain their types.
    transmit('pokemon', 'Squirtle');
        // => I choose you Squirtle!
    transmit('attack', 'Squirtle');
        // => Squirtle used Water Gun!
}

waterGun(content) {
    print('${content} used Water Gun!');
}

choose(content) {
    print('I choose you ${content}!');
}
```
    
### Cancelling a Service

Cancel services any time you want it to stop running the callback. In order to cancel a Service, you'll need to store it in a Service variable.

In this example, the service will run once, because it cancels itself.
Notice that the Service variable is declared *before* it is defined, allowing the callback to access it.

```dart
main() {
    Service myService;
    myService = new Service(['rattata'], (_) {
        // code here will only run on the first transmit(),
        // because this line turns off the Service:
        myService.cancel();
    });
}
```
    
Cancel Services from anywhere the declared Service is accessible:

```dart
import "dart:html";

Service myPublicService;
    
main() {
    myPublicService = new Service(['trapinch'], (_) {
        print("Trapinch never made it live");
    });
        
    querySelector("#myButton").onClick.first.then((_) => stopListening());
}
    
void stopListening() {
    myPublicService.cancel();
}
```

## JS API

```javascript
transmit(String type, content);
```
