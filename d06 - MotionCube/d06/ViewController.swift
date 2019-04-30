//
//  ViewController.swift
//  d06
//
//  Created by Illia NAZARINA on 4/9/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit
import CoreMotion


/*
//CoreMotion

func accelerometerHandler(data: CMAccelerometerData?, error: NSError?) {
    print("accelerometerHandler CALLED!")
}
let motionManager = CMMotionManager()

if motionManager.isAccelerometerAvailable {
    motionManager.accelerometerUpdateInterval = 0.2
    let queue = OperationQueue.main
    motionManager.startAccelerometerUpdates(to: queue, withHandler: accelerometerHandler as! CMAccelerometerHandler)
}
*/

//class for figures
class Figure: UIView, UIGestureRecognizerDelegate {
    
    var shouldBeRound: Bool = false
    var delegate: ViewController?
    
    init(curX: Int, curY: Int, shouldBeRound: Bool) {
        super.init(frame : CGRect(x: curX, y: curY, width: 100, height: 100))
        self.shouldBeRound = shouldBeRound
//        backgroundColor = UIColor.black
        backgroundColor = self.randomColor()
    }
    
    func randomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())

        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func changeRotation(by rot: CGFloat) {
        self.transform = self.transform.rotated(by: rot)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return (self.shouldBeRound == true) ? .ellipse : .rectangle
    }
}

class ViewController: UIViewController, UIDynamicAnimatorDelegate {

    var dynamicAnimator = UIDynamicAnimator()
    var gravityBehavior = UIGravityBehavior()
    let motionManager: CMMotionManager = CMMotionManager()
    var collisionBehavior = UICollisionBehavior()
    var dynamicBehavior = UIDynamicItemBehavior()
    
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        print(">>TAPPED")
        
        let curLocation = sender.location(in: self.view)
        let figureIndex = Int(arc4random_uniform(42))
//        let figureIndex = 1
        
        let newItem : Figure
        
        if (figureIndex % 2 == 0){
            newItem = drawRectangle(location: curLocation)
        } else {
            newItem = drawCircle(location: curLocation)
        }
        //adding gesture recognition tonew item
        let panGest = UIPanGestureRecognizer(target: self, action: #selector(panGesture(gesture:)))
        newItem.addGestureRecognizer(panGest)
        
        let pinchGest = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(gesture:)))
        newItem.addGestureRecognizer(pinchGest)
        
        let rotateGest = UIRotationGestureRecognizer(target: self, action: #selector(rotateGesture(gesture:)))
        newItem.addGestureRecognizer(rotateGest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setups for animation gravity and collision
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        //become
        dynamicBehavior = UIDynamicItemBehavior(items: [])
        //was
//        dynamicBehavior = UIDynamicItemBehavior(items: [])
        gravityBehavior = UIGravityBehavior(items: [])
        collisionBehavior = UICollisionBehavior(items: [])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        dynamicAnimator.addBehavior(dynamicBehavior)
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(collisionBehavior)
        
        //cheking elasticity
        dynamicBehavior.elasticity = 0.7
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: (motionHandle as? CMDeviceMotionHandler)!)
        } else {
            print(">>> No MOTION  !<<<")
        }
        
        if motionManager.isAccelerometerAvailable {
            
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: (accelHandle as? CMAccelerometerHandler)!)
        }else {
            print(">>> No ACCEEL  !<<<")
        }
    }
    
    //motion and acceleration handle
    func accelHandle(data: CMAccelerometerData?, error: NSError?) {
        print("HERE GOES THE HANDLER OF ACCEELERATION!")
        if (error != nil) {
            NSLog("\(String(describing: error))")
        }
        if let temp = data {
            gravityBehavior.gravityDirection = CGVector(dx: temp.acceleration.x, dy: -temp.acceleration.y)
        }
    }
    
    func motionHandle(data: CMDeviceMotion!, error: NSError!) {
        print("HERE GOES THE HANDLER OF Motion!")
        if (error != nil) {
            NSLog("\(error)")
        }
        if let temp = data {
            gravityBehavior.gravityDirection = CGVector(dx: temp.gravity.x, dy: temp.gravity.y)
        }
    }
    
    @objc func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
            case .began:
                print("Began!")
                gravityBehavior.removeItem(gesture.view!)
            case .changed:
                print("CHanged tom \(gesture.location(in: view)).")
                gesture.view?.center = gesture.location(in: gesture.view?.superview)
            
            case .ended:
                print("Ended!")
                dynamicBehavior.elasticity = 0.7
                gravityBehavior.addItem(gesture.view!)
                dynamicAnimator.updateItem(usingCurrentState: gesture.view!)
            case .failed:
                print("Failde")
            case .possible:
                print("Possible")
            case .cancelled:
                print("Cancelled")
        }
    }
    
    @objc func pinchGesture(gesture: UIPinchGestureRecognizer){
        switch gesture.state {
        case .began:
            print(" pinch Began!")
            gravityBehavior.removeItem(gesture.view!)
            collisionBehavior.removeItem(gesture.view!)

        case .changed:
            print(" pinch CHanged! item=\(gesture.view!)")
           
//            view.bringSubview(toFront: gesture.view!)
//            gesture.view?.transform = (gesture.view?.transform)!.scaledBy(x: gesture.scale, y: gesture.scale)
            
            gesture.view?.layer.bounds.size.width *= gesture.scale
            gesture.view?.layer.bounds.size.height *= gesture.scale
            
            
            

            //fitting figure to screen size
            if ((Int((gesture.view?.superview?.layer.bounds.width)!) < Int((gesture.view?.layer.bounds.size.width)!)) || (Int((gesture.view?.superview?.layer.bounds.height)!) < Int((gesture.view?.layer.bounds.size.height)!))) {
                
                if (Int((gesture.view?.superview?.layer.bounds.width)!) < Int((gesture.view?.superview?.layer.bounds.height)!)) {
                    gesture.view?.layer.bounds.size.width = (gesture.view?.superview?.layer.bounds.width)!
                    gesture.view?.layer.bounds.size.height = (gesture.view?.superview?.layer.bounds.width)!
                } else {
                    gesture.view?.layer.bounds.size.width = (gesture.view?.superview?.layer.bounds.width)!
                    gesture.view?.layer.bounds.size.height = (gesture.view?.superview?.layer.bounds.height)!
                }
            }
            
            let temp: Figure = (gesture.view as? Figure)!
            if temp.shouldBeRound {
                gesture.view?.layer.cornerRadius *= gesture.scale
            }
            
            
//            gesture.view?.frame.size.height = (gesture.view?.layer.bounds.size.height)!
            
//            dynamicAnimator.updateItem(usingCurrentState: gesture.view!)

//            print("DEBUG SIZES: frame=\(String(describing: gesture.view?.frame)), \nlayer=\(String(describing: gesture.view?.layer))")
            
             gesture.scale = 1.0
        case .ended:
            print("pinch Ended!")
            gravityBehavior.addItem(gesture.view!)
            collisionBehavior.addItem(gesture.view!)
            dynamicBehavior.elasticity = 0.7
            collisionBehavior.translatesReferenceBoundsIntoBoundary = true
            dynamicAnimator.updateItem(usingCurrentState: gesture.view!)
        case .failed:
            print("Failed")
        case .possible:
            print("Possible")
        case .cancelled:
            print("Cancelled")
        }
    }
    

 
    @objc func rotateGesture(gesture: UIRotationGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            print("rotation Began!")
            gravityBehavior.removeItem(gesture.view!)
            
        case .changed:
            print("roattion CHanged tom \(gesture.rotation).")
            gesture.view?.transform = gesture.view!.transform.rotated(by: gesture.rotation)
            dynamicAnimator.updateItem(usingCurrentState: gesture.view!)
//            gesture.rotation = 0
        case .ended:
            print(" rotation Ended!")
//            dynamicBehavior.elasticity = 0.6
            gravityBehavior.addItem(gesture.view!)
//            dynamicAnimator.updateItem(usingCurrentState: gesture.view!)
        case .failed:
            print("Failde")
        case .possible:
            print("Possible")
        case .cancelled:
            print("Cancelled")
        }
    }
    
    // drawing functions
    func drawRectangle(location: CGPoint) -> Figure {
        
        print("Rectangle")
        
        let newView = Figure(curX: Int(location.x - 50), curY: Int(location.y - 50), shouldBeRound: false)
        
        view.addSubview(newView)
        gravityBehavior.addItem(newView)
        collisionBehavior.addItem(newView)
        dynamicBehavior.addItem(newView)
        
        return newView
    }
    
    func drawCircle(location: CGPoint) -> Figure {
        print("Circle")
    
        
        let newView = Figure(curX: Int(location.x - 50), curY:Int(location.y - 50), shouldBeRound: true)
        newView.layer.cornerRadius = newView.frame.size.width / 2
        
        view.addSubview(newView)
        
        gravityBehavior.addItem(newView)
        collisionBehavior.addItem(newView)
        dynamicBehavior.addItem(newView)
        
        return newView
    }
    
}

