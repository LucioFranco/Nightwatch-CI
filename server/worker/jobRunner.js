var _ = require('lodash');

var queue = [];
var worker = require('./index.js');
var currentBuild = {};
var currentlyWorking = false;
var lastBuildNumber = -1;
var config = {};

console.log('Started Job runner');

function addBuild() {
  console.log('adding build');
  queue.push({ buildNumber: lastBuildNumber++, inProgress: false, started_at: new Date() });
  startBuild();
}

function listenAndStartBuild() {
  currentlyWorking = false;
  if (lastBuildNumber > 0) {
    setTimeout(addBuild, 900000);
  }
}

function startBuild() {
  currentlyWorking = true;
  queue.inProgress = true;
  var build = currentBuild = queue[0];
  console.log('Build #' + currentBuild + ' has started');
  worker
    .runNightwatch(config, build.buildNumber)
    .then(function (result) {
      process.send({type: 'buildCompleted', result: _.merge(result, {finished_at: new Date(), started_at: currentBuild.started_at})});
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
    lastBuildNumber = msg.buildNumber + queue.length;
    queue.push({ buildNumber: msg.buildNumber + queue.length, inProgress: false, started_at: new Date() });
    if (!currentlyWorking)
      startBuild();
    process.send({ type: 'newBuild' });
  }else if (msg.type === 'currentBuild')
    process.send({ type: 'currentBuild', result: currentBuild });
  else if (msg.type === 'buildQueue')
    process.send({ type: 'buildQueue', results: buildQueueList()});
  else if (msg.type === 'config')
    config = msg.config;
});

listenAndStartBuild();
