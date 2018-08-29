//
//  Utils.swift
//  DicomImageProcessing
//
//  Created by Genix on 28/08/18.
//  Copyright © 2018 Genix. All rights reserved.
//

import Foundation

class Utils {
    
    static func generateImage(chain: ImebraTransformsChain, image: ImebraImage) -> UIImage? {
        do {
            let draw = ImebraDrawBitmap(transform: chain)
            return try draw?.getImebraImage(image)
        } catch {
            return nil
        }
    }
    
    static func applyTransformation(colorSpace: String?,
                                    dataSet: ImebraDataSet,
                                    image: ImebraImage,
                                    width: UInt32,
                                    height: UInt32) -> ImebraTransformsChain? {
        let chain = ImebraTransformsChain()
        do {
            if(ImebraColorTransformsFactory.isMonochrome(colorSpace)) {
                
                let voilutTransform = ImebraVOILUT()
                
                var vois: [ImebraVOIDescription] = try dataSet.getVOIs() as! [ImebraVOIDescription]
                
                var luts = [ImebraLUT]()
                
                var scanLuts: UInt32 = 0
                while(true){
                    do {
                        luts.append(try dataSet.getLUT(ImebraTagId(group: 0x0028, tag: 0x3010), item: scanLuts))
                        scanLuts = scanLuts + 1
                    } catch {
                        print("vois loop exit")
                        break;
                    }
                }
                if (!vois.isEmpty) {
                    voilutTransform?.setCenter(vois[0].center, width: vois[0].width)
                } else if (!luts.isEmpty) {
                    voilutTransform?.setLUT(luts[0])
                } else {
                    try voilutTransform?.applyOptimalVOI(image, inputTopLeftX: 0, inputTopLeftY: 0, inputWidth: width, inputHeight: height)
                }
                chain?.add(voilutTransform)
            }
        } catch {
            print("Error occured")
        }
        return chain
    }
    
}
