//
//  ViewController.swift
//  d02
//
//  Created by Illia NAZARINA on 4/4/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit
import Foundation


struct Data{
    var name: String
    var date: String
    var desc: String
    
    init(name: String, date: String, desc: String) {
        self.name = name
        self.date = date
        self.desc = desc
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableCells: UITableView!
    
    var notes: [Data] = []
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let res = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        res.labelName.text = notes[indexPath.row].name
        res.labelDate.text = notes[indexPath.row].date
        
        //delete me
        print(res);
        
        return res
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes.append(Data(name: "One", date: "1 January 1970 00:00:00", desc: "First"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

