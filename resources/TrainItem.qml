import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1

import vsdt.lab.work 1.0

GridLayout {
    id: root

    signal aboutClicked
    Connections {
        target: aboutButton
        onClicked: aboutClicked()
    }
    Connections {
        target: mouseArea
        onClicked: aboutClicked()
    }
    width: parent.width
    rowSpacing: 2
    rows: 4
    columns: 2
    flow: GridLayout.TopToBottom
    state: 'unhovered'
    states: [
        State {
            name: 'hovered'
            when: mouseArea.containsMouse
            PropertyChanges {
                target: aboutButton
                highlighted: true
            }
        },
        State {
            name: 'unhovered'
            when: !mouseArea.containsMouse
            PropertyChanges {
                target: aboutButton
                highlighted: false
            }
        }
    ]
    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
    }
    Label {
        Layout.column: 0
        Layout.row: 0
        font.pointSize: 13
        text: train.destination
        wrapMode: Text.WordWrap
    }
    Label {
        Layout.column: 0
        Layout.row: 1
        font.pointSize: 12
        text: train.trainNumber
        wrapMode: Text.WordWrap
    }
    Label {
        Layout.column: 0
        Layout.row: 2
        font.pointSize: 11
        text: train.departureTime
        wrapMode: Text.WordWrap
    }
    Button {
        id: aboutButton
        Layout.column: 1
        Layout.rowSpan: 4
        Layout.minimumHeight: 44
        Layout.minimumWidth: 44
        text: qsTr("Подробнее")
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
    }
}
