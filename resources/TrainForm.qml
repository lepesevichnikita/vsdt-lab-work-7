import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import vsdt.lab.work 1.0

GridLayout {
    id: root

    property Train train: Train {
    }

    property bool submited: false
    property bool reseted: false

    signal submitClicked
    signal resetClicked
    signal changed

    Connections {
        target: resetButton
        onClicked: {
            reseted = true
            submited = false
            resetClicked()
        }
    }
    Connections {
        target: submitButton
        onClicked: {
            submited = true
            submited = false
            submitClicked()
        }
    }

    Connections {
        target: root
        onChanged: {
            submited = false
            reseted = false
        }
    }

    columns: 2
    RowLayout {
        width: parent.width
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.columnSpan: 2
        Label {
            font.pointSize: 25
            font.bold: true
            text: qsTr("Введите данные поезда")
        }
        RowLayout {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Button {
                id: resetButton
                Layout.fillWidth: true
                text: qsTr("Сбросить")
            }
            Button {
                id: submitButton
                Layout.fillWidth: true
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
            changed()
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
        onEditingFinished: {
            changed()
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
        onEditingFinished: {
            changed()
            train.departureTime = text
        }
    }
}
