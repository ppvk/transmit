# Pump

A simple global message-passing library.

###API
a `Service` receives all `Messages` created after it with a matching `type`

    Service(var type, Function target);

    Message(List types, var content);


### Example

    main() {
      new Service(['pokemon'], choose);
      new Service(['attack'], waterGun);

      // Messages trigger services that contain their types.
      new Message('pokemon', 'Squirtle');
        // => I choose you Squirtle!
      new Message('attack', 'Squirtle');
        // => Squirtle used Water Gun!
    }

    waterGun(Message m) {
      print('${m.content} used Water Gun!');
    }

    choose(Message m) {
      print('I choose you ${m.content}!');
    }
