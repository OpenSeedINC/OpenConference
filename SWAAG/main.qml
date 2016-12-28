import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtSensors 5.3

import QtQuick.LocalStorage 2.0 as Sql


import "locations.js" as Scripts

Window {
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("SWAAG Conference 2016")
    id:mainView



    property var db: Sql.LocalStorage.openDatabaseSync("UserInfo", "1.0", "Local UserInfo");


    property string cardname:""
    property string cardage:""
    property string cardlocation:""


     property string firstName: ""
     property string lastName: ""
     property int userAge: 0
     property string homeTown:""

    property int passive: 1

    property string devId: "Vag-01001011" //given by the OpenSeed server when registered
    property string appId: "SWAAG-2016" //given by the OpenSeed server when registered


    onClosing: {
      /*  if(viewpic.state == "Show") {viewpic.state = "Hide"}
        if(settings.visible == true) {
            thefooter.state ="Show"
                    postslist.clear()
                stream_reload.running = true
                get_stream.running = true
            settings.visible = false
        }
        if(viewfinder.state == "Show") {viewfinder.state = "Hide"

        } */

    close.accepted = false
    //if (contextMenuManager.menuVisible)
   // contextMenuManager.menuVisible = false
    }


    Timer {
        id:firstrun
        interval: 1
        repeat: false
        running: true
        onTriggered:Scripts.load_userdata(),Scripts.download_sessions(),Scripts.download_speakers()

    }


    Timer {
        id:todays
        interval: 10
        repeat: false
        running: true
        onTriggered:Scripts.list_speakers(),Scripts.todays_sessions()

    }


    Timer {
        id:todays_sync
        interval: 400000
        repeat: true
        running: true
        onTriggered:Scripts.download_sessions(),Scripts.download_speakers(),Scripts.todays_sessions()

    }

    Rectangle {
        anchors.fill: parent
        color:"white"
    }

    Background {
        anchors.fill: parent
    }

Item {
    id:banner
    anchors.top:parent.top
    anchors.left:parent.left
    width:parent.width
    height:parent.height * 0.15
    /*Image {
        anchors.fill:parent
    source:"Graphics/SWAAG Banner.png"
    fillMode: Image.PreserveAspectFit
    } */

    Rectangle {
        anchors.fill:parent
        color:"#404040"

        Rectangle {
            anchors.bottom:parent.bottom
            width:parent.width
            height:parent.height * 0.1
            color:"green"
        }
    }

    Image {
        id:logoleft
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width:parent.height * 0.7
        height:parent.height * 0.7
        source: "Graphics/seal.png"
    }

        Text {
            id:maintitle
            text:"SWAAG 2016"
            anchors.left:logoleft.right
            anchors.margins:parent.height* 0.07
            anchors.right:logoright.left
            //anchors.verticalCenter: parent.verticalCenter
            anchors.top:parent.top
            color:"White"
            font.pixelSize: parent.height * 0.35
            horizontalAlignment: Text.AlignHCenter

        }

        Text {
            text: "Join us in historic downtown Denton for an affair on the Square"
            width:maintitle.width
            color:"white"
            anchors.bottom:parent.bottom
            anchors.left:maintitle.left
           anchors.bottomMargin:parent.height* 0.1
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.height * 0.14
        }


    Image {
        id:logoright
        anchors.right:parent.right
        anchors.verticalCenter: parent.verticalCenter
        source:"Graphics/unt-1890-banner.svg"
        width:parent.height * 0.7
        height:parent.height * 0.7
        fillMode:Image.PreserveAspectFit

    }
}




ListView {
    id:centercolumn
    anchors.top:banner.bottom
    anchors.topMargin:parent.height * 0.01
    width:parent.width
    height:footer.y
    clip:true
    spacing: parent.height * 0.01

    model: ListModel {
        id:eventlocation

        ListElement {
            type:"title"
            name:"Locations"
            badge:"Graphics/gps.svg"

        }

        ListElement {
            type:"location"
            name:"UNT on the Square"
            address:"109 N Elm St, Denton, TX 76201"
            image:"Graphics/UNTSquare.jpg"
            website:"https://untonthesquare.unt.edu/"
            overlaycolor:"green"
            lo:1
        }

        ListElement {
            type:"location"
            name:"Denton Courthouse"
            address:"110 W Hickory St, Denton, TX 76201"
            image:"Graphics/CourtHouse.jpg"
            website:"http://www.cityofdenton.com/visitors/denton-history/courthouse-on-the-square"
            overlaycolor:"gray"
            lo:2
        }

        ListElement {
            type:"location"
            name:"Mullberry Street Cantina"
            address:"110 W Mulberry St, Denton, TX 76201"
            image:"Graphics/MSC.jpg"
            website:"http://mulberrystcantina.com/"
            overlaycolor:"purple"
            lo:3
        }

        ListElement {
            type:"location"
            name:"UNT – EESAT"
            address:"1704 W. Mulberry St.Denton, TX 76201"
            image:"Graphics/ESSATJPG"
            website:"http://unt.edu/"
            overlaycolor:"brown"
            lo:4
        }

        ListElement {
            type:"title"
            name:"Guest Speakers"
            badge:"Graphics/account.svg"

        }

        ListElement {
            type:"grid"
            list:1
        }

        ListElement {
            type:"title"
            name:"Todays Sessions"
            badge:"Graphics/calendar-today.svg"

        }

        ListElement {
            type:"session"

        }

       /* ListElement {
            type:"buff"
        }
        ListElement {
            type:"buff"
        }
        ListElement {
            type:"buff"
        }
        ListElement {
            type:"buff"
        }ListElement {
            type:"buff"
        }
        ListElement {
            type:"buff"
        }ListElement {
            type:"buff"
        }
        ListElement {
            type:"buff"
        }ListElement {
            type:"buff"
        }
        ListElement {
            type:"buff"
        } */

    }

    delegate:  Item {
                 width:parent.width
                 height: switch(type) {

                         case "title":mainView.height * 0.06;break;
                         case "grid":mainView.height * 0.4;break;
                         //case "grid":thegrid.contentHeight;break;
                         case "session":mainView.height * 0.4 + todaylist.height;break;
                    default:mainView.height * 0.15;break;
                         }

            Item {
                visible:if(type == "location") {true} else {false}
                width:parent.width
                height:parent.height

                clip:true

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    //border.color:black
                    radius:6
                    width:parent.width * 0.96
                    height:parent.height * 0.9
                    color:overlaycolor
                    opacity:0.7
                }

        Image {
             anchors.horizontalCenter: parent.horizontalCenter
            source:image
            opacity:0.5
            width:parent.width * 0.96
            height:parent.height * 0.9
            fillMode:Image.PreserveAspectCrop

        }

        Text {
            //anchors.centerIn: parent
            anchors.left:parent.left
            anchors.top:parent.top
            //anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin:parent.height * 0.2
            anchors.topMargin: parent.height * 0.1
            text:name
            width:parent.width
            wrapMode: Text.WordWrap
            color:"white"
            font.pixelSize: parent.height * 0.3
        }

        Text {
            anchors.right:parent.right
            anchors.bottom:parent.bottom
            anchors.rightMargin:parent.height * 0.3
            anchors.bottomMargin: parent.height * 0.1
            text:address
            width:parent.width * 0.5
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignRight
            color:"white"
            font.pixelSize: parent.height * 0.15

        }

        Image {
             anchors.horizontalCenter: parent.horizontalCenter
                source:"Graphics/border.svg"
                width:parent.width * 0.98
                height:parent.height * 0.9

        }

        MouseArea {
            anchors.fill:parent
            onClicked:slider.type = "location",slider.website = website,slider.address = address,slider.location = lo,slider.title = name,slider.state = "Show"
        }

    }

       Item {
            visible:if(type == "title") {true} else {false}
            width:parent.width
            height:parent.height
            clip:true

            Text {
                id:localname
                text:name
                font.pixelSize: parent.height * 0.7
                width:parent.width

                Rectangle {
                    anchors.top:parent.bottom
                    //anchors.topMargin: mainView.height * 0.01
                    color:"lightgray"
                    width:parent.width
                    height:parent.height * 0.05
                }

                Rectangle {
                    anchors.top:parent.top
                    //anchors.topMargin: -mainView.height * 0.01
                    color:"lightgray"
                    width:parent.width
                    height:parent.height * 0.05
                }
            }

            Image {
                source:badge
                anchors.right:parent.right
                anchors.rightMargin: parent.height * 0.1
                width:parent.height * 0.8
                height:parent.height * 0.8
                anchors.verticalCenter: localname.verticalCenter
            }

        }

        Item {
            visible:if(type == "grid") {true} else {false}
            width:parent.width
            height:parent.height
           // height:thegrid.contentHeight

            clip:true

            GridView {
                id:thegrid
                width:parent.width
                height:parent.height
               cellHeight: parent.height / 2
               cellWidth: parent.height /3
               flow:GridView.FlowTopToBottom

                //cellHeight: 300
               // cellWidth: 150

                model: guestlist

                delegate: Item {
                    width:thegrid.cellWidth
                    height:thegrid.cellHeight

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top:parent.top
                        width:parent.width * 0.8
                        height:parent.height * 0.78
                        radius:5
                        color:"white"
                        //border.color: "black"
                        id:imageback
                        clip:true

                        Image {
                            anchors.centerIn: parent
                            source:image
                            fillMode: Image.PreserveAspectFit
                            width:parent.height * 0.95
                            height:parent.height* 0.95

                        }

                        Image {
                             anchors.centerIn: parent
                                source:"Graphics/border.svg"
                                width:parent.width * 1
                                height:parent.height * 1

                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: slider.type = "speaker",slider.website = website,slider.location = lo,slider.title = name,slider.state = "Show"
                        }


                    }

                    Text {
                        anchors.top:imageback.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:name
                        width:parent.width
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        clip:true
                        font.pixelSize: parent.height * 0.1
                    }
                }
            }
        }

        Item {
            visible:if(type == "session") {true} else {false}
            width:parent.width
            height:todaylist.contentHeight

            clip:true



            ListView {
                id:todaylist
                width:parent.width
                height:contentHeight
                spacing:mainView.height * 0.01

                model: today


                delegate: Item {

                    width:mainView.width
                    height:(mainView.height * 0.07) + thename.height

                    clip:true

                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color:"black"
                        radius:6
                        width:parent.width * 0.96
                        height:parent.height
                        //color:overlaycolor

                    }

                   Rectangle {
                        id:sortcolor
                        //anchors.left:parent.left
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.leftMargin:parent.height * 0.12
                        height:(mainView.height * 0.1) * 0.25
                        //anchors.verticalCenter: parent.verticalCenter
                        anchors.bottom: parent.bottom
                        color:switch(thelocation) {
                              case 1:"green";break;
                              case 2:"gray";break;
                              case 3:"purple";break;
                              case 4:"brown";break;
                              default:"red";break;
                              }
                        opacity: 0.5

                        width:parent.width * 0.96
                    }



            Text {
                id:thename
                //anchors.centerIn: parent
              //  anchors.left:sortcolor.right
                anchors.left:parent.left
                anchors.leftMargin: parent.width * 0.05
                anchors.top:parent.top
                //anchors.verticalCenter: parent.verticalCenter
                //anchors.leftMargin:(window_container.height * 0.1) * 0.2
                anchors.topMargin: (mainView.height * 0.1) * 0.1
                text:name
                width:parent.width * 0.7
                wrapMode: Text.WordWrap
                color:"black"
                //font.pixelSize: (window_container.height * 0.05)
            }

            Text {
                //anchors.left:sortcolor.right
                anchors.left:parent.left
                anchors.bottom:parent.bottom
                //anchors.leftMargin:parent.height * 0.2
                anchors.leftMargin: parent.width * 0.08
                //anchors.bottomMargin: parent.height * 0.1
                text:switch(thelocation) {
                     case 1:"UNT on the Square";break;
                     case 2:"Denton Courthouse";break;
                     case 3:"Mullberry Street Cantina";break;
                     case 4:"UNT - ESSAT";break;
                     default:"Unknown";break;
                     }
                width:parent.width * 0.5
                wrapMode: Text.WordWrap
                color:"black"
                font.pixelSize: (mainView.height * 0.1) * 0.2


               /* Text {
                    anchors.left:parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text:speaker
                    color:"black"
                    font.pixelSize: (mainView.height * 0.1) * 0.2
                } */
            }

            Rectangle {
                anchors.right:thedate.left
                anchors.rightMargin:parent.height * 0.1
                height:parent.height * 0.9
                anchors.verticalCenter: parent.verticalCenter
                color:"gray"
                width:(mainView.height * 0.1) * 0.01
            }

            Text {
                id:thetime
                anchors.right:parent.right
                anchors.top:parent.top
                anchors.topMargin:(mainView.height * 0.1) * 0.1
                anchors.rightMargin: (mainView.height * 0.1) * 0.2
                text:time
                font.pixelSize: (mainView.height * 0.1) * 0.2
            }
            Text {
                id:thedate
                anchors.right:parent.right
                anchors.top:thetime.bottom
                anchors.rightMargin:(mainView.height * 0.1) * 0.2
                anchors.topMargin:(mainView.height * 0.1) * 0.1
                text:date
                font.pixelSize: (mainView.height * 0.1) * 0.2
            }



         }

            }
        }

    }


}


Locate {
    id:loca
    width:parent.width
    height:parent.height-footer.height
    state:"Hide"

}

Credits {
    id:thecredits
    state:"Hide"
    width:parent.width
    height:parent.height-footer.height
    anchors.horizontalCenter: parent.horizontalCenter
}


Item {
    id:footer
    anchors.bottom:parent.bottom
    width:parent.width
    height:parent.height * 0.1

    Rectangle {
        width:parent.width
        height:parent.height
        color:"lightgray"
        opacity:0.7
    }

    Rectangle {
        anchors.top:parent.top
        width:parent.width
        height:parent.height * 0.03
        id:border

    color:"gray"

    }


        Rectangle {
            anchors.left:parent.left
            anchors.leftMargin:parent.height * 0.1
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.9
            height:parent.height * 0.9
            color:if(settingsmenu.visible == false) {"white"} else {"#404040"}
            border.color:"black"
            radius:8

            Image {
                anchors.centerIn: parent

                source:"Graphics/navigation-menu.svg"
                fillMode: Image.PreserveAspectFit
                width:parent.height * 0.8
                height:parent.height * 0.8
            }

            MouseArea {anchors.fill:parent
                onClicked:if(settingsmenu.visible == false) {settingsmenu.visible =true} else {settingsmenu.visible = false}
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 2
            height:parent.height * 0.9
            color:if(loca.state == "Hide") {"white"} else {"#404040"}
            border.color:"black"
            radius:8

            Image {
                anchors.centerIn: parent
                source:"Graphics/gps.svg"
                fillMode: Image.PreserveAspectFit
                width:parent.height * 0.8
                height:parent.height * 0.8
            }

            MouseArea {anchors.fill:parent
                onClicked:if(loca.state == "Hide") {loca.state = "Show"} else {loca.state = "Hide"}
            }
        }

        Rectangle {
            anchors.right:parent.right
            anchors.rightMargin:parent.height * 0.1
            anchors.verticalCenter: parent.verticalCenter
            width:parent.height * 0.9
            height:parent.height * 0.9
            color:if(thecredits.state == "Hide") {"white"} else {"#404040"}
            border.color:"black"
            radius:8

            Image {
                anchors.centerIn: parent
                source:"Graphics/info.svg"
                fillMode: Image.PreserveAspectFit
                width:parent.height * 0.8
                height:parent.height * 0.8
            }

            MouseArea {anchors.fill:parent
                onClicked:if(thecredits.state == "Hide") {thecredits.state ="Show"} else {thecredits.state = "Hide"}
            }
        }






}

Policy {
    id:showpolicy
    anchors.horizontalCenter: parent.horizontalCenter
    width:parent.width * 0.99
    height:parent.height * 0.99
    state:"Hide"
}

Login {
    id:showlogin
    anchors.horizontalCenter: parent.horizontalCenter
    width:parent.width * 0.80
    height:parent.height * 0.60
    state:"Hide"
}

SideSlide {
    id:slider
    width:parent.width
    height:parent.height
    state:"Hide"
}

Menu {
    id:settingsmenu
    visible:false
    anchors.bottom:footer.top
    anchors.left:parent.left
}





ListModel {
    id:guestlist

    ListElement {
        name:"Derek H. Alderman"
        image:"Graphics/alderman.jpg"
        website:"http://geography.utk.edu/about-us/faculty/dr-derek-alderman/"
        thelocation:1
        lo:1
    }

}

ListModel {
    id:today


    ListElement {
        type:"session"
        name:"Test Session 1"
        thelocation:5
        time:"10:00AM"
        date:"09-29-16"

    }



}

}
