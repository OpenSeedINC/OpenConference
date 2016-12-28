import QtQuick 2.0
import "locations.js" as Lo

Item {

id:window_container

property string type:"location"

property string title:""
property string info:""
property string snapshot:""
property int location:1

property string website:""
property string address:""

onStateChanged: if(window_container.state == "Show") {if(type == "location") {Lo.location_info(location)} else {Lo.speaker_info(location)}
                } else {}

states: [
    State {
        name:"Show"

        PropertyChanges {
            target: window_container
            x:0
        }
    },

    State {
        name:"Hide"

        PropertyChanges {
            target: window_container
            x:parent.width
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
            property: "x"
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

]

state:"Hide"

Rectangle {
    anchors.centerIn: parent
    width:parent.width
    height:parent.height
    radius:8
    clip:true
    border.color: "gray"

}

Background {
    anchors.fill:parent
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
        text:title
        color:"white"
        font.pixelSize: parent.height * 0.5
    }
}


    Flickable {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top:topborder.bottom
        anchors.bottom:parent.bottom
        anchors.margins: parent.height * 0.02
        anchors.right:parent.right
        width:parent.width * 0.95
        contentHeight: theinfo.height +theinfo.y
        clip:true

        Column {
            width:parent.width
            spacing: parent.height * 0.02


        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source:snapshot
            width:parent.width * 0.9
            height:window_container.height * 0.25
            fillMode: Image.PreserveAspectFit


        }

        Item {
            width:parent.width
            height:window_container.height * 0.06

            Rectangle {
                anchors.bottom:parent.top
                width:parent.width
                height:window_container.height * 0.003
                color:"green"
            }

            Rectangle {
                anchors.top:parent.bottom
                width:parent.width
                height:window_container.height * 0.003
                color:"green"
            }

            Image {
                id:gps
                anchors.right:parent.right
                height:parent.height * 0.8
                width:parent.height * 0.8
                source:"Graphics/gps.svg"
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill:parent
                    onClicked:Qt.openUrlExternally("http://maps.google.com/?q="+address)
                }
            }

            Image {
                id:web
                anchors.left:parent.left
                height:parent.height * 0.8
                width:parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                source:"Graphics/stock_website.svg"

                MouseArea {
                    anchors.fill:parent
                    onClicked:Qt.openUrlExternally(website)
                }
            }

        }
        Text {
            text:"About:"
            width:parent.width * 0.92
            anchors.right:parent.right
            font.pixelSize: window_container.height * 0.03
        }


       Text {
            id:theinfo
          text:info
          wrapMode: Text.WordWrap
          width:parent.width * 0.92
          anchors.right:parent.right

       }


        }
    }


    Rectangle {
        anchors.bottom: parent.bottom
        width:parent.width * 0.01
        height:parent.height * 0.90
        color:"green"
        radius:5

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    width:parent.width * 5
    height:parent.height * 0.2
    color:"#404040"
    radius:5

    MouseArea {
        anchors.fill:parent
        onClicked:window_container.state = "Hide"
    }
}

    }


    Schedule {
        location: window_container.location
        width:parent.width
        height:parent.height
        state:"Hide"
        host:title
    }


}
