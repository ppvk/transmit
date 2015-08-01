# Transmit

A very simple global message-passing library for dart/js interop, based on custom events.
It's particularly useful as a two way communication system between dart and Js contexts.

### Dart API
a `Service` receives all messages created by a following `transmit` with a matching `type`

    Service(List<String> types, Function target);

    transmit(String type, var content);

### Example

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

### JS API
    
    transmit(String type, content);
    