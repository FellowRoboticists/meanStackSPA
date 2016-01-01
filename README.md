meanStackSPA
-----------

This project is to serve as a start-up template for the development
of a MEAN-stack-based Single Page Application.

Frankly, I'm tired of piecing together these things from a variety of
sources. I'd rather just start with a template that I know works and get
on with the devlopment of the intended application.

This template should document how the thing was put together in the first
place and discuss how to use it.

It is certainly my intention to keep this template up-to-date with enhancements
in library versions and new technologies (we'll see how that goes).

There are a few technologies I would like to illustrate and embed in this template:

* Mongoose models
* JWT Authentication
* Beanstalk integration
* Socket.io (WebSockets) integration
* AngularJS application tool chain (using gulp/bower)
* Mongodb GridFS usage

I'll try to explain how each of these things are integrated so you can have an
easy time leveraging them or deleting them (if you don't need them).

The details will be provided in the Wiki.

Good luck.

Installing and Running
======================

I'm going to assume you have Node.js, Mongo, etc installed.

Just do the following to get going:

1. Clone this repository
2. Change your current directory to the root of meanStackSPA
3. Pull in the required NPM modules (npm install)
4. Pull in the required bower components (bower install)
5. Run gulp to prep the front-end code for deliver (gulp or gulp watch)
6. Seed the database with a user (scripts/addUsers.js)
6. Start the server (DEBUG=meanStackSPA:* npm start)
7. Play with the application.

The default user seeded above has the following credentials:

    email: user1@mail.com
    password: Pass1234

Feel free to play around.

Also, feel free to fork and send pull requests. I can use all the help I can get.
