module.exports = {
  before: function (browser, done) {
    browser
      .url('http://google.com');
    done();
  },
  'Test': function (browser) {
    browser
      .assert.elementPresent('#hplogo')
      //.assert.elementPresent('.laskdfjsadljf')
      .pause(5000);
  },
  after: function (browser) {
    browser.end();
  }
};
