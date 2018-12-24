import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: element
    height:600
    width:100
    signal changeAffichage(var nb)
    property int indiceAffiche:1
    Column {
        id: column
        width: 100
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        ColumnLayout {
            id: rowLayout1
            width: 100
            height: column.height/3

            MouseArea
            {
                id: mouseArea
                Layout.fillHeight: true
                Layout.fillWidth: true
                onClicked:
                {
                    indiceAffiche=1
                    changeAffichage(1)
                }
                Rectangle {
                    id: rectangle5

                    anchors.fill: parent
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color:indiceAffiche==1?"#262626":"transparent"
                }
                Rectangle {
                    id: rectangle1
                    height: 1
                    color: "#000000"
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: rectangle5.bottom
                    anchors.topMargin: 0
                    Layout.preferredHeight: 1
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                }

                Text {
                    id: element1
                    text: qsTr("Comportement")
                    anchors.bottomMargin: 1
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pixelSize: 12
                }


            }

        }

        ColumnLayout {
            id: rowLayout
            width: 100
            height: column.height/3

            MouseArea
            {
                id: mouseArea1
                Layout.fillHeight: true
                Layout.fillWidth: true
                onClicked:
                {
                    indiceAffiche=2
                    changeAffichage(2)
                }
                Rectangle {
                    id: rectangle4
                    color:indiceAffiche==2?"#262626":"transparent"
                    anchors.bottomMargin: 1
                    anchors.fill: parent
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
                Text {
                    id: element2
                    text: qsTr("Création action")
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pixelSize: 12
                }

                Rectangle {
                    id: rectangle2
                    height: 1
                    color: "#000000"
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: rectangle4.bottom
                    anchors.topMargin: 0
                    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                    Layout.preferredHeight: 1
                    Layout.fillWidth: true
                }

            }
        }

        ColumnLayout {
            id: rowLayout3
            width: 100
            height: column.height/3

            MouseArea
            {
                Layout.fillHeight: true
                Layout.fillWidth: true
                onClicked:
                {
                    indiceAffiche=3
                    changeAffichage(3)
                }

                Rectangle {
                    id: rectangle3
                    color:indiceAffiche==3?"#262626":"transparent"
                    anchors.topMargin: 1
                    anchors.fill: parent
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Text {
                    id: element4
                    text: qsTr("Live")
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pixelSize: 12
                }
            }
        }

    }

    Rectangle {
        id: rectangle
        width: 1
        color: "#000000"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: column.right
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
}



























/*##^## Designer {
    D{i:5;anchors_x:0;anchors_y:199}D{i:9;anchors_width:200;anchors_x:0;anchors_y:199}
D{i:14;anchors_x:0;anchors_y:103}D{i:10;anchors_height:200;anchors_x:"-248";anchors_y:155}
}
 ##^##*/
