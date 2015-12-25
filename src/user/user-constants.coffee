"use strict"

angular

  .module( "app.user" )

  .constant( "USER",

    "TEMPLATE":
      "id": null
      "account": null
      "accountOwner": false
      "contractor": false
      "email": null
      "name": null
      "locked": false
      "termsAccepted": false
      "permissions":
        "manageUsers": false
        "curateBooks": false

    "MESSAGES":
      "DOWNLOAD_COMPLETE":
        """
          &ldquo;<b>{{downloadTitle}}</b>&rdquo; is ready! You may <b>
          <a href='/user/{{user}}/pagedownload/{{id}}'>download it now</a></b>
          or later from the <b><a href='#/downloads'>Downloads Page</a></b>.
        """
      "DUPLICATE_LOGIN":
        """
          Someone signed in with your email and password at another location so
          your session has been terminated. Contact <b>
          <a href='mailto:support@bighornimaging.com'>support@bighornimaging.com
          </a></b> if you think this is in error.
        """
      "PROFILE_LOCKED":
        """
          Your <em>profile</em> has been locked. Contact <b>
          <a href='mailto:support@bighornimaging.com?subject=Why is my profile
          locked?'>support@bighornimaging.com</a></b> if you think this is
          in error.
        """
  )