#ifndef GESTIONSEQUENCE_H
#define GESTIONSEQUENCE_H

#include <QObject>
#include <QDateTime>
#include <QList>

#include "editableaction.h"
#include "../libXML/tinystr.h"
#include "../libXML/tinyxml.h"

class GestionSequence : public QObject
{
    Q_OBJECT
public:
    GestionSequence(QObject *parent = nullptr);
public slots:
    void ajoutAction(EditableAction* act);

    void clearList();
    int ouvrirXML(QString nomFile);
    void exportXML(QString nomFile);
signals:
    void modifParam(QString nom, QString value);
    void ouvrirAction(QString nomAction,int xBloc, int yBloc);
    void addFils(int indiceParent, int indiceFils);
    void addTimeOut(int indiceParent, int indiceFils);
private:
    QList<EditableAction*> listAction;
};

#endif // GESTIONSEQUENCE_H
