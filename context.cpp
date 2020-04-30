#include "context.h"


QString Context::blurEffect(QVariant obj, int screeshot)
{
    Window desktop = -1;

    if (screeshot == 1)
    {
        unsigned long items;
        Window *list = this->xwindows(&items);
        for (int i = 0; i < items; i++)
        {
            QString type = this->xwindowType(list[i]);
            if (type == "_NET_WM_WINDOW_TYPE_DESKTOP")
            {
                desktop = list[i];
                break;
            }
        }
    }
    else
    {
        desktop = 0;
    }

    if (desktop != -1)
    {
        QPixmap map;
        QScreen *screen = QGuiApplication::primaryScreen();
        if (!obj.isNull())
        {
            QObject *_obj = obj.value<QObject *>();
            if (_obj)
            {
                QWindow *win = qobject_cast<QWindow *>(_obj);
                map = screen->grabWindow(desktop, win->x(), win->y(), win->width(), win->height());
            }
        }
        if (!map.isNull())
        {
            QBuffer buffer;
            buffer.open(QIODevice::ReadWrite);
            map.save(&buffer, "jpg");
            const QByteArray bytes = buffer.buffer();
            buffer.close();
            QString base64("data:image/jpg;base64,");
            base64.append(QString::fromLatin1(bytes.toBase64().data()));
            return base64;
        }
    }
    return "";
}

void Context::windowMove(int x, int y, int w, int h)
{
    util.xwindowMove(window->winId(), x, y, w, h);
}

QString Context::getImgBackground()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
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
    QString tmp = dir.homePath() + "/.config/synth/desktop/wallpaper/thumbs";
    QStringList lista;

    for (QFileInfo info : dir.entryInfoList(QDir::Files | QDir::NoDot | QDir::NoDotAndDotDot))
    {
        QString name = info.fileName().toLower();
        if (name.contains(".jpg") || name.contains(".png") || name.contains(".jpeg"))
        {
            dir.mkpath(tmp + info.absolutePath());
            QString imgTemp = tmp + info.absolutePath() + "/" + info.fileName() + "-" + info.suffix() + ".jpg";
            QFile file(imgTemp);
            file.open(QFile::ReadOnly);

            if (!file.exists())
            {
                QImage image(info.absoluteFilePath());
                if (!image.isNull())
                {
                    image = image.scaled(140, 100, Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
                    if (image.save(imgTemp, "jpg"))
                    {
                        lista << "file://" + imgTemp + ",file://" + info.absoluteFilePath();
                    }
                }
            }
            else
            {
                lista << "file://" + imgTemp + ",file://" + info.absoluteFilePath();
            }
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
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    settings.setValue("background", bg);
}

void Context::backgroundPath(QString bg)
{
    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    settings.setValue("path", bg);
}

QString Context::backgroundPath()
{
    QDir dir;
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
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
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
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
    QString path = dir.homePath() + "/.config/synth/desktop/";
    QSettings settings(path + "settings.conf", QSettings::NativeFormat);
    settings.beginGroup("wallpaper");
    pos << settings.value("x").toString();
    pos << settings.value("y").toString();
    pos << settings.value("w").toString();
    pos << settings.value("h").toString();
    settings.endGroup();
    return pos;
}
