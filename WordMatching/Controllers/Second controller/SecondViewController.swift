//
//  SecondViewController.swift
//  WordMatching
//
//  Created by Abdullah Alhaider on 6/12/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Helper4Swift

class SecondViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var roamingSwitch: UISwitch!
    
    
    let groupUserDefaults = UserDefaults.init(suiteName: "group.net.alhaider.WordMatching.widget")
    
    let nextBillKEY = "nextBillKEY"
    let roamingModeKEY = "roamingModeKEY"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        toolBar()
        roamingMode()
    }

    override func viewDidAppear(_ animated: Bool) {
        roamingMode()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        nextBillSetup()
    }
    
    
    @IBAction func roamingSwitchTapped(_ sender: UISwitch) {
        groupUserDefaults?.set(roamingSwitch.isOn, forKey: roamingModeKEY)
    }
    
    
    //MARK: nextBillSetup
    fileprivate func nextBillSetup(){
        
        if textField1.hasText {
            label1.text = textField1.text
            // assigning textField1.text value to our app group to access it from our new Today Extension (Widget)
            groupUserDefaults?.set(textField1.text, forKey: nextBillKEY)
        }else{
            Helper4Swift.showBasicAlert(title: nil, message: "No text to save", buttonTitle: "OK", vc: self)
        }
    }
    
    
    //MARK: roamingMode
    fileprivate func roamingMode(){
        // grabbing the value of roamingSwitch
        if let bool = groupUserDefaults?.value(forKey: roamingModeKEY) as? Bool {
            roamingSwitch.isOn = bool
        }
    }
    
    
    //MARK: setup
    fileprivate func setup(){
        
        // grabbing the value of nextBillKEY to update the label1
        if let textToUse = groupUserDefaults?.value(forKey: nextBillKEY) as? String {
            label1.text = textToUse
        }
        
        self.view.backgroundColor = .white
        button1.applyButtonDesign(title: "Save",
                                     titleColor: .white,
                                     cornerRadius: button1.frame.size.height / 2,
                                     backgroundColor: #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1) ,
                                     shadowColor: .darkGray,
                                     shadowRadius: 10,
                                     shadowOpacity: 0.3)
    }
    
    
    //MARK: toolBar
    fileprivate func toolBar(){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.isTranslucent = true
        toolBar.barStyle = .default
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = doneBarButton()
        toolBar.setItems([space,done,space], animated: true)
        textField1.inputAccessoryView = toolBar
    }
    
    //MARK: doneBarButton
    private func doneBarButton() -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 75, height: 30)
        button.applyButtonDesign(title: "Done",
                                 titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                 cornerRadius: button.frame.size.height / 2,
                                 backgroundColor: #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1) ,
                                 shadowColor: .clear,
                                 shadowRadius: 5,
                                 shadowOpacity: 0)
        
        button.addTarget(self, action: #selector(self.dismissKeyboard), for: UIControlEvents.touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
