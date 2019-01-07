import QtQuick 2.0
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

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
        onCreerBloc:
        {
            bar.getTab(bar.currentIndex).children[0].addBloc(gestTypeAction.getIndiceByName(nom))
        }
    }

    ListModel
    {
        id:listOnglet
        ListElement{ _nom:"Séquence principale" ; _index:0}
        ListElement{ _nom:"Deux" ; _index:1}
    }
    Button
    {
        id:buttonSave
        anchors.top: parent.top
        anchors.topMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        height:20
        width:40
        z:5
        text:"Save"
        onClicked:
        {
            gestionSequence.exportXML()
        }
    }

    TabView
    {
        id: bar
        anchors.left: sidePanelComportement.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: buttonSave.bottom
        anchors.leftMargin: 0
        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color:  styleData.selected ? "#262626":"transparent"
                border.width: 1
                border.color:"black"

                implicitWidth: text.width + 30
                implicitHeight: 35
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ?"white":"black"
                }
                MouseArea
                {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onClicked:
                    {
                        bar.currentIndex = index
                        if (mouse.button === Qt.RightButton && index !== 0)
                        {
                            contextMenu.popup()
                        }
                    }
                }
            }
            frame: Rectangle { color: "transparent" }
        }

        Repeater
        {
            id:repeaterOnglet
            model:listOnglet
            property int nbTabOpen:0
            Tab
            {
                id:tab
                title: _nom
                OngletSequence {
                    id: ongletSequence
                    anchors.fill: parent

                }

            }
        }
    }
}


