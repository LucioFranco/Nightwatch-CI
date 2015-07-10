module.exports = {
  before: function (browser, done) {
    browser
      .url('http://google.com');
    done();
  },
  'Test': function (browser) {
    browser
      .assert.elementPresent('#hplogo')
      .assert.elementPresent('.laskdfjsadljf')
  },
  after: function (browser) {
    browser.end();
  }
};
