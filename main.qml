import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Imagine
import QtQuick3D

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Gouge Counter")
    color: "cadetblue"
    opacity: 0.7


    View3D {
        anchors.fill: parent

        PerspectiveCamera { z: 600 }

        SpotLight {
            z: 1030
            color: "#f08080"
            //visible: false
            brightness: 500
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
        }

        Model {
            source: "#Rectangle"
            scale: Qt.vector3d(10, 10, 10)
            z: -100
            materials: PrincipledMaterial { }
        }

        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2, 2, 2)
            materials: PrincipledMaterial {
                baseColor: "blue"
                roughness: 0.1
            }
        }

        Button {
            id: button
            x: 524
            y: 404
            width: 68
            height: 50
            text: qsTr("Button")

            Connections {
                target: button
                function onPressed(){
                    volumeDial.value += 1
                    slider.value += 1
            }
        }
    }
    Rectangle {
        width: 420
        height: 420
        radius: 210
        border{
            color: "blue"
            width: 10
        }
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        opacity: 1
        gradient: Gradient{
            GradientStop{position: 0.0; color: "black" }
            GradientStop{position: 1.0; color: "darkred" }
        }

/******************************************/
        anchors.centerIn: parent
        Canvas{
            width: parent.width
            height: parent.height
            id: canvasTexture
            anchors.centerIn: parent.Window
            onPaint: {

                var radius = 190
                var ctx = getContext("2d")
                ctx.lineWidth = 1
                ctx.font = "16px Arial"
                var cx = width/2
                var cy = height/2
                ctx.strokeStyle = Qt.rgba(1, 1, 1, 1);

                var xShift = 0
                var yShift = 0
                var xShiftTo = 0
                var yShiftTo = 0


                for(var i = -36; i<=210; i+= 25){
                    var radiant = i*(Math.PI/150)
                    ctx.beginPath();
                    //color: "yellow"

                    //ctx.fillStyle = Qt.rgba(i/360, 1-i/360, 1-i/360, 1);
                    //ctx.strokeStyle = Qt.rgba(i/360, 1-i/360, 1-i/360, 1);

                    xShift = cx+radius*Math.cos(radiant)
                    yShift = cy-radius*Math.sin(radiant)
                    xShiftTo = cx+radius*Math.cos(radiant)*.95
                    yShiftTo = cy-radius*Math.sin(radiant)*.95
                    ctx.moveTo(xShiftTo, yShiftTo)
                    ctx.lineTo(xShift, yShift)
                    ctx.closePath()
                    ctx.stroke()

                }
            }
        }

        Dial{
            id: volumeDial
            from: 0
            value: 0
            to: 100
            stepSize: 1
            anchors.centerIn: parent
            width: parent.width - 80
            height: parent.height - 80
            opacity: 1
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            clip: true
            layer.smooth: true
            layer.enabled: true
            wheelEnabled: true

            Label {
                text: volumeDial.value.toFixed(0)
                horizontalAlignment: Text.AlignLeft
                fontSizeMode: Text.FixedSize
                color: "red"
                font.bold: true
                font.pixelSize: Qt.application.font.pixelSize * 11
                anchors.centerIn: parent
            }

        }
    }
        Slider {
            id: slider
            height: 200
            stepSize: 0
            width: 65
            from: 0
            to: 100
            x: 540
            y: 140
            live: true
            orientation: Qt.Vertical
            background: Rectangle{
                color: "red"
                radius: 10

            }
        }
        Connections{
            target: slider
            function onValueChanged() {
                volumeDial.value = slider.value
            }
        }
    }
}





