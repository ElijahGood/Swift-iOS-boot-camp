//
//  ViewController.swift
//  d03-1
//
//  Created by Illia NAZARINA on 4/5/19.
//  Copyright © 2019 Illia NAZARINA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
//    let imagesLabels = ["image42", "image1", "image2", "image3", "image4"]

    //for static images
//    let images: [UIImage] = [
//        UIImage(named: "image42")!,
//        UIImage(named: "image1")!,
//        UIImage(named: "image2")!,
//        UIImage(named: "image3")!,
//        UIImage(named: "image4")!
//
//    ]
    let imagesPath = [
        "https://images-assets.nasa.gov/image/PIA18033/PIA18033~orig.jpg",
        "https://images-assets.nasa.gov/image/iss050e066094/iss050e066094~orig.jpg",
        "https://images-assets.nasa.gov/image/PIA12348/PIA12348~orig.jpg",
        "https://images-assets.nasa.gov/image/AFRC2019-0052-07/AFRC2019-0052-07~orig.jpg"
    ]
    
    var imagesDone: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        collectionView.dataSource = self
        collectionView.delegate = self

//        //some stupid layuot
//        var layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        layout.minimumInteritemSpacing = 3
//        layout.itemSize = CGSize(width: ((self.collectionView.frame.size.width - 15)/2), height: (self.collectionView.frame.size.height/3))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesPath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        //spinning shit goes here
        cell.activityView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        if let path = URL(string: imagesPath[indexPath.item]){
            
            DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
                if let newImage = try? Data.init(contentsOf: path){
                    DispatchQueue.main.sync {
                        cell.imagesView.image = UIImage(data: newImage)
                        self.imagesDone += 1
                        cell.activityView.stopAnimating()
                        if (self.imagesDone == self.imagesPath.count){
                                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
//                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                } else {
                    //alert
                    self.showAllert(str: self.imagesPath[indexPath.item])
                    
                    //stoping animations
                    cell.activityView.stopAnimating()
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        } else {
            //alert
            self.showAllert(str: self.imagesPath[indexPath.item])
            
            //stoping animations
            cell.activityView.stopAnimating()
//            if (imagesDone == imagesPath.count){
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            }
        }
        //mb move it to image???
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        
//        if (imagesDone == imagesPath.count){
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//            //delete
//            print("now= ", imagesDone)
//        }
        
        
        
        return cell
    }

    //selection fuctions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
        
        
        
        //passing image to new view
        if let imageToPass = cell.imagesView.image {
            let  mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let newViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            newViewController.pickedImage = imageToPass
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
        

    }
    
    func showAllert(str: String){
        let string = "Cannot acces to: " + str
        let alertController = UIAlertController(title: "Error", message:
            string, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        
    }

}

