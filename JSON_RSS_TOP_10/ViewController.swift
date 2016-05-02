//
//  ViewController.swift
//  JSON_RSS_TOP_10
//
//  Created by paw daw on 02/05/16.
//  Copyright © 2016 paw daw. All rights reserved.
//
import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ARRAY from the appDelegate
    var albums = [Album]()
    
    // func from the appDelegate
    func dataIsReady(){
        
        tableView.reloadData()
    }
    
    // return amount of prototype cell
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // return amount of rows in the Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
        
    }
    // MARK: - set value to the cell
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath ) as! TableViewCell
        
        // set data to cell
        cell.titleCell.text = albums[indexPath.row].title
        cell.categoryCell.text = albums[indexPath.row].categories
        cell.priceCell.text = albums[indexPath.row].price
        
        // set image to cell
        
        let item = albums[indexPath.row]
        
        if let picture = item.image{
            
            //cached Version
            cell.imageCell.image = picture
            
        }else{
            
            // download and display
            item.getDataFromUrl({ (data) -> Void in
                dispatch_async(dispatch_get_main_queue())
                    {
                        self.albums[indexPath.row].image = UIImage(data: data!)
                        cell.imageCell.image  = self.albums[indexPath.row].image
                        cell.setNeedsLayout()
                }
            })
            
        }
        return cell
    }
    
    
    // MARK: - Swipe edit cell, row Action
    
    // get index PATH
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // .Normal - color
        let shareAction = UITableViewRowAction(style: .Normal, title: "Share") { (action: UITableViewRowAction! , indexPath: NSIndexPath!) -> Void in
            
            let firstactivityItem = self.albums[indexPath.row]
            
            let activityViewController = UIActivityViewController(activityItems: [firstactivityItem], applicationActivities: nil)
            
            self.presentViewController(activityViewController, animated: true, completion: nil)
            
            
        }
        
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (action: UITableViewRowAction!,indexPath: NSIndexPath! ) -> Void in
            
            self.albums.removeAtIndex(indexPath.row)
            tableView.reloadData()
            
        })
        
        
        shareAction.backgroundColor = UIColor.blueColor()
        // deleteAction.backgroundColor = UIColor.redColor()
        
        return [shareAction, deleteAction]
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    // MARK: - Sqgue to DetailViewConntroller
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showDetail" )
        {
            let upcoming : DetailViewController = segue.destinationViewController as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let item = albums[indexPath.row]
            
            upcoming.titleString = item.title
            upcoming.categorieString = item.categories
            upcoming.priceString = item.price
            upcoming.imageView = item.image
    
            
            
        }
    }
    
   
    
    
    
    
    
    
    
}