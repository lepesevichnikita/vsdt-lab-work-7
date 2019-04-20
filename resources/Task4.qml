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
    StackView {
        id: stackView
        initialItem: trainsList
        anchors.fill: parent
        TrainForm {
            id: editTrainForm
            visible: false
            property Train oldTrain
            onSubmitClicked: {
                if (train.isValid) {
                    oldTrain.setFromObject(train)
                    train.reset()
                    stackView.pop()
                }
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
                    stackView.pop()
                }
            }
            onResetClicked: {
                train.reset()
            }
        }

        ListView {
            id: trainsList
            model: trains
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: TrainItem {
                onAboutClicked: {
                    editTrainForm.oldTrain = train
                    editTrainForm.train.setFromObject(train)
                    editTrainForm.dirty = false
                    stackView.push(editTrainForm)
                }
            }
            ScrollBar.vertical: ScrollBar {
                active: true
            }
        }
    }

    header: RowLayout {
        width: parent.width
        RowLayout {
            id: backButton
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Button {
                text: qsTr("Назад")
                onClicked: stackView.pop()
            }
        }
        RowLayout {
            id: mainHeader
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
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
                onClicked: stackView.push(newTrainForm)
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

    states: [
        State {
            name: "homePage"
            when: stackView.depth == 1
            PropertyChanges {
                target: backButton
                visible: false
            }
            PropertyChanges {
                target: mainHeader
                visible: true
            }
        },
        State {
            name: "stacked"
            when: stackView.depth > 1
            PropertyChanges {
                target: backButton
                visible: true
            }
            PropertyChanges {
                target: mainHeader
                visible: false
            }
        }
    ]
}

/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/

