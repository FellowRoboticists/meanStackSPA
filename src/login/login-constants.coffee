"use strict"

angular

  .module( "app.login" )

  .constant( "LOGIN",

    "MESSAGES":

      "LOCKED":
        """
          Your {{name}} is locked. Please contact <a href='mailto:support@bighornimaging.com?subject=Why is my {{name}} locked?'>
          support@bighornimaging.com</a> for more information.
        """

      "BAD_CREDENTIALS": "Incorrect email or password."
  )
