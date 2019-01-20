#ifndef GESTIONCREATIONACTION_H
#define GESTIONCREATIONACTION_H

#include <QObject>
#include <QList>

#include <QDebug>
#include "../libXML/tinyxml.h"
#include "../libXML/tinystr.h"
#include "gestiontypeaction.h"
#include "editableaction.h"

/*


  Modifier pour avoir toujours une action en cours et pas qu'au lancement.
  je peux le faire.


  */

class GestionCreationAction : public QObject
{
    Q_OBJECT
public:
    explicit GestionCreationAction(GestionTypeAction* gestType, QObject *parent = nullptr);

signals:

public slots:
    void saveAction();
    void clearParam();
    QString getNomAction() const;

    void setNomAction(const QString &value);

    bool getIsActionBlocante() const;
    void setIsActionBlocante(bool value);

    void clearAlias(QString nom);


    void setNouveauParam(QString nom, QString valueDefault);

    int getNbParam(){return editAction.getNbParam();}
    void setNomParam(int indiceParam, QString newNom);
    void setValueParam(int indiceParam, QString newValue);
    void ajoutNouveauAlias(QString nomParam, QString nom, QString value);

    void setNomAlias(QString nameParam, int indiceAlias, QString nameAlias);
    void setValueAlias(QString nameParam, int indiceAlias, QString valueAlias);
    int getNbAlias(QString nameParam);
    QString getNomAlias(QString nameParam, int indiceAlias);
    QString getValueAlias(QString nameParam, int indiceAlias);


private:

    EditableAction editAction;
    GestionTypeAction* _gestType;
};

#endif // GESTIONCREATIONACTION_H
