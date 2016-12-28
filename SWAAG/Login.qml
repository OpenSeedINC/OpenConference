import QtQuick 2.0
import QtQuick.Controls 1.4

import "locations.js" as Scripts

import QtQuick.LocalStorage 2.0 as Sql



Item {

    id:window_container
    clip:true

    states: [
        State {
            name:"Show"

            PropertyChanges {
                target: window_container
                y:(parent.height - window_container.height) /2
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

    MouseArea {
        anchors.fill:parent
        onClicked: console.log(" ")
    }

    Rectangle {
        anchors.centerIn: parent
        width:parent.width * 0.99
        height:parent.height * 0.99
        border.color:"black"

        radius:5
        color:"white"

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
            text:"Create Account"
            color:"white"
            font.pixelSize: parent.height * 0.5
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width:parent.width * 0.95

        //height:parent.height * 0.98
        //anchors.centerIn: parent
        anchors.top:topborder.bottom
        anchors.topMargin:window_container.height * 0.03
        anchors.bottom:footer.top
        anchors.margins: parent.height * 0.01
        spacing:parent.height * 0.04


        Text {
            text:"Tell us a little about yourself"
            anchors.horizontalCenter: parent.horizontalCenter
            width:parent.width
            wrapMode:Text.WordWrap
        }

        Rectangle {

            width:parent.width
            height:parent.height * 0.01
            id:border

        color:"gray"

        }

        Row {
            width:parent.width

            Text {
                text:"First "
            }

        TextField {
            width:parent.width * 0.75
            //anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "First Name"
            text:firstName
            onTextChanged: firstName = text


            Rectangle {
                anchors.fill:parent
                border.color:"black"
                radius:5
                z:-1

            }
        }
        }

        Row {
            width:parent.width

            Text {
                text:"Last "
            }

        TextField {
            width:parent.width * 0.8
            //anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Last Name"
            text:lastName
            onTextChanged: lastName = text


            Rectangle {
                anchors.fill:parent
                border.color:"black"
                radius:5
                z:-1

            }
        }

        }

        Row {
            width:parent.width


        Text {
            text:"Age:"
        }

        TextField {
            width:parent.width * 0.2
            //anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "18+"
            text:userAge
            onTextChanged: userAge = text

            Rectangle {
                anchors.fill:parent
                border.color:"black"
                radius:5
                z:-1

            }
        }

        }

        Text {
            text:"From:"
        }

        TextField {
            width:parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "Denton Texas"
            text:homeTown
            onTextChanged: homeTown = text

            Rectangle {
                anchors.fill:parent
                border.color:"black"
                radius:5
                z:-1

            }
        }


    }

    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        id:footer
        width:parent.width* 0.98
        height:parent.height * 0.1
        anchors.bottom:parent.bottom
        anchors.bottomMargin: parent.height * 0.01

        Rectangle {
            anchors.fill:parent
            color:"white"
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right:parent.right
            anchors.margins: parent.height * 0.1
            width:okay.width * 1.4
            height:parent.height * 0.8
            border.color: "black"
            radius:5

        Text {
            anchors.centerIn: parent
                id:okay
            text:"Okay"
        }

        MouseArea {
            anchors.fill:parent
            onClicked:if(firstName.length > 1 && lastName.length > 1) {Scripts.save_userdata(firstName,lastName,userAge,homeTown),window_container.state = "Hide"}
        }

        }
    }

}
