module.exports = {
  before: function (browser, done) {
    browser
      .url('http://localhost:3000');
    done();
  },
  'Test': function (browser) {
    browser
      .assert.elementPresent('#app')
      .pause(3000);
      //.assert.elementPresent('.laskdfjsadljf')
  },
  after: function (browser) {
    browser.end();
  }
};
