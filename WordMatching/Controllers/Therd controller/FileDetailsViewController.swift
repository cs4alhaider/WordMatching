//
//  FileDetailsViewController.swift
//  WordMatching
//
//  Created by Abdullah Alhaider on 6/9/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class FileDetailsViewController: UIViewController {

    
    var recivedFileName: String?
    let fileExt = "txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func setup(){
        self.title = "File Details"
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
