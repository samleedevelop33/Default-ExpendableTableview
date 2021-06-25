//
//  ViewController.swift
//  ExpendableTableview
//
//  Created by sam on 2021/05/18.
//

import UIKit


class Section {
    let title: String
    let options: [String]
    var isOpend: Bool = false
    
    init(title: String,
         options: [String],
         isOpend: Bool = false){
        
        self.title = title
        self.options = options
        self.isOpend = isOpend
    }
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var sections = [Section]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set up models
        
        sections = [
            Section(title: "Section 1", options: [1, 2, 3].compactMap({ return "Cell \($0)" })),
            Section(title: "Section 2", options: [1, 2, 3].compactMap({ return "Cell \($0)" })),
            Section(title: "Section 3", options: [1, 2, 3].compactMap({ return "Cell \($0)" })),
            Section(title: "Section 4", options: [1, 2, 3].compactMap({ return "Cell \($0)" })),
        ]
        
        
       
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        if section.isOpend {
            return section.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as? SectionCell
            cell?.titleLabel.text = sections[indexPath.section].title
            return cell!
        } else {
            let cellDetail = tableView.dequeueReusableCell(withIdentifier: "SectionDetailCell", for: indexPath) as? SectionDetailCell
            cellDetail?.titleLabel.text = sections[indexPath.section].options[indexPath.row - 1]
            return cellDetail!
        }
       
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
        sections[indexPath.section].isOpend = !sections[indexPath.section].isOpend
        tableView.reloadSections([indexPath.section], with: .none)
        } else {
            //세부셀 온터치
        }
    }
}

class SectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class SectionDetailCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}
