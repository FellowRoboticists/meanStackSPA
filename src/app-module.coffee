"use strict"

angular.module( "templates", [])

angular

  .module( "app", [

    "templates",
    "cfp.hotkeys",
    "angularUtils.directives.dirPagination",
    "rails",
    "ui.router",
    "ui.bootstrap",
    "ngMessages",
    "naturalSort",
    "ng.deviceDetector",

    "app.session",
    "app.auth",
    "app.constants",
    "app.components",
    "app.services",
    "app.notifications",
    "app.errors",
    "app.login",
    "app.user"
  ])
