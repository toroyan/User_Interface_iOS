//
//  NewsViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 26/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   var textPost = [String]()
    var profileName = [String]()
    var profileidArray = [Int]()
    var fromIdArray = [Int]()
    var profilePhoto = [String]()
    var postDate = [Int]()
    var likesCount = [Int]()
    var commentsCount = [Int]()
    var shareCount = [Int]()
    var wallPhoto = [String]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
  tableView.dataSource = self
  tableView.delegate = self
        let footerNib = UINib.init(nibName: "FooterView", bundle: Bundle.main)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: "FooterView")
        tableView.backgroundColor = UIColor.clear
      
        let session = Session.shared
        let WallURL="https://api.vk.com/method/wall.get?access_token=\(session.token)&extended=1&fields=first_name,last_name,photo_100&count=100&v=5.95"
        Alamofire.request(WallURL).responseObject { (response: DataResponse<WallRecords>) in
            
            let wResponse = response.result.value
            if let wallItems = wResponse?.itemsResponse{
                for posts in wallItems{
                    self.textPost.append(posts.text ?? "")
                    self.fromIdArray.append(posts.fromId ?? 0)
                    self.postDate.append(posts.date!)
                    self.likesCount.append(posts.like!)
                    self.commentsCount.append(posts.comment!)
                    self.shareCount.append(posts.repost!)
                    if posts.type == "photo"{
                       self.wallPhoto.append(posts.url!)
                       }
                   else if posts.type == "graffiti"{
                        self.wallPhoto.append(posts.urlGraffiti!)
                    }
                    else if posts.type == "video"{
                        self.wallPhoto.append(posts.video!)
                    }
                    else {
                        self.wallPhoto.append(" ")
                    }
                }
              

        
    }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fromIdArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
       
          let session = Session.shared
        let WallURL="https://api.vk.com/method/wall.get?access_token=\(session.token)&extended=1&fields=first_name,last_name,photo_100&count=100&v=5.95"
        Alamofire.request(WallURL).responseObject { (response: DataResponse<Profiles>) in
            
            let wResponse = response.result.value
            if let wallItems = wResponse?.profiles{
               for items in self.fromIdArray {
                    
                        for posts in wallItems{
                            if(items == posts.id){
                                self.profileName.append(posts.firstName! + " " + posts.lastName!)
                                self.profilePhoto.append(posts.photo!)
                            
                            }
                              }
                 }
               
                if let imageURL = self.profilePhoto[indexPath.section] as? String {
                                 Alamofire.request(imageURL).responseImage(completionHandler: { (response) in
                                 if let image = response.result.value{
                                 DispatchQueue.main.async {
                                    cell.userName.text = self.profileName[indexPath.section]
                                 cell.userImageView.image = image
                        }
                          }
                            })
                                }
                }
            }
        
        if let photoURL = self.wallPhoto[indexPath.section] as? String {
            Alamofire.request(photoURL).responseImage(completionHandler: { (response) in
                if let image = response.result.value{
                    DispatchQueue.main.async {
                        cell.NewsImageView.image = image
                    
                        }
                    }
                })
        }
    
            let cornerRadius: CGFloat = 42.5
            cell.userImageView.clipsToBounds = true
            cell.userImageView.layer.cornerRadius = cornerRadius
        
            let formatter = DateFormatter()
            let date = Date(timeIntervalSince1970: TimeInterval(postDate[indexPath.section]))
            formatter.dateFormat = "dd-MM-yyyy"
            let myString = formatter.string(from: date)

            cell.timeText.text =  myString
    
            cell.typedText.text = textPost[indexPath.section]
      
        return cell
    }
  
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
      let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterView") as! FooterView
     
    footer.addSubview(footer.likeButton)
    footer.addSubview(footer.shareButton)
    footer.addSubview(footer.commentButton)
    footer.addSubview(footer.lineView)
    footer.addSubview(footer.commentLabel)
    footer.addSubview(footer.repostLabel)
footer.repostLabel.text = String(shareCount[section])
        footer.commentLabel.text = String(commentsCount[section])
        footer.likesLabel.text = String(likesCount[section])
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    
}
