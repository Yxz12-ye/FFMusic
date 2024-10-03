#include "getalbumimg.h"

GetAlbumImg::GetAlbumImg(QObject *parent): QObject{parent}
{
    player = new QMediaPlayer(this);
    connect(player,&QMediaPlayer::mediaStatusChanged,this,&GetAlbumImg::onMediaStatusChanged);

}

