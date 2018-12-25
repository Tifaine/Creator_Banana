#include "editableaction.h"

EditableAction::EditableAction()
{

}

int EditableAction::getYBloc() const
{
    return yBloc;
}

void EditableAction::setYBloc(int value)
{
    yBloc = value;
}

int EditableAction::getXBloc() const
{
    return xBloc;
}

void EditableAction::setXBloc(int value)
{
    xBloc = value;
}
