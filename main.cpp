#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QWindow>
#include <QDir>
#include <QFile>
#include <QString>
#include <QSettings>
#include <unistd.h>
#include "qquickimage.h"
#include "context.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QFile file(path + "settings.conf");

    if(!dir.exists(path))
    {
        dir.mkpath(path);
    }

    if(!file.exists())
    {
        if (file.open(QIODevice::ReadWrite))
        {
            QSettings settings(path + "settings.conf", QSettings::NativeFormat);
            settings.setValue("background", "file:///usr/share/backgrounds/elementaryos-default");
        }

        file.close();
    }

    Context *context = new Context();
    QQuickImage image;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Context", context);
    engine.addImageProvider("pixmap", &image);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
