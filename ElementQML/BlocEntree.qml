import QtQuick 2.9
import connector 1.0
import QtQuick.Controls 2.2

Rectangle {
    property string _color:"green"
    id: rectangleSortie
    width: 12
    height: 12
    color: _color
    radius: 5
    objectName: "Entree"
    property var papa:null
    property var myself:null

    Component.onCompleted: listMenu.clear()

    property var tabPere:[]

    function moveYourDaddy(deltaX, deltaY)
    {
        for(var i=0;i<rectangleSortie.tabPere.length;i++)
        {
            rectangleSortie.tabPere[i].filsBouge(rectangleSortie,deltaX,deltaY)
        }
    }

    function addPere(papaItem)
    {
        rectangleSortie.tabPere.push(papaItem)
    }



    function affichMenu()
    {
        for(var i=0;i<tabPere.length;i++)
        {
            listMenu.append({_nom: tabPere[i].parent.name,index: listMenu.count})
        }

        menu.open()
    }

    ListModel
    {
        id:listMenu
        ListElement{_nom:"x";index : 0}
    }

    Menu {
        id: menu
        Repeater{
            id:repeaterMenu
            model:listMenu
            MenuItem {
                text:_nom
                onClicked:
                {
                    tabPere[index].parent.removeActionFille(papa)
                    tabPere[index].supprimerFils(myself)
                    tabPere.splice(index,1)
                }

            }
        }


    }
}

