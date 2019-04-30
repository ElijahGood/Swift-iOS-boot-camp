//
//  ViewController.swift
//  ex03
//
//  Created by Illia NAZARINA on 4/1/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var calculusText: UILabel!
    @IBAction func buttons(_ sender: UIButton) {
        print(sender.titleLabel!.text ?? "0");
        if (sender.tag == 1) {
            calculusText.text = sender.titleLabel!.text;
        } else if (sender.tag == 2) {
            calculusText.text = "0";
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //color background
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1);
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

