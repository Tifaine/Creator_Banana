import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "ElementQML"
import "ElementGestionComportement"

Window {
    id: window
    visible: true
    width: 1500
    height: 800
    title: qsTr("RCO_Banana Creator")

    Rectangle
    {
        id: rectangle
        anchors.fill: parent
        LinearGradient {
            anchors.right: parent.right
            anchors.rightMargin: parent.width/2
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            start: Qt.point(0, 0)
            end: Qt.point(parent.width/2, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#000000" }
                GradientStop { position: 1.0; color: "#000022" }
            }
        }

        LinearGradient {
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: parent.width/2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            start: Qt.point(parent.width/2, 0)
            end: Qt.point(0, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#000000" }
                GradientStop { position: 1.0; color: "#000022" }
            }
        }

        SidePanel {
            id: sidePanel
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            onChangeAffichage:
            {
                switch(nb)
                {
                case 1:
                {
                    pageCreationAction.visible = false
                    mainPageComportement.visible = true
                    break
                }
                case 2:
                {
                    pageCreationAction.visible = true
                    mainPageComportement.visible = false
                    break
                }
                case 3:
                {
                    pageCreationAction.visible = false
                    mainPageComportement.visible = false
                    break
                }
                case 4:
                {
                    pageCreationAction.visible = false
                    mainPageComportement.visible = false
                    break
                }
                default:
                    break
                }
            }
        }



        PageCreationAction {
            id: pageCreationAction

            visible:false
            anchors.left: sidePanel.right
            anchors.leftMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }

        MainPageComportement {

            id: mainPageComportement
            visible:true
            anchors.left: sidePanel.right
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
        }
    }
}





/*##^## Designer {
    D{i:3;anchors_y:134}
}
 ##^##*/
