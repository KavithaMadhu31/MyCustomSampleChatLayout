//
//  ChatBotViewController.swift
//  chattingLabelSample
//
//  Created by murganandam on 19/01/19.
//  Copyright © 2019 murganandam. All rights reserved.
//

import UIKit
import SwiftSiriWaveformView

class ChatBotViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate{
    
    var timer:Timer?
    var change:CGFloat = 0.01
    let waveview = SwiftSiriWaveformView()
   
   
    @IBOutlet var sendbutton_outlet: UIButton!
    @IBOutlet var messageview: UIView!
    
    @IBOutlet var micbutton_outlet: UIButton!
    
    @IBOutlet var totalheightconstraint: NSLayoutConstraint!
    @IBOutlet var chatBotTableView: UITableView!
    @IBOutlet var textviewheightconstraint: NSLayoutConstraint!
    @IBOutlet var bgviewheightconstraint: NSLayoutConstraint!
    @IBOutlet var MessageText: UITextView!
    
    
    @IBOutlet var sendviewgradient: UIView!
    
    let chatMessage : NSMutableArray = [];
    
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        loadNibForChat()
    }
    
    
    fileprivate func loadNibForChat() {
        self.sendviewgradient.dropShadow()
        timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(ChatBotViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
        
        
        self.MessageText.delegate = self
        MessageText.text = "Type Message..."
        self.sendbutton_outlet.isHidden = true
        MessageText.textColor = UIColor.lightGray
        MessageText.layer.borderColor = UIColor.lightGray.cgColor
        
        let nibTextlabelLeft = UINib(nibName: "TextLabelLeft", bundle: nil)
        chatBotTableView.register(nibTextlabelLeft, forCellReuseIdentifier: "textLabelLeft" )
        let nibTextlabelRight = UINib(nibName: "TextLabelRight", bundle: nil)
        chatBotTableView.register(nibTextlabelRight, forCellReuseIdentifier: "textLabelRight" )
        
        chatBotTableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        chatBotTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: chatBotTableView.bounds.size.width - 10)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        textviewheightconstraint.constant = self.MessageText.contentSize.height
        bgviewheightconstraint.constant = self.MessageText.contentSize.height + 30
        totalheightconstraint.constant = totalheightconstraint.constant - self.MessageText.contentSize.height
    }
    
    
    @objc internal func refreshAudioView(_:Timer)
    {
        self.waveview.isHidden = false
        
        if self.waveview.amplitude <= self.waveview.idleAmplitude || self.waveview.amplitude > 1.0
        {
            self.change *= -1.0
        }
        
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.waveview.amplitude += self.change
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexval = (chatMessage.count - 1 )-indexPath.row
       
        print(indexval,indexPath.row)
        if(indexval % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "textLabelLeft", for: indexPath) as! TextLabelLeft
            cell.transform = CGAffineTransform(rotationAngle: (-.pi))
            cell.MessageValues(imageValue: "ivar.jpg", Message:chatMessage[indexval] as! String )
            return cell
           
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "textLabelRight", for: indexPath) as! TextLabelRight
            cell.transform = CGAffineTransform(rotationAngle: (-.pi))
            cell.RightMessageValues(imageValue: "ivar1.jpg", Message:chatMessage[indexval] as! String )
            return cell
        }
      
    }
    // MARK -
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        MessageText.resignFirstResponder()
        return true;
        
    }// end textFieldShouldReturn
    
 

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func Send(_ sender: Any) {
        
        if MessageText.text != "" || MessageText.text.count != 0{
            
          chatBotTableView.transform = CGAffineTransform(rotationAngle: (-.pi))
            
            chatBotTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: chatBotTableView.bounds.size.width - 10)
            chatMessage.add(MessageText.text!)
            MessageText.text = "";
            textviewheightconstraint.constant = self.MessageText.contentSize.height
            bgviewheightconstraint.constant = self.MessageText.contentSize.height + 30
            totalheightconstraint.constant = totalheightconstraint.constant - self.MessageText.contentSize.height
            MessageText.text = "Type Message..."
            self.sendbutton_outlet.isHidden = true
            self.micbutton_outlet.isHidden = false
            self.MessageText.resignFirstResponder()
            MessageText.textColor = UIColor.lightGray
            chatBotTableView.reloadData()
        }
    }
    
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            self.sendbutton_outlet.isHidden = false
            self.micbutton_outlet.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type Message..."
            textView.textColor = UIColor.lightGray
            self.sendbutton_outlet.isHidden = true
            self.micbutton_outlet.isHidden = false
        }
    }
    
    
    @IBAction func mic_touchdown_on(_ sender: Any) {
        UIView.animate(withDuration: 2.0, animations: {
            self.waveview.isHidden = false
            self.sendviewgradient.frame = CGRect(x: 8, y: 8, width: self.messageview.frame.width - 16, height: 50)
            self.micbutton_outlet.frame = CGRect(x: self.sendviewgradient.frame.size.width - 50, y: 0, width: 50, height: 50)
            
            self.waveview.frame = CGRect(x: 30, y: 05, width: self.sendviewgradient.frame.size.width - 90
                , height: 40)
            self.waveview.backgroundColor = UIColor.clear
            self.sendviewgradient.addSubview(self.waveview)
            
            if self.timer == nil
            {
                self.timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(ChatBotViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)
            }
            
        })
        
    }
    
    @IBAction func mic_Action(_ sender: Any) {
       
        if timer != nil {
            
            self.waveview.isHidden = false
            timer?.invalidate()
            timer = nil
            self.waveview.amplitude = 0
        }
        UIView.animate(withDuration: 2.0, animations: {
            self.waveview.isHidden = true
            self.sendviewgradient.frame = CGRect(x: self.MessageText.frame.size.width + 20, y: 8, width: 50, height: 50)
            self.micbutton_outlet.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            
        })
    }
    
   
    
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
    }
}


//for label dynamic
//https://jayeshkawli.ghost.io/using-autolayout-to-dynamically-resize-uilabel/
