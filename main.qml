import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.VirtualKeyboard 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Window {
    id: window
    width: 1000
    height: 1000
    visible: true
    title: qsTr("Automobile Dashboard")

    Column {
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent.top
        spacing: 20

        width: parent.width * 0.2

        Button {
            id: confButton
            text: "Vehicle Configuration"

            onClicked: {
                centralPanelLoader.source = "VehicleConfiguration.qml"
            }
        }

        Button {
            id: simButton
            text: "Dashboard Simulation"

            onClicked: {
                centralPanelLoader.source = "DashboardSimulator.qml"
            }
        }
    }

    Loader {
        id: centralPanelLoader
        anchors.centerIn: parent
        width: parent.width
    }
}
