#include "gestionsequence.h"

GestionSequence::GestionSequence(QObject *parent) : QObject(parent)
{

}

void GestionSequence::ajoutAction(EditableAction* act)
{
    listAction.append(act);
}


void GestionSequence::exportXML()
{
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

        if(listAction.at(i)->getIsActionBlocante()==true)
        {
            //MUST CHANGE TIMEOUT MANAGMENT
            action->SetAttribute("timeout", 5000);
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
    qDebug()<<"Coucou";
    doc.SaveFile( "out/temp.xml" );
}
