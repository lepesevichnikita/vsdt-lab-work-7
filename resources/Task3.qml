import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import vsdt.lab.work 1.0

Page {
    id: root
    title: qsTr("Третье задание")
    antialiasing: true

    Task3 {
        id: task
    }

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                text: task.n
                anchors.fill: parent
                font.pointSize: 14
                font.family: "Cantarell Extra Bold"
                renderType: Text.NativeRendering
                font.weight: Font.Bold
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                textFormat: Text.RichText
            }
        }
        Slider {
            id: slider
            Layout.fillWidth: true
            from: 1.0
            to: 1000.0
            value: task.n
            onMoved: task.n = parseInt(value)
        }

        Switch {
            id: modeSwitch
            text: qsTr("Рачет по формуле ряда")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            state: task.mode
            onClicked: task.toggleMode()
            states: [
                State {
                    name: '1'
                    PropertyChanges {
                        target: modeSwitch
                        checked: true
                    }
                },
                State {
                    name: '0'
                    PropertyChanges {
                        target: modeSwitch
                        checked: false
                    }
                }
            ]
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                text: task.result
                anchors.fill: parent
                font.pointSize: 14
                font.family: "Cantarell Extra Bold"
                renderType: Text.NativeRendering
                font.weight: Font.Bold
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                textFormat: Text.RichText
            }
        }
    }
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

