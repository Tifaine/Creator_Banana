import QtQuick 2.0

Item {
    id: element1
    width: 1400
    height: 800

    SidePanelComportement {
        id: sidePanelComportement
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
}

/*##^## Designer {
    D{i:1;anchors_x:0;anchors_y:0}
}
 ##^##*/
