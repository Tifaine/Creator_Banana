import QtQuick 2.11
import QtQuick.Controls 2.3

Item {
    property bool isBlocant:false
    property string name:"Action"
    width:200
    height:30+listParam.count*35

    Component.onCompleted: listParam.clear()

    function addParam(nom, value)
    {
        listParam.append({_nom:nom,value:value, index:listParam.count})
    }


    Rectangle {
        id: fond
        color: "#ffffff"
        border.width: 1
        anchors.fill: parent

        Rectangle {
            id: fondEntete
            height: 25
            color: isBlocant==true?"pink":"transparent"
            border.width: 0
            anchors.right: parent.right
            anchors.rightMargin: 1
            anchors.left: parent.left
            anchors.leftMargin: 1
            anchors.top: parent.top
            anchors.topMargin: 1

            Rectangle {
                id: separationHeader
                height: 1
                color: "#000000"
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }

            Text {
                id: testNom
                text: name
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.bold: true
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                font.pixelSize: 14
            }
        }

        Repeater
        {
            id:repeaterParameter
            x: 0
            y: 200
            anchors.top: fondEntete.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            model:listParam

            Rectangle
            {
                id:rect
                height:35
                color:"transparent"
                anchors.right: repeaterParameter.right
                anchors.rightMargin: 0
                anchors.left: repeaterParameter.left
                anchors.leftMargin: 0
                anchors.top: repeaterParameter.top
                anchors.topMargin:35*index
                Text {
                    id: textFieldNomParam
                    text: _nom
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 16
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width/3+1
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin:2
                    anchors.bottom: parent.bottom
                }

                TextField {
                    id: textFieldDefaultValue
                    text: value
                    height:35
                    font.pixelSize: 16
                    anchors.right: parent.right
                    anchors.rightMargin:2
                    anchors.left: parent.left
                    anchors.leftMargin:  2*parent.width/3+5
                    anchors.top: parent.top
                    anchors.topMargin:2
                    anchors.bottom: parent.bottom
                }
            }
        }
    }
    ListModel
    {
        id:listParam
        ListElement{ _nom:"x" ; value:"0" ; index : 0}
    }
}






/*##^## Designer {
    D{i:1;anchors_height:200;anchors_width:200;anchors_x:"-19";anchors_y:73}
}
 ##^##*/
