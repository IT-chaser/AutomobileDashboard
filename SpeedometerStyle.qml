import QtQuick 2.15
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    id: speedometerStyle

    function degree2Rad(deg) {
        return deg * (Math.PI / 180)
    }

    background: Canvas {
        onPaint: {
            var ctr = getContext("2d")
            ctr.reset()
            ctr.beginPath()

            ctr.strokeStyle = "red"
            ctr.linewidth = outerRadius * 0.02

            ctr.arc(outerRadius, outerRadius,
                    outerRadius - ctr.lineWidth / 2, degree2Rad(
                        valueToAngle(120) - 90), degree2Rad(
                        valueToAngle(180) - 90))
            ctr.stroke()
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.2

            Text {
                id: speedText
                color: "white"
                font.pixelSize: outerRadius * 0.1
                horizontalAlignment: Text.AlignRight
                text: kphValue
                readonly property int kphValue: speedometer.value
            }

            Text {
                id: unitSpeed
                text: "Km/h"
                color: "white"
                font.pixelSize: outerRadius * 0.1
            }
        }
        Text {
            id: gearText
            color: "white"
            text: gear
            font.pixelSize: outerRadius * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.4

            readonly property string gear: valueSource.gearValue
        }
    }

    tickmark: Rectangle {
        visible: styleData.value < 120 || styleData.value % 10 == 0
        implicitWidth: outerRadius * 0.02
        antialiasing: true
        implicitHeight: outerRadius * 0.06
        color: styleData.value >= 120 ? "#e34c22" : "#e5e5e5"
    }

    minorTickmark: Rectangle {
        visible: styleData.value < 120
        implicitWidth: outerRadius * 0.01
        antialiasing: true
        implicitHeight: outerRadius * 0.03
        color: styleData.value >= 120 ? "#e34c22" : "#e5e5e5"
    }

    foreground: Item {
        Rectangle {
            width: outerRadius * 0.2
            height: width
            radius: width / 2
            color: "blue"
            anchors.centerIn: parent
        }
    }
}
