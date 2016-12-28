
function load_userdata() {

    var testStr = "SELECT  *  FROM USER WHERE 1";
         //showlogin.state = "Show";
        console.log("Loading personal data");
        db.transaction(function(tx) {

           //  tx.executeSql('DROP TABLE SESSIONS');

            tx.executeSql('CREATE TABLE IF NOT EXISTS USER (firstname TEXT,lastname TEXT,age INT,hometown TEXT)');

            var pull = tx.executeSql(testStr);

            if(pull.rows.length == 0) {

               showlogin.state = "Show";
            } else {

                //showpolicy.state = "Show";

                firstName = pull.rows.item(0).firstname;
                lastName = pull.rows.item(0).lastname;
                userAge = pull.rows.item(0).age;
                homeTown = pull.rows.item(0).hometown;

            }

        });

}

function save_userdata(firstname,lastname,age,hometown) {


    var testStr = "SELECT  *  FROM USER WHERE 1";

    var data = [firstname,lastname,age,hometown];

    var insert = "INSERT INTO USER VALUES(?,?,?,?)";

    db.transaction(function(tx) {
    tx.executeSql('CREATE TABLE IF NOT EXISTS USER (firstname TEXT,lastname TEXT,age INT,hometown TEXT)');
        var pull = tx.executeSql(testStr);

        if(pull.rows.length == 0) {
            tx.executeSql(insert,data);
        } else {

        }

    });

}


function location_info(lo) {

    //console.log("test");
    switch (lo) {

    case 1:snapshot="Graphics/UNTSquare.jpg";break;
    case 2:snapshot="Graphics/CourtHouse.jpg";break;
    case 3:snapshot="Graphics/MSC.jpg";break;
    case 4:snapshot="Graphics/ESSATJPG";break;
    //case 5:snapshot="Graphics/alderman.jpg";break;



    default:break;
    }

    switch (lo) {
    case 1: info="UNT on the Square (UNTSQ), your portal to the arts at the University of North Texas, is located in downtown Denton, Texas.<Br> UNT on the Square is an arts and meeting space devoted to presenting UNT arts programming in service to the university and to the community at large. <BR> UNT on the Square also houses the UNT Institute for the Advancement of the Arts. ";break;
    case 2:info="One of Denton's most enduring symbols is the beautiful and historic County Courthouse in Denton's historic downtown square. The building was erected in 1895 using Texas limestone. Denton County has built a newer courthouse on McKinney Avenue, but the courthouse on the square is still used in an official capacity by the County, including being the home of the Denton County museum. The City of Denton is the County Seat of Denton County.For more information about the museum, please visit the County's Website.";break;
    case 3:info="Proud to be located in Downtown Denton, we’re a non-smoking full service bar that specializes in margaritas and hand muddled beverages. Happy hour is 3-8 with complimentary chips and salsa. Within walking distance, you’ll find restaurants, pubs, ice cream, coffee, comics, and more.";break;
    case 4:info="Departments<br>Environmental Sciences<br>Geography<br>Institute of Applied Sciences (IAS)<br>Philosophy and Religion Studies<br>Center for Environmental Philosophy<br>Astronomy Lab Help Desk<br>Sky Theater<br>Center for Community & Environmental Journalism<br>Elm Fork Education Center<br>Radiation Safety Office";break;


    default:break;


    }

}

function gps_stats(lat,lon) {

        var collected;
    var http = new XMLHttpRequest();
    //var url = "http://openseed.vagueentertainment.com/corescripts/auth.php?devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email ;
    var url = "http://nominatim.openstreetmap.org/reverse.php?format=json&lat="+lat+"&lon="+lon+"&zoom=18&polygon_svg=1"
   // console.log(url)
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            console.log(http.responseText);
            //userid = http.responseText;
            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                //console.log(http.responseText);
                //id = http.responseText;
                collected = http.responseText;
                place_id = collected.split('":"')[1].split('"')[0];
                licence = collected.split('":"')[2].split('"')[0];
                osm_type= collected.split('":"')[3].split('"')[0];
                osm_id= collected.split('":"')[4].split('"')[0];


                display_name= collected.split('":"')[7].split('"')[0];
                house_number= collected.split('":"')[8].split('"')[0];
                road= collected.split('":"')[9].split('"')[0];
                city= collected.split('":"')[10].split('"')[0];

               county = collected.split('":"')[11].split('"')[0];
                thestate = collected.split('":"')[12].split('"')[0];
                postcode = collected.split('":"')[13].split('"')[0];



            }

        }
    }
    http.open('POST', url.trim(), true);
    http.send(null);
    //http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    //http.send("devid=" + devId + "&appid=" + appId + "&username="+ name + "&email=" + email);

    //http://nominatim.openstreetmap.org/reverse.php?format=json&lat=33.2133763&lon=-97.7512266&zoom=

}

function upload_stats(lastname,firstname,age,hometown,location) {

        var http = new XMLHttpRequest();
        var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/SWAAG-2016/update.php";

        //var sending = file.split(":;:")[0];
        var retrieved;
       // console.log(url)

        console.log("sending");

        var d = new Date();
        var thedate = d;


        http.onreadystatechange = function() {

            if (http.readyState == 4) {

                if(http.responseText == 100) {
                    console.log("Incorrect DevID");
                } else if(http.responseText == 101) {
                    console.log("Incorrect AppID");
                } else {
                    retrieved = http.responseText;
                    //console.log(retrieved);
                    lastping = retrieved;
                   // update_index(file,effect,date,retrieved);
                }

            }

        }
        http.open('POST', url.trim(), true);
       // console.log(http.statusText);
        //http.send(null);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.send("devid=" + devId + "&appid=" + appId + "&firstname="+firstname+"&lastname="+
                  lastname+"&age="+age+"&hometown="+hometown+"&location="+location+"&date="+thedate);


}

function download_sessions () {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/SWAAG-2016/update.php";

    //var sending = file.split(":;:")[0];
    var retrieved;
   // console.log(url)

    console.log("Downloading Sessions");

    var d = new Date();
    var thedate = d;


    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                retrieved = http.responseText;
                //console.log(retrieved);

                //var testStr = "SELECT  *  FROM USER WHERE 1";



                var insert = "INSERT INTO SESSIONS VALUES(?,?,?,?,?)";

                db.transaction(function(tx) {

                tx.executeSql('DROP TABLE SESSIONS');

                tx.executeSql('CREATE TABLE IF NOT EXISTS SESSIONS (session TEXT,discription TEXT,location INT,speaker TEXT,time TEXT)');


                   var  numofsessions = retrieved.split(">!<").length;
                   var sessions = retrieved.split(">!<");
                   var  num = 1;

                    while(num < numofsessions) {

                        var data = [sessions[num].split(":retrieved:")[1],sessions[num].split(":retrieved:")[3],sessions[num].split(":retrieved:")[2],sessions[num].split(":retrieved:")[4],sessions[num].split(":retrieved:")[5]];

                        tx.executeSql(insert,data);

                           // console.log(data);

                        num = num + 1;
                    }

                });


            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&session=1");


}


function download_speakers () {

    var http = new XMLHttpRequest();
    var url = "http://openseed.vagueentertainment.com/devs/Vag-01001011/SWAAG-2016/update.php";

    //var sending = file.split(":;:")[0];
    var retrieved;
   // console.log(url)

    console.log("Downloading Speakers");

    var d = new Date();
    var thedate = d;


    http.onreadystatechange = function() {

        if (http.readyState == 4) {

            if(http.responseText == 100) {
                console.log("Incorrect DevID");
            } else if(http.responseText == 101) {
                console.log("Incorrect AppID");
            } else {
                retrieved = http.responseText;
                //console.log(retrieved);

                //var testStr = "SELECT  *  FROM USER WHERE 1";



                var insert = "INSERT INTO SPEAKERS VALUES(?,?,?,?,?)";

                db.transaction(function(tx) {

                tx.executeSql('DROP TABLE SPEAKERS');

                tx.executeSql('CREATE TABLE IF NOT EXISTS SPEAKERS (session TEXT,discription TEXT,location INT,speaker TEXT,time TEXT)');


                   var  numofsessions = retrieved.split(">!<").length;
                   var sessions = retrieved.split(">!<");
                   var  num = 1;

                    while(num < numofsessions) {

                        var data = [sessions[num].split(":retrieved:")[1],sessions[num].split(":retrieved:")[3],sessions[num].split(":retrieved:")[2],sessions[num].split(":retrieved:")[4],sessions[num].split(":retrieved:")[5]];

                        tx.executeSql(insert,data);

                           // console.log(data);

                        num = num + 1;
                    }

                });


            }

        }

    }
    http.open('POST', url.trim(), true);
   // console.log(http.statusText);
    //http.send(null);
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.send("devid=" + devId + "&appid=" + appId + "&speaker=1");


}



function list_sessions (location,date) {

    var testStr = "SELECT  *  FROM SESSIONS WHERE 1";
         //showlogin.state = "Show";
        console.log("Listing Sessions");
        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS SESSIONS (session TEXT,discription TEXT,location INT,speaker TEXT,time TEXT)');

            var pull = tx.executeSql(testStr);

            schedulelist.clear();

            if(pull.rows.length != 0) {

                var num = 0;

            while(pull.rows.length > num) {

                if(pull.rows.item(num).location == location) {


                schedulelist.append ({
                                         type:"session",
                                         name:pull.rows.item(num).session,
                                         location:pull.rows.item(num).location,
                                         time:pull.rows.item(num).time.split(",")[1],
                                         date:pull.rows.item(num).time.split(",")[0],
                                         speaker:pull.rows.item(num).time.speaker

                                  });

                }


                num = num + 1;
            }

            }

        });

}

function list_host (host,location,date) {

    var testStr = "SELECT  *  FROM SESSIONS WHERE speaker LIKE '%"+host+"%'";
         //showlogin.state = "Show";
        console.log("Listing Guest" + host);
        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS SESSIONS (session TEXT,discription TEXT,location INT,speaker TEXT,time TEXT)');

            var pull = tx.executeSql(testStr);

            schedulelist.clear();

            //console.log(pull.rows.length);

            if(pull.rows.length != 0) {

                var num = 0;

            while(pull.rows.length > num) {

              //  if(pull.rows.item(num).location == location) {
                //    console.log(pull.rows.item(num).session)

                schedulelist.append ({
                                         type:"session",
                                         name:pull.rows.item(num).session,
                                         location:pull.rows.item(num).location,
                                         time:pull.rows.item(num).time.split(",")[1],
                                         date:pull.rows.item(num).time.split(",")[0],
                                         speaker:pull.rows.item(num).time.speaker

                                  });

              //  }


                num = num + 1;
            }

            }

        });

}



function todays_sessions () {


         //showlogin.state = "Show";
       // console.log("Loading todays Sessions");
        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS SESSIONS (session TEXT,discription TEXT,location INT,speaker TEXT,time TEXT)');

            var d = new Date();

            var thedate = d.getMonth()+1+"/"+d.getDate()+"/"+d.getFullYear();


            var testStr = "SELECT  *  FROM SESSIONS WHERE time LIKE '"+thedate+"%'";

            var pull = tx.executeSql(testStr);



            today.clear();


           // var d = new Date();

           // var thedate = d.getMonth()+1+"/"+d.getDate()+"/"+d.getFullYear();


            if(pull.rows.length != 0) {

                var num = 0;

            while(pull.rows.length > num) {



                 if(thedate == pull.rows.item(num).time.split(",")[0]) {
                today.append ({
                                         type:"session",
                                         name:pull.rows.item(num).session,
                                         thelocation:pull.rows.item(num).location,
                                         time:pull.rows.item(num).time.split(",")[1],
                                         date:pull.rows.item(num).time.split(",")[0],
                                         //speaker:pull.rows.item(num).time.speaker

                                  });

                }


                num = num + 1;
            }

            }

        });

}

function speaker_info(lo) {


    switch(lo) {
        case 1:snapshot="Graphics/alderman.jpg";break;



        default:db.transaction(function(tx) {
            var testStr = "SELECT  *  FROM SPEAKERS WHERE 1";
             var pull = tx.executeSql(testStr);
           snapshot = pull.rows.item(lo-8).time;


 });break;

    }


    switch(lo) {
    case 1:info="<p>I am a cultural and historical geographer interested in public memory, popular culture, and heritage tourism in the U.S. South. Much of my work focuses on the rights of African Americans to claim the power to commemorate the past and shape cultural landscapes as part of a broader goal of social and spatial justice.</p><br> \n
                <p>My work has spanned many aspects of the southern landscape, including Civil Rights memorials (esp. streets named for Dr. King), slavery and plantation heritage tourism sites, NASCAR, Graceland and Memphis, Mayberry and film tourism, and even the cultural geography of kudzu.</p><br> \n
                <p>In August of 2012, I proudly joined the faculty at Univ. of Tennessee-Knoxville after serving at East Carolina University since 2000. I also held a tenure-track position at Georgia College (1998-2000), a visiting position at Georgia Southern University (1995-1996), and temporary faculty/graduate teaching positions at the University of Georgia (1990-1998).</p><br> \n
                <p>I am a devoted scholar-teacher who enjoys working and publishing with students, both at the undergraduate and graduate levels. I am also committed to conducting critical public scholarship that engages, informs, and helps the news media, government officials, community activists and organizations, and the broader citizenry.</p> <br> \n
                <p>I founded and co-coordinate the RESET (Race, Ethnicity, and Social Equity in Tourism) Initiative, and currently work with a team of five universities on a large NSF-funded project on race, slavery and plantation tourism. \n
                  I recently completed service on the Council of the Association of American Geographers (AAG) as Regional Councillor (representing the Southeast) and Chair of the Association’s Publications Committee. \n
                  I am a former President of the Southeastern Division of the AAG and a former co-editor of the peer-reviewed journal Southeastern Geographer.</p>";break;
        default: db.transaction(function(tx) {
                        var testStr = "SELECT  *  FROM SPEAKERS WHERE 1";
                         var pull = tx.executeSql(testStr);
            info = pull.rows.item(lo-8).discription+"\n"+pull.rows.item(lo-8).speaker;


             });break;
    }

}


function list_speakers () {

    var testStr = "SELECT  *  FROM SPEAKERS WHERE 1 ";
         //showlogin.state = "Show";
        console.log("Listing Speakers");
        db.transaction(function(tx) {

            tx.executeSql('CREATE TABLE IF NOT EXISTS SPEAKERS (session TEXT,discription TEXT,location INT,speaker TEXT,time TEXT)');

            var pull = tx.executeSql(testStr);

            guestlist.clear();


            guestlist.append ({

                                  name:"Derek H. Alderman",
                                  image:"Graphics/alderman.jpg",
                                  website:"http://geography.utk.edu/about-us/faculty/dr-derek-alderman/",
                                  thelocation:1,
                                  lo:1


                              });

            if(pull.rows.length != 0) {

                var num = 0;


               // console.log(pull.rows.length);

            while(pull.rows.length > num) {

                if(pull.rows.item(num).time != "") {

                    console.log(pull.rows.item(num).session);

               guestlist.append ({
                                         //type:"speaker",
                                         name:pull.rows.item(num).session,
                                         image:pull.rows.item(num).time,
                                         website:"www.google.com",
                                         lo:num+8,
                                         //info:
                                        // time:pull.rows.item(num).time.split(",")[1],
                                        // date:pull.rows.item(num).time.split(",")[0],
                                        // speaker:pull.rows.item(num).speaker.split(":")[0],


                                  });

                }


                num = num + 1;
            }

            }

        });

}

