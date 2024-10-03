#include "readdata.h"
#include <QDebug>
//#include <QFileDialog>

ReadData::ReadData(QObject *parent)
    : QObject{parent}
{}

ReadData *ReadData::getInstance()
{
    static ReadData * senddata=new ReadData();
    return senddata;
}

int ReadData::bisPlaying() const
{
    return m_bisPlaying;
}

void ReadData::setBisPlaying(int newBisPlaying)
{
    qDebug()<<"nn";
    if (m_bisPlaying == newBisPlaying)
        return;
    m_bisPlaying = newBisPlaying;
    emit bisPlayingChanged();
}

double ReadData::volume_value() const
{
    return m_volume_value;
}

void ReadData::setVolume_value(double newVolume_value)
{
    qDebug()<<"现在的音量是:"<<m_volume_value;
    if (qFuzzyCompare(m_volume_value, newVolume_value))
        return;
    m_volume_value = newVolume_value;

    emit volume_valueChanged();
}


