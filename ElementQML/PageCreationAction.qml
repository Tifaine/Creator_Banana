import QtQuick 2.0
import QtQuick.Controls 2.3

Item {
    id: element1
    width: 1400
    height: 800

    Component.onCompleted: listParam.clear()

    Text {
        id: elementTitre
        text: qsTr("Création d'action")
        font.family: "Amiri"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        font.pixelSize: 30
    }

    Rectangle {
        id: rectangle
        color: "#000000"
        anchors.right: parent.right
        anchors.rightMargin: parent.width/2-1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: parent.width/2
        anchors.top: parent.top
        anchors.topMargin: 15
    }

    Text {
        id: textNomAction
        height: 40
        text: qsTr("Nom de l'action : ")
        verticalAlignment: Text.AlignVCenter
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: elementTitre.bottom
        anchors.topMargin: 35
        font.bold: true
        font.pixelSize: 16
    }

    RadioButton {
        id: radioButtonBlocant
        text: qsTr("")
        autoExclusive: false
        checkable: true
        anchors.top: textNomAction.bottom
        anchors.topMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 20
        font.bold: true
        font.pixelSize: 16
    }

    Text {
        id: textActionBlocante
        height: 40
        text: qsTr("Action blocante ?")
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        anchors.left: radioButtonBlocant.right
        anchors.leftMargin: 10
        anchors.top: textNomAction.bottom
        anchors.topMargin: 25
        font.pixelSize: 16
    }

    TextField {
        id: textFieldNomAction
        text: qsTr("NomAction")
        font.pixelSize: 16
        anchors.left: textNomAction.right
        anchors.leftMargin: 10
        anchors.top: elementTitre.bottom
        anchors.topMargin: 35
    }

    ComboBox {
        id: comboBoxCategorie
        width: 200
        font.bold: true
        font.pixelSize: 16
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: radioButtonBlocant.bottom
        anchors.topMargin: 25
        model: [ "Banana", "Apple", "Coconut" ]

    }

    Text {
        id: elementCategorieAction
        height: 40
        text: qsTr("Catégorie de l'action")
        anchors.left: comboBoxCategorie.right
        anchors.leftMargin: 25
        anchors.top: textActionBlocante.bottom
        anchors.topMargin: 25
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 16
    }

    Text {
        id: elementNameParam
        text: qsTr("Nom paramètre")
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 3*parent.width/4+5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: comboBoxCategorie.bottom
        anchors.topMargin: 50
        font.pixelSize: 16
    }

    Text {
        id: elementDefaultValue
        y: 321
        text: qsTr("Valeur par défaut")
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
            id:rect
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
                anchors.rightMargin: parent.width/2
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin:2
                anchors.bottom: parent.bottom
            }
            TextField {
                id: textFieldDefaultValue
                text: value
                height:50
                font.pixelSize: 16
                anchors.right: parent.right
                anchors.rightMargin:2
                anchors.left: parent.left
                anchors.leftMargin:  parent.width/2
                anchors.top: parent.top
                anchors.topMargin:2
                anchors.bottom: parent.bottom
            }
        }


    }

    Button {
        id: buttonAddParam
        x: 581
        y: 269
        text: qsTr("Ajouter paramètre")
        font.bold: true
        font.pixelSize: 16
        anchors.bottom: elementDefaultValue.top
        anchors.bottomMargin: 10
        anchors.right: rectangle.left
        anchors.rightMargin: 10
        onClicked:
        {
            listParam.append({_nom:"Nouvelle Action",value:"0", index:listParam.count})
        }
    }

    Button {
        id: buttonSaveAction
        x: 581
        text: qsTr("Sauvegarder action")
        anchors.top: parent.top
        anchors.topMargin: 175
        anchors.right: rectangle.left
        anchors.rightMargin: 20
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
}









/*##^## Designer {
    D{i:2;anchors_height:200;anchors_width:200;anchors_x:505;anchors_y:308}D{i:3;anchors_x:20;anchors_y:114}
D{i:8;anchors_x:20;anchors_y:142}D{i:9;anchors_x:77;anchors_y:161}D{i:11;anchors_x:180;anchors_y:101}
D{i:25;anchors_x:30;anchors_y:228}D{i:26;anchors_x:181;anchors_y:228}D{i:27;anchors_x:70;anchors_y:318}
D{i:28;anchors_x:380}
}
 ##^##*/
