import QtQuick 2.3


Tabone {
    id: tabs
    titles: ['Option 1', 'Option 2', 'Option 3']

    onClick: {
        for (var i = 0; i < titles.length; i++) {
            itemsTab.itemAt(i).visible = false
        }
        itemsTab.itemAt(_index).visible = true
    }
}
