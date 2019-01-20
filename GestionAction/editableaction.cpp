#include "editableaction.h"

EditableAction::EditableAction()
{

}

int EditableAction::getYBloc() const
{
    return yBloc;
}

void EditableAction::setYBloc(int value)
{
    yBloc = value;
}

int EditableAction::getXBloc() const
{
    return xBloc;
}

void EditableAction::setXBloc(int value)
{
    xBloc = value;
}

void EditableAction::clearAlias(QString nameParam)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nameParam)==0)
        {
            listParam.at(i)->nomAlias->clear();
            listParam.at(i)->valueAlias->clear();
        }
    }
}

int EditableAction::getNbAlias(QString nameParam)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nameParam)==0)
        {
            return listParam.at(i)->nomAlias->size();
        }
    }
    return 0;
}

QString EditableAction::getNomAlias(QString nameParam, int indiceAlias)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nameParam)==0)
        {
           return listParam.at(i)->nomAlias->at(indiceAlias);
        }
    }
    return "-1";
}

QString EditableAction::getValueAlias(QString nameParam, int indiceAlias)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nameParam)==0)
        {
            return listParam.at(i)->valueAlias->at(indiceAlias);
        }
    }
    return "-1";
}

void EditableAction::ajoutAlias(QString nomParam, QString nom, QString value)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nomParam)==0)
        {
            listParam.at(i)->nomAlias->append(nom);
            listParam.at(i)->valueAlias->append(value);
            break;
        }
    }
}

void EditableAction::ajoutParametre(QString nomParam, QString value)
{
    listParam.append(new parametreEditable);
    listParam.last()->nomParam = nomParam;
    listParam.last()->valueParam = value;
    listParam.last()->nomAlias = new QList<QString>();
    listParam.last()->valueAlias = new QList<QString>();
}

void EditableAction::setNomParam(int indiceParam, QString newNom)
{
    listParam.at(indiceParam)->nomParam.clear();
    listParam.at(indiceParam)->nomParam.append(newNom);
}

void EditableAction::setValueParam(int indiceParam, QString newValue)
{
    listParam.at(indiceParam)->valueParam.clear();
    listParam.at(indiceParam)->valueParam.append(newValue);
}

QString EditableAction::getNomAction() const
{
    return nomAction;
}

void EditableAction::setNomAction(const QString &value)
{
    nomAction = value;
}

void EditableAction::modifierValue(QString nomParam, QString nouvelleValue)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nomParam)==0)
        {
            listParam.at(i)->valueParam.clear();
            listParam.at(i)->valueParam.append(nouvelleValue);
        }
    }
}

void EditableAction::setNomAlias(QString nameParam, int indiceAlias, QString nameAlias)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nameParam)==0)
        {
            listParam.at(i)->nomAlias->replace(indiceAlias,nameAlias);
            break;
        }
    }
}

void EditableAction::setValueAlias(QString nameParam, int indiceAlias, QString valueAlias)
{
    for(int i=0;i<listParam.size();i++)
    {
        if(listParam.at(i)->nomParam.compare(nameParam)==0)
        {
            listParam.at(i)->valueAlias->replace(indiceAlias,valueAlias);
            break;
        }
    }
}

void EditableAction::ajoutActionFille(EditableAction * act)
{
    listActionFille.append(act);
}

void EditableAction::ajoutActionFilleTimeOut(EditableAction * act)
{
    listActionFilleTimeOut.append(act);
}

bool EditableAction::getIsActionBlocante() const
{
    return isActionBlocante;
}

void EditableAction::setIsActionBlocante(bool value)
{
    isActionBlocante = value;
}
