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
        
        //設定Title
        self.title = thisAnimalDic?["Name"] as? String
        
        //取得圖片網址
        let fileUrl = NSURL(string: thisAnimalDic?["ImageName"] as! String)
        if let fileUrl = fileUrl //如果有圖片網址，向伺服器請求圖片資料
        {
            //顯示動物圖，採用非同步下載處理
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
            cell.valueLabel.text = thisAnimalDic?["Phone"] as? String
        case 14:
            cell.fieldLabel.text = "聯絡email:"
            cell.valueLabel.text = thisAnimalDic?["Email"] as? String
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
    
   
    
   
    
}
