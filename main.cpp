#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "readdata.h"
#include <QQmlContext>
#include <QtQml>
#include "getalbumimg.h"
#include <QUrl>

int main(int argc, char *argv[])
{
    ReadData readData;
    GetAlbumImg getAlbumImg;
    qmlRegisterSingletonInstance<ReadData>("SendData",1,0,"ReadData",ReadData::getInstance());
    qmlRegisterType<ReadData>("SendData",1,0,"ReadData");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QQuickView view;
    engine.load(QUrl(QStringLiteral("main.qml")));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);


    engine.rootContext()->setContextProperty("SendData",&readData);
    engine.rootContext()->setContextProperty("mediaPlayer_I",&getAlbumImg);
    view.rootContext()->setContextProperty("mediaPlayer_I",&getAlbumImg);
    view.setSource(QUrl("file://main.qml"));

    engine.loadFromModule("FFMusic", "Main");

    //engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
