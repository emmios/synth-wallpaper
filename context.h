#ifndef CONTEXT_H
#define CONTEXT_H


#include <QObject>
#include <QString>
#include <QFile>
#include <QUrl>
#include <QDebug>
#include <QStringList>
#include <QFileInfoList>
#include <QFileInfo>
#include <QScreen>
#include <QPoint>
#include <QCursor>
#include <QApplication>
#include <QDBusMessage>
#include <QDBusConnection>
#include <QDBusInterface>
#include <QDir>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QWindow>
#include <QProcess>
#include <QSettings>
#include <QX11Info>

#include "xlibutil.h"


class Context : public QObject
{

    Q_OBJECT

public:
    Q_INVOKABLE QString getImgBackground();
    Q_INVOKABLE void copy(QString from,QString to);
    Q_INVOKABLE QStringList backgrouds(QString path);
    Q_INVOKABLE void backgroundChange(QString bg);
    Q_INVOKABLE void backgroundPath(QString bg);
    Q_INVOKABLE QString backgroundPath();
    Q_INVOKABLE void allDesktop();
    Q_INVOKABLE int mouseX();
    Q_INVOKABLE int mouseY();
    Q_INVOKABLE QStringList positions();
    Q_INVOKABLE void windowMove(int x, int y, int w, int h);
    Q_INVOKABLE void positions(int x, int y, int w, int h);
    QWindow *window;
    QQmlApplicationEngine *engine;

private:
    QScreen *screen = QApplication::screens().at(0);
    Xlibutil util;

};

#endif // CONTEXT_H
