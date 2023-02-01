import QtQuick 2.15
import QtQml.Models 2.15

QtObject {
    id: indicatorModel

    property ListModel leftIcons: ListModel {
        id: leftBottomIndicators

        ListElement {
            name: "windowDefrost"
            src: "images/defrost.svg"
            isvisible: false
        }

        ListElement {
            name: "acin"
            src: "images/acin.svg"
            isvisible: false
        }
        ListElement {
            name: "wiper"
            src: "images/wiper.svg"
            isvisible: false
        }
    }

    property ListModel rightIcons: ListModel {
        id: rightBottomIndicators

        ListElement {
            name: "battery"
            src: "images/battery.svg"
            isvisible: false
        }
        ListElement {
            name: "gasoline"
            src: "images/gasoline.svg"
            isvisible: false
        }
        ListElement {
            name: "settings"
            src: "images/settings.svg"
            isvisible: false
        }
        ListElement {
            name: "enginefault"
            src: "images/enginefault.svg"
            isvisible: false
        }
    }

    function getIconVisibility(name) {
        for (var i=0; i < leftIcons.count; i++) {
            if (leftIcons.get(i).name === name) {
                return leftIcons.get(i).isvisible;
            }
        }
        for (i=0; i < rightIcons.count; i++) {
            if (rightIcons.get(i).name === name) {
                return rightIcons.get(i).isvisible;
            }
        }
    }
    function setIconVisibility(name, value) {
        for (var i=0; i < leftIcons.count; i++) {
            if (leftIcons.get(i).name === name) {
                leftIcons.setProperty(i, "isvisible", value);
                return;
            }
        }
        for (i=0; i < rightIcons.count; i++) {
            if (rightIcons.get(i).name === name) {
                rightIcons.setProperty(i, "isvisible", value);
                return;
            }
        }
    }

}

