//
//  ViewController.swift
//  WordMatch
//
//  Created by Abdullah Alhaider on 6/8/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import MessageUI


var sharedFilePath: String?

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var subLabel1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var subLabel2: UILabel!
    
    @IBOutlet weak var findButton: UIButton!
    
    var sharedFilePath: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: readFileFromThisProj
    fileprivate func readFileFromThisProj(fileName: String, ofType: String) -> String {
        
        let fileURLProj = Bundle.main.path(forResource: fileName, ofType: ofType)
        var readStringProj = ""
        
        do {
            readStringProj = try String(contentsOfFile: fileURLProj!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Error : \(error)")
        }
        
        return readStringProj
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
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let err as NSError {
            print("Faold to write to URL: \(err)")
        }
    }
    
    
    //MARK: setup
    fileprivate func setup(){
        
        self.title = "Word Matching"
        
        label1.text = "First file text is:"
        subLabel1.text = readFileFromThisProj(fileName: "text1", ofType: "txt")
        
        label2.text = "Second file text is:"
        subLabel2.text = readFileFromThisProj(fileName: "text2", ofType: "txt")
        
        findButton.addCustomization()
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
        
        // creating new file ..
        createNewTextFile(fileName: "file", fileExtension: "txt", textToWrite: result)
        
        return result
    }
    
    
    //MARK: handelAlert
    fileprivate func handelAlert(){
        
        let message = matchedWords(text1: readFileFromThisProj(fileName: "text1", ofType: "txt"),
                                   text2: readFileFromThisProj(fileName: "text2", ofType: "txt"))
        
        let alert = UIAlertController(title: "Matche words", message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let sendByEmail = UIAlertAction(title: "Send by Email?", style: .default) { (action) in
            self.handelEmailAttachment()
        }
        
        alert.addAction(dismiss)
        alert.addAction(sendByEmail)
        present(alert, animated: true, completion: nil)
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
            let sendEmaillError = UIAlertController(title: nil, message: "Could not send an Email, Please check your Mail settings in your device and try again.", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "ok", style: .default, handler: nil)
            
            sendEmaillError.addAction(dismiss)
            present(sendEmaillError, animated: true, completion: nil)
        }
    }
    
    // dismissing the mail controller after sending .
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func openingTheFile(fileURL:String){
        
        
        
    }
    
    
    
    
    
    
    @IBAction func findButtonTapped(_ sender: UIButton) {
        handelAlert()
    }
    
    
    
    
}

