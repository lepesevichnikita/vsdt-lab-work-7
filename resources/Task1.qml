import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import QtQml.Models 2.1

import vsdt.lab.work 1.0

Page {
    id: root
    antialiasing: true
    title: qsTr("Первое задание")

    ColumnLayout {

        anchors.fill: parent

        Task1 {
            id: task
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                Layout.fillWidth: false
                text: qsTr("Длина")
            }
            TextField {
                Layout.fillWidth: true
                text: task.length
                onEditingFinished: task.length = Math.abs(parseFloat(text)) || 0
            }
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                Layout.fillWidth: false
                text: qsTr("Ширина")
            }
            TextField {
                Layout.fillWidth: true
                text: task.width
                onEditingFinished: task.width = Math.abs(parseFloat(text)) || 0
            }
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            clip: false
            Label {
                text: qsTr("Высота")
                Layout.fillWidth: false
            }
            TextField {
                text: task.height
                Layout.fillWidth: true
                antialiasing: true
                onEditingFinished: task.height = Math.abs(parseFloat(text)) || 0
            }
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                Layout.fillWidth: false
                text: qsTr("Объём комнаты")
            }
            TextField {
                Layout.fillWidth: true
                text: task.roomVolume
                readOnly: true
                selectByMouse: true
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
            Label {
                Layout.fillWidth: true
                text: qsTr("Объём кислорода в комнате")
            }
            TextField {
                Layout.fillWidth: true
                readOnly: true
                selectByMouse: true
                text: task.oxygenVolume
            }
        }
    }
}




/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
