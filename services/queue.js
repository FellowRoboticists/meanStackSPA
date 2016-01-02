module.exports = (() => {

  var fiveBeans = require('fivebeans');

  // This is the global connected client variable. This will be
  // set to the five-beans client when connected. If not connected,
  // it will be set to null.
  var connectedClient = null;

  var connect = (host, port) => {
    var client = new fiveBeans.client(host, port);

    return new Promise( (resolve, reject) => {

      client.
        on('connect', () => { 
          connectedClient = client;
          resolve(client); 
        }).

        on('error', (err) => reject(err) ).

        on('close', () => {        
          connectedClient = null;
          resolve(null);
        }).

        connect();

    });
  };

  var useTube = (tubeName) => {
    return new Promise( (resolve, reject) => {
      connectedClient.use(tubeName, (err) => {
        if (err) { return reject(err); }
        resolve(tubeName);
      });
    });
  };

  var putJob = (priority, delay, ttr, payload) => {
    console.log(`Priority: ${priority}`);
    console.log(`Delay: ${delay}`);
    console.log(`Ttr: ${ttr}`);
    console.log(`Payload: '${payload}'`);
    return new Promise( (resolve, reject) => {
      connectedClient.put(priority, delay, ttr, payload, (err, jobid) => {
        if (err) { return reject(err); }
        resolve(jobid);
      });
    });
  };

  var queueJob = (tubeName, priority, delay, ttr, data) => {
    return useTube(tubeName).
      then( (tn) => putJob(priority, delay, ttr, data) );
  };

  var listTubes = () => {
    return new Promise( (resolve, reject) => {
      connectedClient.list_tubes( (err, tubeNames) => {
        if (err) { return reject(err); }
        resolve(tubeNames);
      });
    });
  };

  var getTubeStatistics = (tubeName) => {
    return new Promise( (resolve, reject) => {
      connectedClient.stats_tube(tubeName, (err, tubeStats) => {
        if (err) { return reject(err); }
          resolve(tubeStats);
        });
      });
  };

  var watchTube = (tubeName) => {
    return new Promise( (resolve, reject) => {
      connectedClient.watch(tubeName, (err, numWatched) => {
        if (err) { return reject(err); }
        resolve(numWatched);
      });
    });
  };

  var reserveJob = () => {
    return new Promise( (resolve, reject) => {
      connectedClient.reserve( (err, jobid, payload) => {
        if (err) { return reject(err); }
        resolve({ id: jobid, payload: payload.toString() });
      });
    });
  };

  var deleteJob = (jobid) => {
    return new Promise( (resolve, reject) => {
      connectedClient.destroy(jobid, (err) => {
        if (err) { return reject(err); }
        resolve();
      });
    });
  };
                                                
  var processJobsInTube = (tubeName, workJob) => {
    return watchTube(tubeName).
      then( (numWatched) => reserveJob() ).
      then( (job) => workJob(job).  
           then( () => deleteJob(job.id) ).
           catch( (err) => {
            deleteJob(job.id).
              then( () => console.log(err.stack) );
          })
      ).
      then( () => {
        // Do it again...
        process.nextTick( () => processJobsInTube(tubeName, workJob) );
      }).
      catch( (err) => {
        console.log(err.stack);
        process.nextTick( () => processJobsInTube(tubeName, workJob) );
      });
  };

  var mod = {
    connect: connect,
    listTubes: listTubes,
    getTubeStatistics: getTubeStatistics,
    useTube: useTube,
    putJob: putJob,
    queueJob: queueJob,
    watchTube: watchTube,
    deleteJob: deleteJob,
    processJobsInTube: processJobsInTube,
    reserveJob: reserveJob
  };

  return mod;
}());
