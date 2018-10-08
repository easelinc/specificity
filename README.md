CSS selector specificity.

```
$.specificity('#this .is-a .css-selector'); // => 1200
```

### Contents

* a README
* a simple test structure you dont need any other packages to run: [jasmine][jasmine]
* coffeescript
  * [install coffeescript][install]
  * `make watch` and `make test-watch`

### Structure

* /test/src - coffeescript jasmine tests
* /test/suite - runs the tests
* /src - your coffeescript
* library.js - generated js

### Contributing

* adhere to our [styleguide][styleguide]
* Send a pull request.
* Write tests. New untested code will not be merged.

MIT License

[jasmine]: https://jasmine.github.io/
[install]: http://jashkenas.github.com/coffee-script/#installation
[skeleton]: http://buttersafe.com/2008/03/13/romance-on-the-floating-island/
[styleguide]: https://github.com/easelinc/coffeescript-style-guide
