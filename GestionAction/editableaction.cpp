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

void EditableAction::ajoutParametre(QString nomParam, QString value)
{
    listParam.append(new parametreEditable);
    listParam.last()->nomParam = nomParam;
    listParam.last()->valueParam = value;
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
