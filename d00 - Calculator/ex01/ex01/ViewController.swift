//
//  ViewController.swift
//  ex01
//
//  Created by Illia NAZARINA on 4/1/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //test this
    var labelFlag = true;
    
    @IBOutlet weak var labelText: UILabel!
    @IBAction func clickButton(_ sender: UIButton) {
        if labelFlag == true {
            labelText.text = "Hello World !";
            labelFlag = false;
        } else {
            labelText.text = "Hello !";
            labelFlag = true;
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

