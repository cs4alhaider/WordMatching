//
//  ViewController.swift
//  WordMatch
//
//  Created by Abdullah Alhaider on 6/8/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Helper4Swift
import MessageUI



class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var subLabel1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var subLabel2: UILabel!
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var findButton: UIButton!
    @IBAction func unwindToFirstController(_ sender: UIStoryboardSegue){}
    
    var sharedFilePath: String?
    var message: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: readFileFromThisProj
    static func readFileFromThisProj(fileName: String, ofType: String) -> String {
        
        let fileURLProj = Bundle.main.path(forResource: fileName, ofType: ofType)
        let fileContents = FileManager.default.contents(atPath: fileURLProj!)
        let fileContentsAsString = String(bytes: fileContents!, encoding: .utf8)
        
        return fileContentsAsString!
    }
    
    
    //MARK: createAndReadNewTextFile
    fileprivate func createNewTextFile(fileName: String, fileExtension: String, textToWrite: String){
        
        let fileName = fileName
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        
        print("File path: \(fileURL.path)")
        sharedFilePath = fileURL.path
        
        // writing a new file ..
        let writeString = textToWrite
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch let err as NSError {
            print("Failed to write to URL: \(err)")
        }
    }
    
    
    //MARK: setup
    fileprivate func setup(){
        
        self.title = "Word Matching"
        
        label1.text = "First file text is:"
        subLabel1.text = ViewController.readFileFromThisProj(fileName: "text1", ofType: "txt")
        
        label2.text = "Second file text is:"
        subLabel2.text = ViewController.readFileFromThisProj(fileName: "text2", ofType: "txt")
        
        self.view.backgroundColor = .white
        
        upView.applyViewDesign(masksToBounds: false,
                               color: .darkGray,
                               cornerRadius: 15,
                               opacity: 0.2,
                               offSet: CGSize(width: 0, height: 0),
                               radius: 20)
        
        downView.applyViewDesign(masksToBounds: false,
                                 color: .darkGray,
                                 cornerRadius: 15,
                                 opacity: 0.2,
                                 offSet: CGSize(width: 0, height: 0),
                                 radius: 20)
        
        findButton.applyButtonDesign(title: "Search For Matching",
                                     titleColor: .white,
                                     cornerRadius: findButton.frame.size.height / 2,
                                     backgroundColor: #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1) ,
                                     shadowColor: .darkGray,
                                     shadowRadius: 10,
                                     shadowOpacity: 0.3)
    }
    
    
    //MARK: matchedWords
    func matchedWords(text1:String, text2:String) -> String?{
        
        let firstText = Set(text1.split(separator: " "))
        let secondText = Set(text2.split(separator: " "))
        
        // If order doesn't matter:
        //let result = firstText.intersection(secondText).reduce("") { $0 + $1 + " "}
        
        // If order matters:
        let result = firstText.intersection(secondText).sorted{
            firstText.index(of: $0)! < firstText.index(of: $1)!
            }.reduce(""){ $0 + $1 + " "}
        
        // listing the result in array to be more clear
        let wordList =  result.components(separatedBy: .punctuationCharacters).joined().components(separatedBy: " ").filter{!$0.isEmpty}
        
        message = "Word List:\n\(wordList)\nNumber of words = \(wordList.count)"
        
        // creating new file ..
        createNewTextFile(fileName: "file", fileExtension: "txt", textToWrite: message!)
        
        return message
    }
    
    
    //MARK: handelAlert
    fileprivate func handelAlert(){
        
        let message = matchedWords(text1: ViewController.readFileFromThisProj(fileName: "text1", ofType: "txt"),
                                   text2: ViewController.readFileFromThisProj(fileName: "text2", ofType: "txt"))
        
        if (message?.isEmpty)! {
            Helper4Swift.showBasicAlert(title: "Nothing to match!", message: nil, buttonTitle: "OK", vc: self)
        }else{
            let alert = UIAlertController(title: "Matched words:", message: "\(message!)", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            let sendByEmail = UIAlertAction(title: "Create a new file and send by email?", style: .default) { (action) in
                self.handelEmailAttachment()
            }
            
            alert.addAction(dismiss)
            alert.addAction(sendByEmail)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: handelEmailAttachment
    fileprivate func handelEmailAttachment() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            //Attach the new file ..
            if let fileData = NSData(contentsOfFile: sharedFilePath!){
                mail.addAttachmentData(fileData as Data, mimeType: "txt", fileName: "file")
            }
            self.present(mail, animated: true, completion: nil)
            
        }else {
            // Showing failure alert
            Helper4Swift.showBasicAlert(title: nil,
                                        message: "Could not send an Email, Please check your Mail settings in your device and try again.",
                                        buttonTitle: "OK",
                                        vc: self)
        }
    }
    
    // dismissing the mail controller after sending .
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func findButtonTapped(_ sender: UIButton) {
        handelAlert()
    }
    
    
}

