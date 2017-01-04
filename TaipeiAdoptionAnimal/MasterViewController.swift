//
//  MasterViewController.swift
//  TaipeiAdoptionAnimal
//
//  Created by Mac on 2016/12/30.
//  Copyright © 2016年 simonkira. All rights reserved.
//


import UIKit
import SDWebImage

let adoptionAnimalUrl = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c" // 臺北市開放認養動物 公開資料網址


class MasterViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate,
UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var mTableView: UITableView!
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    var dataArray = [AnyObject]() //儲存動物資料

    override func viewDidLoad() {
        super.viewDidLoad()
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 44))
        
        // 使用 UIImageView(frame:) 建立一個 UIImageView
        let myImageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 50, height: 50))
        // 使用 UIImage(named:) 放置圖片檔案
        myImageView.image = UIImage(named: "logo.png")
        
        let myLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 150, height: 44))
        myLabel.text = "臺北市❤毛小孩"
        // myLabel titleTextAttributes
        if let titleFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 20.0) {
            myLabel.font = titleFont
            myLabel.textColor = UIColor.white
        }
        
        myView.addSubview(myImageView)
        myView.addSubview(myLabel)
        
        self.navigationController?.navigationBar.topItem?.titleView = myView
        
        
        // 臺北市開放認養動物 公開資料網址
        let url = URL(string: adoptionAnimalUrl)
        
        // 建立一般的session設定
        let sessionWithConfigure = URLSessionConfiguration.default
        
        // 設定委任對象為自己
        let session = Foundation.URLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: OperationQueue.main)
        
        // 設定下載網址
        let dataTask = session.downloadTask(with: url!)
        
        // 啟動或重新啟動下載動作
        dataTask.resume()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.mTableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                destinationController.thisAnimalDic = dataArray[indexPath.row]
            }
        }
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //依據動物數量呈現
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MasterTableViewCell
        
        //顯示動物的暱稱於Table View中
        cell.nameLabel?.text = dataArray[indexPath.row]["Name"] as? String
        
        //顯示動物縮圖，採用非同步下載處理
        let fileUrl = NSURL(string: dataArray[indexPath.row]["ImageName"] as! String)
        cell.thumbnailImageView.sd_setImage(with: fileUrl as! URL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            // JSON資料處理
            let dataDic = try JSONSerialization.jsonObject(with: Data(contentsOf: location), options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:[String:AnyObject]]
            
            // 依據先前觀察的結構，取得result對應中的results所對應的陣列
            dataArray = dataDic["result"]!["results"] as! [AnyObject]
            
            // 重新整理Table View
            self.mTableView.reloadData()
            
        } catch {
            print("URL Session Error!")
        }
    }
}
