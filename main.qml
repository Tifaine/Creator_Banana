import QtQuick 2.9
import QtQuick.Window 2.2
import "ElementQML"

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
        color:"#f2f2f2"

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
                    pageCreationAction.visible = false
                    break
                case 2:
                    pageCreationAction.visible = true
                    break
                case 3:
                    pageCreationAction.visible = false
                    break
                case 4:
                    pageCreationAction.visible = false
                    break
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
    }
}



/*##^## Designer {
    D{i:3;anchors_y:134}
}
 ##^##*/
