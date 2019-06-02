//
//  Classes.swift
//  L2_toroyanseda
//
//  Created by Seda on 03/05/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

// Get Friends
class UserResponse: Mappable{
    //var countResponse: Int?
    var itemsResponse: [Items]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        //countResponse <- map["response.count"]
        itemsResponse <- map["response.items"]
    }
}

class Items: Mappable {
    var id : Int?
    var firstName : String?
    var lastName : String?
    var photo: String?
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        photo <- map["photo_100"]
    }
}



// Get Groups
class GroupsResponse:Object, Mappable{
    var itemsResponse: [ItemsGroups]?
    
    convenience  required init?(map: Map){
        self.init()
    }
    func mapping(map: Map){
        itemsResponse <- map["response.items"]
    }
}
class ItemsGroups:Object, Mappable {
    @objc dynamic var id = 0
   @objc dynamic var name : String?
    var photo: String?
   convenience required init?(map: Map){
       self.init()
    }
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        photo <- map["photo_100"]
    }
}


// Get Photos
class PhotosResponse: Mappable{
    var photosResponse: [ItemsPhotos]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        photosResponse <- map["response.items.0.sizes"] // указан ноль так как у моего пользователя только одно фото
    }
}
class ItemsPhotos: Mappable{
    var type: String?
    var url: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        type <- map["type"]
        url <- map["url"]
    }
}


class WallRecords: Mappable{
   var itemsResponse: [ItemsWall]?
    required init?(map: Map){
    }
    func mapping(map: Map){
        itemsResponse <- map["response.items"]
    }
}
class ItemsWall: Mappable{
    var fromId: Int?
    var date: Int?
    var text:String?
    var comment: Int?
    var like: Int?
    var repost: Int?
    var type: String?
    var typePhoto: String?
    var url: String?
    var urlGraffiti: String?
    var video: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        fromId <- map["from_id"]
        date <- map["date"]
        text <- map["text"]
        comment <- map["comments.count"]
        like <- map["likes.count"]
        repost <- map["reposts.count"]
        type <- map["attachments.0.type"]
        typePhoto <- map["attachments.0.photo.sizes.4.type"]
        url <- map["attachments.0.photo.sizes.4.url"]
        urlGraffiti <- map["attachments.0.graffiti.photo_200"]
        video <- map["attachments.0.video.photo_130"]
    }
}



class Profiles: Mappable{
    var profiles: [UserProfile]?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        profiles <- map["response.profiles"]
    }
}

class UserProfile: Mappable{
    var id : Int?
    var firstName : String?
    var lastName : String?
    var photo: String?
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        photo <- map["photo_100"]
    }
}
