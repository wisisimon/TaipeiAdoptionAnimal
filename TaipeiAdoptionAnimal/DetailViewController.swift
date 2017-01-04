//
//  DetailViewController.swift
//  TaipeiAdoptionAnimal
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 simonkira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var thisAnimalDic:AnyObject?
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //取得圖片網址
        let url = (thisAnimalDic as? [String:AnyObject])?["ImageName"]
        
        if let url = url //如果有圖片網址，向伺服器請求圖片資料
        {
            let sessionWithConfigure = URLSessionConfiguration.default
            
            let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
            
            let dataTask = session.downloadTask(with: URL(string: url as! String)!)
            
            dataTask.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let imageData = try? Data(contentsOf: location) else {
            return
        }
        
        imageView.image = UIImage(data: imageData)
    }
}
