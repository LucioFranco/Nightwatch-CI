var Nightwatch = require('nightwatch');

process.on('err', function (data) {
  process.send(data);
});

console.log(Nightwatch);

process.on('message', function (msg) {
  if (msg.type === 'cancel') {
    process.exit(0);
  }
});

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
  console.log('[Nightwatch Error]', err);
  process.exit(2);
}
