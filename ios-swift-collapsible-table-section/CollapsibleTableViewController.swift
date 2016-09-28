//
//  CollapsibleTableViewController.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 5/30/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

extension UIView {
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")

        rotateAnimation.toValue = toValue
        rotateAnimation.duration = duration
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode = kCAFillModeForwards

        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

class CollapsibleTableViewController: UITableViewController {

    //
    // MARK: - Data
    //
    struct Section {
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        
        init(name: String, items: [String], collapsed: Bool = false) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Apple Products"
        
        // Initialize the sections array
        // Here we have three sections: Mac, iPad, iPhone
        sections = [
            Section(name: "Mac", items: ["MacBook", "MacBook Air", "MacBook Pro", "iMac", "Mac Pro", "Mac mini", "Accessories", "OS X El Capitan"]),
            Section(name: "iPad", items: ["iPad Pro", "iPad Air 2", "iPad mini 4", "Accessories"]),
            Section(name: "iPhone", items: ["iPhone 6s", "iPhone 6", "iPhone SE", "Accessories"])
        ]
    }
    
    //
    // MARK: - Event Handlers
    //
    func toggleCollapse(sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = !collapsed
        
        // Reload section
        tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }
    
}

extension CollapsibleTableViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sections[section].collapsed!) ? 0 : sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell? ?? UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        cell.textLabel?.text = sections[section].name
        cell.section = section
        cell.delegate = self
        
        return cell
    }

}

extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleHeader(section: Int) {
        print(section)
    }
    
}
