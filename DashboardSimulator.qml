import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.VirtualKeyboard 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import QtQml.Models 2.15

Item {
    ValueSource {
        id: valueSource
    }

    IndicatorModel {
        id: indicatorModel
    }



    Rectangle {
        id: dashboard
        anchors.centerIn: parent
        height: 500
        width: 1000
        color: "black"

        Row {
            id: indicatorRow
            spacing: dashboard.width * 0.02
            anchors.top: parent.top
            anchors.topMargin: dashboard.width * 0.02
            anchors.horizontalCenter: parent.horizontalCenter



            ArrowIndicator {
                id: leftindicator
                height: dashboard.height * 0.08
                width: height * 1.5
                direction: Qt.LeftArrow
            }
            Rectangle {
                height: dashboard.height * 0.1
                width: height
                color: "black"
                Image {
                    id: iconImageLight
                    anchors.fill: parent
                    source: "images/light.svg"
                    visible: false
                }
            }

            ArrowIndicator {
                id: rightIndicator
                height: dashboard.height * 0.08
                width: height * 1.5
                direction: Qt.RightArrow
            }
        }

        Row {
            id: dashboardRow
            spacing: dashboard.width * 0.02
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: indicatorRow.bottom

            CircularGauge {
                id: tempMeter
                anchors.bottom: parent.bottom
                value: engineConfigCPP.engineTemp
                width: height
                height: dashboard.height * 0.3
                maximumValue: 140
                minimumValue: 50

                style: TempGaugeStyle {}
            }

            CircularGauge {
                id: rpmMeter
                value: engineConfigCPP.engineRPM
                width: height
                height: dashboard.height * 0.6
                maximumValue: engineConfigCPP.maxEngineRPM

                style: RPMMeterStyle {}
            }

            CircularGauge {
                id: speedometer
                width: height
                height: dashboard.height * 0.6
                value: engineConfigCPP.speed
                maximumValue: 180

                property bool acceleration: false

                style: SpeedometerStyle {}

                Component.onCompleted: forceActiveFocus()
            }
            CircularGauge {
                id: fuelGauge
                anchors.bottom: parent.bottom
                width: height
                height: dashboard.height * 0.3
                value: engineConfigCPP.fuelLevel
                maximumValue: 100

                style: FuelGaugeStyle {}

                onValueChanged: {
                    if (value < 20) {
                        indicatorModel.setIconVisibility("gasoline", true);
                    }
                    else {
                        indicatorModel.setIconVisibility("gasoline", false);
                    }
                }
            }

        }

        Rectangle {
            id: speedrect
            height: dashboard.height * 0.05
            width: dashboard.width * 0.1
            color: "#327dc8"
            radius: height * 0.2

            anchors.right: parent.right
            anchors.rightMargin: dashboard.width * 0.3
            anchors.top: dashboardRow.bottom

            Text {
                text: engineConfigCPP.distance + " km"
                font.pointSize: 10
                color: "white"
            }
        }

        Rectangle {
            height: dashboard.height * 0.1
            width: height
            anchors.top: dashboardRow.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: "black"
            Image {
                id: iconOverspeed
                anchors.fill: parent
                source: "images/speed130.svg"
                visible: speedometer.value > 130
            }
        }
        DashboardIndicators {
            id: leftBottomRow

            iconModel: indicatorModel.leftIcons
            height: dashboard.height * 0.1
            anchors.top: dashboardRow.bottom
            anchors.left: parent.left
            anchors.topMargin: dashboard.width * 0.02
        }
        DashboardIndicators {
            id: rightBottomRow
            iconModel: indicatorModel.rightIcons
            height: dashboard.height * 0.1
            anchors.top: dashboardRow.bottom
            anchors.right: parent.right
            anchors.topMargin: dashboard.width * 0.02
        }

        Keys.onLeftPressed: {
            leftindicator.on = true
            rightIndicator.on = false
        }

        Keys.onRightPressed: {
            rightIndicator.on = true
            leftindicator.on = false
        }

        Keys.onUpPressed: {
            engineConfigCPP.applyBrake(false)
            engineConfigCPP.accelerate(true)
            speedometer.acceleration = true
        }

        Keys.onDownPressed: {
            engineConfigCPP.applyBrake(true)
            engineConfigCPP.accelerate(false)
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_D) {
                indicatorModel.setIconVisibility("windowDefrost", !indicatorModel.getIconVisibility("windowDefrost"));
            }
            else if (event.key === Qt.Key_A) {
                indicatorModel.setIconVisibility("acin", !indicatorModel.getIconVisibility("acin"));
            }
            else if (event.key === Qt.Key_W) {
                indicatorModel.setIconVisibility("wiper", !indicatorModel.getIconVisibility("wiper"));
            }
            else if (event.key === Qt.Key_L) {
                iconImageLight.visible = !iconImageLight.visible;
            }
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Up) {
                engineConfigCPP.accelerate(false)
                speedometer.acceleration = false
                event.accepted = true
            }
            if (event.key === Qt.Key_Down) {
                engineConfigCPP.applyBrake(false)
                event.accepted = true
            }
        }
    }

    Connections {
        target: engineConfigCPP
        function onEventGenerated(event) {
            if (event === "battery") {
                indicatorModel.setIconVisibility("battery", true);
            }
            else if (event === "settings") {
                    indicatorModel.setIconVisibility("settings", true);
            }
            else if (event === "enginefault") {
                indicatorModel.setIconVisibility("enginefault", true);
            }
        }

    }

}
