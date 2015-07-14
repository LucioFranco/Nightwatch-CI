worker = require '../server/worker'
path = require 'path'
should = require 'should'

describe 'NIGHTWATCH TEST WORKER', ->
  it 'FULL RUN OF NIGHTWATCH', ->
    @timeout 100000000
    config =
      args: ['-c', path.join(__dirname, 'nightwatch/nightwatch.travis.json')]
      testPath: path.join(__dirname, 'nightwatch')
    #if process.env.TRAVIS then config.args = [ '-e', 'chrome' ]
    worker
      .runNightwatch(config, 1)
      .then (result) ->
        result.should.be.ok
        result.pass.should.be.false
        result.buildNumber.should.eql 1
        return result.results;
      .then (result) ->
        result.passed.should.eql 2
        result.failed.should.eql 1
        result.tests.should.eql 3
        result.should.have.properties ['passed', 'failed', 'errors', 'skipped', 'tests', 'errmessages', 'modules']
