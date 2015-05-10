# Pump

A very simple global message-passing library for dart/js interop.

###API
a `Service` receives all messages created by `pump` with a matching `type`

    Service(List types, Function target);

    pump(String type, var content);


### Example

    main() {
      new Service(['pokemon'], choose);
      new Service(['attack'], waterGun);

      // Messages trigger services that contain their types.
      pump('pokemon', 'Squirtle');
        // => I choose you Squirtle!
      pump('attack', 'Squirtle');
        // => Squirtle used Water Gun!
    }

    waterGun(content) {
      print('${content} used Water Gun!');
    }

    choose(content) {
      print('I choose you ${content}!');
    }
