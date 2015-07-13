module.exports = ->
  app = require '../index.js'

  config =
    log_level: 'warn'
    noCompile: true
    createAdmin: true

  if !process.env.TRAVIS
    config.jobRunner = nightwatchConfig:
                        args:
                          [
                            '-e',
                            'chrome'
                          ]

  app.init config
