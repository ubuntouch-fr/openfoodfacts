import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.0
import Ubuntu.Components.ListItems 1.3 as ListItem

Page {
    id: healtjournal

    title: i18n.tr("Healt journal");
    head {
        foregroundColor: openFoodFacts.settings.fontColor;
    }
    Component.onCompleted: openFoodFacts.currentPage="healtjournal";

    head.sections.model: [
        (healtjournal.head.sections.selectedIndex === 0 ? i18n.tr("Summary") : "<font color=\"#FFFFFF\">" + i18n.tr("Summary") + "</font>"),
        (healtjournal.head.sections.selectedIndex === 1 ? i18n.tr("Food Diary") : "<font color=\"#FFFFFF\">" + i18n.tr("Food Diary") + "</font>"),
        (healtjournal.head.sections.selectedIndex === 2 ? i18n.tr("Exercise Diary") : "<font color=\"#FFFFFF\">" + i18n.tr("Exercise Diary") + "</font>")
    ]


    VisualItemModel {
        id: tabs


// Summary TAB
Item {
            width: tabView.width
            height: tabView.height

            Rectangle {
                anchors.fill: parent;
                color: "#EDEDEC"


                    Rectangle {
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        anchors.topMargin: units.gu(5);
                        color: "#EDEDEC"


                        Item {
                            anchors.fill: parent;

                            Icon {
                                id: emptyIcon
                                name: "bookmark"
                                anchors.horizontalCenter: parent.horizontalCenter
                                height: units.gu(10)
                                width: height
                                color: "#BBBBBB"
                            }

                            Label {
                                id: emptyLabel
                                text: "Not implemented"
                                color: "#5d5d5d"
                                font.bold: true
                                wrapMode: Text.WordWrap
                                anchors.top: emptyIcon.bottom
                                anchors.topMargin: units.gu(4)
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Label {
                                id: emptySublabel
                                text: "Page not finished yet"
                                color: "#7b7b7b"
                                wrapMode: Text.WordWrap
                                anchors.top: emptyLabel.bottom
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }


    }
} //Summary TAB

// Food Diary TAB
Item {
            width: tabView.width
            height: tabView.height


            Rectangle {
                id:main
                anchors.fill: parent;
                color: "#EDEDEC"

                ListItem.Standard {
                    id: dateFoodDiary
                        onClicked: {calendarFoodDiary.visible = !calendarFoodDiary.visible}

                        Text {
                            text: Qt.formatDateTime(calendarFoodDiary.selectedDate, "d MMMM yyyy") //calendar.selectedDate
                            anchors.centerIn: parent
                            color: "#AEA79F"
                            font.pointSize: 13
                            }
                        Component.onCompleted: {
                            /*var date = calendarFoodDiary.selectedDate
                            var datepattern = new RegExp(Qt.formatDateTime(calendarFoodDiary.selectedDate, "dd-MM-yyyy"))
                            sortedfooddiaryModel.filter.pattern = datepattern*/

                            if (sortedfooddiaryModel.count == "0"){
                                emptyfooddiary.visible = true;
                                 fooddiaryColumn.visible = false;
                            }else{
                                fooddiaryColumn.visible = true;
                                    emptyfooddiary.visible = false;}
                        }

                }


                Flickable {
                    id: flickablefooddiary
                    anchors.fill: parent
                    contentWidth: main.width;
                    flickableDirection: Flickable.VerticalFlick
                    clip: true
                    anchors.topMargin: dateFoodDiary.height
                    contentHeight: fooddiaryColumn.height + addfooddiary.height


                    ListItem.Standard {
                        id: addfooddiary
                        showDivider: true
                        text: "<font color=\""+openFoodFacts.settings.color+"\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " + i18n.tr("Add a product to diary") + "</font>"
                        onTriggered: { pageStack.push(Qt.resolvedUrl("AddFoodDiary.qml")); }
                        Icon {
                            id: addfooddiaryIcon
                            name: "bookmark-new"
                            anchors { left: parent.left; verticalCenter: parent.verticalCenter}
                            anchors.leftMargin: 15;
                            height: units.gu(2.5)
                            width: height
                        }
                    }

                        Rectangle {
                            id:emptyfooddiary
                            anchors.top: addfooddiary.bottom
                            visible: false

                            anchors {
                                top: parent.top
                                left: parent.left
                                right: parent.right
                            }
                            anchors.topMargin: units.gu(5);
                            color: "#EDEDEC"

                            Item {
                                id: emptyStatefooddiary
                                anchors.fill: parent;

                                Icon {
                                    id: emptyIconfooddiary
                                    source: Qt.resolvedUrl("qrc:/images/OpenFoodFacts/plate.png");
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    height: units.gu(10)
                                    width: height
                                    color: "#BBBBBB"
                                }

                                Label {
                                    id: emptyLabelfooddiary
                                    text: i18n.tr("Empty Food Diary")
                                    color: "#5d5d5d"
                                    font.bold: true
                                    width: fooddiaryColumn.width
                                    wrapMode: Text.WordWrap
                                    anchors.top: emptyIconfooddiary.bottom
                                    anchors.topMargin: units.gu(4)
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                Label {
                                    id: emptySublabelfooddiary
                                    text: i18n.tr("You have not added a product this day.")
                                    color: "#7b7b7b"
                                    width: fooddiaryColumn.width
                                    wrapMode: Text.WordWrap
                                    anchors.top: emptyLabelfooddiary.bottom
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }
                        }

                Column {
                    id: fooddiaryColumn
                    anchors.topMargin: addfooddiary.height
                    anchors.fill: parent
                    visible: false
                    height: totalfooddiary.height + listfooddiary.height

                Rectangle {
                    anchors { left: parent.left; right: parent.right; topMargin: units.gu(0.5);
                                bottomMargin: units.gu(0.5)
                    }
                    color: openFoodFacts.settings.color
                    height: units.gu(3)
                    Label {
                        id: totalfooddiary
                        anchors.fill: parent
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: units.gu(3)
                        horizontalAlignment: Text.AlignRight
                        color: "#FFFFFF"
                    }
                 }

                Rectangle {
                    anchors { left: parent.left; right: parent.right; topMargin: units.gu(0.5);
                                bottomMargin: units.gu(0.5)
                    }
                    height: units.gu(1)
                    color: "transparent"
                 }

                SortFilterModel {
                    id: sortedfooddiaryModel
                    model: openFoodFacts.fooddiaryModel
                    sort.property: "datefoodiarry"
                    sort.order: Qt.DescendingOrder
                    filter.property: "datefoodiarry"
                }
                        UbuntuListView {
                            id: listfooddiary
                            objectName: "ubuntuListView"
                            width: parent.width
                            height: main.height
                            model: sortedfooddiaryModel
                            spacing: units.gu(1)
                            interactive: false

                            delegate: ListItem.Subtitled {
                                showDivider: true
                                anchors.leftMargin: units.gu(2)
                                //removable: true
                                confirmRemoval : true
                                //onItemRemoved: openFoodFacts.fooddiaryModel.remove(index)
                                Text {
                                    text: label
                                    color: openFoodFacts.settings.color
                                }

                                Label {
                                    anchors { right: parent.right; verticalCenter: parent.verticalCenter}
                                    anchors.rightMargin: 15;
                                    text: energy + " " +"KJ"
                                    color: openFoodFacts.settings.color
                                }
                                subText: datefoodiarry
                                Component.onCompleted: {
                                    function sum(){
                                      var result = 0;
                                      for(var i = 0; i < sortedfooddiaryModel.count; i++){
                                           result += parseFloat(sortedfooddiaryModel.get(i).energy);
                                      }
                                      console.log(result);
                                      totalfooddiary.text = i18n.tr("Total") + " : " + result + " KJ"
                                    }
                                    sum();
                                }
                            }
                        } // ListView
                } // Column


                DatePicker {
                    id: datePicker
                    maximum: {
                        var d = new Date();
                        d.setFullYear(d.getFullYear() - 1);
                        return d;
                    }
                    minimum: Date.prototype.getInvalidDate.call()
                }
                /*Calendar{
                id: calendarFoodDiary
                anchors.topMargin: 0
                anchors.top: dateFoodDiary.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
                activeFocusOnTab: true
                onClicked: {
                    visible = false;
                    var date = calendarFoodDiary.selectedDate
                    var datepattern = new RegExp(Qt.formatDateTime(calendarFoodDiary.selectedDate, "dd-MM-yyyy"))
                    sortedfooddiaryModel.filter.pattern = datepattern

                        if (sortedfooddiaryModel.count == "0"){
                            emptyfooddiary.visible = true;
                             fooddiaryColumn.visible = false;
                        }else{
                            fooddiaryColumn.visible = true;
                                emptyfooddiary.visible = false;}
                        function sum(){
                          var result = 0;
                          for(var i = 0; i < sortedfooddiaryModel.count; i++){
                              result += parseFloat(sortedfooddiaryModel.get(i).energy);
                          }
                          console.log(result);
                          totalfooddiary.text = i18n.tr("Total") + " : " + result + " KJ"
                        }
                        sum();
                     }

                style: CalendarStyle {
                    gridVisible: false
                    }
              }*/

                } // Flickable
            }



} //Food Diary TAB

// Exercice Diary TAB
Item {
            width: tabView.width
            height: tabView.height

            Rectangle {
                anchors.fill: parent;
                color: "#EDEDEC"
                    Rectangle {
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                        }
                        anchors.topMargin: units.gu(5);
                        color: "#EDEDEC"

                        Item {
                            anchors.fill: parent;

                            Image {
                                id: emptyIcon3
                                source: Qt.resolvedUrl("qrc:/images/OpenFoodFacts/runman.png");
                                anchors.horizontalCenter: parent.horizontalCenter
                                height: units.gu(10)
                                width: height
                            }

                            Label {
                                id: emptyLabel3
                                text: "Not implemented"
                                color: "#5d5d5d"
                                font.bold: true
                                wrapMode: Text.WordWrap
                                anchors.top: emptyIcon3.bottom
                                anchors.topMargin: units.gu(4)
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Label {
                                id: emptySublabel3
                                text: "Page not finished yet"
                                color: "#7b7b7b"
                                wrapMode: Text.WordWrap
                                anchors.top: emptyLabel3.bottom
                                horizontalAlignment: Text.AlignHCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }


    }
} //Exercice Diary TAB




   } //VisualItemModel

    ListView {
        id: tabView

        model: tabs
        interactive: false
        anchors.fill: parent
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        currentIndex: healtjournal.head.sections.selectedIndex
        highlightMoveDuration: UbuntuAnimation.SlowDuration
    }

}