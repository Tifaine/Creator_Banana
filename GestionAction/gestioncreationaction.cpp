#include "gestioncreationaction.h"

GestionCreationAction::GestionCreationAction(QObject *parent) : QObject(parent)
{

}

void GestionCreationAction::saveAction()
{
    QString nomFile;
    nomFile.append("res/");
    nomFile.append(nomAction);
    nomFile.append(".xml");
    TiXmlDocument doc;
    TiXmlElement* msg;
    TiXmlDeclaration* decl = new TiXmlDeclaration( "1.0", "UTF-8", "" );
    doc.LinkEndChild( decl );

    TiXmlElement * root = new TiXmlElement( "Action" );
    doc.LinkEndChild( root );
    msg = new TiXmlElement( "nom" );
    msg->LinkEndChild( new TiXmlText( nomAction.toStdString().c_str() ));
    root->LinkEndChild( msg );
    msg = new TiXmlElement( "isActionBlocante" );
    msg->LinkEndChild( new TiXmlText( QString::number(isActionBlocante).toStdString().c_str() ));
    root->LinkEndChild( msg );
    for(int i=0;i<listParam.size();i++)
    {
        msg = new TiXmlElement( "Param" );
        root->LinkEndChild( msg );
        msg->SetAttribute("name",listParam.at(i).nomParam.toStdString().c_str());
        msg->SetAttribute("valueDefault",listParam.at(i).valueDefault.toStdString().c_str());
    }

    doc.SaveFile( nomFile.toStdString().c_str() );

    listParam.clear();
}

QString GestionCreationAction::getNomAction() const
{
    return nomAction;
}

void GestionCreationAction::setNomAction(const QString &value)
{
    nomAction = value;
}

bool GestionCreationAction::getIsActionBlocante() const
{
    return isActionBlocante;
}

void GestionCreationAction::setIsActionBlocante(bool value)
{
    isActionBlocante = value;
}

QString GestionCreationAction::getCategorieAction() const
{
    return categorieAction;
}

void GestionCreationAction::setCategorieAction(const QString &value)
{
    categorieAction = value;
}

void GestionCreationAction::setNouveauParam(QString nom, QString valueDefault)
{
    param nouveauParam;
    nouveauParam.nomParam = nom;
    nouveauParam.valueDefault = valueDefault;

    listParam.append(nouveauParam);
}
