//
//  ListModel.swift
//  DemoByNarendraYadavv
//
//  Created by Narendra Yadav on 30/01/23.
//

import Foundation
import UIKit

//MARK: Model For List Response
class ListModel: Codable {
    var status: Bool?
    var list: [ListModelDetail]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case list = "movie_list"
    }
}

//MARK: Model For List Details
class ListModelDetail: Codable {
    var id:Int?
    var categoryId:Int?
    var title:String?
    var imageUrl:String?
    
    enum CodingKeys: String, CodingKey {
        case id,categoryId,title
        case imageUrl = "image_url"
    }
}
