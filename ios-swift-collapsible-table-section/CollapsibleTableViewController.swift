//
//  CollapsibleTableViewController.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 5/30/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

//
// MARK: - Section Data Structure
//
struct Item {
    var name: String
    var detail: String
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

//
// MARK: - View Controller
//
class CollapsibleTableViewController: UITableViewController {
    
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = "Apple Products"
        
        // Initialize the sections array
        // Here we have three sections: Mac, iPad, iPhone
        sections = [
            Section(name: "Mac", items: [
                Item(name: "MacBook", detail: "Apple's ultraportable laptop, trading portability for speed and connectivity."),
                Item(name: "MacBook Air", detail: "While the screen could be sharper, the updated 11-inch MacBook Air is a very light ultraportable that offers great performance and battery life for the price."),
                Item(name: "MacBook Pro", detail: "Retina Display The brightest, most colorful Mac notebook display ever. The display in the MacBook Pro is the best ever in a Mac notebook."),
                Item(name: "iMac", detail: "iMac combines enhanced performance with our best ever Retina display for the ultimate desktop experience in two sizes."),
                Item(name: "Mac Pro", detail: "Mac Pro is equipped with pro-level graphics, storage, expansion, processing power, and memory. It's built for creativity on an epic scale."),
                Item(name: "Mac mini", detail: "Mac mini is an affordable powerhouse that packs the entire Mac experience into a 7.7-inch-square frame."),
                Item(name: "OS X El Capitan", detail: "The twelfth major release of OS X (now named macOS)."),
                Item(name: "Accessories", detail: "")
            ]),
            Section(name: "iPad", items: [
                Item(name: "iPad Pro", detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size."),
                Item(name: "iPad Air 2", detail: "The second-generation iPad Air tablet computer designed, developed, and marketed by Apple Inc."),
                Item(name: "iPad mini 4", detail: "iPad mini 4 puts uncompromising performance and potential in your hand."),
                Item(name: "Accessories", detail: "")
            ]),
            Section(name: "iPhone", items: [
                Item(name: "iPhone 6s", detail: "The iPhone 6S has a similar design to the 6 but updated hardware, including a strengthened chassis and upgraded system-on-chip, a 12-megapixel camera, improved fingerprint recognition sensor, and LTE Advanced support."),
                Item(name: "iPhone 6", detail: "The iPhone 6 and iPhone 6 Plus are smartphones designed and marketed by Apple Inc."),
                Item(name: "iPhone SE", detail: "The iPhone SE was received positively by critics, who noted its familiar form factor and design, improved hardware over previous 4-inch iPhone models, as well as its overall performance and battery life."),
                Item(name: "Accessories", detail: "")
            ])
        ]
    }
    
}

//
// MARK: - View Controller DataSource and Delegate
//
extension CollapsibleTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[(indexPath as NSIndexPath).section].collapsed ? 0 : UITableViewAutomaticDimension
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

}

//
// MARK: - Section Header Delegate
//
extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
