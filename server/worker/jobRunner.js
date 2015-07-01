var _ = require('lodash');

var queue = [];
var worker = require('./index.js');
var currentBuild = {};
var currentlyWorking = false;

console.log('Started Job runner');

function listenAndStartBuild() {
  currentlyWorking = false;
  process.on('message', function (msg) {
    if (msg.type === 'newBuild' && !currentlyWorking)
      setTimeout(startBuild(), 500);
  });
}

function startBuild() {
  currentlyWorking = true;
  queue.inProgress = true;
  var build = currentBuild = queue[0];
  console.log('Build #' + currentBuild + ' has started');
  worker
    .runNightwatch(build.buildNumber)
    .then(function (result) {
      process.send({type: 'buildCompleted', result: result});
      queue.shift();
      currentBuild = new Object();
      if (queue.length > 0)
        startBuild();
      else
        listenAndStartBuild();
    });
}

function buildQueueList() {
  return _.map(queue, function (e) {
    if (e.buildNumber === currentBuild.buildNumber) {
      e.inProgress = true;
      return e;
    }else {
      return e;
    }
  });
}

process.on('message', function (msg) {
  if (msg.type === 'newBuild') {
    queue.push({ buildNumber: msg.buildNumber + queue.length, inProgress: false });
    console.log('post add ', queue);
    process.send({ type: 'newBuild' });
  }else if (msg.type === 'currentBuild')
    process.send({ type: 'currentBuild', result: currentBuild });
  else if (msg.type === 'buildQueue')
    process.send({ type: 'buildQueue', results: buildQueueList()});
});

listenAndStartBuild();
