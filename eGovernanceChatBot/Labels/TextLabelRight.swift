//
//  TextLabelRight.swift
//  chattingLabelSample
//
//  Created by murganandam on 19/01/19.
//  Copyright © 2019 murganandam. All rights reserved.
//

import UIKit

class TextLabelRight: UITableViewCell {

   
    @IBOutlet var rightView: UIView!
    @IBOutlet var RightLabel: UILabel!
    @IBOutlet var rightImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        rightImage.layer.cornerRadius = rightImage.frame.size.width/2
        rightImage.layer.masksToBounds = true
        rightView.layer.cornerRadius = 10
        rightView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func RightMessageValues(imageValue : String,Message : String){
        rightImage.image = UIImage(named: imageValue)
        RightLabel.text = Message
       
    }
}
