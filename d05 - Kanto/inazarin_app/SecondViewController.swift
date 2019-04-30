//
//  SecondViewController.swift
//  inazarin_app
//
//  Created by Illia NAZARINA on 6/3/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

struct mapLoc {
    var placeName: String
    var desc: String
    var lat: Double
    var long: Double
}

class SecondViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let placeList: [mapLoc] = [
        mapLoc(placeName: "Ecole 42", desc: "BORN TO CODE?\n96 Boulevard Bessières, 75017 Paris", lat: 48.896550, long: 2.318461),
        mapLoc(placeName: "UNIT Factory", desc: "27-inch iMacs, free wi-fi, PS and shower", lat: 50.468855, long: 30.462169),
        mapLoc(placeName: "Meditation center", desc: "Place to ponder over life the universe and everything...", lat: 50.461403, long: 30.477747),
        mapLoc(placeName: "McDonalds", desc: "Where fat people can smile and complaine...", lat:  50.447523, long: 30.522950)
    ]
    var pickeItem: Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        cell?.textLabel?.text = placeList[indexPath.row].placeName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pickeItem = indexPath.row
        performSegue(withIdentifier: "toMap", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? FirstViewController {
            dest.tableStruct = placeList[pickeItem]
        }
    }
    
}
