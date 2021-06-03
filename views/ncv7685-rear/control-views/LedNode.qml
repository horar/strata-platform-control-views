import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import tech.strata.sgwidgets 1.0
//import tech.strata.sgwidgets 1.0 as SGWidgets
import QtGraphicalEffects 1.12


Rectangle {
    id: root    //ledbg

    implicitWidth:  8
    implicitHeight: implicitWidth

    property bool redled :  true
    property alias ledValue : ledSet.value
    property alias interval : ledTimer.interval

    Rectangle {
          id: led
          width: parent.width
          height: width
          radius: width/2
//          color: "#696969"
          color: "#4F4F4F"

          antialiasing: true

          MouseArea {
              id: led_mouse_area
              width: led.width * 1.2
              height: width
              anchors.verticalCenter: led.verticalCenter
              anchors.horizontalCenter: led.horizontalCenter
              hoverEnabled: true;
              onEntered: {  ledSet.visible = true ; ledTimer.start()}
              }
      }

      Rectangle {
          id: rgled
          width: led.width * 3
          height: width
          radius: width/2
          anchors.verticalCenter: led.verticalCenter
          anchors.horizontalCenter: led.horizontalCenter
          color: "transparent"
          visible: ledSet.value > 0 ? true : false
          RadialGradient {
                    anchors.fill: parent
                    angle: 0.0

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white" }
                        GradientStop { position: 0.1; color: root.redled ? Qt.rgba(0.5 + ledSet.value/254,0,0,1) : Qt.rgba(0.5 + ledSet.value/254,0.5 + ledSet.value/254,0,1)}
                        GradientStop { position: 0.5; color: root.redled ? Qt.rgba(0.01,0,0,1) : Qt.rgba(0.01,0.01,0,1)}
//                        GradientStop { position: 0.5; color: Qt.rgba(0.01,0.01,0,1 )}

                        GradientStop { position: 1; color:  "transparent" }
                    }
          }

      }

//      Text {
//          id: ledText
//          text: qsTr(String(ledSet.value) )
//          color: testrg.visible ? "black" : rgled.color
//          anchors.fill: led
//          anchors.verticalCenter: led.verticalCenter
//          anchors.horizontalCenter: led.horizontalCenter
//      }

      SGSlider {
          id: ledSet
          width:rgled.width * 5
          anchors.top : rgled.bottom
          anchors.horizontalCenter: rgled.horizontalCenter
          visible: false
          from: 0
          to: 127
          value: 0
          stepSize: 1
          fillColor: root.redled ? "#ff0000" : "#ffff00"
          //                    property int cmd_adc_period_test:  1000
          onUserSet: {
              ledTimer.restart()
          }
      }

      Timer {
          id: ledTimer;
          interval: 2000
          repeat: false
          //                    triggeredOnStart: true;
          onTriggered:{
              ledTimer.stop()
              ledSet.visible = false
//              ledText.visible = false
          }
      }


  }






//Window{
//    color: "yellow"
//    width: 100; height: 100
//    visible: true
//    MouseArea {
//        anchors.fill: parent
//        onClicked: console.log("clicked yellow")
//    }

//    Rectangle {
//        color: "blue"
//        width: 50; height: 50

//        MouseArea {
//            anchors.fill: parent
//            propagateComposedEvents: true // 默认值为false
//            onClicked: {
//                console.log("clicked blue")
//                mouse.accepted = false // 设置为false,这样才能传播到另个MouseArea
//            }
//        }
//    }




//Rectangle
//    {
//        x: 30
//        y: 30
//        width: 100
//        height: 100
//        radius: 50
//        antialiasing: true;
//scale
//transformOrigin
//        RadialGradient {
//          anchors.fill: parent
//          angle: 0.0
//          gradient: Gradient {
//              GradientStop { position: 0.0; color: "white" }
//              GradientStop { position: 0.5; color: "black" }
//          }
//      }
//    }
//}

//Window{
//    visible: true

//    Rectangle {
//        id: rect1
//        width: 20;
//        height:20;
//        radius: 10
//        color: "red"
//        visible: false
//    }

//    MouseArea {
//        anchors.fill: parent;
//        id: area;
//    }

//    function click() {
//        rect1.visible = true;
//        rect1.color = Qt.rgba(Math.random(), Math.random(),     Math.random(), 1);
//        rect1.x = arguments[0].x - rect1.width/2;
//        rect1.y = arguments[0].y - rect1.height/2;
//　　}
//    Component.onCompleted: {
//        area.clicked.connect(click); // 将MouseArea的clicked(mouse)信号连接到click方法上
//    }
//}

//Window{
//    visible: true
//    Rectangle {
//        id: rect1
//        width: 20;
//        height:20;
//        radius: 10
//        color: "red"
//       visible: false
//    }

//    MouseArea {
//        id: area;
//        anchors.fill: parent;
//        signal moveRectPos(real x, real y)
//        onClicked: area.moveRectPos(mouse.x, mouse.y); // 当点击后,发射moveRectPos信号
//    }

//    Connections {
//        target: area;
//        onMoveRectPos: {
//        　　rect1.visible = true;
//        　　rect1.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
//        　　rect1.x = x - rect1.width/2;
//        　　rect1.y = y - rect1.height/2;
//        }
//    }
//}


//import QtQuick 2.12
//import QtQuick.Controls 2.12

//Button {
//    id: root
//    text: qsTr("Button")
//    checkable: true
//    enabled: masterEnabled
//    hoverEnabled: masterHoverEnabled

//    // Figures out which button this instance is
//    Component.onCompleted: {
//        if (root.parent.children.length === 1) {
//            // single button style (hopefully this is never used)
//            flatSide.width = 0;
//            flatSide.height = 0;
//        } else if (root.parent.children[root.parent.children.length-1] === root){
//            // last button style
//            flatSide.anchors.left = buttonStyle.left;
//        } else if (root.parent.children[0] === root){
//            // first button style
//            flatSide.anchors.right = buttonStyle.right;
//        } else {
//            //middle buttons style
//            flatSide.width = 0;
//            flatSide.height = 0;
//            buttonStyle.radius = 0;
//        }
//    }

//    property real radius: masterRadius
//    property color activeColor: masterActiveColor
//    property color inactiveColor: masterInactiveColor
//    property color textColor: masterTextColor
//    property color textActiveColor: masterActiveTextColor
//    property alias textSize: buttonText.font.pixelSize
//    property int index: 0

//    signal indexUpdate(int index)

//    background: Rectangle{
//        id: buttonStyle
//        color: root.hovered ? Qt.rgba( (activeColor.r + inactiveColor.r) / 2, (activeColor.g + inactiveColor.g) / 2, (activeColor.b + inactiveColor.b) / 2, 1) : root.checked ? activeColor : inactiveColor
//        radius: root.radius
//        implicitHeight: masterHeight
//        implicitWidth: masterButtonImplicitWidth
//        //opacity: root.enabled ? 1.0 : 0.3
//        layer.enabled: true

//        Rectangle{
//            id: flatSide
//            height: buttonStyle.height
//            width: buttonStyle.width/2
//            color: buttonStyle.color
//        }
//    }

//    contentItem: Text {
//        id:buttonText
//        text: root.text
//        //opacity: root.enabled ? 1.0 : 0.3
//        color: root.checked ? root.textActiveColor : root.textColor
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//        elide: Text.ElideRight
//    }

//    onCheckedChanged: {
//        if (checked) {
//            indexUpdate(root.index)
//        }
//    }
//}



//Item {
//    id: control
//    implicitWidth: strip.width
//    implicitHeight: strip.height

//    property alias model: repeater.model
//    readonly property alias count: repeater.count
//    property bool exclusive: true
//    property int orientation: Qt.Horizontal

//    /* Holds indexes of checked buttons in power of 2 format:
//       for example:
//       0       - no button checked
//       1 = 2^0 - first button checked
//       2 = 2^1 - second button checked
//       4 = 2^2 - third button checked
//       5 = 2^0 + 2^2 - first and third buttons checked
//       6 = 2^1 + 2^2 - second and third buttons checked
//       7 = 2^0 + 2^1 + 2^2 - first, second and third buttons checked
//       8 = 2^3 - fourth button checked

//       To check particular button, use isChecked(buttonIndex)
//    */
//    property int checkedIndices: 0

//    signal clicked(int index)

//    /* The easiest way to check particular button */
//    function isChecked(index) {
//        return checkedIndices & (1 << index)
//    }

//    Grid {
//        id: strip

//        rows: orientation === Qt.Horizontal ? 1 : -1
//        columns: orientation === Qt.Vertical ? 1 : -1
//        spacing: 1

//        Repeater {
//            id: repeater

//            delegate: SGWidgets.SGButton {
//                id: buttonDelegate

//                text: modelData
//                checkable: true
//                checked: checkedIndices & powIndex
//                roundedLeft: orientation == Qt.Horizontal ? index === 0 : true
//                roundedRight: orientation == Qt.Horizontal ? index === repeater.count - 1 : true
//                roundedTop: orientation == Qt.Vertical ? index === 0 : true
//                roundedBottom: orientation == Qt.Vertical ? index === repeater.count - 1 : true

//                property int powIndex: 1 << index

//                onClicked: {
//                    control.clicked(index)

//                    if (control.exclusive) {
//                        checkedIndices = 0
//                        checkedIndices = powIndex
//                    } else {
//                        checkedIndices ^= powIndex
//                    }
//                }
//            }
//        }
//    }
//}



//pragma Singleton

//import QtQuick 2.12
//import Qt.labs.settings 1.1 as QtLabsSettings

//Item {
//    id: root

//    property int fontPixelSize: defaultFontPixelSize

//    readonly property int defaultFontPixelSize: 13

//    QtLabsSettings.Settings {
//        category: "SGWidgets"
//        property alias fontPixelSize: root.fontPixelSize
//    }

//    function resetToDefaultValues() {
//        fontPixelSize = defaultFontPixelSize
//    }
//}




//import QtQuick 2.12
//import QtQuick.Layouts 1.12
//import QtQuick.Controls 2.12

//import tech.strata.sgwidgets 1.0
//import tech.strata.fonts 1.0

//GridLayout {
//    id: root
//    rowSpacing: 0
//    columnSpacing: 0
//    Layout.fillWidth: false
//    Layout.fillHeight: false
//    clip: true
//    opacity: enabled ? 1 : .5
//    layer.enabled: true

//    property real fontSizeMultiplier: 1.0
//    property color textColor: "black"
//    property alias mirror: slider.mirror
//    property alias handleSize: slider.handleSize
//    property alias orientation: slider.orientation
//    property alias value: slider.value
//    property alias from: slider.from
//    property alias to: slider.to
//    property alias horizontal: slider.horizontal
//    property alias vertical: slider.vertical
//    property alias showTickmarks: tickmarkRow.visible
//    property alias showLabels: numsContainer.visible
//    property alias showInputBox: inputBox.visible
//    property alias showToolTip: slider.showToolTip
//    property alias stepSize: slider.stepSize
//    property alias live: slider.live
//    property alias visualPosition: slider.visualPosition
//    property alias position: slider.position
//    property alias snapMode: slider.snapMode
//    property alias pressed: slider.pressed
//    property alias grooveColor: slider.grooveColor
//    property alias fillColor: slider.fillColor

//    property alias slider: slider
//    property alias inputBox: inputBox
//    property alias fromText: fromText
//    property alias toText: toText
//    property alias tickmarkRepeater: tickmarkRepeater
//    property alias inputBoxWidth: inputBox.overrideWidth
//    property alias toolTip: toolTip
//    property alias toolTipText: toolTipText
//    property alias toolTipBackground: toolTipBackground
//    property alias validatorObject: inputValidator
//    property alias handleObject: handle
//    property alias contextMenuEnabled: inputBox.contextMenuEnabled

//    signal userSet(real value)
//    signal moved()

//    function userSetValue (value) {  // sets value, signals userSet
//        slider.userSetValue(value)
//    }

//    function increase () {
//        slider.increase()
//    }

//    function decrease () {
//        slider.decrease()
//    }

//    function valueAt (position) {
//        return slider.valueAt(position)
//    }

//    Slider {
//        id: slider
//        padding: 0
//        Layout.fillHeight: slider.handleSize > -1 && root.horizontal ? false : true
//        Layout.fillWidth: slider.handleSize > -1 && !root.horizontal ? false : true
//        Layout.column: root.horizontal ? 0 : root.mirror ? 1 : 0
//        Layout.row: root.horizontal ? root.mirror ? 1 : 0 : 0
//        Layout.alignment: Qt.AlignHCenter
//        implicitWidth: root.horizontal ? 20 : slider.handleSize > -1 ? slider.handleSize : 20
//        implicitHeight: root.horizontal ? slider.handleSize > -1 ? slider.handleSize : 20 : 20
//        stepSize: .1
//        value: (from + to)/2

//        property int tickmarkCount: stepSize === 0.0 ? 2 : ((to - from) + stepSize) / stepSize
//        property real grooveHandleRatio: .2
//        property color grooveColor: "#bbb"
//        property color fillColor: "#21be2b"
//        property bool mirror: false
//        property bool showToolTip: true
//        property real handleSize: -1

//        // when using stepSize <1, value is generated with rounding error: https://bugreports.qt.io/browse/QTBUG-59020
//        property real roundedValue: parseFloat(value.toFixed(decimals))

//        property int decimals: {
//            if (stepSize === 0.0) {
//                // stepSize of 0 logically means infinite decimals; 15 is max of double precision IEEE 754
//                return 15
//            } else if (Math.floor(slider.stepSize) === slider.stepSize) {
//                return 0
//            } else {
//                return slider.stepSize.toString().split(".")[1].length || 0
//            }
//        }

//        property real lastValue

//        onPressedChanged: {
//            if (!live && !pressed) {
//                if (value !== lastValue){
//                    userSet(value)
//                }
//            } else {
//                lastValue = value
//            }
//        }

//        onMoved: {
//            if (live && value !== lastValue){
//                // QML Slider press/release while live results in onMoved calls (despite no movement and no value change)
//                // this check filters out those calls and ensure userSet() only called when value changes
//                userSet(value)
//                lastValue = value
//            }
//            root.moved()
//        }

//        function userSetValue(value) { // Using this will break value bindings
//            if (value !== slider.value) {
//                slider.value = value
//                userSet(value)
//            }
//        }

//        background: Rectangle {
//            id: groove

//            property real grooveHandleRatio: slider.grooveHandleRatio < 0 ? 0 : slider.grooveHandleRatio > 1 ? 1 : slider.grooveHandleRatio
//            x: slider.horizontal ? 0 : slider.width / 2 - width / 2
//            y: slider.horizontal ? slider.height / 2 - height / 2 : 0
//            implicitWidth: slider.horizontal ? handle.width : handle.width * grooveHandleRatio
//            implicitHeight: slider.horizontal ? handle.height * grooveHandleRatio : handle.height
//            width: slider.horizontal ? slider.width : implicitWidth
//            height: slider.horizontal ? implicitHeight : slider.height
//            radius: (Math.min(height, width))/ 2
//            color: slider.grooveColor

//            Rectangle {
//                id: grooveFill
//                width: slider.horizontal ? handle.x + handle.width / 2: groove.width
//                height: slider.horizontal ? groove.height : groove.height - handle.y - handle.height / 2
//                anchors {
//                    bottom: groove.bottom
//                }
//                color: slider.fillColor
//                radius: groove.radius
//            }

//            Grid {
//                id: tickmarkRow
//                visible: false
//                z: -1
//                x: {
//                    if (slider.horizontal) {
//                        return (handle.width / 2) - 1
//                    } else {
//                        if (mirror) {
//                            return (groove.width / 2) - tickmarkRepeater.tickmarkWidth
//                        } else {
//                            return groove.width / 2
//                        }
//                    }
//                }
//                y: {
//                    if (slider.horizontal) {
//                        if (mirror) {
//                            return (groove.height / 2) - tickmarkRepeater.tickmarkHeight
//                        } else {
//                            return groove.height / 2
//                        }
//                    } else {
//                        return (handle.height / 2) - 1
//                    }
//                }
//                columns: slider.horizontal ? slider.tickmarkCount : 1
//                spacing: {
//                    if (slider.horizontal) {
//                        return slider.width / (slider.tickmarkCount - 1) - tickmarkRepeater.tickmarkWidth - (handle.width / (slider.tickmarkCount-1))
//                    } else {
//                        return slider.height / (slider.tickmarkCount - 1) - tickmarkRepeater.tickmarkHeight - (handle.width / (slider.tickmarkCount-1))
//                    }
//                }

//                Repeater {
//                    id: tickmarkRepeater
//                    model: slider.tickmarkCount < 100 ? slider.tickmarkCount : 2 // don't flood with tickmarks if (to-from) is large and stepSize is very small
//                    property real tickmarkHeight: slider.horizontal ? slider.height / 2 : 1
//                    property real tickmarkWidth: slider.horizontal ? 1 : slider.width / 2
//                    delegate: Rectangle {
//                        id: tickmark
//                        color: groove.color
//                        width: tickmarkRepeater.tickmarkWidth
//                        height: tickmarkRepeater.tickmarkHeight
//                    }
//                }
//            }
//        }

//        handle: Rectangle {
//            id: handle
//            x: slider.horizontal ? slider.visualPosition * (slider.width - width) : slider.width / 2 - width /2
//            y: slider.horizontal ? slider.height / 2 - height / 2 : slider.visualPosition * (slider.height - height)
//            implicitWidth: height
//            implicitHeight: Math.min(slider.height, slider.width)
//            radius: (Math.min(height, width))/ 2
//            color: slider.pressed ? "#f0f0f0" : "#f6f6f6"
//            border.color: groove.color

//            ToolTip {
//                id: toolTip
//                visible: slider.showToolTip && slider.pressed
//                text: (slider.valueAt(slider.position)).toFixed(slider.decimals) // not 'correctedValue' so it shows live value when 'live: false'

//                contentItem: SGText {
//                    id: toolTipText
//                    color: root.textColor
//                    text: toolTip.text
//                    font.family: Fonts.inconsolata
//                    fontSizeMultiplier: root.fontSizeMultiplier
//                }

//                background: Rectangle {
//                    id: toolTipBackground
//                    color: "#eee"
//                    radius: 2
//                }
//            }
//        }
//    }

//    Item {
//        id: numsContainer
//        Layout.preferredHeight: root.horizontal ? numsGrid.implicitHeight : fromText.contentHeight + toText.contentHeight
//        Layout.preferredWidth: root.horizontal ? fromText.contentWidth + toText.contentWidth : numsGrid.implicitWidth
//        Layout.fillHeight: true
//        Layout.fillWidth: true
//        Layout.maximumHeight: root.horizontal ? Layout.preferredHeight : slider.height
//        Layout.maximumWidth: root.horizontal ? slider.width : Layout.preferredWidth
//        Layout.column: root.horizontal ? 0 : root.mirror ? 0 : 1
//        Layout.row: root.horizontal ? root.mirror ? 0 : 1 : 0
//        Layout.rightMargin: !root.horizontal && root.mirror ? 3 * fontSizeMultiplier : 0  // for padding against tickmark when vertical
//        Layout.leftMargin: !root.horizontal && !root.mirror ? 3 * fontSizeMultiplier : 0

//        GridLayout {
//            id: numsGrid
//            anchors.fill: numsContainer
//            rowSpacing: 0
//            columnSpacing: 0

//            SGText {
//                id: fromText
//                text: slider.from
//                fontSizeMultiplier: root.fontSizeMultiplier
//                Layout.alignment: root.horizontal ? Qt.AlignLeft : Qt.AlignBottom
//                Layout.column: 0
//                Layout.row: root.horizontal ? 0 : 1
//                Layout.bottomMargin: root.horizontal ? 0 : (contentHeight < slider.handle.height) ? (slider.handle.height - contentHeight) / 2 : 0
//                Layout.leftMargin: root.horizontal ? (contentWidth < slider.handle.width) ? (slider.handle.width - contentWidth) / 2 : 0 : 0
//                Layout.fillWidth: true
//                elide: Text.ElideLeft
//                horizontalAlignment: !root.horizontal && root.mirror ? Text.AlignRight : Text.AlignLeft
//                color: root.textColor
//            }

//            SGText {
//                id: toText
//                text: slider.to
//                fontSizeMultiplier: root.fontSizeMultiplier
//                Layout.alignment: root.horizontal ? Qt.AlignRight : Qt.AlignTop
//                Layout.column: root.horizontal ? 1 : 0
//                Layout.row: 0
//                Layout.topMargin: root.horizontal ? 0 : (contentHeight < slider.handle.height) ? (slider.handle.height - contentHeight) / 2 : 0
//                Layout.rightMargin: root.horizontal ? (contentWidth < slider.handle.width) ? (slider.handle.width - contentWidth) / 2 : 0 : 0
//                Layout.fillWidth: true
//                elide: Text.ElideLeft
//                horizontalAlignment: root.horizontal || !root.horizontal && root.mirror ? Text.AlignRight : Text.AlignLeft
//                color: root.textColor
//            }
//        }
//    }

//    SGInfoBox {
//        id: inputBox
//        Layout.column: root.horizontal ? 1 : root.mirror ? 1 : 0
//        Layout.rowSpan: 1
//        Layout.columnSpan: 1
//        Layout.row: root.horizontal ? root.mirror ? 1 : 0 : 1
//        Layout.alignment: Qt.AlignHCenter
//        Layout.topMargin: root.horizontal ? 0 : 5
//        Layout.leftMargin: root.horizontal ? 5 : 1
//        Layout.rightMargin: 1 // prevents root from clipping right border occasionally
//        Layout.preferredWidth: overrideWidth > -1 ? overrideWidth : (implicitWidthHelper.width + boxFont.pixelSize)
//        Layout.maximumWidth: Layout.preferredWidth
//        Layout.fillWidth: true
//        fontSizeMultiplier: root.fontSizeMultiplier
//        readOnly: false
//        text: slider.roundedValue
//        textColor: root.textColor

//        property real overrideWidth: -1

//        validator: DoubleValidator {
//            id: inputValidator
//            decimals: slider.decimals
//            bottom: slider.from
//            top: slider.to
//        }

//        onEditingFinished: slider.userSetValue(parseFloat(text))

//        TextMetrics {
//            id: implicitWidthHelper
//            font: inputBox.boxFont
//            text: {
//                var string = "0"
//                return string.repeat(lengthOfLongestString)
//            }
//            property int lengthOfLongestString: Math.max(root.from.toString().length, root.to.toString().length) + slider.decimals + (slider.decimals > 0 ? 1 : 0) // if decimal places, add 1 for decimal point
//        }
//    }
//}

//import QtQuick 2.9
//import QtQuick.Layouts 1.3
//import QtQuick.Controls 2.2
//import tech.strata.sgwidgets 0.9

//Rectangle {
//    id: root

//    property alias outputVoltage: outputVoltageBox.value
//    property alias inputVoltage: inputVoltageBox.value
//    property alias inputCurrent: inputCurrentBox.value
//    property alias outputCurrent: outputCurrentBox.value
//    property alias temperature: temperatureBox.value
//    //property alias efficiency: efficiencyBox.value

//    property int boxHeight: root.height/5
//    property int statBoxValueSize: 24
//    property int statBoxUnitSize: 15

//    color: "dimgray"
//    radius: 10
//    //border.color:"white"
//    width: 400

//    Column {
//        id: column1

//        width: root.width/3-1
//        spacing: 3
//        anchors.left:parent.left
//        anchors.leftMargin:50

//        PortStatBox{
//            id:inputVoltageBox
//            anchors.left:column1.left
//            anchors.topMargin: 8
//            anchors.right: column1.right
//            height:boxHeight
//            label: "VOLTAGE IN"
//            labelColor: "white"
//            color:"transparent"
//            icon: "../images/icon-voltage.svg"
//            valueSize:statBoxValueSize
//            unitSize:statBoxUnitSize
//            textColor: "#FFF"
//        }

//        PortStatBox{
//            id:inputCurrentBox
//            anchors.left:column1.left
//            anchors.topMargin: 8
//            anchors.right: column1.right
//            height:boxHeight
//            label: "CURRENT IN"
//            labelColor: "white"
//            unit: "mA"
//            color:"transparent"
//            icon: "../images/icon-voltage.svg"
//            valueSize:statBoxValueSize
//            unitSize:statBoxUnitSize
//            textColor: "#FFF"
//        }

//        PortStatBox{
//            id:efficiencyBox
//            anchors.left:column1.left
//            anchors.topMargin: 8
//            anchors.right: column1.right
//            height:boxHeight
//            label: "EFFICIENCY"
//            labelColor: "white"
//            unit:"%"
//            color:"transparent"
//            icon: "../images/icon-efficiency.svg"
//            valueSize:statBoxValueSize
//            unitSize:statBoxUnitSize
//            textColor: "#FFF"
//            opacity:0
//        }

//    }

//    Column {
//        id: column2
//        anchors {
//            //left: column1.right
//            //leftMargin: root.width/3
//            right:parent.right
//            rightMargin:50
//            verticalCenter: column1.verticalCenter
//        }
//        spacing: column1.spacing
//        width: root.width/3 - 2

//        PortStatBox{
//            id:outputVoltageBox
//            anchors.left:column2.left
//            anchors.topMargin: 8
//            anchors.right: column2.right
//            height:boxHeight
//            label: "VOLTAGE OUT"
//            labelColor: "white"
//            unit: "V"
//            color:"transparent"
//            icon: "../images/icon-voltage.svg"
//            valueSize:statBoxValueSize
//            unitSize:statBoxUnitSize
//            textColor: "#FFF"
//        }

//        PortStatBox{
//            id:outputCurrentBox
//            anchors.left:column2.left
//            anchors.topMargin: 8
//            anchors.right: column2.right
//            height:boxHeight
//            label: "CURRENT OUT"
//            labelColor: "white"
//            unit:"mA"
//            color:"transparent"
//            icon: "../images/icon-voltage.svg"
//            valueSize:statBoxValueSize
//            unitSize:statBoxUnitSize
//            textColor: "#FFF"
//        }

//        PortStatBox{
//            id:temperatureBox
//            anchors.left:column2.left
//            anchors.topMargin: 8
//            anchors.right: column2.right
//            height:boxHeight
//            label: "TEMPERATURE"
//            labelColor: "white"
//            unit:"°C"
//            color:"transparent"
//            icon: "../images/icon-temp.svg"
//            valueSize:statBoxValueSize
//            unitSize:statBoxUnitSize
//            textColor: "#FFF"
//        }
//    }

//    Text{
//        id:sourceCapabilitiesText
//        text:"SOURCE CAPABILITIES"
//        color:"white"
//        font.bold:true
//        anchors {
//            left: PortInfo.left
//            leftMargin: 10
//            top: column2.bottom
//            topMargin: 10
////            right: advanceControlsView.right
////            rightMargin: 10
//        }
//    }

//    SGSegmentedButtonStrip {
//        id: sourceCapabilitiesButtonStrip
//        anchors {
//            top: sourceCapabilitiesText.bottom
//            topMargin: 3
////            verticalCenter: advanceControlsView.verticalCenter
////            horizontalCenter: advanceControlsView.horizontalCenter
//              left: PortInfo.left
//              leftMargin: 10

//        }
//        textColor: "#666"
//        activeTextColor: "white"
//        radius: 4
//        buttonHeight: 30
//        buttonImplicitWidth: root.width/7 -3   //deduct the spacing between columns
//        hoverEnabled: false

//        property var sourceCapabilities: platformInterface.usb_pd_advertised_voltages_notification.settings

//        onSourceCapabilitiesChanged:{

//            //the strip's first child is the Grid layout. The children of that layout are the buttons in
//            //question. This makes accessing the buttons a little bit cumbersome since they're loaded dynamically.
//            //console.log("updating advertised voltages for port ",portNumber)
//            //disable all the possibilities
//            sourceCapabilitiesButtonStrip.buttonList[0].children[6].enabled = false;
//            sourceCapabilitiesButtonStrip.buttonList[0].children[5].enabled = false;
//            sourceCapabilitiesButtonStrip.buttonList[0].children[4].enabled = false;
//            sourceCapabilitiesButtonStrip.buttonList[0].children[3].enabled = false;
//            sourceCapabilitiesButtonStrip.buttonList[0].children[2].enabled = false;
//            sourceCapabilitiesButtonStrip.buttonList[0].children[1].enabled = false;
//            sourceCapabilitiesButtonStrip.buttonList[0].children[0].enabled = false;

//            var numberOfSettings = platformInterface.usb_pd_advertised_voltages_notification.number_of_settings;
//            if (numberOfSettings >= 7){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[6].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[6].text = platformInterface.usb_pd_advertised_voltages_notification.settings[6].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[6].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[6].text += platformInterface.usb_pd_advertised_voltages_notification.settings[6].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[6].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[6].text = "NA";
//            }

//            if (numberOfSettings >= 6){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[5].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[5].text = platformInterface.usb_pd_advertised_voltages_notification.settings[5].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[5].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[5].text += platformInterface.usb_pd_advertised_voltages_notification.settings[5].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[5].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[5].text = "NA";
//            }

//            if (numberOfSettings >= 5){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[4].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[4].text = platformInterface.usb_pd_advertised_voltages_notification.settings[4].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[4].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[4].text += platformInterface.usb_pd_advertised_voltages_notification.settings[4].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[4].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[4].text = "NA";
//            }

//            if (numberOfSettings >= 4){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[3].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[3].text = platformInterface.usb_pd_advertised_voltages_notification.settings[3].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[3].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[3].text += platformInterface.usb_pd_advertised_voltages_notification.settings[3].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[3].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[3].text = "NA";
//            }

//            if (numberOfSettings >= 3){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[2].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[2].text = platformInterface.usb_pd_advertised_voltages_notification.settings[2].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[2].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[2].text += platformInterface.usb_pd_advertised_voltages_notification.settings[2].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[2].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[2].text = "NA";
//            }

//            if (numberOfSettings >= 2){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].text = platformInterface.usb_pd_advertised_voltages_notification.settings[1].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].text += platformInterface.usb_pd_advertised_voltages_notification.settings[1].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].text = "NA";
//            }

//            if (numberOfSettings >= 1){
//                sourceCapabilitiesButtonStrip.buttonList[0].children[0].enabled = true;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[0].text = platformInterface.usb_pd_advertised_voltages_notification.settings[0].voltage;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[0].text += "V, ";
//                sourceCapabilitiesButtonStrip.buttonList[0].children[0].text += platformInterface.usb_pd_advertised_voltages_notification.settings[0].maximum_current;
//                sourceCapabilitiesButtonStrip.buttonList[0].children[0].text += "A";
//            }
//            else{
//                sourceCapabilitiesButtonStrip.buttonList[0].children[1].text = "NA";
//            }

//        }



//        segmentedButtons: GridLayout {
//            id:advertisedVoltageGridLayout
//            columnSpacing: 2

//            property int sidePadding: 5

//            SGSegmentedButton{
//                id: setting1
//                text: qsTr("5V\n3A")
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }

//            SGSegmentedButton{
//                id: setting2
//                text: qsTr("7V\n3A")
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }

//            SGSegmentedButton{
//                id:setting3
//                text: qsTr("8V\n3A")
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }

//            SGSegmentedButton{
//                id:setting4
//                text: qsTr("9V\n3A")
//                //enabled: false
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }

//            SGSegmentedButton{
//                id:setting5
//                text: qsTr("12V\n3A")
//                enabled: false
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }

//            SGSegmentedButton{
//                id:setting6
//                text: qsTr("15V\n3A")
//                enabled: false
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }

//            SGSegmentedButton{
//                id:setting7
//                text: qsTr("20V\n3A")
//                enabled: false
//                checkable: false
//                leftPadding:sidePadding
//                rightPadding:sidePadding
//            }
//        }
//    } //source capabilities segmented button strip
//}




