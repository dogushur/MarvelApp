//
//  CharectersCell.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 23.11.2021.
//

import UIKit
import SnapKit

class CharactersCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var characterimage = UIImageView()
    var charactereffect = UIView()
    var charactertitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        contentView.addSubview(characterimage)
        characterimage.backgroundColor = UIColor.clear
        characterimage.clipsToBounds = true
        characterimage.layer.cornerRadius = 10
        characterimage.contentMode = .scaleAspectFill
        characterimage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(0)
            make.left.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(-20)
            make.right.equalTo(contentView).offset(0)
            make.height.equalTo(150)
        }
        
        characterimage.addSubview(charactereffect)
        charactereffect.backgroundColor = UIColor.black
        charactereffect.layer.opacity = 0.3
        charactereffect.clipsToBounds = true
        charactereffect.layer.cornerRadius = 10
        charactereffect.snp.makeConstraints { make -> Void in
            make.top.equalTo(characterimage).offset(0)
            make.left.equalTo(characterimage).offset(0)
            make.bottom.equalTo(characterimage).offset(0)
            make.right.equalTo(characterimage).offset(0)
        }
        
        contentView.addSubview(charactertitle)
        charactertitle.textColor = UIColor.white
        charactertitle.font = UIFont.boldSystemFont(ofSize: 18)
        charactertitle.snp.makeConstraints { make -> Void in
            make.left.equalTo(characterimage).offset(10)
            make.right.equalTo(characterimage).offset(-10)
            make.bottom.equalTo(characterimage).offset(-10)
        }
        
        self.contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
