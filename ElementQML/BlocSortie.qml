import QtQuick 2.0
import connector 1.0

Rectangle {
    property string _color:"#ff0000"
    id: rectangleSortie
    width: 12
    height: 12
    color: _color
    radius: 5
    objectName: "Sortie"

    property var tabFils:[]

    ListModel
    {
        id:listLien
        ListElement{_x1:5; _y1:5; _x2:5; _y2:5}
    }

    Repeater
    {
        id:repeaterLien
        model:listLien

        Liaison
        {
            id:liaison
            antialiasing: true
            _color:"yellow"
            z:  -5
            x1: _x1
            y1: _y1
            x2: _x2
            y2: _y2
        }
    }
    function valideSortie(blocEntree)
    {
        listLien.append({_x1:5,_y1:5, _x2:5,_y2:5})
    }

    function repaint(x,y)
    {
        listLien.setProperty(listLien.count-1,"_x2",x)
        listLien.setProperty(listLien.count-1,"_y2",y)
    }
}

