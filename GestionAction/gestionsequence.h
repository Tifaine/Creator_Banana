#ifndef GESTIONSEQUENCE_H
#define GESTIONSEQUENCE_H

#include <QObject>
#include <QList>

#include "editableaction.h"

class GestionSequence : public QObject
{
    Q_OBJECT
public:
    GestionSequence(QObject *parent = nullptr);
public slots:
    void ajoutAction(EditableAction* act);
private:
    QList<EditableAction*> listAction;
};

#endif // GESTIONSEQUENCE_H
