//
//  PopularCollectionViewController.swift
//  Gallery
//
//  Created by Максим Чесников on 21.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class PopularCollectionViewController: UICollectionViewController {
         private var imageContent: UIImageView = UIImageView(image: UIImage(named: "Image"))
         var countRowsInd = 10
         private var images: [ImageOfTarget] = []
         private var imagesCat: [UIImage] = []
         private var data: [String] = []
         var posts: [Post] = []

    override func viewDidLoad() {
             super.viewDidLoad()
             
             let refreshControl = UIRefreshControl()
             refreshControl.tintColor = .blue
             refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
             collectionView.addSubview(refreshControl)
             collectionView.alwaysBounceVertical = true
             
             
            for i in 0...countRowsInd + 1 {
                  data.append("\(i)")
             }
            for _ in 0...countRowsInd {
                imagesCat.append(UIImage(named: "Image")!)
            }
            
            for i in 0...countRowsInd
            {
             posts.append(Post(id: Int(data[i])!, title: "", image: "", description: ""))
            }
             downloadImages()
     //        for i in 0...countRowsInd
     //        {
     //            posts[i].print()
     //        }
             
             collectionView.dataSource = self
         }
         @objc func refresh()
         {
             downloadImages()
         }

         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if let destination = segue.destination as? DetailViewController {
                 let cell = sender as! UICollectionViewCell
                 let selectedRow = collectionView.indexPath(for: cell)!.row
                 destination.bigImageOr = posts[selectedRow].imageC
                 destination.nameIm = posts[selectedRow].title
                 destination.descriptionIm = posts[selectedRow].description
             }
         }
         func downloadImages(){
             var schet = 0
             Alamofire.request("http://gallery.dev.webant.ru/api/photos?new=false&popular=true").responseJSON { responseJSON in

                         switch responseJSON.result {
                         case .success(let value):

                             guard let jsonArray = value as? [String: Any] else {print("er1"); return }
                             guard let jsonObjects = jsonArray["data"] as? Array<[String: Any]> else {print("er2");return}

                             

                             for jsonObject in jsonObjects {
                                 guard
                                     let id = jsonObject["id"] as? Int,
                                     let title = jsonObject["name"] as? String,
                                     let description = jsonObject["description"] as? String,
                                     let image = jsonObject["image"] as? [String: Any],
                                     let imageURL = image["contentUrl"] as? String
                                 else {
                                     return
                                 }
                                 

                                 if schet == 10
                                 {
                                     self.getImage3(beginIM: 0, endIM: 10)
                                 }
                                 else if schet > 10
                                 {
                                     return
                                 }
                                 else
                                 {
                                     let targetImage = UIImageView(image: UIImage(named: "Image"))
                                     targetImage.imageFromUrl(urlString: "http://gallery.dev.webant.ru/media/" + imageURL)
                                     print(schet)
                                     let post = Post(id: id, title: title, image: "http://gallery.dev.webant.ru/media/" + imageURL, imageC: targetImage.image!, description: description)
                                     
     //                                post.print()
                                     self.collectionView.reloadData()
                                     self.posts[schet] = post
     //                                print(self.posts[schet])
                                 }
                                 
                                 
                                 schet += 1
                                 self.collectionView.reloadData()
                             }

     //                        print(self.posts)

                         case .failure(let error):
                             print("errror")
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "errorInternet")
                            self.present(balanceViewController, animated: true, completion: nil)
                         }
                     }
             
                     self.collectionView.reloadData()
         }

         
         
         @IBAction func buttonA(_ sender: Any) {
             self.collectionView.reloadData()
            
         }
         // MARK: UICollectionViewDataSource

         override func numberOfSections(in collectionView: UICollectionView) -> Int {
             // #warning Incomplete implementation, return the number of sections
             return 1
         }


         override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             // #warning Incomplete implementation, return the number of items
             return countRowsInd
         }

         override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
             cell.layer.cornerRadius = cell.frame.size.height / 8
             cell.image2.image = posts[indexPath.row].imageC
             // Configure the cell
         
             return cell
         }
         

         
         func getImage3(beginIM: Int, endIM: Int){
                 var schet = 0
                 var schet2 = 0
             for _ in beginIM...endIM - 1{
                 let downloadURL = posts[schet].imageURL
                 

                             print(downloadURL)
                             let strLoc = downloadURL
                             let urlLoc = URL(string: strLoc)
                             if let data1 = try? Data(contentsOf: urlLoc!) {
                                 DispatchQueue.main.async {
                                     print("formatted result: \(data1.count)")
                                     let image_dow = UIImage(data: data1)!
                                     self.posts[schet2].imageC = image_dow
                                     self.collectionView.reloadData()
                                     schet2 += 1
                                 }
                             }
                 schet += 1
                 }

                 
                 self.collectionView.reloadData()
         }


         // MARK: UICollectionViewDelegate

         /*
         // Uncomment this method to specify if the specified item should be highlighted during tracking
         override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
             return true
         }
         */

         /*
         // Uncomment this method to specify if the specified item should be selected
         override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
             return true
         }
         */

         /*
         // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
         override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
             return false
         }

         override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
             return false
         }

         override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
         
         }
         */

     }
