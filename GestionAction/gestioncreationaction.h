#ifndef GESTIONCREATIONACTION_H
#define GESTIONCREATIONACTION_H

#include <QObject>
#include <QList>
#include <QDebug>
#include "../libXML/tinyxml.h"
#include "../libXML/tinystr.h"

typedef struct param
{
    QString nomParam;
    QString valueDefault;
}param;

class GestionCreationAction : public QObject
{
    Q_OBJECT
public:
    explicit GestionCreationAction(QObject *parent = nullptr);



signals:

public slots:
    void saveAction();

    QString getNomAction() const;
    void setNomAction(const QString &value);

    bool getIsActionBlocante() const;
    void setIsActionBlocante(bool value);

    QString getCategorieAction() const;
    void setCategorieAction(const QString &value);

    void setNouveauParam(QString nom, QString valueDefault);

private:
    QString nomAction;
    bool isActionBlocante;
    QString categorieAction;
    QList<param> listParam;
};

#endif // GESTIONCREATIONACTION_H
