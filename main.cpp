#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "GestionAction/gestioncreationaction.h"
#include "GestionAction/gestiontypeaction.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    GestionCreationAction gestAction;
    GestionTypeAction gestTypeAction;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("gestAction", &gestAction);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
