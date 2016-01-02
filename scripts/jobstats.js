#!/usr/bin/env node

var program = require('commander');
var async = require('async');

require('../bootstrap');

program.
  version('0.0.1').
  option('--host <host>', 'Hostname of beanstalk server (default: localhost)', 'localhost').
  option('-p --port <port>', 'Port number of beanstalk server (default: 11300)', parseInt, 11300).
  option('-c --command <command>', 'Specify the command to run (default: tubes)', 'tubes').
  option('-t --tube <tube>', 'The tube to use (default: default)', 'default').
  option('-v --verbose', 'Be verbose when processing').
  option('--priority <priority>', 'Set the priority of the job to be queued (default: 100)', parseInt, 100).
  option('--delay <delay>', 'Number of seconds to delay before making the job ready (default: 0)', parseInt, 0).
  option('--ttr <ttr>', 'Maximum number of seconds allocated to run the job (default: 30)', parseInt, 30).
  parse(process.argv);

if (program.verbose) {
  console.log("Options: ");
  console.log(`  Host:     ${program.host}`);
  console.log(`  Port:     ${program.port}`);
  console.log(`  Comand:   ${program.command}`);
  console.log(`  Tube:     ${program.tube}`);
  console.log(`  Verbose:  ${program.verbose}`);
  console.log(`  Priority: ${program.priority}`);
  console.log(`  Delay:    ${program.delay}`);
  console.log(`  Ttr:      ${program.ttr}`);
  console.log(`  Argument: ${program.args}`);
  console.log();
}

var tubes = function() {
  return queue.listTubes().
    then(function(tubeNames) {
      console.log("Available Tubes");
      console.log("---------------");
      tubeNames.forEach(function(tubeName) {
        console.log(`* ${tubeName}`);
      });
    });
};

var stats = function() {
  return queue.listTubes().
    then(function(tubeNames) {
      return new Promise(function(resolve, reject) {
        async.eachSeries(tubeNames, function(tubeName, cb) {
          console.log(`Statistics for tube: ${tubeName}`);
          queue.getTubeStatistics(tubeName).
            then(function(tubeStats) {
              console.log(`   - ready       ${tubeStats['current-jobs-ready']}`);
              console.log(`   - reserved    ${tubeStats['current-jobs-reserved']}`);
              console.log(`   - delayed     ${tubeStats['current-jobs-delayed']}`);
              console.log(`   - buried      ${tubeStats['current-jobs-buried']}`);
              console.log(`   - using       ${tubeStats['current-using']}`);
              console.log(`   - watching    ${tubeStats['current-watching']}`);

              cb();
            }).
            catch(cb);
        }, function(err) {
          if (err) { reject(err); }
          resolve();
        });
      });
    });
};

var wargs = function(options) {
  return new Promise(function(resolve, reject) {
    if (options.args.length > 0) {
      console.log(`Do something with the args: ${options.args}`);
      resolve();
    } else {
      reject(new Error("Must specify an argument (or two)"));
    }
  });
};

var enqueue = function(options) {
  if (options.args.length < 1) {
    throw new Error('Must specify argument containing the job to queue');
  }

  return queue.queueJob(options.tube, 
                            options.priority, 
                            options.delay,
                            options.ttr,
                            options.args[0]).
    then(function(jobId) {
      console.log(`Queued '${options.args[0]}' in job ${jobId}`);
    });
};

var __workJob = function(job) {
  return new Promise(function(resolve, reject) {
    // reject(new Error("Just faking an error"));
    console.log("Processing job: ");
    console.log(`  Job id: ${job.id}`);
    console.log(`  Job Payload: ${job.payload}`);
    resolve();
  });
};

var listen = function(options) {
  return queue.processJobsInTube(options.tube, __workJob);
};

var commands = {
  tubes: tubes,
  stats: stats,
  enqueue: enqueue,
  listen: listen,
  wargs: wargs
};

queue.connect(program.host, program.port).
  then(function() {
    if (commands[program.command]) {
      return commands[program.command](program);
    } else {
      throw new Error(`Invalid command: ${program.command}`);
    }
  }).
  then(function() {
    if (program.command !== 'listen') {
      process.exit();
    }
  }).
  catch(function(err) {
    console.log(err);
    process.exit();
  });
