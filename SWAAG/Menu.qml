import QtQuick 2.0
import QtQuick.Controls 1.4

Item {

    width:parent.width
    height:parent.height * 0.1


    Rectangle {
        width:parent.width
        height:parent.height
        //color:"lightgray"
        //opacity:0.7
    }

    Rectangle {
        anchors.top:parent.top
        width:parent.width
        height:parent.height * 0.04
        id:border

    color:"gray"

    }

    Text {
        id:optiontitle
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.height * 0.3
        text:"Automatic Location Tracking:"
    }
    CheckBox {
        anchors.left:optiontitle.right
        anchors.verticalCenter: optiontitle.verticalCenter
        checked:true
        height:optiontitle.height

    }


}
