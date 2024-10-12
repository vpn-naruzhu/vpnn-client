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

    Connections {
        target: ImportController

        function onQrDecodingFinished() {
            if (Qt.platform.os === "ios") {
                PageController.closePage()
            }
            PageController.goToPage(PageEnum.PageSetupWizardViewConfig)
        }
    }

    defaultActiveFocusItem: focusItem

    FlickableType {
        id: fl
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        contentHeight: content.height

        ColumnLayout {
            id: content

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 0

            Item {
                id: focusItem
                KeyNavigation.tab: backButton
            }

            BackButtonType {
                id: backButton
                Layout.topMargin: 20
            }

            HeaderType {
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.rightMargin: 16
                Layout.leftMargin: 16

                headerText: qsTr("Server connection")

            /*
                actionButtonImage: PageController.isStartPageVisible() ? "qrc:/images/controls/more-vertical.svg" : ""
                actionButtonFunction: function() {
                    moreActionsDrawer.open()
                }

                DrawerType2 {
                    id: moreActionsDrawer

                    parent: root

                    anchors.fill: parent
                    expandedHeight: root.height * 0.35

                    expandedContent: ColumnLayout {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16

                        HeaderType {
                            Layout.fillWidth: true
                            Layout.topMargin: 32

                            headerText: qsTr("Settings")
                        }

                        SwitcherType {
                            id: switcher
                            Layout.fillWidth: true
                            Layout.topMargin: 16

                            text: qsTr("Enable logs")

                            checked: SettingsController.isLoggingEnabled
                            onCheckedChanged: {
                                if (checked !== SettingsController.isLoggingEnabled) {
                                    SettingsController.isLoggingEnabled = checked
                                }
                            }
                        }
                    }
                }
            */
            }

            Header2TextType {
                Layout.fillWidth: true
                Layout.topMargin: 48
                Layout.rightMargin: 16
                Layout.leftMargin: 16

                text: qsTr("What do you have?")
            }
            /*
            ParagraphTextType {
                Layout.fillWidth: true
                Layout.topMargin: 32
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 24

                text: qsTr("Insert the key, add a configuration file or scan the QR-code")
            }

            TextFieldWithHeaderType {
                id: textKey

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16

                headerText: qsTr("Insert key")
                buttonText: qsTr("Insert")

                clickedFunc: function() {
                    textField.text = ""
                    textField.paste()
                }

                KeyNavigation.tab: continueButton
            }

            BasicButtonType {
                id: continueButton

                Layout.fillWidth: true
                Layout.topMargin: 16
                Layout.rightMargin: 16
                Layout.leftMargin: 16

                visible: textKey.textFieldText !== ""

                text: qsTr("Continue")
                Keys.onTabPressed: lastItemTabClicked(focusItem)

                clickedFunc: function() {
                    if (ImportController.extractConfigFromData(textKey.textFieldText)) {
                        PageController.goToPage(PageEnum.PageSetupWizardViewConfig)
                    }
                }
            }

            ParagraphTextType {
                Layout.fillWidth: true
                Layout.topMargin: 32
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 24

                color: AmneziaStyle.color.charcoalGray
                text: qsTr("Other connection options")
            }

            CardWithIconsType {
                id: apiInstalling

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                headerText: qsTr("VPN by Amnezia")
                bodyText: qsTr("Connect to classic paid and free VPN services from Amnezia")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/amnezia.svg"

                onClicked: function() {
                    PageController.showBusyIndicator(true)
                    var result = InstallController.fillAvailableServices()
                    PageController.showBusyIndicator(false)
                    if (result) {
                        PageController.goToPage(PageEnum.PageSetupWizardApiServicesList)
                    }
                }
            }

            CardWithIconsType {
                id: manualInstalling

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                headerText: qsTr("Self-hosted VPN")
                bodyText: qsTr("Configure Amnezia VPN on your own server")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/server.svg"

                onClicked: {
                    PageController.goToPage(PageEnum.PageSetupWizardCredentials)
                }
            }

            CardWithIconsType {
                id: backupRestore

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                visible: PageController.isStartPageVisible()

                headerText: qsTr("Restore from backup")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/archive-restore.svg"

                onClicked: {
                    var filePath = SystemController.getFileName(qsTr("Open backup file"),
                                                                qsTr("Backup files (*.backup)"))
                    if (filePath !== "") {
                        PageController.showBusyIndicator(true)
                        SettingsController.restoreAppConfig(filePath)
                        PageController.showBusyIndicator(false)
                    }
                }
            }
            */

            CardWithIconsType {
                id: openFile

                Layout.fillWidth: true
                Layout.topMargin: 16
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                headerText: qsTr("Key as file")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/folder-search-2.svg"

                onClicked: {
                    var nameFilter = "Config files (*.vpn *.ovpn *.conf *.json)"
                    var fileName = SystemController.getFileName(qsTr("Open key file"), nameFilter)
                    if (fileName !== "") {
                        if (ImportController.extractConfigFromFile(fileName)) {
                            PageController.goToPage(PageEnum.PageSetupWizardViewConfig)
                        }
                    }
                }
            }

            CardWithIconsType {
                id: openAsText

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                headerText: qsTr("Key as Text")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/text-cursor.svg"

                onClicked: {
                    PageController.goToPage(PageEnum.PageSetupWizardTextKey)
                }
            }

            /*
            CardWithIconsType {
                id: scanQr

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                visible: SettingsController.isCameraPresent()

                headerText: qsTr("QR code")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/scan-line.svg"

                onClicked: {
                    ImportController.startDecodingQr()
                    if (Qt.platform.os === "ios") {
                        PageController.goToPage(PageEnum.PageSetupWizardQrReader)
                    }
                }
            }

            CardWithIconsType {
                id: siteLink

                Layout.fillWidth: true
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.bottomMargin: 16

                visible: PageController.isStartPageVisible()

                headerText: qsTr("I have nothing")

                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/help-circle.svg"

                onClicked: {
                    Qt.openUrlExternally(LanguageModel.getCurrentSiteUrl())
                }
            }
            */
        }
    }
}
