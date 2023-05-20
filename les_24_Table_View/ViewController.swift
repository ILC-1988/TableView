//
//  ViewController.swift
//  les_24_Table_View
//
//  Created by Илья Черницкий on 18.05.23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    static var dataArray: [DataStr] = []
    static var row: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ViewController.dataArray = loadFromUserDefaults()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc
    func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        
        if tableView.isEditing {
            return
        }
        
        if sender.state == .ended {
            let touchPoint = sender.location(in: tableView)
            if tableView.indexPathForRow(at: touchPoint) != nil {
                
                let alertVC = UIAlertController(title: "Вопрос",
                                                message: "Открыть дынные сотрудника ?",
                                                preferredStyle: .alert)
                
                let actionHandler: (UIAlertAction) -> Void = { action in
                    if action.style == .default {
                        
                        if let myViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoView") as? InfoView {
                            let data = ViewController.dataArray[ViewController.row]
                            myViewController.data = data
                            if let navigator = self.navigationController {
                                //navigator.navigationItem.title  = "Штат"
                                navigator.pushViewController(myViewController, animated: true)
                            }
                        }
                        
                    }
                }
                
                alertVC.addAction(
                    UIAlertAction(title: "Отмена",
                                  style: .cancel,
                                  handler: actionHandler)
                )
                
                alertVC.addAction(
                    UIAlertAction(title: "OK",
                                  style: .default,
                                  handler: actionHandler)
                )
                
                present(alertVC, animated: true)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myViewController = segue.destination as? NewInfoView {
            
            myViewController.dataArray = ViewController.dataArray
            
        }
    }
    
    @IBAction func editTableView(_ sender: Any) {
        if !tableView.isEditing {
            tableView.setEditing(true, animated: true)
            editButton.title = "Готово" }
        else {
            tableView.setEditing(false, animated: true)
            editButton.title = "Изменить"
        }
    }
    
}
