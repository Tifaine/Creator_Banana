#ifndef EDITABLEACTION_H
#define EDITABLEACTION_H

#include <QQuickItem>
#include <QList>

typedef struct parametreEditable
{
    QString nomParam;
    QString valueParam;
}parametreEditable;

class EditableAction : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString nomAction READ getNomAction WRITE setNomAction NOTIFY nomActionChanged)
    Q_PROPERTY(int xBloc READ getXBloc WRITE setXBloc NOTIFY xBlocChanged)
    Q_PROPERTY(int yBloc READ getYBloc WRITE setYBloc NOTIFY yBlocChanged)
public:
    EditableAction();
    void setXBloc(int value);
    void setYBloc(int value);

    QString getNomAction() const;
    void setNomAction(const QString &value);

signals:
    void xBlocChanged();
    void yBlocChanged();
    void nomActionChanged();

public slots:
    int getXBloc() const;
    int getYBloc() const;
    void modifierValue(QString nomParam, QString nouvelleValue);
    void ajoutParametre(QString nomParam, QString value);

private:
    int xBloc;
    int yBloc;
    QString nomAction;
    QList<parametreEditable*> listParam;
};

#endif // EDITABLEACTION_H
