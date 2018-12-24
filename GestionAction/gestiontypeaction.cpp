#include "gestiontypeaction.h"

GestionTypeAction::GestionTypeAction(QObject *parent) : QObject(parent)
{
    update();
}

void GestionTypeAction::update()
{
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
                    TiXmlElement* elemBis = root->FirstChildElement("nom");
                    std::string elemNameBis = elemBis->GetText();
                    if(elemNameBis=="1")
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
}

int GestionTypeAction::getNbAction()
{
    return listAction.size();
}
QString GestionTypeAction::getNomAction(int indice)
{
    return listAction.at(indice)->getNomAction();
}
