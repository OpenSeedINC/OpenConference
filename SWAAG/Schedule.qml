import QtQuick 2.0
import "locations.js" as Scripts

Item {

id:window_container

property int location:0
property string host:""
//property int localnum: 0

states: [
    State {
        name:"Show"

        PropertyChanges {
            target: window_container
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


onStateChanged: if(window_container.state == "Show") {if(location <8) {Scripts.list_sessions(location,Date())} else {Scripts.list_host(host,location,Date()) }}

Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom:parent.top
    width:localbutton.width * 1.2
    height:parent.height * 0.05
    color:"#404040"
    border.color:"#404040"

    Text {
        id:localbutton
        anchors.centerIn: parent
        text:switch(location) {
             case 1:"UNT on the Square's Event Schedule";break;
             case 2:"Denton Courthouse's Event Schedule";break;
             case 3:"Mullberry Street Cantina's Event Schedule";break;
             case 4:"UNT - ESSAT's Event Schedule";break;
             default:"Event Schedule";break;
             }
        color:"white"
        font.pixelSize: parent.height * 0.4
    }

    MouseArea {
        anchors.fill: parent
        onClicked:window_container.state = "Show"
    }
}

Rectangle {
    anchors.fill:parent
    color:"white"

    Background {
       anchors.bottom:parent.bottom
       anchors.right:parent.right
       width:parent.width
       height:parent.height * 0.6
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
            text:"Schedule"
            color:"white"
            font.pixelSize: parent.height * 0.5
        }
    }

    ListView {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:topborder.bottom
        anchors.bottom:parent.bottom
        anchors.topMargin: parent.height * 0.02
        anchors.bottomMargin: parent.height * 0.02

        //anchors.right:parent.right
        width:parent.width
        //contentHeight: theinfo.height +theinfo.y
        clip:true
        spacing:window_container.height * 0.01

       model: ListModel {
           id:schedulelist


       }

       delegate:
           Item {

           width:window_container.width
           height:(window_container.height * 0.07) + thename.height

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
               height:(window_container.height * 0.1) * 0.25
               //anchors.verticalCenter: parent.verticalCenter
               anchors.bottom: parent.bottom
               color:switch(location) {
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
       anchors.topMargin: (window_container.height * 0.1) * 0.1
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
       text:switch(location) {
            case 1:"UNT on the Square";break;
            case 2:"Denton Courthouse";break;
            case 3:"Mullberry Street Cantina";break;
            case 4:"UNT - ESSAT";break;
            default:"Unknown";break;
            }
       width:parent.width * 0.5
       wrapMode: Text.WordWrap
       color:"black"
       font.pixelSize: (window_container.height * 0.1) * 0.2


      /* Text {
           anchors.left:parent.right
           anchors.verticalCenter: parent.verticalCenter
           text:speaker
           color:"black"
           font.pixelSize: (window_container.height * 0.1) * 0.2
       } */
   }

   Rectangle {
       anchors.right:thedate.left
       anchors.rightMargin:parent.height * 0.1
       height:parent.height * 0.9
       anchors.verticalCenter: parent.verticalCenter
       color:"gray"
       width:(window_container.height * 0.1) * 0.01
   }

   Text {
       id:thetime
       anchors.right:parent.right
       anchors.top:parent.top
       anchors.topMargin:(window_container.height * 0.1) * 0.1
       anchors.rightMargin: (window_container.height * 0.1) * 0.2
       text:time
       font.pixelSize: (window_container.height * 0.1) * 0.2
   }
   Text {
       id:thedate
       anchors.right:parent.right
       anchors.top:thetime.bottom
       anchors.rightMargin:(window_container.height * 0.1) * 0.2
       anchors.topMargin:(window_container.height * 0.1) * 0.1
       text:date
       font.pixelSize: (window_container.height * 0.1) * 0.2
   }



}

    }
}

Rectangle {
    anchors.bottom: parent.bottom
    width:parent.width
    height:parent.height * 0.01
    color:"green"
    radius:5

Rectangle {
anchors.bottom:parent.bottom
anchors.horizontalCenter: parent.horizontalCenter
width:parent.width * 0.5
height:parent.height * 4
color:"#404040"
radius:5

MouseArea {
    anchors.fill:parent
    onClicked:window_container.state = "Hide"
}
}

}

}
