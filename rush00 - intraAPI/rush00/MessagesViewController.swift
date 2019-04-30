//
//  MessagesViewController.swift
//  rush00
//
//  Created by Ganna DANYLOVA on 4/7/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit
import Foundation

struct cellMsg {
    var name: String
    var date: String
    var msg : String
    
}


class MessagesViewController: UIViewController {
    
    var token: String = ""
    var msgUrl: String = ""
    var msgs: [cellMsg] = []
    
    @IBOutlet weak var MessagesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessagesTableView.delegate = self
        MessagesTableView.dataSource = self
        get_message(msgIdUrl: self.msgUrl)

        // Do any additional setup after loading the view.
    }


    func get_message(msgIdUrl : String){
        
        let urlPath: String = msgIdUrl
        let url = URL(string: urlPath)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let response = response {
                print("response")
                print(response)
            }
            guard let data = data else { return }
            print(">>> MSG data <<<")
            print(data)
            do {
                
                let json :  [NSDictionary] = (try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary])!
                
                print(">>> MSG JSON first")
                DispatchQueue.main.async {
                    for value in json {
                        let author: NSDictionary = (value["author"] as? NSDictionary)!
                        //                        print("login:", author["login"] ?? "NC")
                        //                        print("date:", value["created_at"] ?? "NC")
                        //                        print("msg:", value["content"] ?? "NC")
                        //                        //                        print(">>> Testing msg: ", message,"\nMarkdown: ", content["markdown"] ?? "NC")
                        self.msgs.append(cellMsg(name: (author["login"] as? String)! , date: (value["created_at"] as? String)!, msg: (value["content"] as? String)!))
                    }
                    print(">>>MSGS ARRAY: ", self.msgs)
                    print("first name: ", self.msgs[0].name, "first msg: ", self.msgs[0].msg)
                    self.MessagesTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
        session.resume()
    }

    
//    override func viewDidAppear(_ animated: Bool) {
//        MessagesTableView.rowHeight = UITableViewAutomaticDimension
//        MessagesTableView.estimatedRowHeight = 100
//    }
}


extension MessagesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }

    //was
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell")
//        cell?.textLabel?.text = self.msgs[indexPath.row].name
//        cell?.detailTextLabel?.text = self.msgs[indexPath.row].date
//        print("---->>>>>>> CELL", cell as Any)
//        return cell!
//    }
    
    //become
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath) as? MsgTableViewCell {
            DispatchQueue.main.async {
                cell.name.text = self.msgs[indexPath.row].name
                cell.date.text = self.msgs[indexPath.row].date
                cell.msg.text = self.msgs[indexPath.row].msg
            }
            return cell
        }
        return UITableViewCell()
    }
    
}













