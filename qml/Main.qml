/*
 * Copyright (C) 2020  Michael Sheldon
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * cyclecomputer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtLocation 5.9
import QtPositioning 5.9

import Example 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'cyclecomputer.mikeasoft.com'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Cycle Computer')
        }

        Plugin {
            id: mapPlugin
            name: "osm"
            PluginParameter { name: "osm.useragent"; value: "cyclecomputer.mikeasoft.com 0.1" }
            PluginParameter { name: "osm.mapping.providersrepository.address"; value: "http://cyclecomputer.mikeasoft.com" }
            PluginParameter { name: "osm.mapping.highdpi_tiles"; value: true }
        }

        PositionSource {
            id: positionSource
            preferredPositioningMethods: PositionSource.SatellitePositioningMethods
            active: true
        }

        ColumnLayout {
            spacing: units.gu(2)

            anchors {
                margins: 0
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Map {
                plugin: mapPlugin
                center: positionSource.position.coordinate
                zoomLevel: 17
                Layout.fillHeight: true
                Layout.fillWidth: true
                activeMapType: supportedMapTypes[1] // Cycle map
            }

            RowLayout {
                spacing: units.gu(2)
                Layout.alignment: Qt.AlignHCenter

                ColumnLayout {
                    spacing: units.gu(1)

                    Label {
                       text: i18n.tr("Speed")
                    }

                    RowLayout {
                        spacing: units.gu(1)

                        Label {
                            id: speed
                            text: "0"
                            font.pixelSize: units.gu(4)
                        }

                        Label {
                            text: "mph"
                        }
                    }
                }

                ColumnLayout {
                    spacing: units.gu(1)

                    Label {
                        text: i18n.tr("Distance")
                    }

                    RowLayout {
                        spacing: units.gu(1)
                        Label {
                            id: distance
                            text: "0"
                            font.pixelSize: units.gu(4)
                        }

                        Label {
                            text: "miles"
                        }
                    }
                }

                ColumnLayout {
                    spacing: units.gu(1)

                    Label {
                        text: i18n.tr("Elevation")
                    }

                    RowLayout {
                        spacing: units.gu(1)
                        Label {
                            id: elevation
                            text: "0"
                            font.pixelSize: units.gu(4)
                        }

                        Label {
                            text: "feet"
                        }
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}
