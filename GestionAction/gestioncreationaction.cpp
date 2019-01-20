#include "gestioncreationaction.h"

GestionCreationAction::GestionCreationAction(GestionTypeAction *gestType, QObject *parent) : QObject(parent)
{
    _gestType = gestType;
}

void GestionCreationAction::saveAction()
{
    QString nomFile;
    nomFile.append("res/bloc/");
    nomFile.append(editAction.getNomAction());
    nomFile.append(".xml");
    qDebug()<<nomFile<<" coucou";
    TiXmlDocument doc;
    TiXmlElement* msg;
    TiXmlElement* msg2;
    TiXmlDeclaration* decl = new TiXmlDeclaration( "1.0", "UTF-8", "" );
    doc.LinkEndChild( decl );

    TiXmlElement * root = new TiXmlElement( "Action" );
    doc.LinkEndChild( root );
    msg = new TiXmlElement( "nom" );
    msg->LinkEndChild( new TiXmlText( editAction.getNomAction().toStdString().c_str() ));
    root->LinkEndChild( msg );
    msg = new TiXmlElement( "isActionBlocante" );
    msg->LinkEndChild( new TiXmlText( QString::number(editAction.getIsActionBlocante()).toStdString().c_str() ));
    root->LinkEndChild( msg );
    for(int i=0;i<editAction.getNbParam();i++)
    {
        msg = new TiXmlElement( "Param" );
        root->LinkEndChild( msg );
        msg->SetAttribute("name",editAction.getNomParam(i).toStdString().c_str());
        msg->SetAttribute("valueDefault",editAction.getValueParam(i).toStdString().c_str());
        for(int j=0;j<editAction.getNbAlias(editAction.getNomParam(i));j++)
        {
            msg2 = new TiXmlElement( "Alias" );
            msg->LinkEndChild( msg2 );
            msg2->SetAttribute("name",editAction.getNomAlias(editAction.getNomParam(i),j).toStdString().c_str());
            msg2->SetAttribute("valueAlias",editAction.getValueAlias(editAction.getNomParam(i),j).toStdString().c_str());
        }
    }
    doc.SaveFile( nomFile.toStdString().c_str());
}

void GestionCreationAction::clearParam()
{
    editAction.clearParam();
}

void GestionCreationAction::clearAlias(QString nom)
{
    editAction.clearAlias(nom);
}

QString GestionCreationAction::getNomAction() const
{
    return editAction.getNomAction();
}

void GestionCreationAction::setNomAction(const QString &value)
{
    editAction.setNomAction(value);
}

bool GestionCreationAction::getIsActionBlocante() const
{
    return editAction.getIsActionBlocante();
}

void GestionCreationAction::setIsActionBlocante(bool value)
{
    editAction.setIsActionBlocante(value);
}

void GestionCreationAction::setNouveauParam(QString nom, QString valueDefault)
{
    editAction.ajoutParametre(nom,valueDefault);
}

void GestionCreationAction::setNomParam(int indiceParam, QString newNom)
{
    editAction.setNomParam(indiceParam,newNom);
}

void GestionCreationAction::setValueParam(int indiceParam, QString newValue)
{
    editAction.setValueParam(indiceParam,newValue);
}

void GestionCreationAction::setNomAlias(QString nameParam, int indiceAlias, QString nameAlias)
{
    editAction.setNomAlias(nameParam,indiceAlias,nameAlias);
}

void GestionCreationAction::setValueAlias(QString nameParam, int indiceAlias, QString valueAlias)
{
    editAction.setValueAlias(nameParam,indiceAlias,valueAlias);
}

void GestionCreationAction::ajoutNouveauAlias(QString nomParam, QString nom, QString value)
{
    editAction.ajoutAlias(nomParam,nom,value);
}

int GestionCreationAction::getNbAlias(QString nameParam)
{
    return editAction.getNbAlias(nameParam);
}

QString GestionCreationAction::getNomAlias(QString nameParam, int indiceAlias)
{
    return editAction.getNomAlias(nameParam,indiceAlias);
}

QString GestionCreationAction::getValueAlias(QString nameParam, int indiceAlias)
{
    return editAction.getValueAlias(nameParam, indiceAlias);
}
