#include "gestiontypeaction.h"

GestionTypeAction::GestionTypeAction(QObject *parent) : QObject(parent)
{
    update();
}

void GestionTypeAction::update()
{
    listAction.clear();
    QDir dir("res/");
    QStringList listFiles = dir.entryList(QStringList() << "*.xml",QDir::Files);
    for(int i = 0 ;i<listFiles.size();i++)
    {
        listAction.append(new Action);
        QString nomFile;
        nomFile.append("res/");
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

                        listAction.last()->setIsBlocant(true);
                    }else
                    {
                        listAction.last()->setIsBlocant(false);
                    }
                }else if(elemName == "Param")
                {
                    std::string name = elem->Attribute("name");
                    std::string valueDefault = elem->Attribute("valueDefault");
                    listAction.last()->setNouveauParam(QString::fromStdString(name),QString::fromStdString(valueDefault));
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
    return listAction.at(indiceAction)->getDefaultValueParam(indiceParam);
}

bool GestionTypeAction::getIsBlocant(int indiceAction)
{
    return listAction.at(indiceAction)->getIsBlocant();
}
