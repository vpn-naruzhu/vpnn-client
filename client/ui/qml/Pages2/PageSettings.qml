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

    defaultActiveFocusItem: header

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

            HeaderType {
                id: header
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.rightMargin: 16
                Layout.leftMargin: 16

                headerText: qsTr("Settings")

                KeyNavigation.tab: account.rightButton
            }

            LabelWithButtonType {
                id: account
                Layout.fillWidth: true
                Layout.topMargin: 16

                text: qsTr("Servers")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/server.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsServersList)
                }

                KeyNavigation.tab: connection.rightButton
            }

            DividerType {}

            LabelWithButtonType {
                id: connection
                Layout.fillWidth: true

                text: qsTr("Connection")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/radio.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsConnection)
                }

                KeyNavigation.tab: application.rightButton
            }

            DividerType {}

            LabelWithButtonType {
                id: application
                Layout.fillWidth: true

                text: qsTr("Application")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/app.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsApplication)
                }

                KeyNavigation.tab: backup.rightButton
            }

            DividerType {}

            LabelWithButtonType {
                id: backup
                Layout.fillWidth: true

                text: qsTr("Backup")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/save.svg"

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageSettingsBackup)
                }

                KeyNavigation.tab: about.rightButton
            }

            DividerType {}

            LabelWithButtonType {
                id: about
                Layout.fillWidth: true

                text: qsTr("About VPNNaruzhu")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/external-link.svg"

                clickedFunction: function() {
                    Qt.openUrlExternally("https://naruzhu.click/appam")
                }
                KeyNavigation.tab: close

            }

            DividerType {}

            LabelWithButtonType {
                id: devConsole
                visible: SettingsController.isDevModeEnabled
                Layout.fillWidth: true

                text: qsTr("Dev console")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/bug.svg"

                // Keys.onTabPressed: lastItemTabClicked(header)

                clickedFunction: function() {
                    PageController.goToPage(PageEnum.PageDevMenu)
                }
            }

            DividerType {
                visible: SettingsController.isDevModeEnabled
            }

            LabelWithButtonType {
                id: supportTelegramm
                Layout.fillWidth: true

                text: qsTr("Support via Telegram")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/telegramNaruzhu.svg"

                clickedFunction: function() {
                     Qt.openUrlExternally("https://t.me/vpn_naruzhu_support_bot")
                }
            }

            DividerType {}

            LabelWithButtonType {
                id: supportEmail
                Layout.fillWidth: true

                text: qsTr("Support via Email")
                descriptionText: qsTr("team@vpn-naruzhu.com")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/email.svg"

                clickedFunction: function() {
                     Qt.openUrlExternally("mailto:team@vpn-naruzhu.com")
                }
            }

            DividerType {}

            LabelWithButtonType {
                id: telegrammGroup
                Layout.fillWidth: true

                text: qsTr("Telegram Group")
                rightImageSource: "qrc:/images/controls/chevron-right.svg"
                leftImageSource: "qrc:/images/controls/chat.svg"

                clickedFunction: function() {
                     Qt.openUrlExternally("https://t.me/vpn_naruzhu")
                }
>>>>>>> f5a305cd (Apply design changes.)
            }

            LabelWithButtonType {
                id: close
                visible: GC.isDesktop()
                Layout.fillWidth: true
                Layout.preferredHeight: about.height

                text: qsTr("Close application")
                leftImageSource: "qrc:/images/controls/x-circle.svg"
                isLeftImageHoverEnabled: false

                Keys.onTabPressed: lastItemTabClicked(header)

                clickedFunction: function() {
                    PageController.closeApplication()
                }
            }

            DividerType {
                visible: GC.isDesktop()
            }
        }
    }
}
