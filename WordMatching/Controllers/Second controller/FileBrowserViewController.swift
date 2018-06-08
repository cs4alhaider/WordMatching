//
//  FileBrowserViewController.swift
//  WordMatching
//
//  Created by Abdullah Alhaider on 6/9/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class FileBrowserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    let fileArray = ["text1.txt","text2.txt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setup(){
        self.title = "All Files"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    
        
    fileprivate func readFile(fileName: String, fileExtension: String, textToWrite: String){
        
        let fileName = fileName
        let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirURL.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        
        // reading from file
        var readString: String?
        do {
            readString = try String(contentsOf: fileURL)
        } catch let err as NSError {
            print("Faild to read file: \(err)")
        }
        print("Contants of the file is: \(readString ?? "")")
    }
    
    
    
    
    

}
extension FileBrowserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FileBrowserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        
        cell.fileLabel.text = fileArray[indexPath.row]
        return cell
    }
}
