//
//  ViewController.swift
//  DicomImageProcessing
//
//  Created by Genix on 27/08/18.
//  Copyright © 2018 Genix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dicomImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
