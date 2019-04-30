//
//  SecondViewController.swift
//  d03-1
//
//  Created by Illia NAZARINA on 4/5/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // //was liek 
    @IBOutlet weak var imageView: UIImageView!
    
//    var imageView: UIImageView!
    var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = self.pickedImage
        self.scrollView.delegate = self
        // Do any additional setup after loading the view.
        scrollView.addSubview(imageView)
        scrollView.contentSize = (imageView?.frame.size)!
        scrollView.maximumZoomScale = 50
        scrollView.minimumZoomScale = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// //was like
extension SecondViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

