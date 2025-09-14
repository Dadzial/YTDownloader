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
        anchors.margins: 10
        spacing: 10

        Label {
            text: "Paste link here"
            font.pointSize: 12
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: urlField
            Layout.fillWidth: true
            height: 40
            placeholderText: "..."
            font.pointSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            background: Rectangle {
                color: "#1E1E1E"
                radius: 5
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            Rectangle {
                id: formatChoose
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#1E1E1E"
                radius: 5

                property string selectedFormat: "mp4"

                Label {
                    text: "Choose format"
                    font.pointSize: 11
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    color: "white"
                }

                Row {
                    id: radioRow
                    spacing: 20
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    anchors.left: parent.left
                    anchors.leftMargin: 10

                    RadioButton {
                        id: mp4Button
                        text: "mp4"
                        checked: true
                        onCheckedChanged: if (checked) formatChoose.selectedFormat = "mp4"

                        indicator: Rectangle {
                            width: 16
                            height: 16
                            radius: 8
                            border.color: "white"
                            border.width: 2
                            color: parent.checked ? "red" : "white"
                        }
                    }
                    RadioButton {
                        id: mp3Button
                        text: "mp3"
                        onCheckedChanged: if (checked) formatChoose.selectedFormat = "mp3"

                        indicator: Rectangle {
                            width: 16
                            height: 16
                            radius: 8
                            border.color: "white"
                            border.width: 2
                            color: parent.checked ? "red" : "white"
                        }
                    }
                    RadioButton {
                        id: webmButton
                        text: "webm"
                        onCheckedChanged: if (checked) formatChoose.selectedFormat = "webm"

                        indicator: Rectangle {
                            width: 16
                            height: 16
                            radius: 8
                            border.color: "white"
                            border.width: 2
                            color: parent.checked ? "red" : "white"
                        }
                    }
                }
            }

            Rectangle {
                id: localizationChoose
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#1E1E1E"
                radius: 5
                property string selectedPath: ""

                Label {
                    text: "Choose localization"
                    font.pointSize: 11
                    font.bold: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    color: "white"
                }

                Button {
                    id: chooseButton
                    font.pointSize: 10
                    font.bold: true
                    background: Rectangle {
                        color: "red"
                        radius: 5
                    }
                    text: "Browse..."
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 40
                    onClicked: {
                        var folder = downloader.choose_folder()
                        if(folder !== "") {
                            chosenPath.text = folder
                            localizationChoose.selectedPath = folder
                        }
                    }
                }

                Label {
                    id: chosenPath
                    text: "No folder selected"
                    color: "white"
                    anchors.left: parent.left
                    anchors.top: chooseButton.bottom
                    anchors.leftMargin: 10
                    anchors.topMargin: 10
                    elide: Text.ElideRight
                    width: parent.width - 20
                }
            }
        }

        Button {
            id: downloadButton
            text: "Download"
            Layout.alignment: Qt.AlignHCenter
            anchors.topMargin: 15
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
                downloader.download(urlField.text, formatChoose.selectedFormat, localizationChoose.selectedPath)
            }
        }

        Text {
            id: statusLabel
            text: ""
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }

        Connections {
            target: downloader
            onFinished: function(msg) {
                statusLabel.text = msg
            }
        }
    }
}
