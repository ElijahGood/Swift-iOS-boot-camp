//
//  ViewController.swift
//  d07
//
//  Created by Illia NAZARINA on 4/10/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI
//import JSQMessagesViewController

//class MessageViewController: JSQMessagesViewController {
//
//}

class ViewController: UIViewController {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var reqButton: UIButton!
    
    
    
    let client = DarkSkyClient(apiKey: "10080f1546815197183f30931fc4a058")
//    client.units = .auto
//    client.language = .english
    
    var bot : RecastAIClient?
    
    @IBAction func sendRequest(_ sender: UIButton) {
        guard let reqText = textField.text else {return}
        if (!reqText.isEmpty) {
            bot?.textRequest(reqText, successHandler: { (success) in
                if let location = success.entities!["location"] as? [[String: Any]] {
                    //            print("Location = \(String(describing: location))")
                    print("\nLocation = \(String(describing: location[0]))")
                    
                    
                    let latitude = location[0]["lat"] as! Double
                    let longitude = location[0]["lng"] as! Double
//                    print(">>> RES lat=\(latitude) and long=\(longitude)")
                    
                    self.client.getForecast(latitude: latitude, longitude: longitude, completion: { (forecast) in DispatchQueue.main.async {
                        
//                            print(">>> forecast currently=\(String(describing: forecast.value.0?.currently))")
//                            print(">>> forecast summary=\(String(describing: forecast.value.0?.currently?.summary))")
                        
                            if let answer = forecast.value.0?.currently?.summary {
                                let answerText: String = "It`s " + answer
                                self.labelView.text = answerText
                            } else {
                                self.labelView.text = "ERROR"
                            }
                        }
                        
                    })
                    
                } else {
                    print("ERROR OCCURED")
                    self.labelView.text = "ERROR"
                }
            }, failureHandle: { (error) in
                self.labelView.text = "ERROR"
                print("ERROR OCCURED!!!\n\(error.localizedDescription)")
                
            })
        } else {
            self.labelView.text = "You never know"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.bot = RecastAIClient(token : "5c1aec65bec9e9d49a1280c18df61f95", language: "en")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

