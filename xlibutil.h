#ifndef XUTIL_H
#define XUTIL_H

#include <QX11Info>
#include <QWindow>
#include <QScreen>
#include <QDebug>
#include <QApplication>
#include <QThread>
#include <QPixmap>
#include <QImage>
#include <QWindow>

#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>
#include <X11/Xutil.h>
#include <X11/extensions/Xinerama.h>


#define ALL_DESKTOPS 0xFFFFFFFF


class Xlibutil
{

public:
    Xlibutil();
    void xactive(Window window);
    void xminimize(Window window);
    Window* xwindows(unsigned long *size);
    int xwindowPid(Window window);
    char* xwindowClass(Window window);
    char* xwindowName(Window window);
    char* xwindowType(Window window);
    unsigned char* xwindowState(Window window);
    Window xwindowID(int pid);
    void xminimizeByClass(QString wmclass);
    void xactiveByClass(QString wmclass);
    bool xwindowExist(QString wmclass);
    bool xisActive(QString wmclass);
    Window xwindowIdByClass(QString wmclass);
    bool xsingleActive(QString wmclass);
    void xchange(Window window, const char * atom);
    void xreservedSpace(Window window, int h);
    unsigned char* windowProperty(Display *display, Window window, const char *arg, unsigned long *nitems, int *status);
    QString xwindowLauncher(Window window);
    void xaddDesktopFile(int pid, QString arg);
    Atom atom(const char* atomName);
    QPixmap xwindowScreenShot(Window window, bool argb = false);
    QPixmap xwindowIcon(Window window, QSize size, bool smooth = false);
    XWindowAttributes attrWindow(Display *display, Window window);
    int xwindowMove(Window window, int x, int y, int w, int h);
    void resizeWindow(Display *display, Window window, int x, int y, unsigned int w, unsigned int h);
    void xwindowClose(Window window);
    void xchangeProperty(Window window, const char * atom, const char * internalAtom, int format);
    void xchangeProperty(Window window, int atom, const char * internalAtom, int format);
    void openboxChange(Window window, long atom);
    QString xgetWindowFocused();

private:
    QThread t;
    //Display *display = QX11Info::display();
};

#endif // XUTIL_H
