import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../ElementQML"

Item {
    id: element1
    width: 1200
    height: 700

    Component.onCompleted: listBloc.clear()

    function addBloc(indice)
    {
        listBloc.append({_nom:gestTypeAction.getNomAction(indice), index:listBloc.count, _x:100, _y:10100})
        repeaterParameter.itemAt(listBloc.count-1).isBlocant = gestTypeAction.getIsBlocant(indice)
        for(var i =0; i<gestTypeAction.getNbParam(indice);i++)
        {
            repeaterParameter.itemAt(listBloc.count-1).addParam(gestTypeAction.getNameParam(indice,i),gestTypeAction.getValueParam(indice,i));
        }
console.log(repeaterParameter.itemAt(listBloc.count-1).isBlocant, gestTypeAction.getIsBlocant(indice))

    }

    ListModel
    {
        id:listBloc
        ListElement{ _nom:"Deplacement" ;_x:100; _y:10100; index : 0}
    }

    Rectangle
    {
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
            contentWidth: 20000; contentHeight: 20000
            contentX: 0
            contentY:10000

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
                model:listBloc
                anchors.fill: parent
                BlocBehaviour
                {
                    x:_x
                    y:_y
                    name:_nom
                }

            }
        }
    }
}
