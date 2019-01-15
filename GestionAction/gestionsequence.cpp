#include "gestionsequence.h"

GestionSequence::GestionSequence(QObject *parent) : QObject(parent)
{

}

void GestionSequence::ajoutAction(EditableAction* act)
{
    listAction.append(act);
}

void GestionSequence::clearList()
{
    listAction.clear();
}

int GestionSequence::ouvrirXML(QString nomFile)
{
    nomFile=nomFile.right(nomFile.size()-7);
    int rc = 0;
    TiXmlDocument doc(nomFile.toStdString().c_str());
    if(!doc.LoadFile())
    {
        qDebug()<<"Fichier introuvable";
        return -1;
    }else
    {
        TiXmlElement* root = doc.FirstChildElement();
        root = root->NextSiblingElement();
        for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
        {
            std::string elemName = elem->Value();
            QString nomAction;
            if(elemName == "Action")
            {
                TiXmlAttribute* e = elem->FirstAttribute();
                if(e!=NULL)
                {
                    std::string s = e->Value();
                    nomAction = QString::fromStdString(s);
                }
                for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
                {
                    std::string elemNameBis = elemBis->Value();
                    if(elemNameBis == "bloc")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        int xBloc,yBloc;
                        if(pAttrib != NULL)
                        {
                            xBloc = (QString::fromStdString(pAttrib->Value())).toInt();
                            pAttrib=pAttrib->Next();
                            yBloc = (QString::fromStdString(pAttrib->Value())).toInt();
                            ouvrirAction(nomAction,xBloc, yBloc);
                        }
                    }else if(elemNameBis == "parametres")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        while (pAttrib)
                        {
                            modifParam(QString::fromStdString(pAttrib->Name()), QString::fromStdString(pAttrib->Value()));
                            pAttrib=pAttrib->Next();
                        }
                    }
                }
            }
        }
    }


    if(!doc.LoadFile())
    {
        qDebug()<<"Fichier introuvable";
        return -1;
    }else
    {
        TiXmlElement* root = doc.FirstChildElement();
        root = root->NextSiblingElement();
        int indiceAction = 0;
        for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
        {
            std::string elemName = elem->Value();
            QString nomAction;
            if(elemName == "Action")
            {
                TiXmlAttribute* e = elem->FirstAttribute();
                if(e!=NULL)
                {
                    std::string s = e->Value();
                    nomAction = QString::fromStdString(s);
                }
                for(TiXmlElement* elemBis = elem->FirstChildElement(); elemBis != NULL; elemBis = elemBis->NextSiblingElement())
                {
                    std::string elemNameBis = elemBis->Value();
                    if(elemNameBis == "fils")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        std::string s = pAttrib->Value();
                        QString listFils = QString::fromStdString(s);
                        QStringList listFilsSplit = listFils.split(";");
                        for(int i=0;i<listFilsSplit.size()-1;i++)
                        {
                            addFils(indiceAction,listFilsSplit.at(i).toInt());
                        }
                        //void addFils(int indiceParent, int indiceFils);

                    }else if(elemNameBis == "timeout")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        std::string s = pAttrib->Value();
                        QString listFils = QString::fromStdString(s);
                        QStringList listFilsSplit = listFils.split(";");
                        for(int i=0;i<listFilsSplit.size()-1;i++)
                        {
                            addTimeOut(indiceAction,listFilsSplit.at(i).toInt());
                        }
                    }
                }
                indiceAction++;
            }

        }
    }
}


void GestionSequence::exportXML(QString nomFile)
{
    nomFile=nomFile.right(nomFile.size()-7);
    TiXmlDocument doc;
    TiXmlElement* msg;
    TiXmlDeclaration* decl = new TiXmlDeclaration( "1.0", "UTF-8", "" );
    doc.LinkEndChild( decl );
    msg = new TiXmlElement( "typeXml" );
    msg->SetAttribute("key", QDateTime::currentDateTimeUtc().toString().toStdString().c_str());
    msg->LinkEndChild( new TiXmlText( "scenario" ));
    doc.LinkEndChild( msg );

    TiXmlElement * root = new TiXmlElement( "Sequence" );
    doc.LinkEndChild( root );
    msg = new TiXmlElement( "version" );
    msg->LinkEndChild( new TiXmlText( "3.1" ));
    root->LinkEndChild( msg );

    for(int i=0;i<listAction.size();i++)
    {

        TiXmlElement * action = new TiXmlElement( "Action" );
        root->LinkEndChild( action );
        action->SetAttribute("type",listAction.at(i)->getNomAction().toStdString().c_str());

        action->SetAttribute("numero", i);

        TiXmlElement * posBloc = new TiXmlElement( "bloc" );
        action->LinkEndChild( posBloc );
        posBloc->SetAttribute("x", listAction.at(i)->getXBloc());
        posBloc->SetAttribute("y", listAction.at(i)->getYBloc());

        QString listFils;
        listFils.clear();

        for(int j=0;j<listAction.at(i)->getNbFille();j++)
        {
            listFils.append(QString::number(listAction.indexOf(listAction.at(i)->getFille(j))));
            listFils.append(";");
        }
        TiXmlElement * posFils = new TiXmlElement( "fils" );
        action->LinkEndChild( posFils );
        posFils->SetAttribute("liste", listFils.toStdString().c_str());

        listFils.clear();
        for(int j=0;j<listAction.at(i)->getNbFilleTimeout();j++)
        {
            listFils.append(QString::number(listAction.indexOf(listAction.at(i)->getFilleTimeout(j))));
            listFils.append(";");
        }
        TiXmlElement * posTimeOut = new TiXmlElement( "timeout" );
        action->LinkEndChild( posTimeOut );
        posTimeOut->SetAttribute("liste", listFils.toStdString().c_str());

        TiXmlElement * param = new TiXmlElement( "parametres" );
        action->LinkEndChild( param );
        for(int j=0;j<listAction.at(i)->getNbParam();j++)
        {
            param->SetAttribute(listAction.at(i)->getNomParam(j).toStdString().c_str(), listAction.at(i)->getValueParam(j).toStdString().c_str());
        }
        //listAction.at(i)->saveXML(action,2);
    }
    doc.SaveFile( nomFile.toStdString().c_str() );
}
