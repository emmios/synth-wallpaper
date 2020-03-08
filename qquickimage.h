#ifndef QQUICKIMAGE_H
#define QQUICKIMAGE_H

#include <QQuickImageProvider>
#include <QDebug>

#include "context.h"


class QQuickImage : public QQuickImageProvider
{
public:
    QQuickImage() : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {

    }

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
    {
       QPixmap pixel;

       if (!id.isEmpty())
       {
           QString img = id;
           if (img.contains("file:///")) img = img.replace("file://", "");
           pixel.load(img);

           if (!pixel.isNull())
           {
               pixel = pixel.scaled(140, 100, Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
           }
       }

        return pixel;
    }

    Context *ctx;
};

#endif // QQUICKIMAGE_H
