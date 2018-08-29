//
//  ViewController.swift
//  DicomImageProcessing
//
//  Created by Genix on 27/08/18.
//  Copyright © 2018 Genix. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dicomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        
        //dicomImageView.layer.cornerRadius = 5.0
        dicomImageView.clipsToBounds  = true
        
        do{
            let filePath = Bundle.main.path(forResource: "MRBRAIN", ofType: "DCM")
            let dataSet = try ImebraCodecFactory.load(fromFile: filePath)
            
            // patientNameCharacter
            _ = try dataSet.getString(ImebraTagId(group: 0x10, tag: 0x10), elementNumber: 0, defaultValue: "")
            
            // patientNameIdeographic
            _ = try dataSet.getString(ImebraTagId(group: 0x10, tag: 0x10), elementNumber: 1, defaultValue: "")
            
            let image = try dataSet.getImageApplyModalityTransform(0)
            let colorSpace = image.colorSpace
            let width = image.width
            let height = image.height
            
            let chain = Utils.applyTransformation(colorSpace: colorSpace,
                                                  dataSet: dataSet,
                                                  image: image,
                                                  width: width,
                                                  height: height)
            
            dicomImageView.image = Utils.generateImage(chain: chain!, image: image)
        } catch {
            print("Something went wrong")
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.dicomImageView
    }
}
