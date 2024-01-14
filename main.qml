import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.0

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "Text File Save Example"

    property var text1: ""
    property var text2: ""
    property var db

    Rectangle {
        anchors.fill: parent

        TextField {
            id: textBox1
            anchors.top: parent.top
            width: parent.width
            height: parent.height / 2
            placeholderText: "Enter text for text box 1"
            onTextChanged: text1 = textBox1.text
        }

        TextField {
            id: textBox2
            anchors.top: textBox1.bottom
            width: parent.width
            height: parent.height / 2
            placeholderText: "Enter text for text box 2"
            onTextChanged: text2 = textBox2.text
        }

        Button {
            anchors.centerIn: parent
            text: "Save to File"
            onClicked: saveToFile()
        }
    }

    function saveToFile() {
        // Open or create the local storage database
        db = LocalStorage.openDatabaseSync("C:/Users/PAPPU KUMAR KESHARI/OneDrive/Desktop/QtFile.txt", "1.0", "My Application Database", 100000)

        // Start a transaction to save data
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS TextData(key TEXT, value TEXT)')
            tx.executeSql('INSERT INTO TextData VALUES(?, ?)', ["text1", text1])
            tx.executeSql('INSERT INTO TextData VALUES(?, ?)', ["text2", text2])
        })

        console.log("Data saved to local storage.")
    }
}
