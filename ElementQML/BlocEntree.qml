import QtQuick 2.0
import connector 1.0

Rectangle {
    property string _color:"green"
    id: rectangleSortie
    width: 12
    height: 12
    color: _color
    radius: 5
    objectName: "Entree"

    property var tabPere:[]

    function moveYourDaddy(deltaX, deltaY)
    {
        for(var i=0;i<rectangleSortie.tabPere.length;i++)
        {
            rectangleSortie.tabPere[i].filsBouge(rectangleSortie,deltaX,deltaY)
        }
    }

    function addPere(papa)
    {
        rectangleSortie.tabPere.push(papa)
    }
}

