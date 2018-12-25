#include "gestionsequence.h"

GestionSequence::GestionSequence(QObject *parent) : QObject(parent)
{

}

void GestionSequence::ajoutAction(EditableAction* act)
{
    listAction.append(act);
}
