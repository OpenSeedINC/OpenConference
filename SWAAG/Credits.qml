import QtQuick 2.0

Item {
    id:window_container

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


    Rectangle {
        width:parent.width
        height:parent.height
        color:"white"
        border.color:"#404040"
    }

    Background {
        anchors.fill: parent
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
            text:"Credits"
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
            id:theinfo
            width:parent.width
            spacing: parent.height * 0.03


            Text {
                text:"<B>Created by:</B>"
                font.pixelSize:window_container.height * 0.05
            }

            Rectangle {
                width:parent.width
                height:window_container.height * 0.005
                color:"green"
            }

            Text {
                text:"<B>Company: </B>Vague Entertainment"
                font.pixelSize:window_container.height * 0.03
            }
            Text {
                text:"Website:www.vagueentertainment.com"
                font.pixelSize:window_container.height * 0.02
                 wrapMode: Text.WordWrap
                width:parent.width * 0.8
                //horizontalAlignment: Text.AlignRight
            }

            Text {
                text:"Contact:ideas@vagueentertainment.com"
                font.pixelSize:window_container.height * 0.02
                 wrapMode: Text.WordWrap
                width:parent.width * 0.8
                //horizontalAlignment: Text.AlignRight
            }



            Text {
                text:"<B>Programmer: </B>Benjamin Flanagin"
                font.pixelSize:window_container.height * 0.03
            }
            Text {
                text:"<B>Website: </B>http://benjamin.vagueentertainment.com/"
                font.pixelSize:window_container.height * 0.02
                 wrapMode: Text.WordWrap
                 width:parent.width * 0.8
               // horizontalAlignment: Text.AlignRight
            }
            Text {
                text:"<B>Contact: </B>bflanagin@vagueentertainment.com"
                font.pixelSize:window_container.height * 0.02
                 wrapMode: Text.WordWrap
                 width:parent.width * 0.8
                //horizontalAlignment: Text.AlignRight
            }

            Rectangle {
                width:parent.width
                height:window_container.height * 0.005
                color:"green"
            }


            Text {
                text:"<B>Sources:</B>"
                font.pixelSize:window_container.height * 0.05
            }


            Rectangle {
                width:parent.width
                height:window_container.height * 0.005
                color:"green"
            }

            Text {
                text:"<B>Icons: </B>Ubuntu Touch Suru Theme"
                font.pixelSize:window_container.height * 0.03
            }
            Text {
                text:"Special thanks to Ubuntu and the work they have done on this amazing icon set."
                font.pixelSize:window_container.height * 0.02
                 wrapMode: Text.WordWrap
                width:parent.width * 0.8
                //horizontalAlignment: Text.AlignRight
            }

            Text {
                text:"<B>Images: </B>Found on Google"
                font.pixelSize:window_container.height * 0.03
            }
            Text {
                text:"Images used in this application are found via public searches."
                font.pixelSize:window_container.height * 0.02
                 wrapMode: Text.WordWrap

                width:parent.width * 0.8
                //horizontalAlignment: Text.AlignRight
            }

            Text {
                text:"<B>Created with: </B>Qt on Ubuntu "
                font.pixelSize:window_container.height * 0.03
            }
            Text {
                text:"Developed on Ubuntu using Qt. Sources will be available per opensource licenses. Please email ideas@vagueentertainment.com for access to the code."
                font.pixelSize:window_container.height * 0.02
                wrapMode: Text.WordWrap

                width:parent.width * 0.7
                //horizontalAlignment: Text.AlignRight
            }



        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width:parent.width
        height:parent.height * 0.01
        color:"green"
        radius:5

    }

}
