#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QWindow>
#include <QPoint>
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

    app.setAttribute(Qt::AA_EnableHighDpiScaling);

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
            settings.beginGroup("wallpaper");
            settings.setValue("x", 0);
            settings.setValue("y", 0);
            settings.setValue("w", 770);
            settings.setValue("h", 600);
            settings.endGroup();
        }
        file.close();
    }

    Context *context = new Context();
    QQuickImage image;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Context", context);
    engine.addImageProvider("pixmap", &image);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject *main = engine.rootObjects().first();
    QWindow *window = qobject_cast<QWindow *>(main);
    context->window = window;

    return app.exec();
}
