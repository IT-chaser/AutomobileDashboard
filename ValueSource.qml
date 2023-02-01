import QtQuick 2.15

Item {
    id: valuesource

    property real curGear: engineConfigCPP.curGear

    property string gearValue: {
        var gear
        if (engineConfigCPP.spped === 0) {
            return "P"
        } else if (curGear == 1) {
            return "1"
        } else if (curGear == 2) {
            return "2"
        } else if (curGear == 3) {
            return "3"
        } else if (curGear == 4) {
            return "4"
        } else if (curGear == 5) {
            return "5"
        } else {
            return "6"
        }
    }
}
