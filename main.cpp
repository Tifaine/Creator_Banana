#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "GestionAction/editableaction.h"
#include "GestionAction/gestioncreationaction.h"
#include "GestionAction/gestiontypeaction.h"
#include "GestionAction/gestionsequence.h"
#include "ElementQML/connector.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    GestionTypeAction gestTypeAction;
    GestionCreationAction gestAction(&gestTypeAction);
    //GestionSequence gestSequence;

    qmlRegisterType<EditableAction>("editableAction", 1, 0, "EditableAction");
    qmlRegisterType<GestionSequence>("gestionSequence", 1, 0, "GestionSequence");
    qmlRegisterType<connector>("connector", 1, 0, "Liaison");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("gestAction", &gestAction);
    engine.rootContext()->setContextProperty("gestTypeAction", &gestTypeAction);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
