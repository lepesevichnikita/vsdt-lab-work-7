import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.1

ApplicationWindow {
    id: application
    visible: true
    title: swipeView.currentItem.title
    minimumWidth: 1024
    minimumHeight: 720

    ObjectModel {
        id: objectModel
        Task1 {
        }
        Task2 {
        }
        Task3 {
        }
        Task4 {
        }
    }

    footer: TabBar {
        id: bar
        width: parent.width
        currentIndex: swipeView.currentIndex
        Repeater {
            model: ["Первое", "Второе", "Третье", "Четвёртое"]
            delegate: TabButton {
                text: [qsTr(modelData), qsTr("задание")].join(" ")
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        anchors.margins: 20
        currentIndex: bar.currentIndex

        Repeater {
            model: objectModel
        }
    }
}
