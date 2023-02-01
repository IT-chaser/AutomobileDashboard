import QtQuick 2.15
import QtQuick.Controls 1.4

Item {
    id: rootComp

    VehicleConfModel {
        id: vehicleConfModel
    }

    Column {
        id: settingPanel
        width: parent.width
        anchors.centerIn: parent
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        Repeater {
            id: parameterRepeater
            model: vehicleConfModel

            Row {
                id: rpmRow
                spacing: 10

                Text {
                    id: name
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.3
                    font.pointSize: 15
                    text: displayText
                }
                TextField {
                    id: valF
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.3
                    font.pointSize: 15
                    text: value
                    onTextChanged: {
                        for (var i = 0; i < vehicleConfModel.count; i++) {
                            if (vehicleConfModel.get(
                                        i).displayText === name.text)
                                vehicleConfModel.setProperty(i, "value",
                                                             parseFloat(text))
                        }
                    }
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.2
                    font.pointSize: 15
                    text: unit
                }
            }
        }

        Button {
            id: updateButton
            text: "Update"
            width: settingPanel.width * 0.1
            height: width * 0.4
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                for (var i = 0; i < vehicleConfModel.count; i++) {
                    var pName = vehicleConfModel.get(i).name
                    var pValue = vehicleConfModel.get(i).value
                    engineConfigCPP.updateEngineProp(pName, pValue)
                }
            }
        }
    }
}
