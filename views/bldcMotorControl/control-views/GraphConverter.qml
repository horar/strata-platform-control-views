/*
 * Copyright (c) 2018-2022 onsemi.
 *
 * All rights reserved. This software and/or documentation is licensed by onsemi under
 * limited terms and conditions. The terms and conditions pertaining to the software and/or
 * documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
 * Terms and Conditions of Sale, Section 8 Software”).
 */
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.0

import tech.strata.sgwidgets 1.0

SGGraph {
    id: graphConverter

    property string xAxisTitle
    xTitle: xAxisTitle

    property string yAxisTitle
    yTitle: yAxisTitle

    property real maxYValue
    yMax: maxYValue

    property real minYValue
    yMin: minYValue

    property real maxXValue
    xMax: maxXValue

    property real minXValue
    xMin: minXValue

    property bool showYGrids
    yGrid: showYGrids

    property bool showXGrids
    xGrid: showXGrids

    property color textColor
    foregroundColor: textColor

    property color gridLineColor
    gridColor: gridLineColor

    property bool autoAdjustMaxMin: false  // due to compatibility with SGGraphTimed - this feature was for Y axis only
    property bool autoAdjustXMaxMin: false
    property bool autoAdjustYMaxMin: autoAdjustMaxMin
    property real inputData
    property color dataLineColor: "black"
    property int pointCount: 50

    // PROPERTIES THAT DO NOTHING - no equivalent in SGGraph 1.0
    property real xAxisTickCount: 0
    property real yAxisTickCount: 0
    property bool throttlePlotting
    property bool reverseDirection
    property color underDataColor
    property color axesColor
    property bool showOptions
    property bool repeatOldData
    ////

    panXEnabled: true
    panYEnabled: true
    zoomXEnabled: true
    zoomYEnabled: true
    autoUpdate: true

    Component.onCompleted: {
        if (autoAdjustXMaxMin) {
            autoScaleXAxis()
        }
        if (autoAdjustYMaxMin) {
            autoScaleYAxis()
        }

        let movingCurve = createCurve("movingCurve")
        movingCurve.color = dataLineColor
        movingCurve.autoUpdate = true
    }

    function reset() {
        graphConverter.removeCurve(0);
    }

    Timer {
        id: graphTimerPoints
        interval: ((xMax-xMin)/pointCount)*1000 // like SGGraphTimed, plots a point every (1/pointCount) of the min/max X time interval
        running: true
        repeat: true

        property real lastTime

        onRunningChanged: {
            if (running){
                graphConverter.curve(0).clear()
                lastTime = Date.now()
            }
        }

        onTriggered: {
            let currentTime = Date.now()
            let curve = graphConverter.curve(0)
            if (curve === null) {
                return
            }
            curve.shiftPoints((currentTime - lastTime)/1000, 0)
            curve.append(0, inputData)
            removeOutOfViewPoints()
            graphConverter.update()
            lastTime = currentTime
        }

        function removeOutOfViewPoints() {
            // recursively clean up points that have moved out of view
            if (graphConverter.curve(0).at(0).x > graphConverter.xMax) {
                graphConverter.curve(0).remove(0)
                removeOutOfViewPoints()
            }
        }
    }
}
