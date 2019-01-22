import QtQuick 2.0
import connector 1.0

Rectangle {
    property string _color:"#ff0000"
    id: rectangleSortie
    width: 12
    height: 12
    color: _color
    radius: 5


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
            _color:"steelblue"
            z:  -5
            x1: _x1
            y1: _y1
            x2: _x2
            y2: _y2
        }
    }

    function killMePlease(myself)
    {
        for(var i=0;i<tabFils.length;i++)
        {
            tabFils[i].deleteFather(myself)
        }
    }

    function supprimerFils(fils)
    {
        listLien.remove(rectangleSortie.tabFils.indexOf(fils))
        //repeaterLien.
        tabFils.splice(rectangleSortie.tabFils.indexOf(fils),1)
    }


    function pereBouge(deltax,deltay)
    {
        for(var i=0;i<repeaterLien.count-1;i++)
        {
            listLien.setProperty(i,"_x2",repeaterLien.itemAt(i).x2-deltax)
            listLien.setProperty(i,"_y2",repeaterLien.itemAt(i).y2-deltay)
        }
    }

    function filsBouge(fils,deltax,deltay)
    {
        listLien.setProperty(rectangleSortie.tabFils.indexOf(fils),"_x2",repeaterLien.itemAt(rectangleSortie.tabFils.indexOf(fils)).x2+deltax)
        listLien.setProperty(rectangleSortie.tabFils.indexOf(fils),"_y2",repeaterLien.itemAt(rectangleSortie.tabFils.indexOf(fils)).y2+deltay)
    }

    function valideSortie(blocEntree)
    {
        rectangleSortie.tabFils.push(blocEntree)
        listLien.append({_x1:5,_y1:5, _x2:5,_y2:5})
    }

    function repaint(x,y)
    {
        listLien.setProperty(listLien.count-1,"_x2",x)
        listLien.setProperty(listLien.count-1,"_y2",y)
    }
}

