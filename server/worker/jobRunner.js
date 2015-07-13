var _ = require('lodash');

var queue = [];
var worker = require('./index.js');
var currentBuild = {};
var currentlyWorking = false;
var lastBuildNumber = -1;
var buildScheduled = false;
var config = {};
var winston = require('winston');

function addBuild() {
  winston.info('last build number', lastBuildNumber);
  lastBuildNumber += 1;
  queue.push({ buildNumber: lastBuildNumber, inProgress: false, started_at: new Date() });
  buildScheduled = false;
  startBuild();
  process.send({ type: 'newBuild', build: currentBuild });
}

function listenAndStartBuild() {
  currentlyWorking = false;
  if (config.repeat && lastBuildNumber > 0 && !buildScheduled) {
    winston.info('adding build');
    buildScheduled = true;
    setTimeout(addBuild, config.repeat);
  }
}

function startBuild() {
  if (!currentlyWorking) {
    currentlyWorking = true;
    queue.inProgress = true;
    var build = currentBuild = queue[0];
    winston.info('Build #' + currentBuild.buildNumber + ' has started');
    process.send({ type: 'preBuild', info: currentBuild });
    process.on('message', function (msg) {
      if (msg.type === 'donePreBuild') {
        //TODO clean up this mess
        process.removeListener('message', function (data) {
          return;
        });
        worker
          .runNightwatch(config.nightwatchConfig, build.buildNumber)
          .then(function (result) {
            currentlyWorking = false;
            process.send({type: 'buildCompleted', result: _.merge(result, {finished_at: new Date(), started_at: currentBuild.started_at})});
            queue.shift();
            currentBuild = new Object();
            if (queue.length > 0)
              startBuild();
            else
              listenAndStartBuild();
          });
      }
    });
  }
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
  else if (msg.type === 'config') {
    config = msg.config;
    //silent = msg.config.silent;
    //if (silent)
    //  winston.level = 'warn'
    winston.info('JobRunner configured and starting...');
  }
});

listenAndStartBuild();
