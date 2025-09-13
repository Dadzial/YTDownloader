import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects

ApplicationWindow {
    width: 1020
    height: 640
    visible: true
    title: qsTr("YTDownloader")
    color: "#232323"


    header: ToolBar {
        height: 45
        background: Rectangle { color: "#1E1E1E" }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 5

            Image {
                source: "icons/app_icon.png"
                fillMode: Image.PreserveAspectFit
                width: 25
                height: 25
            }

            Text {
                text: "Video Converter"
                font.bold: true
                color: "white"
                font.pointSize: 15
            }

            Item { Layout.fillWidth: true }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        spacing: 1

        TextField {
            id: urlField
            placeholderText: "Paste link here"
            Layout.fillWidth: true
            height: 40
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: statusLabel
            text: ""
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            id: downloadButton
            text: "Download"
            Layout.alignment: Qt.AlignHCenter
            width: 100
            height: 30
            font.pointSize: 12
            font.bold: true
            background: Rectangle {
                color: "red"
                radius: 5
            }

            onClicked: {
                statusLabel.text = "Downloading..."
                downloader.download(urlField.text)
            }
        }

        Connections {
            target: downloader
            onFinished: function(msg) {
                statusLabel.text = msg
            }
        }
    }
}
