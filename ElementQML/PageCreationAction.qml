import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: element1
    width: 1400
    height: 800

    Component.onCompleted:
    {
        refresh()
        listParam.clear()
        listParam1.clear()
    }

    Connections
    {
        target:gestTypeAction
        onFinUpdate:
        {
            refresh();
        }
    }

    function refresh()
    {
        listComportement.clear();
        for(var i=0;i<gestTypeAction.getNbAction();i++)
        {
            listComportement.append({_nom:gestTypeAction.getNomAction(i), index:listComportement.count, _color:"#00ffffff"})
        }
    }

    ListModel
    {
        id:listComportement
        ListElement{ _nom:"Deplacement" ; index : 0; _color:"#00ffffff"}
        ListElement{ _nom:"test" ; index : 1; _color:"#00ffffff"}
        ListElement{ _nom:"aaa" ; index : 2; _color:"#00ffffff"}
    }

    Flickable
    {
        id: flickable
        height: 100
        flickableDirection: Flickable.HorizontalFlick
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        contentWidth: 5000; contentHeight: 100
        contentX: 0
        contentY:0

        ScrollBar.horizontal: ScrollBar {
            parent: flickable.parent
            anchors.left: flickable.left
            anchors.right: flickable.right
            anchors.bottom: flickable.bottom
        }
        Rectangle
        {
            id:rectangle5
            anchors.fill: parent
            color:"transparent"

            function updateColor(indice)
            {

                listComportement.setProperty(indice,"_color","#4d0000");
                if(behaviorSelected !== -1)
                {
                    listComportement.setProperty(behaviorSelected,"_color","#00ffffff");
                }

                behaviorSelected = indice
            }

            property int behaviorSelected:-1
            Repeater
            {
                id:repeaterListAction
                model:listComportement
                anchors.fill: parent
                Rectangle
                {
                    id:rect
                    height:40
                    width:90
                    color:_color
                    radius: 10
                    border.color: "#ffffff"
                    border.width: 1
                    anchors.left: repeaterListAction.left
                    anchors.leftMargin: (index%2)==1?(index==1?0:(Math.floor(index/2))*100)+5:((index/2)*100)+5
                    anchors.top: repeaterListAction.top
                    anchors.topMargin:(index%2)==1?50:5


                    Rectangle
                    {
                        color: _color//"#0cfdfdfd"
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
                            color:"white"
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }



                        MouseArea
                        {
                            anchors.fill: parent
                            z:1
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked:
                            {
                                rectangle5.updateColor(index)

                                textFieldNomAction.text = gestTypeAction.getNomAction(index)
                                radioButtonBlocant.checked = gestTypeAction.getIsBlocant(index)
                                listParam.clear();
                                listParam1.clear();
                                for(var i =0; i<gestTypeAction.getNbParam(index);i++)
                                {
                                    listParam.append({_nom:gestTypeAction.getNameParam(index,i),value:gestTypeAction.getValueParam(index,i), index:listParam.count})
                                    listParam1.append({_nom:gestTypeAction.getNameParam(index,i),_color:"#00ffffff", index:listParam1.count})
                                }
                            }
                        }
                    }
                }
            }
        }
    }



    ListModel
    {
        id:listParam1
        ListElement{ _nom:"Deplacement" ; index : 0; _color:"#00ffffff"}
        ListElement{ _nom:"test" ; index : 1; _color:"#00ffffff"}
        ListElement{ _nom:"aaa" ; index : 2; _color:"#00ffffff"}
    }

    Flickable
    {
        id: flickableListParam

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: rectangle2.left
        anchors.rightMargin: 5
        anchors.left: rectangle.right
        anchors.leftMargin: 5
        anchors.top: textListParam.bottom
        anchors.topMargin: 15
        contentWidth: parent.width; contentHeight: 2000
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical: ScrollBar {
            parent: flickableListParam.parent
            anchors.top: flickableListParam.top
            anchors.left: flickableListParam.right
            anchors.leftMargin: -10
            anchors.bottom: flickableListParam.bottom
        }

        Rectangle
        {
            id:rectangle6
            anchors.fill: parent
            color:"transparent"

            function updateColor(indice)
            {

                listParam1.setProperty(indice,"_color","#4d0000");
                if(behaviorSelected !== -1)
                {
                    listParam1.setProperty(behaviorSelected,"_color","#00ffffff");
                }

                behaviorSelected = indice
            }

            property int behaviorSelected:-1
            Repeater
            {
                id:repeaterListParam
                model:listParam1
                anchors.fill: parent
                Rectangle
                {
                    id:rect1
                    height:40
                    width:90
                    color:_color
                    radius: 10
                    border.color: "#ffffff"
                    border.width: 1
                    anchors.left: repeaterListParam.left
                    anchors.leftMargin: (index%2)==1?105:5
                    anchors.top: repeaterListParam.top
                    anchors.topMargin:(index%2)==1?(index==1?0:(Math.floor(index/2))*50)+5:((index/2)*50)+5



                    Rectangle
                    {
                        color: _color//"#0cfdfdfd"
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
                            id: nomCompt
                            text: _nom
                            color:"white"
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }



                        MouseArea
                        {
                            anchors.fill: parent
                            z:1
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked:
                            {
                                rectangle6.updateColor(index)


                            }
                        }
                    }
                }
            }
        }
    }

    Flickable
    {
        id: flickableAlias
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: rectangle2.right
        anchors.leftMargin: 5
        anchors.top: textAlias.bottom
        anchors.topMargin: 15
        contentWidth: parent.width; contentHeight: 2000
        flickableDirection: Flickable.VerticalFlick
        ScrollBar.vertical: ScrollBar {
            parent: flickableAlias.parent
            anchors.top: flickableAlias.top
            anchors.left: flickableAlias.right
            anchors.leftMargin: -10
            anchors.bottom: flickableAlias.bottom
        }
    }

    Rectangle {
        id: rectangle
        color: "white"
        anchors.right: parent.right
        anchors.rightMargin: parent.width/2-1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2
        anchors.top: flickable.bottom
        anchors.topMargin: 15
    }

    Text {
        id: textNomAction
        height: 40
        text: qsTr("Nom de l'action : ")
        anchors.top: rectangle1.bottom
        anchors.topMargin: 5
        verticalAlignment: Text.AlignVCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.bold: true
        font.pixelSize: 16
        color:"white"
    }

    RadioButton {
        id: radioButtonBlocant
        text: qsTr("")
        autoExclusive: false
        checkable: true
        anchors.top: textNomAction.bottom
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.bold: true
        font.pixelSize: 16
        onCheckedChanged:
        {
            if(checked)
            {
                listParam.insert(0,{_nom:"timeout",value:"50000", index:0})
                for(var i=1;i<listParam.count;i++)
                {
                    listParam.setProperty(i,"index",listParam.get(i).index+1)
                }
            }else
            {
                if(listParam.count>0)
                {
                    listParam.remove(0,1)
                    for(var i=0;i<listParam.count;i++)
                    {
                        listParam.setProperty(i,"index",listParam.get(i).index-1)
                    }
                }
            }
        }
    }

    Text {
        id: textActionBlocante
        height: 40
        text: qsTr("Action blocante ?")
        color:"white"
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        anchors.left: radioButtonBlocant.right
        anchors.leftMargin: 10
        anchors.top: textNomAction.bottom
        anchors.topMargin: 15
        font.pixelSize: 16
    }

    TextField {
        id: textFieldNomAction
        text: qsTr("NomAction")
        font.pixelSize: 16
        anchors.left: textNomAction.right
        anchors.leftMargin: 10
        anchors.top: rectangle1.bottom
        anchors.topMargin: 5
        color: "white"
        background: Rectangle {
            color:"#22ffffff"
            radius: 10
            implicitWidth: 100
            implicitHeight: 24
            border.color: "#333"
            border.width: 1
        }
    }



    Text {
        id: elementNameParam
        text: qsTr("Nom paramètre")
        color:"white"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 3*parent.width/4+5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 220
        font.pixelSize: 16
    }

    Text {
        id: elementDefaultValue
        text: qsTr("Valeur par défaut")
        anchors.top: parent.top
        anchors.topMargin: 220
        color:"white"
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.right: rectangle.left
        anchors.rightMargin: 5
        anchors.left: elementNameParam.right
        anchors.leftMargin: 10
        font.pixelSize: 16
    }

    ListModel
    {
        id:listParam
        ListElement{ _nom:"x" ; value:"0" ; index : 0}
        ListElement{ _nom:"y" ; value:"0" ; index : 1}
    }

    Repeater
    {
        id:repeaterParameter
        model:listParam
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: elementNameParam.bottom
        anchors.topMargin: 5
        anchors.right: rectangle.left
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        Rectangle
        {
            id:rect7
            height:50
            color:"transparent"
            anchors.right: repeaterParameter.right
            anchors.rightMargin: 0
            anchors.left: repeaterParameter.left
            anchors.leftMargin: 0
            anchors.top: repeaterParameter.top
            anchors.topMargin:50*index
            TextField {
                id: textFieldNomParam
                text: _nom
                font.pixelSize: 16
                anchors.right: parent.right
                anchors.rightMargin: parent.width/2+1
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin:2
                anchors.bottom: parent.bottom
                color: "white"
                background: Rectangle {
                    color:"#22ffffff"
                    radius: 10
                    implicitWidth: 100
                    implicitHeight: 24
                    border.color: "#333"
                    border.width: 1
                }
            }
            TextField {
                id: textFieldDefaultValue
                text: value
                height:50
                font.pixelSize: 16
                anchors.right: parent.right
                anchors.rightMargin:2
                anchors.left: parent.left
                anchors.leftMargin:  parent.width/2+1
                anchors.top: parent.top
                anchors.topMargin:2
                anchors.bottom: parent.bottom
                color: "white"
                background: Rectangle {
                    color:"#22ffffff"
                    radius: 10
                    implicitWidth: 100
                    implicitHeight: 24
                    border.color: "#333"
                    border.width: 1
                }
            }
        }
    }

    Button {
        id: buttonAddParam
        x: 581
        text: qsTr("Ajouter paramètre")
        anchors.top: rectangle1.bottom
        anchors.topMargin: 15
        font.bold: true
        font.pixelSize: 16
        anchors.right: rectangle.left
        anchors.rightMargin: 10
        onClicked:
        {
            listParam.append({_nom:"Nouvelle Action",value:"0", index:listParam.count})
        }
    }

    Button {
        id: buttonSaveAction
        text: qsTr("Sauvegarder action")
        anchors.left: buttonClear.right
        anchors.leftMargin: 45
        anchors.top: rectangle1.bottom
        anchors.topMargin: 15
        onClicked:
        {
            gestAction.setNomAction(textFieldNomAction.text)
            //gestAction.setCategorieAction()
            gestAction.setIsActionBlocante(radioButtonBlocant.checked)
            for(var i = 0;i<listParam.count;i++)
            {
                gestAction.setNouveauParam(repeaterParameter.itemAt(i).children[0].text,repeaterParameter.itemAt(i).children[1].text)
            }
            gestAction.saveAction();
            gestTypeAction.update();
        }
    }

    Button {
        id: buttonClear
        text: qsTr("Reset action")
        anchors.left: rectangle.right
        anchors.leftMargin: 25
        anchors.top: rectangle1.bottom
        anchors.topMargin: 15
        onClicked:
        {
            listParam.clear()
        }
    }

    Rectangle {
        id: rectangle1
        height: 1
        color: "#ffffff"
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: flickable.bottom
        anchors.topMargin: 0
    }

    Text {
        id: textListParam
        color: "#ffffff"
        text: qsTr("Liste paramètres")
        horizontalAlignment: Text.AlignHCenter
        anchors.rightMargin: 5
        anchors.right: rectangle2.left
        font.bold: true
        anchors.left: rectangle.right
        anchors.leftMargin: 5
        anchors.top: buttonClear.bottom
        anchors.topMargin: 15
        font.pixelSize: 16
    }

    Text {
        id: textAlias
        color: "#ffffff"
        text: qsTr("Alias")
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.right: rectangle3.left
        anchors.rightMargin: 5
        anchors.left: rectangle2.right
        anchors.leftMargin: 5
        anchors.top: buttonAjoutAlias.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
    }

    Text {
        id: textValue
        width: 224
        color: "#ffffff"
        text: qsTr("Value")
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: rectangle3.right
        anchors.leftMargin: 5
        anchors.top: buttonAjoutAlias.bottom
        anchors.topMargin: 10
        font.pixelSize: 16
    }

    Rectangle {
        id: rectangle2
        x: 784
        width: 1
        color: "#ffffff"
        anchors.leftMargin: 210
        anchors.left: rectangle.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: buttonSaveAction.bottom
        anchors.topMargin: 25
    }

    Rectangle {
        id: rectangle3
        x: 1081
        width: 1
        color: "#ffffff"
        anchors.rightMargin: parent.width/6
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: buttonAjoutAlias.bottom
        anchors.topMargin: 15
        anchors.right: parent.right
    }

    Button {
        id: buttonAjoutAlias
        x: 1213
        text: qsTr("Ajouter Alias")
        anchors.rightMargin: parent.width/6 - 50
        anchors.right: parent.right
        anchors.top: buttonClear.bottom
        anchors.topMargin: 20
    }
}









/*##^## Designer {
    D{i:2;anchors_height:200;anchors_width:200;anchors_x:505;anchors_y:308}D{i:3;anchors_x:20;anchors_y:114}
D{i:8;anchors_x:20;anchors_y:142}D{i:9;anchors_x:77;anchors_y:161}D{i:11;anchors_x:180;anchors_y:101}
D{i:25;anchors_x:30;anchors_y:228}D{i:26;anchors_x:181;anchors_y:228}D{i:27;anchors_x:70;anchors_y:318}
D{i:28;anchors_x:380}
}
 ##^##*/
