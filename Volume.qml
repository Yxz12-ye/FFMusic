import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    visible: true
    width:25
    height:25

    property double volume_value: volume_slider.value;

    PlayLogic{
        id:playlogic
        visible:false
    }

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

        Rectangle{
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
                value:0.5
                anchors.centerIn:parent
                //anchors.horizontalCenter: parent.horizontalCenter
                //anchors.bottom: parent.top
                //anchors.bottomMargin:10

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
                }


            }


        }


        function getVolume(){
            return volume_slider.value
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
