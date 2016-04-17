'use strict';

module.exports.handler = function(event, context) {
  console.log('event:'   + JSON.stringify(event));
  
  return context.done(null, {
    message: 'Go Serverless! Your Lambda function executed successfully!'
  });
};
