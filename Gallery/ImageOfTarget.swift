//
//  ImageOfTarget.swift
//  Gallery
//
//  Created by Максим Чесников on 17.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import Foundation
import UIKit

class ImageOfTarget
{
    var id: Int
    var image: UIImage
    var size: Double
    
    init(id: Int, image: UIImage, size: Double = 0.0) {
        self.id = id
        self.image = image
        self.size = size
    }
    func get_id() -> Int
    {
        return self.id
    }
    func get_image() -> UIImage
    {
        return self.image
    }
}
