//
//  ViewController.swift
//  Feedback Animation
//
//  Created by O-mkar on 10/10/16.
//  Copyright © 2016 O-mkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sliderStep: SliderStep!
    let size  = CGSize(width: 100, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Top Size
        sliderStep.activeImageSize = size
        //Bottom Image Size
        sliderStep.size = CGSize(width: 80, height: 80)
        sliderStep.activeImages = [imageWithImage("disappointed-active", newSize: size), imageWithImage("not-happy-active", newSize: size), imageWithImage("just-ok-active", newSize: size), imageWithImage( "satisfied-active", newSize: size), imageWithImage( "loved-it-active", newSize: size)]
        sliderStep.titleLabels = ["Disappointed", "Not Happy", "Just Ok","Satisfied", "Loved It"]
        sliderStep.bottomImages = [UIImage(named:"disappointed")!, UIImage(named:"not-happy")!, UIImage(named:"just-ok")!, UIImage(named: "satisfied")! , UIImage(named: "loved-it")!]
        sliderStep.minimumValue = 2
        sliderStep.maximumValue = Float(sliderStep.activeImages!.count) + sliderStep.minimumValue - 1.0
        sliderStep.sliderLineColor = UIColor.darkGrayColor()
        sliderStep.sliderLineHeight = 5
        //Change 0.0 to the index you want don't change 2.0
        sliderStep.value = 2.0 + 2.0
        
    }
    
    func imageWithImage(imageName: String, newSize: CGSize) -> UIImage
    {
        let image = UIImage(named: imageName)!
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}



