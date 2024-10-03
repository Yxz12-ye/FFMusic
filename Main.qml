import SendData
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia
import QtQuick.Dialogs

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    //界面和部分按钮逻辑
    Rectangle {
            id: play_Area
            anchors.fill: parent
            anchors.topMargin:420
            color: "lightgray"
            radius:8
            gradient: Gradient{
                stops: [
                    GradientStop { position: 0.0; color: "lightgray" },
                    GradientStop { position: 1.0; color: "black" }
                ]

            }


            //内部矩形(主要用来实现边框的渐变)
            Rectangle{
                anchors.fill:parent
                color:"white"
                radius:8
                anchors.topMargin:2
                anchors.rightMargin:2
                anchors.leftMargin:2
                anchors.bottomMargin:2
            }
            //音量调节


            Item {

                visible: true
                width:25
                height:25
                z:2
                anchors.right:parent.right
                anchors.rightMargin:50
                anchors.verticalCenter:parent.verticalCenter
                property double volume_value: volume_slider.value;

                Rectangle {
                    anchors.fill: parent
                    radius:5
                    color: "white"
                    border.color:"lightgray"
                    border.width:2

                    Image {
                        id: ico

                        source: "qrc:/new/image/vloume_ico.svg"
                        width:20
                        height:20
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit // 保持纵横比
                    }



                    property bool sliderVisible: false

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled:true
                        onEntered: {
                            playlogic_continer.visible = true
                            playlogic_continer.sliderVisible = true
                            resetTimeout();
                        }
                        onExited: {
                            // 开始计时器
                            timeout.start();
                        }
                    }

                    Timer {
                        id: timeout
                        interval: 500 // 500毫秒后隐藏滑动条
                        repeat: false
                        onTriggered: {
                            if (!volume_slider.containsMouse) {
                                playlogic_continer.visible = false;
                                volumeButton.sliderVisible = false;
                            }
                        }
                    }

                    Rectangle{
                        id:playlogic_continer
                        visible:false
                        width:100
                        height:20
                        color:"white"
                        border.color:"lightgray"
                        border.width:2
                        anchors.horizontalCenter:parent.horizontalCenter
                        anchors.bottom:parent.top
                        anchors.bottomMargin:10
                        radius:5



                        Slider{

                            id:volume_slider
                            value:0.1
                            anchors.centerIn:parent
                            property bool containsMouse: false
                            //anchors.horizontalCenter: parent.horizontalCenter
                            //anchors.bottom: parent.top
                            //anchors.bottomMargin:10

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled:true
                                drag.target:parent

                                propagateComposedEvents: true//鼠标事件穿透

                                onEntered: {
                                    playlogic_continer.visible = true // 鼠标进入滑动条区域时保持可见
                                    timeout.stop(); // 停止计时器

                                }
                                onExited: {
                                    timeout.start(); // 开始计时器
                                }
                                onPressed :(mouse)=>{
                                    mouse.accepted=false//当鼠标按住时穿透
                                }
                            }

                            background:Rectangle{
                                x:volume_slider.leftPadding
                                y:volume_slider.topPadding+volume_slider.availableHeight/2-height/2
                                width:volume_slider.width
                                height:4
                                radius:2
                                color: "#bdbebf"
                                Rectangle {
                                    width: volume_slider.visualPosition * parent.width
                                    height: parent.height
                                    color: "#21be2b"
                                    radius: 2
                                }

                            }
                            handle: Rectangle {
                                x: volume_slider.leftPadding + volume_slider.visualPosition * (volume_slider.availableWidth - width)
                                y: volume_slider.topPadding + volume_slider.availableHeight / 2 - height / 2
                                implicitWidth: 10
                                implicitHeight: 10
                                radius: 5
                                color: volume_slider.pressed ? "#f0f0f0" : "#f6f6f6"
                                border.color: "#bdbebf"
                            }


                            onValueChanged:{
                                SendData.setVolume_value(value);
                                mediaplayer.sound_volume=value;
                            }


                        }


                    }







                    /*
                    Slider {
                            id: control
                            value: 0.5

                            background: Rectangle {
                                x: control.leftPadding
                                y: control.topPadding + control.availableHeight / 2 - height / 2
                                implicitWidth: 200
                                implicitHeight: 4
                                width: control.availableWidth
                                height: implicitHeight
                                radius: 2
                                color: "#bdbebf"

                                Rectangle {
                                    width: control.visualPosition * parent.width
                                    height: parent.height
                                    color: "#21be2b"
                                    radius: 2
                                }
                            }

                            handle: Rectangle {
                                x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                                y: control.topPadding + control.availableHeight / 2 - height / 2
                                implicitWidth: 26
                                implicitHeight: 26
                                radius: 13
                                color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                                border.color: "#bdbebf"
                            }
                        }


                    Slider {
                        id: volumeSlider
                        from: 0
                        to: 100
                        stepSize: 1
                        value: 50
                        visible: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        anchors.bottomMargin:20

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled:true
                            drag.target:parent
                            onEntered: {
                                volumeSlider.visible = true // 鼠标进入滑动条区域时保持可见
                                timeout.stop(); // 停止计时器
                            }
                            onExited: {
                                timeout.start(); // 开始计时器
                            }
                        }

                        onValueChanged: {
                            console.log("当前音量:", value);
                            // 这里可以加入调节音量的代码
                        }
                    }
                    */



















                    /*
                    Button {
                        id: volumeButton
                        text: "音量"
                        anchors.centerIn: parent

                        // 音量调节条的可见性状态
                        property bool sliderVisible: false

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled:true
                            onEntered: {
                                volumeSlider.visible = true
                                volumeButton.sliderVisible = true
                                resetTimeout();
                            }
                            onExited: {
                                // 开始计时器
                                timeout.start();
                            }
                        }

                        Timer {
                            id: timeout
                            interval: 500 // 500毫秒后隐藏滑动条
                            repeat: false
                            onTriggered: {
                                if (!volumeSlider.containsMouse) {
                                    volumeSlider.visible = false;
                                    volumeButton.sliderVisible = false;
                                }
                            }
                        }
                    }

                    Slider {
                        id: volumeSlider
                        from: 0
                        to: 100
                        stepSize: 1
                        value: 50
                        visible: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: volumeButton.bottom
                        anchors.topMargin: 10

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled:true
                            onEntered: {
                                volumeSlider.visible = true // 鼠标进入滑动条区域时保持可见
                                timeout.stop(); // 停止计时器
                            }
                            onExited: {
                                timeout.start(); // 开始计时器
                            }
                        }

                        onValueChanged: {
                            console.log("当前音量:", value);
                            // 这里可以加入调节音量的代码
                        }
                    }*/
                }
            }
            //中心按钮区域
            Rectangle{
                id:play_Ico_area
                anchors.fill:parent
                anchors.leftMargin:250
                anchors.rightMargin:250
                anchors.topMargin:5
                anchors.bottomMargin:5
                color:"white"
                //播放按钮
                Rectangle{

                    id:play_button
                    width:40
                    height:40
                    radius:20
                    color:"#39CCCC"
                    //property color rectcolor: "#39CCCC"
                    border.width:2
                    border.color:"lightgray"
                    anchors.centerIn:parent
                    ColorAnimation on color{
                        id:play_button_color
                        duration:200
                    }
                    MouseArea{
                        anchors.fill:parent
                        hoverEnabled: true
                        onEntered:{
                            //console.log("1")
                            play_button_color.stop()
                            play_button_color.to="#0074D9"
                            play_button_color.start()
                        }
                        onExited:{
                            //console.log("0")
                            play_button_color.stop()
                            play_button_color.to="#39CCCC"
                            play_button_color.start()
                        }
                        onClicked:{
                            if(iconItem.isPlaying){
                                mediaplayer.pause();
                                //console.log("Media Error:", mediaplayer.error);
                                //console.log("Status:",mediaplayer.mediaStatus);
                                //console.log("播放状态:",mediaplayer.playbackState);
                                iconItem.isPlaying=!iconItem.isPlaying
                            }else{
                                mediaplayer.play();
                                //console.log("Media Error:", mediaplayer.error);
                                //console.log("Status:",mediaplayer.mediaStatus);
                                //console.log("播放状态:",mediaplayer.playbackState);
                                iconItem.isPlaying=!iconItem.isPlaying
                            }


                        }
                    }
                    //播放图形
                    Item{
                        id:iconItem
                        anchors.fill:parent
                        property bool isPlaying: false
                        //anchors.centerIn:parent
                        Canvas{
                            visible:!parent.isPlaying
                            width:20
                            height:20
                            anchors.centerIn:parent
                            onPaint:{
                                var ctx=getContext("2d");
                                ctx.beginPath();
                                ctx.moveTo(5,0);
                                ctx.lineTo(20, 10);
                                ctx.lineTo(5, 20);
                                ctx.closePath();
                                ctx.fillStyle = "white";
                                ctx.fill();

                            }

                        }

                    }
                    //暂停图形
                    Item {
                        id: pauseIcon
                        visible: iconItem.isPlaying
                        width: 18; height: 18
                        anchors.centerIn: parent

                        Rectangle {
                            width: 4
                            height: 18
                            color: "white"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            width: 4
                            height: 18
                            color: "white"
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                //上一首
                Rectangle{
                    id:last_button
                    width:40
                    height:40
                    radius:20
                    color:"white"
                    border.width:2
                    border.color:"lightgray"
                    //anchors.centerIn:parent
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.rightMargin:8
                    anchors.right:play_button.left
                    ColorAnimation on color{
                        id:last_button_color
                        duration:200
                    }
                    MouseArea{
                        anchors.fill:parent
                        hoverEnabled: true
                        onEntered:{
                            //console.log("1")
                            last_button_color.stop()
                            last_button_color.to="#A9A9A9"
                            last_button_color.start()
                        }
                        onExited:{
                            //console.log("0")
                            last_button_color.stop()
                            last_button_color.to="white"
                            last_button_color.start()
                        }
                    }
                    //上一首图形
                    Item{
                        scale:-1
                        id:iconItem3
                        anchors.fill:parent
                        property bool isPlaying: false
                        //anchors.centerIn:parent
                        Canvas{

                            width:20
                            height:20
                            anchors.verticalCenter:parent.verticalCenter
                            anchors.horizontalCenter:parent.horizontalCenter
                            anchors.horizontalCenterOffset:-2
                            onPaint:{
                                var ctx=getContext("2d");
                                ctx.beginPath();
                                ctx.moveTo(5,0);
                                ctx.lineTo(20, 10);
                                ctx.lineTo(5, 20);
                                ctx.closePath();
                                ctx.fillStyle = "lightgray";
                                ctx.fill();

                            }

                        }
                        Rectangle{
                            height:18
                            width:4
                            color:"lightgray"
                            anchors.horizontalCenter:parent.horizontalCenter
                            anchors.horizontalCenterOffset:6
                            anchors.verticalCenter:parent.verticalCenter
                        }

                    }
                }
                //下一首
                Rectangle{
                    id:next_button
                    width:40
                    height:40
                    radius:20
                    color:"white"
                    border.width:2
                    border.color:"lightgray"
                    //anchors.centerIn:parent
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.leftMargin:8
                    anchors.left:play_button.right
                    ColorAnimation on color{
                        id:next_button_color
                        duration:200
                    }
                    MouseArea{
                        anchors.fill:parent
                        hoverEnabled: true
                        onEntered:{
                            //console.log("1")
                            next_button_color.stop()
                            next_button_color.to="#A9A9A9"
                            next_button_color.start()
                        }
                        onExited:{
                            //console.log("0")
                            next_button_color.stop()
                            next_button_color.to="white"
                            next_button_color.start()
                        }

                    }
                    //下一首图形
                    Item{
                        id:iconItem2
                        anchors.fill:parent
                        property bool isPlaying: false
                        //anchors.centerIn:parent
                        Canvas{

                            width:20
                            height:20
                            anchors.verticalCenter:parent.verticalCenter
                            anchors.horizontalCenter:parent.horizontalCenter
                            anchors.horizontalCenterOffset:-2
                            onPaint:{
                                var ctx=getContext("2d");
                                ctx.beginPath();
                                ctx.moveTo(5,0);
                                ctx.lineTo(20, 10);
                                ctx.lineTo(5, 20);
                                ctx.closePath();
                                ctx.fillStyle = "lightgray";
                                ctx.fill();

                            }

                        }
                        Rectangle{
                            height:18
                            width:4
                            color:"lightgray"
                            anchors.horizontalCenter:parent.horizontalCenter
                            anchors.horizontalCenterOffset:6
                            anchors.verticalCenter:parent.verticalCenter
                        }

                    }
                }
            }


            //进度条的实现
            Rectangle{
                width:parent.width-12
                height:4
                radius:2
                color:"green"
                z:1
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.top:parent.top
                Slider{
                    //anchors.fill:parent
                    anchors.centerIn:parent
                    width:parent.width
                    height:4
                    id:duration_slider
                    property bool isIn: false
                    value:0
                    background:Rectangle{
                        id:duration_slider_b
                        anchors.centerIn:parent
                        width:parent.width
                        height:6
                        radius:2
                        color:"gray"
                        Rectangle{
                            width:duration_slider.visualPosition*parent.width
                            height:parent.height
                            color:"pink"
                            radius:2
                        }
                    }
                    handle:Rectangle{

                    }
                    onPressedChanged:{
                        isIn=!isIn
                    }



                    MouseArea{
                        id:durition_slider_c
                        anchors.fill:parent
                        hoverEnabled:true
                        //propagateComposedEvents:true


                        onEntered:{
                            duration_slider_b.height=6


                        }
                        onExited:{
                            duration_slider_b.height=2


                        }

                        onPressed:(mouse)=>{
                            //console.log("鼠标按下")
                            mouse.accepted=false
                            //isIn=true;
                            //mediaplayer.pause();
                            //mediaplayer.position=(duration_slider.value*mediaplayer.last_duration);
                            //console.log(mediaplayer.position,"\t",duration_slider.value)

                        }
                        onReleased:(mouse)=>{
                            //isIn=false;
                            //console.log("鼠标抬起")

                            //mediaplayer.play()
                        }
                    }
                    onValueChanged:{
                        if(isIn){
                            mediaplayer.position=value*mediaplayer.last_duration
                        }
                    }



                }

            }
        }

    Connections{
        target:ReadData
        function onVolume_valueChanged(){
            console.log("音量变了")
        }
    }
    //这里是播放逻辑
    Item{
        Timer{
            interval:1000
            running:true
            repeat:true
            onTriggered:{
                if(mediaplayer.playbackState == mediaplayer.playing){
                    duration_slider.value=mediaplayer.position/mediaplayer.last_duration
                }
                if(albumart.source!=mediaPlayer_I.getAlbumArt()){
                    albumart.source=mediaPlayer_I.getAlbumArt()
                    console.log("专辑图片已经改变")
                }else{
                    console.log("专辑图片没变化")
                }


                //console.log(mediaPlayer_I.getAlbumArt())

            }
        }



        Rectangle{
            MediaPlayer{
                id:mediaplayer
                property double sound_volume:0.1;
                property int last_duration: value;



                //autoPlay:true
                onPositionChanged:{
                    //duration_slider.value=(mediaplayer.position/last_duration)
                }



                audioOutput:AudioOutput{
                    volume:mediaplayer.sound_volume;
                }

                onMediaStatusChanged:{
                    console.log("Media Status:", mediaplayer.mediaStatus);
                    if(mediaplayer.mediaStatus==4){
                        last_duration=mediaplayer.duration
                    }
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
                    albumart.source=""
                    console.log("专辑图片已清空")
                    //mediaplayer.play()

                    mediaPlayer_I.loadMedia(filedialog.filePath) // 加载音频
                    console.log(filedialog.filePath)
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
    }

    Rectangle{
        width:200
        height:200
        color:"gray"
        anchors.horizontalCenter:parent.horizontalCenter
        y:110
        Image {
            id: albumart
            width:200
            height:200
            source: mediaPlayer_I.getAlbumArt()
            //source:"qrc:/new/image/volume_ico.png"

        }
    }


}
