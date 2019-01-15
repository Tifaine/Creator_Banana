import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: element1
    width: 200
    height: 800
    signal creerBloc(string nom)

    Component.onCompleted:
    {
        refresh()
    }

    Connections
    {
        target:gestTypeAction
        onFinUpdate:refresh();
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

        function updateColor(indice)
        {
            behaviorSelected = indice
        }

        property int behaviorSelected:-1
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
                    id:rect
                    height:40
                    width:90
                    //color:rectangle1.behaviorSelected==index?"#262626":"transparent"

                    color: "#00ffffff"
                    radius: 10
                    border.color: "#ffffff"
                    border.width: 1
                    anchors.left: repeaterParameter.left
                    anchors.leftMargin: (index%2)==1?105:5
                    anchors.top: repeaterParameter.top
                    anchors.topMargin:(index%2)==1?(index==1?0:(Math.floor(index/2))*50)+5:((index/2)*50)+5

                    Rectangle
                    {
                        color: "#0cfdfdfd"
                        radius: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 3
                        anchors.left: parent.left
                        anchors.leftMargin: 3
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 3
                        anchors.top: parent.top
                        anchors.topMargin: 3
                        Text {
                            id: nomComportement
                            text: _nom
                            color:rectangle1.behaviorSelected==index?"white":"white"
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }

                        Menu
                        {
                            id:menu
                            MenuItem
                            {
                                text: "Ajouter action"
                                onTriggered: creerBloc(_nom)
                            }
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            z:1
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked:
                            {
                                rectangle1.updateColor(index)
                                if (mouse.button === Qt.RightButton)
                                {
                                    menu.open()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: rectangle
        width: 1
        color: "white"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
}


