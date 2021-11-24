//
//  DetailController.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 24.11.2021.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import JGProgressHUD
import FSPagerView

class DetailController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    var detailJSON = JSON()
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDetail()
    }
    
    var character_image = UIImageView()
    var character_effect = UIView()
    var character_name = UILabel()
    var character_desc = UITextView()
    var comic_list = FSPagerView()
    
    var image_arr = [String]()
    var image_title = [String]()
    
    func setupDetail(){
        //print("JSON: \(detailJSON)")
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(character_image)
        character_image.backgroundColor = UIColor.clear
        character_image.contentMode = .scaleToFill
        character_image.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(250)
        }
        
        let image_url = detailJSON["thumbnail"]["path"].stringValue
        let image_type = detailJSON["thumbnail"]["extension"].stringValue
        
        //let img_string = image_url.dropLast()
        let img_available = image_url.suffix(19)
        if(img_available == "image_not_available"){
            character_image.image = UIImage(named: "sorry_image")
        }else{
            let image = URL(string: "\(image_url).\(image_type)")!
            character_image.af_setImage(withURL: image)
        }
        
        character_image.addSubview(character_effect)
        character_effect.backgroundColor = UIColor.black
        character_effect.layer.opacity = 0.3
        character_effect.clipsToBounds = true
        character_effect.snp.makeConstraints { make -> Void in
            make.top.equalTo(character_image).offset(0)
            make.bottom.equalTo(character_image).offset(0)
            make.left.equalTo(character_image).offset(0)
            make.right.equalTo(character_image).offset(0)
        }
        
        let name = detailJSON["name"].stringValue
        
        character_image.addSubview(character_name)
        character_name.backgroundColor = UIColor.clear
        character_name.textColor = UIColor.white
        character_name.text = name
        character_name.font = UIFont.boldSystemFont(ofSize: 28)
        character_name.snp.makeConstraints { make -> Void in
            make.bottom.equalTo(character_effect).offset(-20)
            make.left.equalTo(character_image).offset(20)
            make.right.equalTo(character_image).offset(-20)
        }
        
        let desc = detailJSON["description"].stringValue
        
        self.view.addSubview(character_desc)
        character_desc.isEditable = false
        character_desc.isSelectable = false
        character_desc.backgroundColor = UIColor.clear
        character_desc.text = desc
        character_desc.textColor = UIColor.black
        character_desc.font = UIFont.systemFont(ofSize: 20)
        character_desc.translatesAutoresizingMaskIntoConstraints = true
        character_desc.sizeToFit()
        character_desc.isScrollEnabled = false
        character_desc.snp.makeConstraints { make -> Void in
            make.top.equalTo(270)
            //make.bottom.equalTo(view).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        if(desc.count <= 1){
            character_desc.isHidden = false
            character_desc.text = "No explanation has been found yet."
        }else{
            character_desc.isHidden = false
        }
        
        
        self.view.addSubview(comic_list)
        comic_list.backgroundColor = UIColor.clear
        comic_list.dataSource = self
        comic_list.delegate = self
        comic_list.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        comic_list.snp.makeConstraints { make -> Void in
            make.bottom.equalTo(-20)
            make.height.equalTo(250)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
       }
        
        
        getComics()
    }
    
    func getComics(){
        hud.show(in: self.view)
        let character_id = detailJSON["id"].stringValue
        let parameters: Parameters = [
            "apikey": "\(App.apikey)",
            "hash": "\(App.hash)",
            "ts": "\(App.ts)",
            "limit": 10,
            "dateRange": "2015-01-01,2021-12-30"
        ]
        AF.request(App.serviceurl + "characters/" + character_id + "/comics", method: .get, parameters: parameters).responseJSON { [self] response in
            if let value = response.value {
                let json = JSON(value)
                print("JSON Comics: \(json)")
                
                let result = json["data"]["results"].arrayValue
                for i in 0..<result.count{
                    let t = result[i]["title"].stringValue
                    print("title:\(t)")
                    image_title.append(t)
                    
                    let image = result[i]["thumbnail"]["path"].stringValue
                    let type = result[i]["thumbnail"]["extension"].stringValue
                    
                    let img_available = image.suffix(19)
                    
                    let ii = "\(image).\(type)"
                    image_arr.append(ii)
                }
                
            }
            DispatchQueue.main.async { [self] in
                comic_list.reloadData()
                self.hud.dismiss(afterDelay: 1)
            }
        }
    }
    
    @objc(numberOfItemsInPagerView:) public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return image_arr.count
    }
        
    @objc(pagerView:cellForItemAtIndex:) public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        let image = URL(string: "\(image_arr[index])")!
        
        cell.imageView?.af_setImage(withURL: image)
        cell.textLabel?.text = image_title[index]
        return cell
    }
    
}
