//
//  CharectersController.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 23.11.2021.
//

import UIKit
import SnapKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import JGProgressHUD
import NVActivityIndicatorView

class CharactersController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let hud = JGProgressHUD(style: .dark)
    var charactersTableView = UITableView()
    var limit = 30
    
    var name_arr = [String]()
    var image_arr = [String]()
    var image_type_arr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacters()
        setupCharactersView()
        
    }
    
    func getCharacters(){
        hud.show(in: self.charactersTableView)
        let parameters: Parameters = [
            "apikey": "\(App.apikey)",
            "hash": "\(App.hash)",
            "ts": "\(App.ts)",
            "limit": limit,
        ]
        AF.request(App.serviceurl + "characters", method: .get, parameters: parameters).responseJSON { response in
            if let value = response.value {
                App.charactersJSON = JSON(value)
                //print("JSON: \(App.charactersJSON)")
                
                let result = App.charactersJSON["data"]["results"].arrayValue
                for i in 0..<result.count{
                    let name = result[i]["name"].stringValue
                    self.name_arr.append(name)
                    
                    let image = result[i]["thumbnail"]["path"].stringValue
                    self.image_arr.append(image)
                    
                    let type = result[i]["thumbnail"]["extension"].stringValue
                    self.image_type_arr.append(type)
                }
                
            }
            DispatchQueue.main.async {
                self.charactersTableView.reloadData()
                self.hud.dismiss(afterDelay: 1)
            }
        }
    }
    
    func setupCharactersView(){
        self.view.backgroundColor = UIColor.white
        navigationItem.title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(charactersTableView)
        charactersTableView.tableFooterView = UIView()
        charactersTableView.contentInsetAdjustmentBehavior = .never
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        charactersTableView.layer.zPosition = 1
        charactersTableView.backgroundColor = UIColor.clear
        charactersTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        charactersTableView.register(CharactersCell.classForCoder(), forCellReuseIdentifier: "CharactersCell")
        charactersTableView.showsVerticalScrollIndicator = false
        charactersTableView.showsHorizontalScrollIndicator = false
        charactersTableView.estimatedRowHeight = 60
        charactersTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.left.equalTo(view).offset(20)
            make.bottom.equalTo(view).offset(0)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let count = App.charactersJSON["data"]["count"].intValue
        return name_arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath) as! CharactersCell
        cell.characterimage.image = nil
        
        let row = indexPath.row
        
        let name = name_arr[row]
        cell.charactertitle.text = "\(name)"
        
        let image_url = image_arr[row]
        let image_type = image_type_arr[row]
        
        //let img_string = image_url.dropLast()
        let img_available = image_url.suffix(19)
        if(img_available == "image_not_available"){
            cell.characterimage.image = UIImage(named: "sorry_image")
        }else{
            let image = URL(string: "\(image_url).\(image_type)")!
            DispatchQueue.main.async {
                cell.characterimage.af_setImage(withURL: image)
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail_json = App.charactersJSON["data"]["results"][indexPath.row]
        
        let pagechange = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailController
        pagechange.detailJSON = detail_json
        pagechange.modalPresentationStyle = .popover
        self.present(pagechange, animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let detail_json = App.charactersJSON["data"]["results"][indexPath.row]
        
        let offsetY = tableView.contentOffset.y + 200
        let contentHeight = tableView.contentSize.height

        if offsetY > contentHeight - tableView.frame.size.height {
            limit = limit + 30
            loadData()
        }
    }
    func loadData(){
        let pageloadactivity = NVActivityIndicatorView(frame: CGRect(x:(charactersTableView.tableFooterView?.frame.width)!/2-30,y:0,width: 60,height: 60), type: .lineScale, color: UIColor.black, padding: nil)
        charactersTableView.tableFooterView?.addSubview(pageloadactivity)
        pageloadactivity.startAnimating()
        let parameters: Parameters = [
            "apikey": "\(App.apikey)",
            "hash": "\(App.hash)",
            "ts": "\(App.ts)",
            "limit": 30,
            "offset": limit,
        ]
        AF.request(App.serviceurl + "characters", method: .get, parameters: parameters).responseJSON { response in
            if let value = response.value {
                App.charactersJSON = JSON(value)
                //print("JSON: \(App.charactersJSON)")
                
                let result = App.charactersJSON["data"]["results"].arrayValue
                for i in 0..<result.count{
                    let name = result[i]["name"].stringValue
                    self.name_arr.append(name)
                    
                    let image = result[i]["thumbnail"]["path"].stringValue
                    self.image_arr.append(image)
                    
                    let type = result[i]["thumbnail"]["extension"].stringValue
                    self.image_type_arr.append(type)
                }
                
            }
            DispatchQueue.main.async {
                self.charactersTableView.reloadData()
                pageloadactivity.stopAnimating()
            }
        }
    }
    
}
