//
//  ItemStore.swift
//  Homepwner
//
//  Created by Piervincenzo Parisi on 14/02/17.
//  Copyright © 2017 Piervincenzo Parisi. All rights reserved.
//

import UIKit


class ItemStore {
    var allItems = [Item]()
    let itemsArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // in iOS si usa sempre e solo .userDomainMask
        let documentDirectory = documentsDirectories.first! // in iOS chiamata precedente ritorna sempre un array con una sola directory
        return documentDirectory.appendingPathComponent("items.archive")
    } ()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemsArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemsArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemsArchiveURL.path)
    }
}
