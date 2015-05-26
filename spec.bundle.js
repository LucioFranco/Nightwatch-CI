var context = require.context('./client/tests', true, /\.coffee$/);
context.keys().forEach(context);
