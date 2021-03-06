'use babel';
'use strict';

var fs = require('fs');
var path = require('path');
var util = require('util');
var _ = require('lodash');
var Task = require('atom').Task;

var originalNodePath = process.env.NODE_PATH;

module.exports.niceName = 'Grunt';

module.exports.isEligable = function (cwd) {
  return fs.existsSync(path.join(cwd, 'Gruntfile.js'));
};

module.exports.settings = function (cwd) {
  if (!atom.config.get('deprecated.tool.grunt')) {
    atom.notifications.addWarning('Bundled `Grunt` build will be removed', {
      dismissable: true,
      detail:
        'You are using a bundled tool for `build` which will have to be installed seperately next version of `build`.\n' +
        'You can install `build-grunt` (apm install build-grunt) at this time and you will be well prepared for the next release!'
    });
    atom.config.set('deprecated.tool.grunt', true);
  }

  var createConfig = function (name, args) {
    var executable = /^win/.test(process.platform) ? 'grunt.cmd' : 'grunt';
    var localPath = path.join(cwd, 'node_modules', '.bin', executable);
    var exec = fs.existsSync(localPath) ? localPath : executable;
    return {
      name: name,
      exec: exec,
      sh: false,
      args: args
    };
  };

  return new Promise(function(resolve, reject) {
    /* This is set so that the spawned Task gets its own instance of grunt */
    process.env.NODE_PATH = util.format('%s%snode_modules%s%s', cwd, path.sep, path.delimiter, originalNodePath);

    Task.once(require.resolve('./grunt-parser-task.js'), cwd, function (result) {
      if (result.error) {
        return resolve([ createConfig('Grunt: default', [ 'default' ]) ]);
      }

      var config = [];
      /* Make sure 'default' is the first as this will be the prioritized target */
      result.tasks.sort(function (t1, t2) {
        if ('default' === t1) {
          return -1;
        }
        if ('default' === t2) {
          return 1;
        }
        return t1.localeCompare(t2);
      });
      _.forEach(result.tasks || [], function (task) {
        config.push(createConfig('Grunt: ' + task, [ task ]));
      });

      return resolve(config);
    });
  }).catch(function (err) {
    process.env.NODE_PATH = originalNodePath;
    throw err;
  });
};
