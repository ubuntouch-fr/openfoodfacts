import QtQuick 2.4
import Ubuntu.Components 1.2
import "component/parser.js" as JS


Page {
    title: "View product"
    id: pageProductView


   property string barcode:"";
    onBarcodeChanged: console.log(pageProductView.barcode)

    Component.onCompleted: JS.load()
    ListModel {  id:listModel }
    property var jsonData

    Flickable {


    Item {
        x : itemParent.width + units.gu(1)
        y : itemParent.height + units.gu(1)
        spacing: units.gu(1)
        anchors {
             margins: units.gu(2)
                right: parent.right
                left: parent.left
         }

        Label {
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
            fontSize: "x-large"
            text: jsonData["product"]["product_name"]
        }
        UbuntuShape {
            id: pictureproduct
            anchors.horizontalCenter: parent.horizontalCenter
            width: units.gu(20)
            height: units.gu(20)
            image: Image {
                source: jsonData["product"]["image_small_url"]          }
        }
        Label {
            id: labelbarcode
            objectName: "label"
            anchors.horizontalCenter: parent.horizontalCenter
            fontSize: "x-small"
            text: pageProductView.barcode
        }
        Label {
            id: featureproduct
            objectName: "label"
            fontSize: "large"
            font.weight: Font.DemiBold
            text: "Caractéristiques du produit :"
        }

        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            id: descproduct
            objectName: "label"
            text: "Dénomination générique : " + jsonData["product"]["generic_name"]
        }
        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            id: condiproduct
            objectName: "label"
            text: "Conditionnement : " + jsonData["product"]["packaging_tags"]
        }
        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            id: marqueproduct
            objectName: "label"
            text: "Marques : " + jsonData["product"]["brands_tags"]
        }
        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            id: catproduct
            objectName: "label"
            text: "Catégories : " + jsonData["product"]["categories"]
        }
        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            id: oriproduct
            objectName: "label"
            text: "Origine des ingrédients : " + jsonData["product"]["countries"]
        }
        Text {
            width: parent.width
            wrapMode: Text.WordWrap
            id: saleproduct
            objectName: "label"
            text: "Pays de vente : " + jsonData["product"]["origins"]
        }




        Label {
            id: ingredients
            objectName: "label"
            fontSize: "large"
            font.weight: Font.DemiBold
            text: "<br/>Ingrédients :"
        }
        Text {
            // For text to wrap, a width has to be explicitly provided
            width: parent.width
            wrapMode: Text.WordWrap
            id: ingredientsproduct
            objectName: "label"
            text: "Liste des ingrédients : " + jsonData["product"]["ingredients_text"]
        }


        Label {
            id: informationproduct
            objectName: "label"
            fontSize: "large"
            font.weight: Font.DemiBold
            text: "<br/>Information nutritionnelles :"
        }


    }
    }
}

