import QtQuick 2.0

Item {




Image {
    source:"Graphics/bg.svg"
    width:parent.width
    height:parent.height
    opacity:0.04
    fillMode: Image.PreserveAspectFit

}

Image {
    source:"Graphics/bg.svg"
    width:parent.width
    height:parent.height
    opacity:0.05
    mirror:true
    fillMode: Image.PreserveAspectCrop

}

}
