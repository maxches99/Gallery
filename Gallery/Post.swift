//
//  Post.swift
//  Gallery
//
//  Created by Максим Чесников on 17.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import Foundation
import UIKit

//struct Post {
//    var id: Int
//    var title: String
//    var image: UIImageView
////    var body: Array<[String: Any]>
////    var userId: String
//}
class Post
{
    var id: Int
    var title: String
    var imageURL: String
    var imageC: UIImage
    var description: String
    
    init(id: Int, title: String, image: String, imageC: UIImage = UIImage(named: "Image")!, description: String) {
        self.id = id
        self.title = title
        self.imageURL = image
        self.imageC = imageC
        self.description = description
    }
    
    func print()
    {
        let str = "\(String(id)):\(String(title)):\(String(imageURL))"
        Swift.print(str)
    }
}

