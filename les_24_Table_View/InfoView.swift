//
//  InfoView.swift
//  Job
//
//  Created by Илья Черницкий on 19.03.23.
//

import UIKit

class InfoView: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var oldLabel: UILabel!
    var data = DataStr.init()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInfo()
        
    }
    
    private func initInfo(){
        fioLabel?.text = data.name
        jobLabel?.text = data.job
        dayLabel?.text = data.dateJob.formatted(date: .abbreviated, time: .omitted)
        statusLabel?.text = (data.status == true ? "Принят" : "Уволен" )
        
        let date = data.old.formatted(date: .abbreviated, time: .omitted)
        oldLabel?.text = "Дата рождения: \(date)"
        
    }
    
}
