#ifndef EDITABLEACTION_H
#define EDITABLEACTION_H

#include <QQuickItem>

class EditableAction : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(int xBloc READ getXBloc WRITE setXBloc NOTIFY xBlocChanged)
    Q_PROPERTY(int yBloc READ getYBloc WRITE setYBloc NOTIFY yBlocChanged)
public:
    EditableAction();
    void setXBloc(int value);
    void setYBloc(int value);

signals:
    void xBlocChanged();
    void yBlocChanged();

public slots:
    int getXBloc() const;
    int getYBloc() const;

private:
    int xBloc;
    int yBloc;
};

#endif // EDITABLEACTION_H
