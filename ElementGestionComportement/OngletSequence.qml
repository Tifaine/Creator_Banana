import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../ElementQML"

Item {
    id: element1
    width: 1200
    height: 700
    property int xCourant:flickable.contentX
    property int yCourant:flickable.contentY

    signal newSequence(string nom)
    Component.onCompleted:
    {
        listBloc.clear()
        addBloc(0,100,10100)

    }

    Shortcut {
        sequence: "Ctrl+I"
        onActivated:
        {
            for(var i=0; i<listBloc.count;i++)
            {
                if(repeaterBloc.itemAt(i).x % 20 <10)
                {
                    repeaterBloc.itemAt(i).x = repeaterBloc.itemAt(i).x - repeaterBloc.itemAt(i).x%20
                }else
                {
                    repeaterBloc.itemAt(i).x = repeaterBloc.itemAt(i).x + 20-(repeaterBloc.itemAt(i).x%20)
                }

                if(repeaterBloc.itemAt(i).y % 20 <10)
                {
                    repeaterBloc.itemAt(i).y = repeaterBloc.itemAt(i).y - repeaterBloc.itemAt(i).y%20
                }else
                {
                    repeaterBloc.itemAt(i).y = repeaterBloc.itemAt(i).y + 20-(repeaterBloc.itemAt(i).y%20)
                }
            }
        }
    }


    Connections
    {
        target: gestionSequence
        onOuvrirAction:
        {
            addBloc(gestTypeAction.getIndiceByName(nomAction), xBloc, yBloc)

        }
        onModifParam:
        {
            repeaterBloc.itemAt(listBloc.count-1).modifValueParam(nom,value);
        }
        onAddFils:
        {
            repeaterBloc.itemAt(indiceParent).blocSortie.repaint(repeaterBloc.itemAt(indiceFils).x+2-repeaterBloc.itemAt(indiceParent).x-repeaterBloc.itemAt(indiceParent).blocSortie.x
                                                                 ,repeaterBloc.itemAt(indiceFils).y+15-repeaterBloc.itemAt(indiceParent).y-repeaterBloc.itemAt(indiceParent).blocEntree.y)
            repeaterBloc.itemAt(indiceParent).blocSortie.valideSortie(repeaterBloc.itemAt(indiceFils).blocEntree)
            repeaterBloc.itemAt(indiceParent).addActionFille(repeaterBloc.itemAt(indiceFils))
            repeaterBloc.itemAt(indiceFils).blocEntree.addPere(repeaterBloc.itemAt(indiceParent).blocSortie)
        }

        onAddTimeOut:
        {
            repeaterBloc.itemAt(indiceParent).blocTimeout.repaint(repeaterBloc.itemAt(indiceFils).x+2-repeaterBloc.itemAt(indiceParent).x-repeaterBloc.itemAt(indiceParent).blocSortie.x
                                                                 ,repeaterBloc.itemAt(indiceFils).y+15-repeaterBloc.itemAt(indiceParent).y-repeaterBloc.itemAt(indiceParent).blocEntree.y)
            repeaterBloc.itemAt(indiceParent).blocTimeout.valideSortie(repeaterBloc.itemAt(indiceFils).blocEntree)
            repeaterBloc.itemAt(indiceParent).addActionFilleTimeOut(repeaterBloc.itemAt(indiceFils))
            repeaterBloc.itemAt(indiceFils).blocEntree.addPere(repeaterBloc.itemAt(indiceParent).blocTimeout)
        }
    }
    function clearListBloc()
    {
        gestionSequence.clearList()
        listBloc.clear()
    }

    function addBloc(indice, xBloc, yBloc)
    {
        listBloc.append({_nom:gestTypeAction.getNomAction(indice), index:listBloc.count, _x:xBloc, _y:yBloc})
        repeaterBloc.itemAt(listBloc.count-1).isBlocant = gestTypeAction.getIsBlocant(indice)
        for(var i =0; i<gestTypeAction.getNbParam(indice);i++)
        {
            repeaterBloc.itemAt(listBloc.count-1).addParam(gestTypeAction.getNameParam(indice,i),gestTypeAction.getValueParam(indice,i));
        }
        gestionSequence.ajoutAction(repeaterBloc.itemAt(listBloc.count-1).cppBloc)
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
            clip:true
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

            Rectangle
            {
                id:rect1
                anchors.fill: parent
                color:"transparent"
                focus:true

                MouseArea
                {
                    id:mouseArea
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    anchors.fill: parent
                    propagateComposedEvents: true
                    property var obj
                    property var obj2
                    property var sortieCourante:null
                    property var entreePopup:null
                    property int indice : -1
                    onWheel:
                    {

                    }
                    onPressed:
                    {

                        if(mouse.button === Qt.LeftButton)
                        {
                            indice = rect1.areYouThere(mouse.x,mouse.y)
                            if(indice!=-1)
                            {

                                obj = repeaterBloc.itemAt(indice)
                                if(obj.childAt(mouse.x-obj.x,mouse.y-obj.y).objectName === "Sortie" ||obj.childAt(mouse.x-obj.x,mouse.y-obj.y).objectName === "timeOut"  )
                                {
                                    flickable.interactive = false
                                    sortieCourante = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)
                                }
                            }
                        }
                    }
                    onReleased:
                    {
                        if(mouse.button === Qt.LeftButton && sortieCourante !==null)
                        {
                            indice = rect1.areYouThere(mouse.x,mouse.y)
                            if(indice!=-1)
                            {

                                obj = repeaterBloc.itemAt(indice)
                                obj2 = obj.childAt(mouse.x-obj.x,mouse.y-obj.y)
                                if(obj2.objectName === "Entree")
                                {
                                    sortieCourante.valideSortie(obj2)

                                    if(sortieCourante.objectName === "Sortie")
                                    {
                                        sortieCourante.parent.addActionFille(obj);
                                    }else if(sortieCourante.objectName === "timeOut")
                                    {
                                        sortieCourante.parent.addActionFilleTimeOut(obj);
                                    }

                                    obj2.addPere(sortieCourante)
                                }else
                                {
                                    sortieCourante.repaint(5,5);
                                }
                            }else
                            {
                                sortieCourante.repaint(5,5);
                            }
                        }

                        flickable.interactive = true
                        sortieCourante=null
                    }
                    onMouseXChanged:
                    {
                        if(sortieCourante!==null)
                        {
                            sortieCourante.repaint(mouse.x-sortieCourante.parent.x-sortieCourante.x
                                                   , mouse.y-sortieCourante.parent.y-sortieCourante.y)

                            if(mouse.x > flickable.contentX+element1.width-20 )
                            {
                                flickable.contentX = mouse.x - element1.width + 50
                            }else if(mouse.x < flickable.contentX && flickable.contentX > 0)
                            {
                                flickable.contentX = mouse.x - 50
                            }
                        }
                    }
                    onMouseYChanged:
                    {
                        if(sortieCourante!==null)
                        {
                            sortieCourante.repaint(mouse.x-sortieCourante.parent.x-sortieCourante.x
                                                   , mouse.y-sortieCourante.parent.y-sortieCourante.y)

                            if(mouse.y > flickable.contentY+element1.height-20)
                            {
                                flickable.contentY = mouse.y - element1.height + 50
                            }else if(mouse.y < flickable.contentY && mouse.y > 0)
                            {
                                flickable.contentY = mouse.y - 50
                            }
                        }
                    }
                }

                ListModel
                {
                    id:listBloc
                    ListElement{ _nom:"Depart" ;_x:100; _y:10100; index : 0}
                }

                Repeater
                {
                    id:repeaterBloc
                    model:listBloc
                    anchors.fill: parent
                    BlocBehaviour
                    {
                        x:_x
                        y:_y
                        name:_nom
                        onCreerSequence:
                        {
                            newSequence(nom)
                        }
                    }
                }

                function areYouThere(mouseX, mouseY)
                {
                    for(var i=0; i<listBloc.count;i++)
                    {
                        if(mouseX+5 > repeaterBloc.itemAt(i).x)
                        {
                            if(mouseX-5 < repeaterBloc.itemAt(i).x + repeaterBloc.itemAt(i).width)
                            {
                                if(mouseY > repeaterBloc.itemAt(i).y)
                                {
                                    if(mouseY < repeaterBloc.itemAt(i).y + repeaterBloc.itemAt(i).height)
                                    {
                                        return i
                                    }
                                }
                            }
                        }
                    }
                    return -1
                }
            }
        }
    }
}
