//
//  ViewController.swift
//  inazarin2019
//
//  Created by ElijahGood on 04/12/2019.
//  Copyright (c) 2019 ElijahGood. All rights reserved.
//

import UIKit
import CoreData
import inazarin2019

class ViewController: UIViewController {

    var testArt = ArticleManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("BEFORE:\(testArt.getAllArticles())")
        
        let newArticle = testArt.newArticle()
        newArticle.title = "Title 1"
        newArticle.content = "Some shitty text to read - 1"
        newArticle.creation_date = NSDate() as Date
        newArticle.language = "en"
        newArticle.modification_date = NSDate() as Date
//        testArt.save()
//        print(newArticle)
        
        let newArticle2 = testArt.newArticle()
        newArticle2.title = "Title 2"
        newArticle2.content = "Some shitty text to write - 2"
        newArticle2.creation_date = NSDate() as Date
        newArticle2.language = "fr"
        newArticle2.modification_date = NSDate() as Date
        testArt.save()
        
        print("AFTER:\(testArt.getAllArticles())")
        print("FR ONLY:\(testArt.getArticles(containString: "write"))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


