import QtQuick 2.15
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
    id: tempGaugeStyle

    function degree2Rad(deg) {
        return deg * (Math.PI / 180)
    }

    labelStepSize: 10
    labelInset: outerRadius * 0.3

    maximumValueAngle: 0
    minimumValueAngle: -90

    tickmarkLabel: Text {
        text: styleData.value === 140 ? "H" : (styleData.value === 50 ? "C" : "")
        font.pixelSize: Math.max(15, outerRadius * 0.01)
        color: "#e5e5e5"
    }

    tickmark: Rectangle {
        visible: styleData.value % 20 == 0
        implicitWidth: outerRadius * 0.05
        antialiasing: true
        implicitHeight: outerRadius * 0.12
        color: styleData.value <= 10 ? "#e34c22": "#e5e5e5"
    }

    background: Canvas {

        Row {
            anchors.left: parent.left
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.2
            anchors.leftMargin: outerRadius * 0.2

            Text {
                text: tempValue + "\xB0"
                font.pixelSize: Math.max(15, outerRadius * 0.1)
                color: "white"

                readonly property int tempValue : tempMeter.value
            }

            Text {
                id: unitSpeed
                text: " C"
                color: "white"
                font.pixelSize: outerRadius * 0.2
            }
        }
    }
}
