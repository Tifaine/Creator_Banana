#include "gestionsequence.h"

GestionSequence::GestionSequence()
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

void GestionSequence::supprimerBloc(int index)
{
    listAction.removeAt(index);
}

int GestionSequence::ouvrirXML(QString nomFile, int indice)
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
                            ouvrirAction(nomAction,xBloc, yBloc,indice);
                        }
                    }else if(elemNameBis == "parametres")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        while (pAttrib)
                        {
                            modifParam(QString::fromStdString(pAttrib->Name()), QString::fromStdString(pAttrib->Value()),indice);
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
                            addFils(indiceAction,listFilsSplit.at(i).toInt(),indice);
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
                            addTimeOut(indiceAction,listFilsSplit.at(i).toInt(),indice);
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
        if(listAction.at(i)->getIsActionBlocante())
        {
            action->SetAttribute("timeout", listAction.at(i)->getValueParam(0).toStdString().c_str());
        }

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
        if(listAction.at(i)->getIsActionBlocante())
        {
            listFils.clear();
            for(int j=0;j<listAction.at(i)->getNbFilleTimeout();j++)
            {
                listFils.append(QString::number(listAction.indexOf(listAction.at(i)->getFilleTimeout(j))));
                listFils.append(";");
            }
            TiXmlElement * posTimeOut = new TiXmlElement( "timeout" );
            action->LinkEndChild( posTimeOut );
            posTimeOut->SetAttribute("liste", listFils.toStdString().c_str());
        }
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


void GestionSequence::exportVersRobot()
{
    int indiceSequence = 1;
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
        if(listAction.at(i)->getNomAction().compare("Sequence")==0)
        {
            QString listFils;
            listFils.clear();

            for(int j=0;j<listAction.at(i)->getNbFille();j++)
            {
                listFils.append(QString::number(listAction.indexOf(listAction.at(i)->getFille(j))));
                listFils.append(";");
            }
            openSequence(listAction.at(i)->getValueParam(0),&indiceSequence,listFils,root,i);
            indiceSequence++;
        }else
        {
            TiXmlElement * action = new TiXmlElement( "Action" );
            root->LinkEndChild( action );
            action->SetAttribute("type",listAction.at(i)->getNomAction().toStdString().c_str());

            action->SetAttribute("numero", i);
            if(listAction.at(i)->getIsActionBlocante())
            {
                action->SetAttribute("timeout", listAction.at(i)->getValueParam(0).toStdString().c_str());
            }

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


            if(listAction.at(i)->getIsActionBlocante())
            {
                listFils.clear();
                for(int j=0;j<listAction.at(i)->getNbFilleTimeout();j++)
                {
                    listFils.append(QString::number(listAction.indexOf(listAction.at(i)->getFilleTimeout(j))));
                    listFils.append(";");
                }
                TiXmlElement * posTimeOut = new TiXmlElement( "timeout" );
                action->LinkEndChild( posTimeOut );
                posTimeOut->SetAttribute("liste", listFils.toStdString().c_str());
            }


            TiXmlElement * param = new TiXmlElement( "parametres" );
            action->LinkEndChild( param );
            for(int j=0;j<listAction.at(i)->getNbParam();j++)
            {
                param->SetAttribute(listAction.at(i)->getNomParam(j).toStdString().c_str(), listAction.at(i)->getValueParam(j).toStdString().c_str());
            }
        }

        //listAction.at(i)->saveXML(action,2);
    }
    doc.SaveFile( "/tmp/temp.xml" );
}

void GestionSequence::openSequence(QString nomSequence, int *indiceSequence, QString listFilsParent, TiXmlElement * root, int indiceParent)
{
    QString nomToSend;
    nomToSend.append("res/Sequence/");
    nomToSend.append(nomSequence);
    QList<EditableAction*> listActionBis;
    getSequence(nomToSend,&listActionBis);
    int localIndiceSequence = *indiceSequence;


    for(int i=0;i<listActionBis.size();i++)
    {

        if(listActionBis.at(i)->getNomAction().compare("Sequence")==0)
        {
            QString listFils;
            listFils.clear();

            for(int j=0;j<listActionBis.at(i)->getNbFille();j++)
            {
                listFils.append(QString::number(listActionBis.indexOf(listActionBis.at(i)->getFille(j))));
                listFils.append(";");
            }
            (*indiceSequence)++;
            openSequence(listActionBis.at(i)->getValueParam(0),indiceSequence,listFils,root,i+10000*(localIndiceSequence));

        }else
        {
            TiXmlElement * action = new TiXmlElement( "Action" );
            root->LinkEndChild( action );
            action->SetAttribute("type",listActionBis.at(i)->getNomAction().toStdString().c_str());
            if(listActionBis.at(i)->getNomAction().compare("Depart")==0)
            {
                action->SetAttribute("numero", indiceParent);
            }else
            {
                action->SetAttribute("numero", i+10000*(localIndiceSequence));
                if(listActionBis.at(i)->getIsActionBlocante())
                {
                    action->SetAttribute("timeout", listActionBis.at(i)->getValueParam(0).toStdString().c_str());
                }
            }


            TiXmlElement * posBloc = new TiXmlElement( "bloc" );
            action->LinkEndChild( posBloc );
            posBloc->SetAttribute("x", listActionBis.at(i)->getXBloc());
            posBloc->SetAttribute("y", listActionBis.at(i)->getYBloc());
            QString listFils;
            listFils.clear();
            if(listActionBis.at(i)->getNomAction().compare("Fin")==0)
            {
                TiXmlElement * posFils = new TiXmlElement( "fils" );
                action->LinkEndChild( posFils );
                posFils->SetAttribute("liste", listFilsParent.toStdString().c_str());
            }else
            {
                for(int j=0;j<listActionBis.at(i)->getNbFille();j++)
                {
                    listFils.append(QString::number(listActionBis.indexOf(listActionBis.at(i)->getFille(j))+10000*(localIndiceSequence)));
                    listFils.append(";");
                }
                TiXmlElement * posFils = new TiXmlElement( "fils" );
                action->LinkEndChild( posFils );
                posFils->SetAttribute("liste", listFils.toStdString().c_str());
            }

            if(listActionBis.at(i)->getIsActionBlocante())
            {
                listFils.clear();
                for(int j=0;j<listActionBis.at(i)->getNbFilleTimeout();j++)
                {
                    listFils.append(QString::number(listActionBis.indexOf(listActionBis.at(i)->getFilleTimeout(j))+10000*(localIndiceSequence)));
                    listFils.append(";");
                }
                TiXmlElement * posTimeOut = new TiXmlElement( "timeout" );
                action->LinkEndChild( posTimeOut );
                posTimeOut->SetAttribute("liste", listFils.toStdString().c_str());
            }


            TiXmlElement * param = new TiXmlElement( "parametres" );
            action->LinkEndChild( param );
            for(int j=0;j<listActionBis.at(i)->getNbParam();j++)
            {
                param->SetAttribute(listActionBis.at(i)->getNomParam(j).toStdString().c_str(), listActionBis.at(i)->getValueParam(j).toStdString().c_str());
            }
        }

        //listAction.at(i)->saveXML(action,2);
    }
}

void GestionSequence::getSequence(QString nomFichier, QList<EditableAction*>* listActionBis)
{

    int rc = 0;
    TiXmlDocument doc(nomFichier.toStdString().c_str());
    if(!doc.LoadFile())
    {
        qDebug()<<"Fichier introuvable";

    }else
    {
        TiXmlElement* root = doc.FirstChildElement();
        root = root->NextSiblingElement();
        for(TiXmlElement* elem = root->FirstChildElement(); elem != NULL; elem = elem->NextSiblingElement())
        {
            std::string elemName = elem->Value();
            if(elemName == "Action")
            {
                listActionBis->append(new EditableAction);
                TiXmlAttribute* e = elem->FirstAttribute();
                if(e!=NULL)
                {
                    std::string s = e->Value();
                    listActionBis->last()->setNomAction(QString::fromStdString(s));
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
                            listActionBis->last()->setXBloc(xBloc);
                            listActionBis->last()->setYBloc(yBloc);
                        }
                    }else if(elemNameBis == "parametres")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        while (pAttrib)
                        {
                            // modifParam(QString::fromStdString(pAttrib->Name()), QString::fromStdString(pAttrib->Value()),indice);
                            listActionBis->last()->ajoutParametre(QString::fromStdString(pAttrib->Name()), QString::fromStdString(pAttrib->Value()));
                            pAttrib=pAttrib->Next();
                        }
                    }

                }
            }
        }
    }

    int indiceAction = 0;
    if(!doc.LoadFile())
    {
        qDebug()<<"Fichier introuvable";
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
                listActionBis->at(indiceAction)->setIsActionBlocante(false);
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
                            listActionBis->at(indiceAction)->ajoutActionFille(listActionBis->at(listFilsSplit.at(i).toInt()));
                        }


                    }else if(elemNameBis == "timeout")
                    {
                        TiXmlAttribute* pAttrib=elemBis->FirstAttribute();
                        std::string s = pAttrib->Value();
                        QString listFils = QString::fromStdString(s);
                        QStringList listFilsSplit = listFils.split(";");
                        listActionBis->at(indiceAction)->setIsActionBlocante(true);
                        for(int i=0;i<listFilsSplit.size()-1;i++)
                        {
                            listActionBis->at(indiceAction)->ajoutActionFilleTimeOut(listActionBis->at(listFilsSplit.at(i).toInt()));
                        }
                    }
                }
                indiceAction++;
            }
        }
    }
}
