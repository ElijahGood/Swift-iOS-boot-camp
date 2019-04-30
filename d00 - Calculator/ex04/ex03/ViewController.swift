//
//  ViewController.swift
//  ex03
//
//  Created by Illia NAZARINA on 4/1/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainNumber:Double = 0;
    var resultNum:Double = 0;
    var firstVal:Double = 0;
    var operatorSign:String = "";
    var firstValBool = false;
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBAction func clickButton(_ sender: UIButton) {
        
        if (firstValBool == true){
            labelText?.text = "";
            firstValBool = false;
        }
        // main if-else logic
        if (sender.tag == 1) {
            if (labelText?.text == "0"){
                labelText.text = (sender.titleLabel?.text)!;
                let temp : String
                temp = (labelText?.text)!;
                mainNumber = Double(temp)!;
            } else {
                let temp : String
                temp = (labelText?.text)! + (sender.titleLabel?.text)!;
                labelText.text = temp;
                mainNumber = Double(temp)!;
            }
        } else if (sender.tag == 2) {
            if (sender.titleLabel?.text == "AC") {
                labelText.text = "0";
                mainNumber = 0;
                resultNum = 0;
                firstVal = 0;
                 firstValBool = false;
            } else if (sender.titleLabel?.text == "NEG" && labelText?.text != "0" && mainNumber != 0 && labelText?.text! != "Not a number :`(") {
                mainNumber *= (-1);
                labelText?.text = String(mainNumber);
            }
        }
    }
    
    @IBAction func operators(_ sender: UIButton) {
        if (sender.tag == 9){
            //equal sign
            
            if (operatorSign != ""){
                if (resultNum != 0){
                    firstVal = resultNum;
                }
                
                if (operatorSign == "+"){
                    resultNum = (firstVal + mainNumber);
                } else if (operatorSign == "-"){
                    resultNum = (firstVal - mainNumber);
                } else if (operatorSign == "/"){
                     resultNum = (firstVal / mainNumber);
                } else if (operatorSign == "*"){
                    resultNum = (firstVal * mainNumber);
                }
                
                //checking if divided by 0
                if (resultNum.isInfinite || resultNum.isNaN) {
                    labelText?.text = "Not a number :`(";
                    firstValBool = true;
                    operatorSign = "";
                    mainNumber = 0;
                    firstVal = 0;
                   
                } else {
                    
                    firstValBool = false;
                    mainNumber = resultNum;
                    let toLabel:String = String(resultNum);
                    labelText?.text! = toLabel;
                    resultNum = 0;
                    operatorSign = "";
                }
            }
        }
        
        // math goes here
        if (firstValBool == false){
            if (operatorSign != ""){
                if (resultNum != 0){
                    firstVal = resultNum;
                }
            
                if (operatorSign == "+"){
                    resultNum = (firstVal + mainNumber);
                } else if (operatorSign == "-"){
                    resultNum = (firstVal - mainNumber);
                } else if (operatorSign == "/"){
                    resultNum = (firstVal / mainNumber);
                } else if (operatorSign == "*"){
                    resultNum = (firstVal * mainNumber);
                }
                
                //checking if divided by 0
                if (resultNum.isInfinite || resultNum.isNaN) {
                    labelText?.text = "Not a number :`(";
                    firstValBool = true;
                    operatorSign = "";
                    mainNumber = 0;
                    firstVal = 0;
                    
                } else {
                    
                    firstValBool = false;
                    mainNumber = resultNum;
                    let toLabel:String = String(resultNum);
                    labelText?.text! = toLabel;
                    resultNum = 0;
                    operatorSign = "";
                }
            }
            
            firstValBool = true;
            firstVal = mainNumber;
        }
        

        if (labelText?.text! != "Not a number :`(") {
            if (sender.tag == 5){
                //plus
                if (operatorSign == "") {
                    labelText?.text! += " +";
                }
                operatorSign = "+";
            } else if (sender.tag == 6){
                //minus
                labelText?.text! += " -";
                operatorSign = "-";
            } else if (sender.tag == 7){
                //multiply
                labelText?.text! += " *";
                operatorSign = "*";
            } else if (sender.tag == 8){
                //divide
                labelText?.text! += " /";
                operatorSign = "/";
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        labelText?.adjustsFontSizeToFitWidth = true;
        labelText?.minimumScaleFactor = 0.1;
        labelText?.numberOfLines = 1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

