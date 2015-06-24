var Nightwatch = require('nightwatch');

process.on('err', function (data) {
  process.send(data)
})
process.send(process.argv[0])

try {
  Nightwatch.cli(function (argv) {
    Nightwatch.runner(argv, function (pass, results) {
      process.send({
        pass: pass,
        results: results
      });
    });
  });
} catch (err) {
  console.log('there was a problem');
  process.exit(2);
}
