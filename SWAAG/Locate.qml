import QtQuick 2.0

import QtPositioning 5.2

import "locations.js" as Scripts


Item {


    id:window_container
    clip:true

    property double lat: 0
    property double log: 0
    //property string collected: ""

    property string place_id: ""
    property string licence: ""
    property string osm_type: ""
    property string osm_id: ""


    property string display_name: ""
    property string house_number: ""
    property string road: ""
    property string city: ""

    property string county:""
    property string thestate:""
    property string postcode:""

    property string lastping:""

    states: [
        State {
            name:"Show"

            PropertyChanges {
                target: window_container
                //y:(parent.height - window_container.height) /2
                y:0
            }
        },

        State {
            name:"Hide"

            PropertyChanges {
                target: window_container
                y:parent.height
            }
        }

    ]

    transitions: [
        Transition {
            from: "Hide"
            to: "Show"
            reversible: true


            NumberAnimation {
                target: window_container
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

    ]

    state:"Hide"

    onStateChanged: { if(window_container.state == "Show") {if (positionSource.supportedPositioningMethods ===
                                             PositionSource.NoPositioningMethods) {
                                         positionSource.nmeaSource = "nmealog.txt";
                                         sourceText.text = "(filesource): " + printableMethod(positionSource.supportedPositioningMethods);
                                     }

                                     positionSource.update(); } else { }

    }


    Timer {
        interval:2000
        running: true
        repeat: false
        onTriggered:{
        if (positionSource.supportedPositioningMethods ===
                PositionSource.NoPositioningMethods) {
            positionSource.nmeaSource = "nmealog.txt";
            sourceText.text = "(filesource): " + printableMethod(positionSource.supportedPositioningMethods);
        }

        positionSource.update();
    }
    }

    Timer {
        interval:1000*200
        running: if(passive == 1 && lastName.length > 1) {true} else {false}
        repeat: true
        onTriggered: positionSource.update();
    }

    PositionSource {
            id: positionSource
            onPositionChanged: {lat = positionSource.position.coordinate.latitude;
                                log = positionSource.position.coordinate.longitude;
                                 Scripts.gps_stats(lat,log);
                                    Scripts.upload_stats(lastName,firstName,userAge,homeTown,lat+","+log);
                                    }

            onSourceErrorChanged: {
                if (sourceError == PositionSource.NoError)
                    return

                //console.log("Source error: " + sourceError)
                //activityText.fadeOut = true
                stop()
            }

            onUpdateTimeout: {
               }
        }


    Rectangle {
        anchors.fill: parent
        color:"white"
        border.color:"black"
    }

    Background {
        //anchors.fill: parent
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        width:parent.width * 0.6
        height:parent.height
    }

    Rectangle {
        id:topborder
        anchors.top:parent.top
        anchors.left: parent.left
        height:parent.height * 0.1
        width:parent.width
        color:"#4e4e4e"

        Rectangle {
            anchors.top:parent.bottom
            width:parent.width
            height:parent.height * 0.1
            color:"green"
        }

        Text {
            anchors.centerIn: parent
            text:"Location"
            color:"white"
            font.pixelSize: parent.height * 0.5
        }
    }


        Item {
            id:info
            anchors.top:topborder.bottom
            anchors.topMargin: parent.height * 0.01
            height:parent.height * 0.98 - topborder.height
            width:parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter



          /*  Text {
                text:place_id
                width:parent.width
                wrapMode: Text.WordWrap
            } */


            Text {
                id:local_title
                anchors.left:parent.left
                anchors.top:parent.top
                width:parent.width * 0.95
                text:display_name
                wrapMode:Text.WordWrap
                font.pixelSize: parent.height * 0.04

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width:parent.width * 0.98
                    height:parent.height * 0.01
                    color:"green"
                    anchors.top:parent.bottom
                }
            }

            Column {
                 anchors.right:parent.right
                 anchors.top:local_title.bottom
                 anchors.topMargin: parent.height * 0.06
                 width:parent.width * 0.50
                 clip:true

            Text {
                text:"Latitude: "+lat
                wrapMode:Text.WordWrap
                anchors.right:parent.right
                width:parent.width
                //font.pixelSize: parent.height * 0.8
            }
            Text {
                text:"Longitude: "+log
                wrapMode:Text.WordWrap
                anchors.right:parent.right
                 width:parent.width
                //font.pixelSize: parent.height * 0.8
            }

            }

            Column {
                anchors.top:local_title.bottom
                anchors.topMargin: parent.height * 0.06
                width:parent.width * 0.5
                anchors.left:parent.left



            Text {
                text:"Number: "+house_number

                width:parent.width
                wrapMode: Text.WordWrap
            }

            Text {
                text:"Road: "+road

                width:parent.width
                wrapMode: Text.WordWrap
            }

            Text {
                text:"City: "+city

                width:parent.width
                wrapMode: Text.WordWrap
            }

            Text {
                text:"County: "+county

                width:parent.width
                wrapMode: Text.WordWrap
            }

            Text {
                text:"State: "+thestate

                width:parent.width
                wrapMode: Text.WordWrap
            }

            Text {
                text:"ZipCode: "+postcode

                width:parent.width
                wrapMode: Text.WordWrap
            }

            }

            Text {
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom:parent.bottom
                anchors.bottomMargin: parent.height * 0.2
                text:"Last Ping on:"+lastping
                wrapMode: Text.WordWrap
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
            }


            Text {
                anchors.bottom:thelic.top
                text:osm_type+":"+osm_id
                anchors.right:parent.right
                width:parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: parent.height * 0.02
            }

            Text {
                id:thelic
                anchors.bottom:parent.bottom
                text:licence
                width:parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: parent.height * 0.02
            }

        }




}
