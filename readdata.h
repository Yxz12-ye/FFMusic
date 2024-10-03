#ifndef READDATA_H
#define READDATA_H

#include <QObject>
#include <QtQml>
#include <QMediaPlayer>
#include <QMediaMetaData>
#include <QGuiApplication>
#include <QImage>
#include <QQuickView>
#include <QFile>
#include <QCoreApplication>

class ReadData : public QObject
{
    Q_OBJECT

    QML_ELEMENT
public:
    explicit ReadData(QObject *parent = nullptr);
    static ReadData * getInstance();

    int bisPlaying() const;
    void setBisPlaying(int newBisPlaying);

    Q_INVOKABLE double m_volume_value;



    double volume_value() const;
    Q_INVOKABLE void setVolume_value(double newVolume_value);

private:
    int m_bisPlaying;
    Q_PROPERTY(int bisPlaying READ bisPlaying WRITE setBisPlaying NOTIFY bisPlayingChanged FINAL)



    Q_PROPERTY(double volume_value READ volume_value WRITE setVolume_value NOTIFY volume_valueChanged FINAL)

signals:
    void bisPlayingChanged();

    void volume_valueChanged();
};

#endif // READDATA_H
