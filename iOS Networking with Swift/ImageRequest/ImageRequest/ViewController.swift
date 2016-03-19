//
//  ViewController.swift
//  ImageRequest
//
//  Created by Jarrod Parkes on 11/3/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Add all the networking code here!
        
        let imageURL = NSURL(string: "https://upload.wikimedia.org/wikipedia/en/b/b7/George,_a_perfect_example_of_a_tuxedo_cat.jpg")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(imageURL) { (data, response, error) in
            
            if error == nil {
                
                let downloadedImage = UIImage(data: data!)
                
                performUIUpdatesOnMain {
                    self.imageView.image = downloadedImage
                }
                
            }
            
        }
        
        task.resume()
        
    }
}
