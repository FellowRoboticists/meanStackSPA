"use strict"

angular

  .module( "app.constants", [] )

  .constant( "REGEX", Object.defineProperties({},
    "EMAIL":
      value: /^((?:[\w\.%\+\-\'])+@(?:[A-Z0-9\-]+\.)+(?:com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum|[A-Z]{2}))$/i
    "PASSWORD":
      value: /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){10,40}$/
    "ALPHA_NUMERIC":
      value: /^[A-Z\d]+$/i
    "ALPHA":
      value: /^[A-Z]+$/i
    "NUMERIC":
      value: /^(\d+)$/
  ))

  .constant( "PAGINATION_LIMIT", 15)

  .constant( "AUOTCOMPLETE_LIMIT", 10)

  .constant( "MESSAGES",
    "NEW_VERSION":
      """
        The Vault has just been upgraded to version {{version}} to fix bugs
        and/or add new features. Please <b>
        <a href='mailto:naiveroboticist@gmail.com'>contact us</a></b> if you
        have any issues or questions.
      """
    "LOGOUT_SUCCESS": "You have signed out successfully."
    "LOGOUT_ERROR": "Error logging out, please reload the page and try again."
    "CRUD":
      "UPLOADING": "Uploading {{name}}..."
      "CREATING": "Creating {{name}}..."
      "RETRIEVING": "Retrieving {{name}}..."
      "UPDATING": "Updating {{name}}..."
      "DELETING": "Deleting {{name}}..."
      "ERROR":
        "CREATE": "The {{name}} could not be created"
        "RETRIEVE": "The {{name}} could not be retrieved"
        "UPDATE": "The {{name}} could not be updated"
        "DELETE": "The {{name}} could not be deleted"
        "UPLOAD": "The {{name}} could not be uploaded"
      "SUCCESS":
        "CREATE": "&ldquo;<b>{{name}}</b>&rdquo; was created successfully"
        "UPDATE": "&ldquo;<b>{{name}}</b>&rdquo; was updated successfully"
        "DELETE": "&ldquo;<b>{{name}}</b>&rdquo; was deleted successfully"
        "UPLOAD": "&ldquo;<b>{{name}}</b>&rdquo; was uploaded successfully"
  )

  .constant( "US_STATES",[
#     {"abbr":"AL","name":"Alabama"},
#     {"abbr":"AK","name":"Alaska"},
#     {"abbr":"AS","name":"American Samoa"},
#     {"abbr":"AZ","name":"Arizona"},
#     {"abbr":"AR","name":"Arkansas"},
#     {"abbr":"CA","name":"California"},
#     {"abbr":"CO","name":"Colorado"},
#     {"abbr":"CT","name":"Connecticut"},
#     {"abbr":"DE","name":"Delaware"},
#     {"abbr":"DC","name":"District Of Columbia"},
#     {"abbr":"FM","name":"Federated States Of Micronesia"},
#     {"abbr":"FL","name":"Florida"},
#     {"abbr":"GA","name":"Georgia"},
#     {"abbr":"GU","name":"Guam"},
#     {"abbr":"HI","name":"Hawaii"},
#     {"abbr":"ID","name":"Idaho"},
#     {"abbr":"IL","name":"Illinois"},
#     {"abbr":"IN","name":"Indiana"},
#     {"abbr":"IA","name":"Iowa"},
#     {"abbr":"KS","name":"Kansas"},
#     {"abbr":"KY","name":"Kentucky"},
#     {"abbr":"LA","name":"Louisiana"},
#     {"abbr":"ME","name":"Maine"},
#     {"abbr":"MH","name":"Marshall Islands"},
#     {"abbr":"MD","name":"Maryland"},
#     {"abbr":"MA","name":"Massachusetts"},
#     {"abbr":"MI","name":"Michigan"},
#     {"abbr":"MN","name":"Minnesota"},
#     {"abbr":"MS","name":"Mississippi"},
#     {"abbr":"MO","name":"Missouri"},
#     {"abbr":"MT","name":"Montana"},
#     {"abbr":"NE","name":"Nebraska"},
#     {"abbr":"NV","name":"Nevada"},
#     {"abbr":"NH","name":"New Hampshire"},
#     {"abbr":"NJ","name":"New Jersey"},
#     {"abbr":"NM","name":"New Mexico"},
#     {"abbr":"NY","name":"New York"},
#     {"abbr":"NC","name":"North Carolina"},
#     {"abbr":"ND","name":"North Dakota"},
#     {"abbr":"MP","name":"Northern Mariana Islands"},
#     {"abbr":"OH","name":"Ohio"},
#     {"abbr":"OK","name":"Oklahoma"},
#     {"abbr":"OR","name":"Oregon"},
#     {"abbr":"PW","name":"Palau"},
#     {"abbr":"PA","name":"Pennsylvania"},
#     {"abbr":"PR","name":"Puerto Rico"},
#     {"abbr":"RI","name":"Rhode Island"},
#     {"abbr":"SC","name":"South Carolina"},
#     {"abbr":"SD","name":"South Dakota"},
#     {"abbr":"TN","name":"Tennessee"},
#     {"abbr":"TX","name":"Texas"},
#     {"abbr":"UT","name":"Utah"},
#     {"abbr":"VT","name":"Vermont"},
#     {"abbr":"VI","name":"Virgin Islands"},
#     {"abbr":"VA","name":"Virginia"},
#     {"abbr":"WA","name":"Washington"},
#     {"abbr":"WV","name":"West Virginia"},
#     {"abbr":"WI","name":"Wisconsin"},
    {"abbr":"WY","name":"Wyoming"}
  ])

  .constant( "WY_COUNTIES", [
    "Albany",
    "Big Horn",
    "Campbell",
    "Carbon",
    "Converse",
    "Crook",
    "Fremont",
    "Goshen",
    "Hot Springs",
    "Johnson",
    "Laramie",
    "Lincoln",
    "Natrona",
    "Niobrara",
    "Park",
    "Platte",
    "Sheridan",
    "Sublette",
    "Sweetwater",
    "Teton",
    "Uinta",
    "Washakie",
    "Weston"
  ])

#   .constant( "CO_COUNTIES", [
#     "Adams",
#     "Alamosa",
#     "Arapahoe",
#     "Archuleta",
#     "Baca",
#     "Bent",
#     "Boulder",
#     "Broomfield",
#     "Chaffee",
#     "Cheyenne",
#     "Clear Creek",
#     "Conejos",
#     "Costilla",
#     "Crowley",
#     "Custer",
#     "Delta",
#     "Denver",
#     "Dolores",
#     "Douglas",
#     "Eagle",
#     "El Paso",
#     "Elbert",
#     "Fremont",
#     "Garfield",
#     "Gilpin",
#     "Grand",
#     "Gunnison",
#     "Hinsdale",
#     "Huerfano",
#     "Jackson",
#     "Jefferson",
#     "Kiowa",
#     "Kit Carson",
#     "La Plata",
#     "Lake",
#     "Larimer",
#     "Las Animas",
#     "Lincoln",
#     "Logan",
#     "Mesa",
#     "Mineral",
#     "Moffat",
#     "Montezuma",
#     "Montrose",
#     "Morgan",
#     "Otero",
#     "Ouray",
#     "Park",
#     "Phillips",
#     "Pitkin",
#     "Prowers",
#     "Pueblo",
#     "Rio Blanco",
#     "Rio Grande",
#     "Routt",
#     "Saguache",
#     "San Juan",
#     "San Miguel",
#     "Sedgwick",
#     "State Level Sites",
#     "Summit",
#     "Teller",
#     "Washington",
#     "Weld",
#     "Yuma"
#   ])
