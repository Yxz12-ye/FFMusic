import QtQuick
import QtQuick.Dialogs
import QtMultimedia
import QtQuick.Controls

Item{
    Rectangle{
        MediaPlayer{
            id:mediaplayer
            property double sound_volume:0.1;

            //autoPlay:true
            onPositionChanged:{
                //console.log("bb:",mediaplayer.position);
            }
            audioOutput:AudioOutput{
                volume:mediaplayer.sound_volume;
            }

            onMediaStatusChanged:{
                console.log("Media Status:", mediaplayer.mediaStatus);

            }
        }

        FileDialog{
            id:filedialog
            property string filePath: "null"
            title:"打开音乐文件"
            onAccepted:{
                filePath=selectedFile
                SendData.filePath=filePath
                mediaplayer.source=filePath
                //mediaplayer.play()
            }
        }

        Button{
            height:20
            width:40
            text:"打开"
            onClicked:{
                SendData.bisPlaying=1
                filedialog.open()


            }
        }
    }
    function play(){
        mediaplayer.play();
    }
    function pause(){
        mediaplayer.pause();
    }

    function setVloume(new_volume){
        if(new_volume!=mediaplayer.sound_volume){
            mediaplayer.sound_volume=new_volume;
        }
    }
}




