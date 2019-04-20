import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import vsdt.lab.work 1.0

GridLayout {
    id: root
    anchors.fill: parent
    columns: 2

    property Train train: Train {
    }

    property bool submited: false
    property bool reseted: false
    property bool dirty: false

    signal submitClicked
    signal resetClicked
    signal changed
    state: 'clear'

    states: [
        State {
            name: "dirty"
            when: dirty
            PropertyChanges {
                target: resetButton
                enabled: true
            }
            PropertyChanges {
                target: submitButton
                enabled: true
            }
        },
        State {
            name: "clear"
            when: !dirty
            PropertyChanges {
                target: resetButton
                enabled: false
            }
            PropertyChanges {
                target: submitButton
                enabled: false
            }
        }
    ]

    Connections {
        target: root
        onChanged: {
            submited = false
            reseted = false
            dirty = true
        }
    }

    Connections {
        target: resetButton
        onClicked: {
            resetClicked()
            reseted = true
            submited = false
            dirty = false
        }
    }
    Connections {
        target: submitButton
        onClicked: {
            submitClicked()
            submited = false
            reseted = false
            dirty = false
        }
    }

    Connections {
        target: destinationEdit
        onTextChanged: changed()
    }

    Connections {
        target: trainNumberEdit
        onTextChanged: changed()
    }

    Connections {
        target: departureTimeEdit
        onTextChanged: changed()
    }

    RowLayout {
        width: parent.width
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.columnSpan: 2
        Label {
            font.pointSize: 25
            font.bold: true
            text: qsTr("Введите данные поезда")
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Button {
                id: resetButton
                Layout.minimumHeight: 44
                Layout.minimumWidth: Layout.minimumHeight
                text: qsTr("Сбросить")
            }
            Button {
                id: submitButton
                Layout.minimumHeight: 44
                Layout.minimumWidth: Layout.minimumHeight
                text: qsTr("Сохранить")
            }
        }
    }

    Label {
        text: qsTr("Пункт назначения")
    }
    TextField {
        id: destinationEdit
        Layout.fillWidth: true
        text: train.destination
        placeholderText: qsTr("Введите пункт назначения")
        onEditingFinished: {
            train.destination = text
        }
    }

    Label {
        text: qsTr("Номер поезда")
    }
    TextField {
        id: trainNumberEdit
        text: train.trainNumber
        Layout.fillWidth: true
        placeholderText: qsTr("Введите номер поезда")
        inputMask: ">aa-000000-aa;_"
        onEditingFinished: {
            train.trainNumber = text
        }
    }
    Label {
        text: qsTr("Время отправления")
    }
    TextField {
        id: departureTimeEdit
        text: train.departureTime
        Layout.fillWidth: true
        placeholderText: qsTr("Введите время отправления")
        inputMask: "00:00:00;0"
        validator: RegExpValidator {
            regExp: /^(2[0-3]|[0-1][0-9]):([0-5][0-9]):([0-5][0-9])(\.[0-9]+)?(Z|[+-](?:2[0-3]|[0-1][0-9]):[0-5][0-9])?$/
        }
        onEditingFinished: {
            train.departureTime = text
        }
    }
}
