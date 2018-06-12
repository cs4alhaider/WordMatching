//
//  TodayViewController.swift
//  Widget
//
//  Created by Abdullah Alhaider on 6/12/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var billDataLabel: UILabel!
    @IBOutlet weak var roamingLabel: UILabel!
    
    let groupUserDefaults = UserDefaults.init(suiteName: "group.net.alhaider.WordMatching.widget")
    
    let nextBillKEY = "nextBillKEY"
    let roamingModeKEY = "roamingModeKEY"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNextBill()
        fetchRoamingMode()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    
    fileprivate func fetchNextBill(){
        if let bill = groupUserDefaults?.value(forKey: nextBillKEY){
            billDataLabel.text = bill as? String
        }
    }
    
    
    fileprivate func fetchRoamingMode(){
        if let bool = groupUserDefaults?.value(forKey: roamingModeKEY) as? Bool {
            if bool == true {
                roamingLabel.text = "Active"
                roamingLabel.backgroundColor = .white
                roamingLabel.textColor = #colorLiteral(red: 0.002464444107, green: 0.8679211612, blue: 0.00382380942, alpha: 1)
            }else{
                roamingLabel.text = "Not active"
                roamingLabel.backgroundColor = .white
                roamingLabel.textColor = #colorLiteral(red: 0.866691783, green: 0.1296491266, blue: 0.007488029385, alpha: 1)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
