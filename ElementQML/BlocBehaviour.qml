import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import editableAction 1.0


Item {
    id: element
    z:1
    objectName: "BlocBehaviour"
    property bool isBlocant:false
    property string name:"Action"
    width:(name=="Depart"||name=="Fin")?70:300
    property int oldX: 0
    property int oldY: 0
    property var cppBloc:editableAction

    property var blocSortie:rectangleSortie
    property var blocEntree:rectangleEntree
    property var blocTimeout:rectangleTimeout

    signal creerSequence(string nom)
    property int taille : 0;
    height:30+taille*35
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

    function addActionFille(fille)
    {
        editableAction.ajoutActionFille(fille.cppBloc)
    }

    function addActionFilleTimeOut(fille)
    {
        editableAction.ajoutActionFilleTimeOut(fille.cppBloc)
    }

    function removeActionFille(fille)
    {
        editableAction.supprimerFils(fille)
    }

    function modifValueParam(nomParam, valueParam)
    {
        for(var i=0;i<listParam.count;i++)
        {
            if(listParam.get(i)._nom === nomParam)
            {
                listParam.get(i).value = valueParam
            }
        }
    }

    function finCreation()
    {

        for(var i=0;i<listParam.count;i++)
        {
            taille++;
            repeaterParameter.itemAt(i).update()
            if(cppBloc.getNbAlias(listParam.get(i)._nom)>0)taille++;
        }
    }

    EditableAction
    {
        id:editableAction
        nomAction: name
        xBloc: element.x
        yBloc: element.y
        isActionBlocante: isBlocant
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
        }
        onDoubleClicked:
        {

            if(element.name==="Sequence")
            {

                creerSequence(repeaterParameter.itemAt(0).children[1].text)
            }
        }
    }

    Rectangle {
        id: fond
        color: "#0cfdfdfd"
        radius: 10
        border.width: 1
        border.color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: fondEntete
            height: 25
            color: isBlocant==true?"#4d0000":"transparent"
            radius: 10
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
                color: "white"
                anchors.right: parent.right
                anchors.rightMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
            }

            Text {
                id: testNom
                text: name
                color:isBlocant==true?"white":"white"
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
            y: 300
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
                anchors.top: index>0?repeaterParameter.itemAt(index-1).bottom:repeaterParameter.top
                anchors.topMargin:0
                Text {
                    id: textFieldNomParam
                    text: _nom
                    color:"white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: 16
                    anchors.right: parent.right
                    anchors.rightMargin: 2*parent.width/3
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin:2
                    anchors.bottom: parent.bottom
                }



                TextField {
                    id: textFieldDefaultValue
                    text: value
                    height:33
                    font.pixelSize: 16
                    anchors.right: parent.right
                    anchors.rightMargin:5
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/3+5

                    anchors.top: comboBox.bottom
                    anchors.topMargin:2
                    color: "white"
                    background: Rectangle {
                        color:"#22ffffff"
                        radius: 10
                        implicitWidth: 100
                        implicitHeight: 24
                        border.color: "#333"
                        border.width: 1
                    }
                    onTextChanged:
                    {
                        editableAction.modifierValue(_nom,text)
                    }
                }

                ListModel
                {
                    id:listAlias
                    ListElement{ text:"x" ; valueAlias:"0" ; index : 0}
                }

                ComboBox {
                    id: comboBox
                    height:35
                    anchors.right: parent.right
                    anchors.rightMargin:2
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width/3+5
                    anchors.top: parent.top
                    anchors.topMargin:2
                    visible:false
                    model: ListModel {
                               id: model

                           }
                    background: Rectangle {
                        color:"#22ffffff"
                        radius: 10
                        implicitWidth: 100
                        implicitHeight: 24
                        border.color: "#333"
                        border.width: 1
                    }
                    contentItem: Text {
                          color : "#ffffff"
                          text: parent.displayText
                          font.family: "Arial";
                          font.pixelSize: 16;
                          verticalAlignment: Text.AlignVCenter;
                          horizontalAlignment: Text.AlignLeft;

                      }
                    onCurrentIndexChanged:
                    {
                        textFieldDefaultValue.text = cppBloc.getValueAlias(_nom,currentIndex)
                    }
                }

                function update()
                {
                    if(cppBloc.getNbAlias(_nom)>0)
                    {
                        comboBox.height = 35
                        comboBox.visible = true
                        rect.height = 70
                        comboBox.model.clear()


                        for(var i=0;i<cppBloc.getNbAlias(_nom);i++)
                        {
                            comboBox.model.append({text: "  "+cppBloc.getNomAlias(_nom,i)+" ("+cppBloc.getValueAlias(_nom,i)+")"})
                        }
                    }else
                    {
                        comboBox.height = 0
                        comboBox.visible = false
                        rect.height = 35
                        comboBox.model.clear()

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
        visible:element.name=="Depart"?false:true
        enabled:element.name=="Depart"?false:true
        papa:cppBloc
        myself:rectangleEntree
    }

    BlocSortie {
        id: rectangleSortie
        width: 10
        height: 10
        _color: "#ff0000"
        objectName: "Sortie"
        anchors.left: parent.right
        anchors.leftMargin: -5
        anchors.top: parent.top
        anchors.topMargin: isBlocant==1?5:10
        enabled:element.name=="Fin"?false:true
        visible:element.name=="Fin"?false:true
    }

    BlocSortie {
        id: rectangleTimeout
        visible:isBlocant==1?true:false
        width: 10
        height: 10
        _color: "yellow"
        objectName: "timeOut"
        anchors.left: parent.right
        anchors.leftMargin: -5
        anchors.top: parent.top
        anchors.topMargin: 20


    }
}






