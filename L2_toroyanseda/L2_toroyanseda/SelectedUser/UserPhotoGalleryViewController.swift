//
//  UserPhotoGalleryViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 04/04/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage

class UserPhotoGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    var newImage:String = ""
    var indexUser = 0
    var name:String = ""
    var id:Int=0
    @IBOutlet weak var collectionView: UICollectionView!
   var likes = [Int]()
    var img = [String]()
    var imgM = [UIImage]()
    var userLikes = [Int]()
    var repostCount = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let session = Session.shared
        let URL="https://api.vk.com/method/friends.get?access_token=\(session.token)&order=name&fields=photo_100&v=5.95"
        Alamofire.request(URL).responseObject { (response: DataResponse<UserResponse>) in
            
            let uResponse = response.result.value
         
            if let userItems = uResponse?.itemsResponse {
                for users in userItems {
                    var name = users.firstName! + " " + users.lastName!
                    if name == self.newImage{
                        self.id = users.id!
                    
                    }
        
        
                   
    }
            }
            let WallURL="https://api.vk.com/method/photos.getAll?access_token=\(session.token)&extended=1&owner_id=\(self.id)&v=5.95"
            Alamofire.request(WallURL).responseObject { (response: DataResponse<UserPhotos>) in
                
                let wResponse = response.result.value
                if let photos = wResponse?.itemsResponse{
                    for photo in photos{
                        if photo.type == "m"{
                            self.img.append(photo.url!)
                            self.likes.append(photo.likesCount ?? 0)
                            self.userLikes.append(photo.userLikes ?? 0)
                            self.repostCount.append(photo.repost ?? 0)
                        }
                        
                    }
                }
                  self.collectionView.reloadData()
            }
          
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath)as! UsersphotoGalleryCollectionViewCell
        if let imageURL = img[indexPath.item] as? String {
            Alamofire.request(imageURL).responseImage(completionHandler: { (response) in
                if let image = response.result.value{
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        self.imgM.append(image)
                    }
                }
         
            })
        
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
   
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let imgVC = mainStoryBoard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
       
        imgVC.index = indexPath.item
        imgVC.i = indexPath.item
        imgVC.imgMa = imgM
        imgVC.image = imgM[indexPath.item]
        imgVC.likesTitle = likes
        imgVC.likesState = userLikes
        imgVC.repostsCount = repostCount
        self.navigationController?.pushViewController(imgVC, animated: true)
    }
    
}
