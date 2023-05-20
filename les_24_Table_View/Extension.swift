//
//  Extension.swift
//  les_24_Table_View
//
//  Created by Илья Черницкий on 19.05.23.
//

import Foundation
import UIKit

extension UIView {
    static var cellIdentifier: String { String(describing: Self.self) }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViewController.row = indexPath.row
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ViewController.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier, for: indexPath)
        cell.textLabel?.text = ViewController.dataArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertVC = UIAlertController(title: "Вопрос",
                                            message: "Удалить сотрудника ?",
                                            preferredStyle: .alert)
            
            let actionHandler: (UIAlertAction) -> Void = { action in
                if action.style == .default {
                    ViewController.dataArray.remove(at: indexPath.row)
                    tableView.reloadData()
                    
                    self.saveInUserDefaults(to: ViewController.dataArray)
                    
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

