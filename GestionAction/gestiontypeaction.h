#ifndef GESTIONTYPEACTION_H
#define GESTIONTYPEACTION_H

#include <QObject>
#include <QDebug>
#include <QDir>
#include <QList>

#include "action.h"

#include "../libXML/tinyxml.h"
#include "../libXML/tinystr.h"

class GestionTypeAction : public QObject
{
    Q_OBJECT
public:
    explicit GestionTypeAction(QObject *parent = nullptr);

signals:
    void finUpdate();
public slots:
    void update();
    int getNbAction();
    QString getNomAction(int indice);

    int getNbParam(int indice);
    QString getNameParam(int indiceAction, int indiceParam);
    QString getValueParam(int indiceAction, int indiceParam);
    int getIndiceByName(QString name);
    bool getIsBlocant(int indiceAction);

private:
    QList<Action*> listAction;


};

#endif // GESTIONTYPEACTION_H
