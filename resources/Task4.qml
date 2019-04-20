import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQml.Models 2.12

import vsdt.lab.work 1.0

Page {
    id: root
    antialiasing: true
    title: qsTr("Четвёртое задание")
    state: 'viewTrain'

    header: RowLayout {
        width: parent.width
        RowLayout {
            id: homeBlock
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Button {
                text: qsTr("Домой")
                onClicked: root.state = "viewTrains"
            }
        }
        RowLayout {
            id: mainHeader
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Button {
                text: qsTr("Открыть файл")
                onClicked: openFileDialog.open()
            }
            Button {
                text: qsTr("Сохранить в файл")
                onClicked: writeFileDialog.open()
            }
            Button {
                id: addNewTrainButton
                text: qsTr("Добавить новый поезд")
                onClicked: root.state = "newTrain"
            }
        }
    }

    TrainModel {
        id: trains
    }
    FileDialog {
        id: openFileDialog
        selectedNameFilter: qsTr("All Files (*)")
        title: qsTr("Открыть файл")
        selectMultiple: false
        onAccepted: {
            trains.inputFilePath = fileUrl
            trains.readTrains()
        }
    }

    FileDialog {
        id: writeFileDialog
        selectExisting: false
        title: qsTr("Сохранить файл")
        selectMultiple: false
        onAccepted: {
            trains.outputFilePath = fileUrl
            trains.writeTrains()
        }
    }

    GridLayout {
        anchors.fill: parent
        ListView {
            id: trainsList
            model: trains
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: TrainItem {
                onAboutClicked: {
                    editTrainForm.oldTrain = train
                    editTrainForm.train.setFromObject(train)
                    root.state = "editTrain"
                }
            }
            ScrollBar.vertical: ScrollBar {
                active: true
            }
        }
        TrainForm {
            id: editTrainForm
            visible: false
            property Train oldTrain
            onSubmitClicked: {
                oldTrain.setFromObject(train)
                train.reset()
                root.state = "viewTrains"
            }
            onResetClicked: {
                train.setFromObject(oldTrain)
            }
        }
        TrainForm {
            id: newTrainForm
            visible: false
            onSubmitClicked: {
                if (train.isValid) {
                    var newTrain = train.copyFromObject(train)
                    train.reset()
                    trains.append(newTrain)
                    root.state = "viewTrains"
                }
            }
            onResetClicked: {
                train.reset()
            }
        }
    }
    states: [
        State {
            name: "editTrain"
            PropertyChanges {
                target: editTrainForm
                visible: true
            }
            PropertyChanges {
                target: newTrainForm
                visible: false
            }
            PropertyChanges {
                target: mainHeader
                visible: false
            }
            PropertyChanges {
                target: trainsList
                visible: false
            }
        },
        State {
            name: "newTrain"
            PropertyChanges {
                target: editTrainForm
                visible: false
            }
            PropertyChanges {
                target: newTrainForm
                visible: true
            }
            PropertyChanges {
                target: mainHeader
                visible: false
            }
            PropertyChanges {
                target: trainsList
                visible: false
            }
        },
        State {
            name: "viewTrains"
            PropertyChanges {
                target: editTrainForm
                visible: false
            }
            PropertyChanges {
                target: newTrainForm
                visible: false
            }
            PropertyChanges {
                target: mainHeader
                visible: true
            }
            PropertyChanges {
                target: trainsList
                visible: true
            }
        }
    ]
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

