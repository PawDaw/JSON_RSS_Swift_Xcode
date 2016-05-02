//
//  Album.swift
//  Top10_Albums_RSS_JSON
//
//  Created by paw daw on 27/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

class Album: NSObject {
    
    let title : String
    let categories : String
    let price : String
    let relaseDate : String
    
    let imageURL : NSURL
    
    var image: UIImage?
    
    
    init(title : String, categories : String,price : String,relaseDate : String,imageURL : String) {
        
        self.title = title
        self.categories = categories
        self.price = price
        self.relaseDate = relaseDate
        self.imageURL = NSURL(string: imageURL)!
        

    }
    
    func getDataFromUrl(completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(imageURL) {
            (data, response, error) in completion(data: NSData(data: data!))
            }.resume()
    }


}
