module.exports = (() => {

  var messageQueueWorker = (job) => {
    return new Promise( (resolve, reject) => {
      // reject(new Error("Just faking an error"));
      console.log("Processing job: ");
      console.log(`  Job id: ${job.id}`);
      console.log(`  Job Payload: ${job.payload}`);
      socketIO.sockets.emit('user:logged_out', { msg: job.payload });
      resolve();
    });
  };

  var mod = {
    messageQueueWorker: messageQueueWorker
  };

  return mod;
}());
