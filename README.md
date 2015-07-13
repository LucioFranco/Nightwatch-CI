# Nightwatch Continuous Integration

![dependecies](https://david-dm.org/LucioFranco/nightwatch-ci.svg)

## Introduction

Nightwatch CI is a realtime continuous integration platform for your [nightwatchjs](https://github.com/nightwatchjs/nightwatch) test suite.

>Notice: *this project is still in heavy development and may still have bugs. I am working hard to add tests to make this project more stable*

## How to install

To install the CLI verseion just run:

```
npm install -g nightwatchci
nightwatch-ci -c path/to/config
```

In most cases you will want to customize the continuous integration suite. For this case you can require the module.

```
var app = require('nightwatchci');
var path = require('path');

var config = {
  createAdmin: true,
  jobRunner: {
    repeat: 200000,
    nightwatchConfig: {
      args: [
        '--group',
        '-e',
        'chrome'
      ],
      testPath: path.join(process.cwd(), 'test/nightwatch')
    },
    before: function (info, done) {
      // This runs before every test
      //  The info object contains:
      //
      //  buildNumber: 2,
      //  inProgress: false,
      //  started_at: Date
      //
      //  You must call done due to the async nature of the worker
      done();
    },
    after: function (result) {
      // This runs after every build
      // The result object contains:
      //
      //    pass: false,
      //    results:
      //      passed: 2,
      //      failed: 1,
      //      errors: 0,
      //      skipped: 0,
      //      tests: 3,
      //      errmessages: [],
      //      modules: { 'folder/sameTest': [Object], test: [Object] },
      //      assertions: 3
      //
      // No need for done in the after
    }
  }
}

// Must be called before app.start()
app.use(someExpressMiddleware);

app.init(config);
app.start(3000);
```

This will startup a server on port 3000. It may take a few seconds for the server to start due to it having to compile the frontend code.

Once you have the webpage open you will not see a start button and you can not really do much. This is because you are not an admin. To create a admin account must have *createAdmin: true* in your config. This will allow you to go to [localhost:3000/create](localhost:3000/create). This will prompt you for with a form. You must fill the form and it will create a admin account for you. Once you have an admin account you can remove *createAdmin* from the config.

Now that you have an account you can go to the home page and start builds. This should start a nightwatch build.

## Config Options
Coming soon!

## Tests

```
  npm test
```

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style.
Add unit tests for any new or changed functionality. Lint and test your code.

## Release History

* 0.1.0 Initial release
