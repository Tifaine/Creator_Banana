#ifndef ACTION_H
#define ACTION_H

#include <QString>
#include <QList>

typedef struct parametre
{
    QString nomParam;
    QString valueDefault;
}parametre;


class Action
{
public:
    explicit Action();

    QString getNomAction() const;
    void setNomAction(const QString &value);

    bool getIsBlocant() const;
    void setIsBlocant(bool value);

    void setNouveauParam(QString nom, QString valueDefault);

    int getNbParam();
    QString getNomParam(int indice);
    QString getDefaultValueParam(int indice);

private:
    QString nomAction;
    bool isBlocant;
    QList<parametre> listParam;

};

#endif // ACTION_H
