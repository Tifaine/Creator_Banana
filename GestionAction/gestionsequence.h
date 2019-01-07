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
    void exportXML();
private:
    QList<EditableAction*> listAction;
};

#endif // GESTIONSEQUENCE_H
