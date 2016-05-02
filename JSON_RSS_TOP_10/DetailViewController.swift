//
//  DetailViewController.swift
//  Top10_Albums_RSS_JSON
//
//  Created by paw daw on 28/04/16.
//  Copyright © 2016 paw daw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    var titleString: String!
    var categorieString: String!
    var priceString: String!
    var imageView: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLable.text = self.titleString
        self.categoryLable.text = self.categorieString
        self.priceLable.text = self.priceString
        self.image.image  = self.imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.

//       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        
//           }
    

}
