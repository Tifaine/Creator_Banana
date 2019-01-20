#include "gestiontypeaction.h"

GestionTypeAction::GestionTypeAction(QObject *parent) : QObject(parent)
{
    update();
}

void GestionTypeAction::initList()
{
    listAction.clear();

    listAction.append(new EditableAction);
    listAction.last()->setNomAction("Depart");
    listAction.last()->setIsActionBlocante(false);

    listAction.append(new EditableAction);
    listAction.last()->setNomAction("Fin");
    listAction.last()->setIsActionBlocante(false);

    listAction.append(new EditableAction);
    listAction.last()->setNomAction("Sequence");
    listAction.last()->setIsActionBlocante(false);
    listAction.last()->ajoutParametre("Nom","temp");
}

void GestionTypeAction::update()
{
    initList();
    QDir dir("res/bloc/");
    QStringList listFiles = dir.entryList(QStringList() << "*.xml",QDir::Files);
    for(int i = 0 ;i<listFiles.size();i++)
    {
        listAction.append(new EditableAction);
        QString nomFile;
        nomFile.append("res/bloc/");
        nomFile.append(listFiles.at(i));
        TiXmlDocument doc(nomFile.toStdString().c_str());
        if(!doc.LoadFile())
        {
            qDebug()<<"Fichier introuvable";

        }else
        {
            TiXmlElement* root = doc.FirstChildElement();

            for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
            {
                std::string elemName = elem->Value();
                if(elemName == "nom")
                {
                    TiXmlElement* elemBis = root->FirstChildElement("nom");
                    std::string elemNameBis = elemBis->GetText();
                    listAction.last()->setNomAction(QString::fromStdString(elemNameBis));
                }else if(elemName == "isActionBlocante")
                {
                    TiXmlElement* elemTer = root->FirstChildElement("isActionBlocante");
                    std::string elemNameTer = elemTer->GetText();

                    if(elemNameTer=="1")
                    {

                        listAction.last()->setIsActionBlocante(true);
                    }else
                    {
                        listAction.last()->setIsActionBlocante(false);
                    }
                }else if(elemName == "Param")
                {
                    std::string name = elem->Attribute("name");
                    std::string valueDefault = elem->Attribute("valueDefault");
                    listAction.last()->ajoutParametre(QString::fromStdString(name),QString::fromStdString(valueDefault));
                    for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
                    {
                        std::string elemNameBis = elemBis->Value();
                        if(elemNameBis == "Alias")
                        {
                            std::string nameAlias = elemBis->Attribute("name");
                            std::string valueAlias = elemBis->Attribute("valueAlias");
                            listAction.last()->ajoutAlias(QString::fromStdString(name),QString::fromStdString(nameAlias),QString::fromStdString(valueAlias));
                        }
                    }
                }
            }
        }
    }
    emit finUpdate();
}

int GestionTypeAction::getNbAction()
{
    return listAction.size();
}
QString GestionTypeAction::getNomAction(int indice)
{
    return listAction.at(indice)->getNomAction();
}

int GestionTypeAction::getIndiceByName(QString name)
{
    for(int i=0;i<listAction.size();i++)
    {
        if(listAction.at(i)->getNomAction().compare(name) == 0)
        {
            return i;
        }
    }
    return -1;
}

int GestionTypeAction::getNbParam(int indice)
{
    return listAction.at(indice)->getNbParam();
}

QString GestionTypeAction::getNameParam(int indiceAction, int indiceParam)
{
    return listAction.at(indiceAction)->getNomParam(indiceParam);
}

QString GestionTypeAction::getValueParam(int indiceAction, int indiceParam)
{
    return listAction.at(indiceAction)->getValueParam(indiceParam);
}

bool GestionTypeAction::getIsBlocant(int indiceAction)
{
    return listAction.at(indiceAction)->getIsActionBlocante();
}

int GestionTypeAction::getNbAlias(int indiceAction, QString nameParam)
{
    return listAction.at(indiceAction)->getNbAlias(nameParam);
}

QString GestionTypeAction::getNomAlias(int indiceAction, QString nameParam, int indiceAlias)
{
    return listAction.at(indiceAction)->getNomAlias(nameParam,indiceAlias);
}

QString GestionTypeAction::getValueAlias(int indiceAction, QString nameParam, int indiceAlias)
{
    return listAction.at(indiceAction)->getValueAlias(nameParam, indiceAlias);
}
