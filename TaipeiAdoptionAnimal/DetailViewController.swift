//
//  DetailViewController.swift
//  TaipeiAdoptionAnimal
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 simonkira. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mTableView: UITableView!
    @IBOutlet var animalImageView: UIImageView!
    
    var thisAnimalDic:AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //客製rightBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: .plain, target: self, action: #selector(self.shareClick(_:)))
        
        //設置rightBarButtonItem titleTextAttributes
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 18.0) {
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:barFont], for: UIControlState.normal)
        }
        
        //設定Title
        self.title = thisAnimalDic?["Name"] as? String
        
        //取得圖片網址
        let fileUrl = NSURL(string: thisAnimalDic?["ImageName"] as! String)
        //如果有圖片網址，向伺服器請求圖片資料
        if let fileUrl = fileUrl {
            //顯示動物圖片，採用非同步下載處理
            self.animalImageView.sd_setImage(with: fileUrl as URL)
        }
        
        // Enable self sizing cells
        self.mTableView.estimatedRowHeight = 36.0
        self.mTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        
        /***********************************************************************************
        Name(名稱)、Sex(性別)、Type(動物種類)、Build(體型)、Age(年齡)、Variety(品種)、Reason(進所原因)、AcceptNum(收容編號)、ChipNum(晶片號碼)、IsSterilization(絕育否)、HairType(毛色)、Note(描述)、Resettlement(位置)、Phone(聯絡電話)、Email(聯絡email)、ChildreAnlong(可否與其他孩童相處)、AnimalAnlong(可否與其他動物相處)、Bodyweight(體重)、ImageName(圖片)
        ************************************************************************************/
        
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "名稱:"
            cell.valueLabel.text = thisAnimalDic?["Name"] as? String

        case 1:
            cell.fieldLabel.text = "性別:"
            cell.valueLabel.text = thisAnimalDic?["Sex"] as? String

        case 2:
            cell.fieldLabel.text = "動物種類:"
            cell.valueLabel.text = thisAnimalDic?["Type"] as? String

        case 3:
            cell.fieldLabel.text = "體型:"
            cell.valueLabel.text = thisAnimalDic?["Build"] as? String
        case 4:
            cell.fieldLabel.text = "年齡:"
            cell.valueLabel.text = thisAnimalDic?["Age"] as? String
        case 5:
            cell.fieldLabel.text = "品種:"
            cell.valueLabel.text = thisAnimalDic?["Variety"] as? String
        case 6:
            cell.fieldLabel.text = "進所原因:"
            cell.valueLabel.text = thisAnimalDic?["Reason"] as? String
        case 7:
            cell.fieldLabel.text = "收容編號:"
            cell.valueLabel.text = thisAnimalDic?["AcceptNum"] as? String
        case 8:
            cell.fieldLabel.text = "晶片號碼:"
            cell.valueLabel.text = thisAnimalDic?["ChipNum"] as? String
        case 9:
            cell.fieldLabel.text = "絕育否:"
            cell.valueLabel.text = thisAnimalDic?["IsSterilization"] as? String
        case 10:
            cell.fieldLabel.text = "毛色:"
            cell.valueLabel.text = thisAnimalDic?["HairType"] as? String
        case 11:
            cell.fieldLabel.text = "描述:"
            cell.valueLabel.text = thisAnimalDic?["Note"] as? String
        case 12:
            cell.fieldLabel.text = "位置:"
            cell.valueLabel.text = thisAnimalDic?["Resettlement"] as? String
        case 13:
            cell.fieldLabel.text = "聯絡電話"
            
            //add gesture to your Label
            let phoneTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.callPhone(_:)))
            cell.valueLabel.tag = 991
            cell.valueLabel.isUserInteractionEnabled = true
            cell.valueLabel.addGestureRecognizer(phoneTapGesture)
            //顯示電話號碼
            cell.valueLabel.text = thisAnimalDic?["Phone"] as? String
            cell.valueLabel.textColor = UIColor.blue
            
        case 14:
            cell.fieldLabel.text = "聯絡email:"
            
            //add gesture to your Label
            let mailTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.sendMail(_:)))
            cell.valueLabel.tag = 992
            cell.valueLabel.isUserInteractionEnabled = true
            cell.valueLabel.addGestureRecognizer(mailTapGesture)

            //顯示EMAIL
            cell.valueLabel.text = thisAnimalDic?["Email"] as? String
            cell.valueLabel.textColor = UIColor.blue
        case 15:
            cell.fieldLabel.text = "可否與其他孩童相處:"
            cell.valueLabel.text = thisAnimalDic?["ChildreAnlong"] as? String
        case 16:
            cell.fieldLabel.text = "可否與其他動物相處:"
            cell.valueLabel.text = thisAnimalDic?["AnimalAnlong"] as? String
        case 17:
            cell.fieldLabel.text = "體重:"
            cell.valueLabel.text = thisAnimalDic?["Bodyweight"] as? String
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // 撥電話
    func callPhone(_ sender: UITapGestureRecognizer) {
        let phoneNumber = thisAnimalDic?["Phone"] as! String
        if let callURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            if (UIApplication.shared.canOpenURL(callURL as URL)) {
                UIApplication.shared.openURL(callURL as URL);
            }
            else {
                // your number not valid
                let tapAlert = UIAlertController(title: "訊息", message: "電話號碼有誤，請查明後在撥，謝謝。", preferredStyle: UIAlertControllerStyle.alert)
                tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(tapAlert, animated: true, completion: nil)
            }
        }
    }
    
    // 寄信
    func sendMail(_ sender: UITapGestureRecognizer) {
        let mailString = thisAnimalDic?["Email"] as! String
        if let mailURL:NSURL = NSURL(string:"mailto:\(mailString)") {
            if (UIApplication.shared.canOpenURL(mailURL as URL)) {
                UIApplication.shared.openURL(mailURL as URL);
            }
            else {
                // your mail not valid
                let tapAlert = UIAlertController(title: "訊息", message: "信箱有誤，無法寄信。", preferredStyle: UIAlertControllerStyle.alert)
                tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(tapAlert, animated: true, completion: nil)
            }
        }
    }
    // 分享
    func shareClick(_ sender: AnyObject) {
        let phoneString = thisAnimalDic?["Phone"] as? String
        let mailString = thisAnimalDic?["Email"] as? String
        let firstActivityItem = "臺北市揪❤毛小孩動物認養\n聯絡電話：\(phoneString! as String)\n聯絡Email：\(mailString! as String)\n"
        
        //screenshot 不包含NavigationBar
//        UIGraphicsBeginImageContext(self.view.bounds.size)
//        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
        
        //screenshot 包含NavigationBar
        let screen = UIScreen.main
        let window = UIApplication.shared.keyWindow
        UIGraphicsBeginImageContextWithOptions(screen.bounds.size, false, 0);
        window?.drawHierarchy(in: (window?.bounds)!, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, image as Any], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
