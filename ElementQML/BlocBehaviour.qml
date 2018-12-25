import QtQuick 2.11
import QtQuick.Controls 2.3
import editableAction 1.0


Item {
    id: element
    z:1
    objectName: "BlocBehaviour"
    property bool isBlocant:false
    property string name:"Action"
    width:200
    property int oldX: 0
    property int oldY: 0
    property var cppBloc:editableAction
    height:30+listParam.count*35
    onXChanged:
    {
        //changeX(x-oldX)
        rectangleSortie.pereBouge(x-oldX,0)
        rectangleTimeout.pereBouge(x-oldX,0)
        rectangleEntree.moveYourDaddy(x-oldX,0)
        oldX = x
    }
    onYChanged:
    {
        //changeY(y-oldY)
        rectangleSortie.pereBouge(0,y-oldY)
        rectangleTimeout.pereBouge(0,y-oldY)
        rectangleEntree.moveYourDaddy(0,y-oldY)
        oldY=y
    }

    Component.onCompleted:
    {
        oldX = x
        oldY = y
        listParam.clear()
    }
    function addParam(nom, value)
    {
        listParam.append({_nom:nom,value:value, index:listParam.count})
        editableAction.ajoutParametre(nom,value)
    }

    EditableAction
    {
        id:editableAction
        nomAction: name
        xBloc: element.x
        yBloc: element.y
    }


    MouseArea
    {
        id:mouseArea3
        anchors.fill: parent
        anchors.leftMargin: 25
        anchors.rightMargin: 25

        drag.target: parent;
        propagateComposedEvents:true
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked:
        {
            console.log("clich")
        }
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
                    onTextChanged:
                    {
                        editableAction.modifierValue(_nom,text)
                    }
                }
            }
        }
    }
    ListModel
    {
        id:listParam
        ListElement{ _nom:"x" ; value:"0" ; index : 0}
    }

    BlocEntree {
        id: rectangleEntree
        _color: "green"
        x: -313
        width: 10
        height: 10
        radius: 5
        anchors.right: parent.left
        anchors.rightMargin: -5
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    BlocSortie {
        id: rectangleSortie
        width: 10
        height: 10
        _color: "#ff0000"

        anchors.left: parent.right
        anchors.leftMargin: -5
        anchors.top: parent.top
        anchors.topMargin: isBlocant==1?5:10

    }

    BlocSortie {
        id: rectangleTimeout
        visible:isBlocant==1?true:false
        width: 10
        height: 10
        _color: "yellow"

        anchors.left: parent.right
        anchors.leftMargin: -5
        anchors.top: parent.top
        anchors.topMargin: 20

    }
}





/*##^## Designer {
    D{i:22;anchors_y:0}D{i:23;anchors_x:"-235";anchors_y:94}D{i:24;anchors_x:173;anchors_y:106}
}
 ##^##*/
