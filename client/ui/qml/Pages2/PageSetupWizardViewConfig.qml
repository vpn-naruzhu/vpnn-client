import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import PageEnum 1.0
import Style 1.0

import "./"
import "../Controls2"
import "../Controls2/TextTypes"
import "../Config"

PageType {
    id: root

    property bool showContent: false

    defaultActiveFocusItem: focusItem

    Item {
        id: focusItem
        KeyNavigation.tab: backButton
    }

    BackButtonType {
        id: backButton

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 20

        KeyNavigation.tab: showContentButton
    }

    Connections {
        target: ImportController

        function onImportErrorOccurred(errorMessage, goToPageHome) {
            if (goToPageHome) {
                PageController.goToStartPage()
            } else {
                PageController.closePage()
            }
        }

        function onImportFinished() {
            if (!ConnectionController.isConnected) {
                ServersModel.setDefaultServerIndex(ServersModel.getServersCount() - 1);
                ServersModel.processedIndex = ServersModel.defaultIndex
            }

            PageController.goToPageHome()
        }
    }

    FlickableType {
        id: fl
        anchors.top: backButton.bottom
        anchors.bottom: parent.bottom
        contentHeight: content.implicitHeight + connectButton.implicitHeight

        ColumnLayout {
            id: content

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 16
            anchors.leftMargin: 16

            HeaderType {
                headerText: qsTr("New connection")
            }

            RowLayout {
                Layout.topMargin: 32
                spacing: 8

                visible: fileName.text !== ""

                Image {
                    source: "qrc:/images/controls/file-check-2.svg"
                }

                Header2TextType {
                    id: fileName

                    Layout.fillWidth: true

                    text: ImportController.getConfigFileName()
                    wrapMode: Text.Wrap
                }
            }

            BasicButtonType {
                id: showContentButton
                Layout.topMargin: 16
                Layout.leftMargin: -8
                implicitHeight: 32

                borderColor: 'transparent'

                text: showContent ? qsTr("Collapse content") : qsTr("Show content")
                contentItem: Text {
                    text: parent.text
                    color: parent.hovered ? UltaStyle.color.buttonTextSelected : UltaStyle.color.buttonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Montserrat Medium"
                }

                KeyNavigation.tab: connectButton

                clickedFunc: function() {
                    showContent = !showContent
                }
            }

            CheckBoxType {
                id: cloakingCheckBox

                visible: ImportController.isNativeWireGuardConfig()

                Layout.fillWidth: true
                text: qsTr("Enable WireGuard obfuscation. It may be useful if WireGuard is blocked on your provider.")
            }

            WarningType {
                Layout.topMargin: 16
                Layout.fillWidth: true

                textString: ImportController.getMaliciousWarningText()
                textFormat: Qt.RichText
                visible: textString !== ""

                iconPath: "qrc:/images/controls/alert-circle.svg"

                textColor: AmneziaStyle.color.vibrantRed
                imageColor: AmneziaStyle.color.vibrantRed
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.bottomMargin: 48

                implicitHeight: configContent.implicitHeight

                radius: 10

                visible: showContent
                color: UltaStyle.color.backGround
                border.color: UltaStyle.color.border

                ParagraphTextType {
                    id: configContent

                    anchors.fill: parent
                    anchors.margins: 16

                    wrapMode: Text.Wrap

                    text: ImportController.getConfig()
                }
            }
        }
    }

    ColumnLayout {
        id: columnContent
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.leftMargin: 16

        Keys.onTabPressed: lastItemTabClicked(focusItem)

        BasicButtonType {
            id: connectButton
            Layout.fillWidth: true
            Layout.bottomMargin: 32

            text: qsTr("Connect")

            contentItem: Text {
                text: parent.text
                color: parent.hovered ? UltaStyle.color.buttonTextSelected : UltaStyle.color.buttonText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Montserrat Medium"
                font.pixelSize: 18
            }

            clickedFunc: function() {
                if (cloakingCheckBox.checked) {
                    ImportController.processNativeWireGuardConfig()
                }
                ImportController.importConfig()
            }
        }
    }
}
