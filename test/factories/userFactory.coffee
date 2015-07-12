Factory = require 'rosie'
faker = require 'faker'

Factory
  .define 'user'
  .attr 'firstname', -> faker.name.firstName()
  .attr 'lastname', -> faker.name.lastName()
  .attr 'username', -> faker.internet.userName()
  .attr 'email', -> faker.internet.email()
  .attr 'password', -> faker.internet.password()
  .attr 'admin', false

module.exports = Factory
