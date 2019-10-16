#include "context.h"


QString Context::getImgBackground()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/Synth/desktop/";
    QSettings settings(path + "settings.txt", QSettings::NativeFormat);
    return settings.value("background").toString();
}

void Context::copy(QString from,QString to)
{
    QFile file(QUrl(from).toLocalFile());
    QString args;

    for (int i =0; ; i++)
    {
        if (i > 0)
        {
            args = "(" + QString::number(i) + ") ";
        } else
        {
            args = "";
        }

        QString fname = to + args + file.fileName().split('/').last();
        QFile f(fname);

        if (!f.exists()) {
            file.copy(fname);
            break;
        }
    }
}

int Context::mouseX()
{
    QPoint Mouse = QCursor::pos(this->screen);
    return Mouse.x();
}

int Context::mouseY()
{
    QPoint Mouse = QCursor::pos(this->screen);
    return Mouse.y();
}

QStringList Context::backgrouds(QString path)
{
    QDir dir(path);
    QStringList lista;

    for (QFileInfo info : dir.entryInfoList(QDir::Files | QDir::NoDot | QDir::NoDotAndDotDot))
    {
        QString name = info.fileName().toLower();
        if (name.contains(".jpg") || name.contains(".png") || name.contains(".jpeg") || name.contains(".mp4"))
        {
            lista << "file://" + info.absoluteFilePath();
        }
    }

    return lista;
}

void Context::backgroundChange(QString bg)
{
//    QDBusMessage msg = QDBusMessage::createSignal("/", "org.example.chat", "backgroundChange");
//    msg << "ok";
//    QDBusConnection::sessionBus().send(msg);

    QDBusInterface iface("emmi.interface.background", "/", "emmi.interface.background", QDBusConnection::sessionBus());
    if (iface.isValid())
    {
        iface.call("BgConnect", bg);
    }

    QDBusInterface iface2("emmi.interface.wallpaper", "/", "emmi.interface.wallpaper", QDBusConnection::sessionBus());
    if (iface2.isValid())
    {
        iface2.call("BgConnect", bg);
    }

    QDir dir;
    QString path = dir.homePath() + "/.config/Synth/desktop/";
    QSettings settings(path + "settings.txt", QSettings::NativeFormat);
    settings.setValue("background", bg);
}

void Context::backgroundPath(QString bg)
{
    QDir dir;
    QString path = dir.homePath() + "/.config/Synth/desktop/";
    QSettings settings(path + "settings.txt", QSettings::NativeFormat);
    settings.setValue("path", bg);
}

QString Context::backgroundPath()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/Synth/desktop/";
    QSettings settings(path + "settings.txt", QSettings::NativeFormat);
    path = settings.value("path").toString();
    if (path.isEmpty()) path = "/usr/share/backgrounds/";
    return path;
}

void Context::allDesktop()
{
//    util.openboxChange(window->winId(), ALL_DESKTOPS);
//    util.xchange(window->winId(), "_NET_WM_WINDOW_TYPE_DESKTOP");
    QObject *obj = this->engine->rootObjects().first();
    QWindow *window = qobject_cast<QWindow *>(obj);

    util.openboxChange(window->winId(), ALL_DESKTOPS);
    util.xchange(window->winId(), "_NET_WM_WINDOW_TYPE_DESKTOP");
}

void Context::positions(int x, int y, int w, int h)
{
    QDir dir;
    QString path = dir.homePath() + "/.config/Synth/desktop/";
    QSettings settings(path + "settings.txt", QSettings::NativeFormat);
    settings.beginGroup("wallpaper");
    settings.setValue("x", x);
    settings.setValue("y", y);
    settings.setValue("w", w);
    settings.setValue("h", h);
    settings.endGroup();
}

QStringList Context::positions()
{
    QStringList pos;
    QDir dir;
    QString path = dir.homePath() + "/.config/Synth/desktop/";
    QSettings settings(path + "settings.txt", QSettings::NativeFormat);
    settings.beginGroup("wallpaper");
    pos << settings.value("x").toString();
    pos << settings.value("y").toString();
    pos << settings.value("w").toString();
    pos << settings.value("h").toString();
    settings.endGroup();
    return pos;
}
