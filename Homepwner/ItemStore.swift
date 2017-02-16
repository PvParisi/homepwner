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
}
