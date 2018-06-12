//
//  FileDetailsViewController.swift
//  WordMatching
//
//  Created by Abdullah Alhaider on 6/9/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Helper4Swift

class FileDetailsViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    
    var recivedFileName: String?
    let fileExt = "txt"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: setup
    fileprivate func setup(){
        self.title = "File Details"
        textLabel.text = fileDetails()
        
        self.view.backgroundColor = .white
        exitButton.applyButtonDesign(title: "Exit",
                                     titleColor: .white,
                                     cornerRadius: exitButton.frame.size.height / 2,
                                     backgroundColor: #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1) ,
                                     shadowColor: .darkGray,
                                     shadowRadius: 10,
                                     shadowOpacity: 0.3)
    }
    
    //MARK: fileDetails
    fileprivate func fileDetails() -> String {
        
        let details = """
        File Name: \(recivedFileName ?? "nil")
        File Extension: \(fileExt)
        ------------------------
        
        File Content: \(ViewController.readFileFromThisProj(fileName: recivedFileName!, ofType: fileExt))
        """
        
        return details
    }
    
    
    

}
