//
//  TaskListTableViewController.swift
//  todo
//
//  Created by 中村太一 on 2018/09/22.
//  Copyright © 2018年 中村太一. All rights reserved.
//

import UIKit
import PKHUD

class TaskListTableViewController: UITableViewController, TaskServiceDelegate {
    
    let taskService = TaskService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        taskService.delegate = self
        
        // くるくるまわるやつ。UIActivityIndicatorViewってのがデフォルトであるけれど見た目も使い勝手もイマイチなので。
        HUD.show(.progress)
        taskService.load()
    }
    
    // TaskServiceDelegateのデリゲート関数。セーブしたら〇〇する。
    func saved() {
        print ("saved")
        // セーブしたらテーブルを更新している
        self.tableView.reloadData()
    }
    
    func loaded() {
        self.tableView.reloadData()
        HUD.hide()
    }

    
    @IBAction func didTouchAddButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showToAddViewController", sender: nil)
    }
    
    // ログアウト
    @IBAction func didTouchLogoutButton(_ sender: Any) {
        User.shared.logout()
        taskService.clear()
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //rootViewControllerに入れる
        appDelegate.window?.rootViewController = initialViewController
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // セクションの数を返している
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 行数を返している。行数はタスクの数。
        return taskService.taskCount()
    }

    // 〇セクション△行目に描画するセルを作っている
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = taskService.getTask(at: indexPath.row).title
        return cell
    }

    // セルをタップしたら。
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let taskViewController = storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        taskViewController.selectedTask = taskService.getTask(at: indexPath.row)
        self.navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    // スワイプで削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        taskService.removeTask(at: indexPath.row)
    }

}
