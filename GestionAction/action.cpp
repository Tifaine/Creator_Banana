#include "action.h"

Action::Action()
{

}

QString Action::getNomAction() const
{
    return nomAction;
}

void Action::setNomAction(const QString &value)
{
    nomAction = value;
}

bool Action::getIsBlocant() const
{
    return isBlocant;
}

void Action::setIsBlocant(bool value)
{
    isBlocant = value;
}


void Action::setNouveauParam(QString nom, QString valueDefault)
{
    parametre nouveauParam;
    nouveauParam.nomParam = nom;
    nouveauParam.valueDefault = valueDefault;
    listParam.append(nouveauParam);
}

int Action::getNbParam()
{
    return listParam.size();
}

QString Action::getNomParam(int indice)
{
    if(indice<listParam.size())
    {
        return listParam.at(indice).nomParam;
    }
    return "-1";
}

QString Action::getDefaultValueParam(int indice)
{
    if(indice<listParam.size())
    {
        return listParam.at(indice).valueDefault;
    }
    return "non";
}
