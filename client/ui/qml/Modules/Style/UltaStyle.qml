pragma Singleton

import QtQuick

QtObject {
    property QtObject color: QtObject {
        readonly property color backGround: '#5869E9'
        readonly property color mainText: '#FFFFFF'
        readonly property color mainTextSelected: '#5869E9'
        readonly property color comment: '#DADADA'
        readonly property color buttonBackGround: 'transparent'
        readonly property color buttonBackGroundSelected: '#FFFFFF'
        readonly property color border: '#FFFFFF'
        readonly property color bottomBarBackGround: '#FFFFFF'
        readonly property color bottomBarText: '#212121'
    }
}