//
//  DetailViewController.swift
//  Gallery
//
//  Created by Максим Чесников on 21.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var bigImage: UIImageView!
    var bigImageOr: UIImage!
    var nameIm: String!
    var descriptionIm: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        bigImage.image = bigImageOr
        nameView.text = nameIm
        descrLabel.text = descriptionIm
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
