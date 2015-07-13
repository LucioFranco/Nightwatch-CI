module.exports = ->
  app = require '../index.js'
  path = require 'path'

  config =
    log_level: 'warn'
    noCompile: true
    createAdmin: true

  if !process.env.TRAVIS
    config.jobRunner =
      silent: true
      nightwatchConfig:
        args:
          [
            '-e',
            'chrome'
          ]
        testPath: path.join(process.cwd(), 'test/nightwatch')

  app.init config
