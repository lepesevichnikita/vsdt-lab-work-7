import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import vsdt.lab.work 1.0

Page {
    id: root
    antialiasing: true
    title: qsTr("Второе задание")

    Task2 {
        id: task
    }

    GridLayout {
        columns: 2
        anchors.fill: parent
        Repeater {
            model: 4
            delegate: Rectangle {
                property int part: index + 1
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                color: task.quorter == part ? 'lightblue' : 'lightgrey'
                Label {
                    text: qsTr((part).toString())
                    font.family: "Cantarell Extra Bold"
                    font.bold: true
                    font.pointSize: 50
                    textFormat: Text.RichText
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.fill: parent
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: task.quorter = part
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
        Rectangle {
            id: signOfResult
            property string text: ""
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.columnSpan: 2
            color: 'lightgrey'
            state: String.fromCharCode(task.signOfResult)
            Label {
                text: parent.text
                font.family: "Cantarell Extra Bold"
                font.bold: true
                font.pointSize: 50
                textFormat: Text.RichText
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
            }
            states: [
                State {
                    name: "-"
                    PropertyChanges {
                        target: signOfResult
                        color: 'crimson'
                        text: qsTr("Отрицательное значение")
                    }
                },
                State {
                    name: '+'
                    PropertyChanges {
                        target: signOfResult
                        color: 'lightgreen'
                        text: qsTr("Положительное значение")
                    }
                }
            ]
        }
    }
}




/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
