import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: element1
    width: 200
    height: 800

    Component.onCompleted:
    {
        refresh()
    }

    function refresh()
    {
        listComportement.clear();
        for(var i=0;i<gestTypeAction.getNbAction();i++)
        {
            listComportement.append({_nom:gestTypeAction.getNomAction(i), index:listComportement.count})
        }
    }

    ListModel
    {
        id:listComportement
        ListElement{ _nom:"Deplacement" ; index : 0}
    }

    Rectangle
    {
        id:rectangle1
        anchors.fill: parent
        color:"transparent"
        Flickable
        {
            id: flickable
            property real echelle :1.0
            anchors.fill: parent
            contentWidth: 150; contentHeight: 20000
            contentX: 0
            contentY:0

            ScrollBar.vertical: ScrollBar {
                parent: flickable.parent
                anchors.top: flickable.top
                anchors.left: flickable.right
                anchors.leftMargin: -10
                anchors.bottom: flickable.bottom
            }
            ScrollBar.horizontal: ScrollBar {
                parent: flickable.parent
                anchors.left: flickable.left
                anchors.right: flickable.right
                anchors.bottom: flickable.bottom
            }

            Repeater
            {
                id:repeaterParameter
                model:listComportement
                anchors.fill: parent
                Rectangle
                {
                    Component.onCompleted: console.log(index,anchors.topMargin)
                    id:rect
                    height:50
                    width:100
                    color:"transparent"
                    radius: 1
                    border.width: 1
                    anchors.left: repeaterParameter.left
                    anchors.leftMargin: (index%2)==1?100:0
                    anchors.top: repeaterParameter.top
                    anchors.topMargin:(index%2)==1?(index==1?0:(Math.floor(index/2))*50):((index/2)*50)
                    Text {
                        id: nomComportement
                        text: _nom
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                }


            }
        }

    }

    Rectangle {
        id: rectangle

        width: 1
        color: "#000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
}


