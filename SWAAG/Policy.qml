import QtQuick 2.0

Item {
    id:window_container

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

    Rectangle {
        anchors.centerIn: parent
        width:parent.width * 0.9
        height:parent.height * 0.9
        radius:8
        clip:true
        border.color: "gray"

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
                text:"Privacy Policy Statement"
                color:"white"
                font.pixelSize: parent.height * 0.5
            }
        }


        Flickable {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:topborder.bottom
            anchors.bottom:footer.top
            anchors.margins: parent.height * 0.02
            width:parent.width * 0.95
            contentHeight: content.height
            clip:true

            Text {
                id:content
                text: "
<p>Among the types of Personal Data that this Application collects, by itself or through third parties, there are: Cookies, Usage Data, first name, last name and gender. Other Personal Data collected may be described in other sections of this privacy policy or by dedicated explanation text contextually with the Data collection. The Personal Data may be freely provided by the User, or collected automatically when using this Application.</p>
<p>Any use of Cookies - or of other tracking tools - by this Application or by the owners of third party services used by this Application, unless stated otherwise, serves to identify Users and remember their preferences, for the sole purpose of collecting data for scientific research. Failure to provide certain Personal Data may make it impossible for this Application to provide its services.</p>
<p>The Data Controller processes the Data of Users in a proper manner and shall take appropriate security measures to prevent unauthorized access, disclosure, modification, or unauthorized destruction of the Data. The Data processing is carried out using computers and/or IT enabled tools, following organizational procedures and modes strictly related to the purposes indicated. In addition to the Data Controller, in some cases, the Data may be accessible to certain types of persons in charge, involved with the operation of the site (legal, system administration) or external parties (such as third party technical service providers, mail carriers, hosting providers, IT companies, communications agencies) appointed, if necessary, as Data Processors by the Owner. The updated list of these parties may be requested from the Data Controller at any time.</p>
<p>The Data is processed at the Data Controller's operating offices and in any other places where the parties involved with the processing are located. For further information, please contact the Data Controller. The Data is kept for the time necessary to conduct scientific research, or stated by the purposes outlined in this document, and the User can always request that the Data Controller suspend or remove the data. The Data concerning the User is collected to allow the Owner to provide its services, as well as for the following purposes: Analytics.</p>
<p>The User's Personal Data may be used for legal purposes by the Data Controller, in Court or in the stages leading to possible legal action arising from improper use of this Application or the related services.</p>
<p>The User declares to be aware that the Data Controller may be required to reveal personal data upon request of public authorities.</p>
<p>In addition to the information contained in this privacy policy, this Application may provide the User with additional and contextual information concerning particular services or the collection and processing of Personal Data upon request.</p>"
                width:parent.width
                //height:parent.height
                wrapMode: Text.WordWrap
            }
        }



        Text {
            id:footer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom:parent.bottom
            text: "Tap here to continue"
            height:parent.height * 0.05
            MouseArea {
                anchors.fill:parent
                onClicked: window_container.state = "Hide",showlogin.state = "Show"
            }

        }
    }



}
