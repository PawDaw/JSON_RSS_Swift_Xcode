//
//  AppDelegate.swift
//  JSON_RSS_TOP_10
//
//  Created by paw daw on 02/05/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        //https://itunes.apple.com/us/rss/topalbums/limit=25/xml   -- RSS
        //https://itunes.apple.com/us/rss/topalbums/limit=25/json  -- JSON
        
        // http://rss2json.com - convert RSS to JSON
        let urlPath = "http://rss2json.com/api.json?rss_url=https%3A%2F%2Fitunes.apple.com%2Fus%2Frss%2Ftopalbums%2Flimit%3D10%2Fexplicit%3Dtrue%2Fxml"
        let url : NSURL = NSURL(string: urlPath)!
        
        // provide an API for downloading content
        let session = NSURLSession.sharedSession()
        
        // Album Array
        var itemObjects = [Album]()
        
        // data - The data returned by the server
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if error == nil {
                
                let returnedData = JSON(data: data!)
                let results = returnedData["items"].arrayValue
                
                
                for item in results {
                    
                    // JSON
                    let title = item["title"].stringValue
                    let categories = item["categories"][0].stringValue
                    let relaseDate = "2015"
                    let price = item["content"].stringValue
                    let imageUrl = item["content"].stringValue
                    
                    var priceSubstring = ""
                    var urlSubstring = ""
                    
                    // Extract required information from a String
                    
                    // check if word "Price:" exist
                    if price.rangeOfString("Price:") != nil{
                        
                        // Finding index of character/String  "$"
                        let startInd = price.rangeOfString("$")?.startIndex
                        let endInd = price.rangeOfString("$")?.startIndex.advancedBy(6)
                        priceSubstring = price.substringWithRange(Range(start: startInd!, end: endInd!))
                        
                        print("price : \(priceSubstring) ")
                    }
                    
                    // check if exist word "Price:"
                    if imageUrl.rangeOfString("http:") != nil{
                        
                        // that just gives me a Start String Index from "http:"
                        let startInd = imageUrl.rangeOfString("http:")?.startIndex
                        // that just gives me a END String Index from "http:"
                        let endInd = price.rangeOfString("85.jpg")?.endIndex
                        urlSubstring = price.substringWithRange(Range(start: startInd!, end: endInd!))
                        
                        print("URL : \(urlSubstring) ")
                        
                        // set data to the array
                        itemObjects.append(Album(title: title, categories: categories, price: priceSubstring, relaseDate: relaseDate, imageURL: urlSubstring))
                    }
                    
                    
                    //print("\(returnData) ")
                    print("title: \(title) ,  categories: \(categories)")
                    
                    print("----------------------")
                    
                }
                
                // connection to VIEW CONNTROLLER
                let vc = (self.window?.rootViewController as! UINavigationController).viewControllers.first as! ViewController
                
                //                let vc = self.window?.rootViewController as! ViewController
                
                // create to members in ViewConntroller to pass ARRAY with itemObjects ...
                vc.albums = itemObjects
                vc.dataIsReady()
                
            }
        }
        
        task.resume()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

