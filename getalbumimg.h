#ifndef GETALBUMIMG_H
#define GETALBUMIMG_H

#include <QObject>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QMediaPlayer>
#include <QMediaMetaData>
#include <QImage>
#include <QQuickView>
#include <QFile>
#include <QCoreApplication>
#include <qaudiooutput.h>
#include <QStandardPaths>
 #include <QDir>

class GetAlbumImg : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit GetAlbumImg(QObject *parent = nullptr);
    Q_INVOKABLE QString getAlbumArt(){
        qDebug()<<"返回专辑封面地址中!";
        return albumArtUrl;

    }


    Q_INVOKABLE void loadMedia(QString filePath){
        qDebug()<<"打开!";
        //QDebug()<<filePath;
        player->setSource(filePath);
        //player->play();
        //audioOutput->setVolume(1);
    }
private slots:

    void onMediaStatusChanged(QMediaPlayer::MediaStatus status) {
        qDebug()<<status;
        if (status == QMediaPlayer::LoadedMedia) {
            qDebug()<<"读取专辑照片中";
            auto metaData = player->metaData();
            albumArt = metaData.value(QMediaMetaData::ThumbnailImage).value<QImage>();
            //qDebug() << metaData.value(QMediaMetaData::Title).toString();
            // 保存为临时文件
            if (!albumArt.isNull()) {
                QString tempDir = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
                QString filePath = QDir(tempDir).filePath("album_art.png");
                albumArt.save(filePath);  // 保存为 PNG 文件
                albumArtUrl = QUrl::fromLocalFile(filePath).toString();  // 获取 URL
            } else {
                albumArtUrl = "";  // 如果没有专辑封面，则清空
            }

        }
        //QMediaMetaData metaData = player->metaData();
        //albumArt = metaData.value(QMediaMetaData::CoverArtImage).value<QImage>();
        qDebug()<<albumArt;

    }

private:

    QMediaPlayer *player;
    QImage albumArt;
    QAudioOutput *audioOutput;
    QString albumArtUrl;

signals:
};

#endif // GETALBUMIMG_H
