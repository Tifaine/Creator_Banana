#ifndef GESTIONSEQUENCE_H
#define GESTIONSEQUENCE_H

#include <QObject>
#include <QQuickItem>
#include <QDateTime>
#include <QList>

#include "editableaction.h"
#include "../libXML/tinystr.h"
#include "../libXML/tinyxml.h"

class GestionSequence : public QQuickItem
{
    Q_OBJECT
public:
    GestionSequence();
public slots:
    void ajoutAction(EditableAction* act);

    void clearList();
    int ouvrirXML(QString nomFile, int indice);
    void exportXML(QString nomFile);
    void exportVersRobot();

signals:
    void modifParam(QString nom, QString value, int indiceTab);
    void ouvrirAction(QString nomAction,int xBloc, int yBloc, int indiceTab);
    void addFils(int indiceParent, int indiceFils, int indiceTab);
    void addTimeOut(int indiceParent, int indiceFils, int indiceTab);
private:
    void openSequence(QString nomSequence, int* indiceSequence, QString listFilsParent, TiXmlElement * root, int indiceParent);
    QList<EditableAction*> listAction;
    void getSequence(QString nomFichier, QList<EditableAction *> *listActionBis);
};

#endif // GESTIONSEQUENCE_H
