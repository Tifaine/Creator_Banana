#ifndef EDITABLEACTION_H
#define EDITABLEACTION_H

#include <QQuickItem>
#include <QList>
typedef struct parametreEditable
{
    QString nomParam;
    QString valueParam;
    QList<QString>* nomAlias;
    QList<QString>* valueAlias;
}parametreEditable;

class EditableAction : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString nomAction READ getNomAction WRITE setNomAction NOTIFY nomActionChanged)
    Q_PROPERTY(bool isActionBlocante READ getIsActionBlocante WRITE setIsActionBlocante NOTIFY isActionBlocanteChanged)
    Q_PROPERTY(int xBloc READ getXBloc WRITE setXBloc NOTIFY xBlocChanged)
    Q_PROPERTY(int yBloc READ getYBloc WRITE setYBloc NOTIFY yBlocChanged)
public:
    EditableAction();
    void setXBloc(int value);
    void setYBloc(int value);

    QString getNomAction() const;
    void setNomAction(const QString &value);

    bool getIsActionBlocante() const;
    void setIsActionBlocante(bool value);

    int getNbFille(){return listActionFille.size();}
    EditableAction* getFille(int indice){return listActionFille.at(indice);}

    int getNbFilleTimeout(){return listActionFilleTimeOut.size();}
    EditableAction* getFilleTimeout(int indice){return listActionFilleTimeOut.at(indice);}

    int getNbParam(){return listParam.size();}
    QString getNomParam(int indice){return listParam.at(indice)->nomParam;}
    QString getValueParam(int indice){return listParam.at(indice)->valueParam;}
    void setNomParam(int indiceParam, QString newNom);
    void setValueParam(int indiceParam, QString newValue);



    void setNomAlias(QString nameParam, int indiceAlias, QString nameAlias);
    void setValueAlias(QString nameParam, int indiceAlias, QString valueAlias);

    void clearAlias(QString nameParam);

    void clearParam(){listParam.clear();}



signals:
    void xBlocChanged();
    void yBlocChanged();
    void nomActionChanged();
    void isActionBlocanteChanged();


public slots:
    int getXBloc() const;
    int getYBloc() const;

    int getNbAlias(QString nameParam);
    QString getNomAlias(QString nameParam, int indiceAlias);
    QString getValueAlias(QString nameParam, int indiceAlias);
    void modifierValue(QString nomParam, QString nouvelleValue);
    void ajoutParametre(QString nomParam, QString value);
    void ajoutAlias(QString nomParam, QString nom, QString value);
    void ajoutActionFille(EditableAction * act);
    void ajoutActionFilleTimeOut(EditableAction * act);

    void supprimerFils(EditableAction* act);

private:
    bool isActionBlocante;
    int xBloc;
    int yBloc;
    QString nomAction;
    QList<EditableAction*> listActionFille;
    QList<EditableAction*> listActionFilleTimeOut;
    QList<parametreEditable*> listParam;

};

#endif // EDITABLEACTION_H
