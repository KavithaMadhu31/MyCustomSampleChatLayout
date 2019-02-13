//
//  TextLabelLeft.swift
//  chattingLabelSample
//
//  Created by murganandam on 19/01/19.
//  Copyright © 2019 murganandam. All rights reserved.
//

import UIKit

class TextLabelLeft: UITableViewCell {

    @IBOutlet var leftView: UIView!
    @IBOutlet var LeftLabel: UILabel!
    @IBOutlet var leftImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        leftImage.layer.cornerRadius = leftImage.frame.size.width/2
        leftImage.layer.masksToBounds = true
        leftView.layer.cornerRadius = 10
        leftView.clipsToBounds = true
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func MessageValues(imageValue : String,Message : String){
        leftImage.image = UIImage(named: imageValue)
        LeftLabel.text = Message
      
    }
}
