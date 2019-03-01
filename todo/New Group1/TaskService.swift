//
//  TaskService.swift
//  todo
//
//  Created by 中村太一 on 2018/09/22.
//  Copyright © 2018年 中村太一. All rights reserved.
//

import Foundation

// Delegate セーブしたら〇〇するの〇〇の部分を他のクラスに任せる（delegate:委譲）
protocol TaskServiceDelegate:class {
    func saved()
    func loaded()
}

class TaskService {
    static var shared = TaskService()
    // 保存する場所をどこにするのかはこのファイル内からは分離している
    // 設定で何を使うかを指定出来るようにするとなお良い。
//    private var taskRepository: TaskRepositoryProtocol = UserDefaultsTaskRepository()
    private var taskRepository: TaskRepositoryProtocol = FirestoreTaskRepository()
    
    let userDefaults = UserDefaults.standard
    private var tasks: [Task] = []
    
    weak var delegate: TaskServiceDelegate?
    
    private init() {
        self.load()
    }
    
    func getTask (at: Int) -> Task{
        return tasks[at]
    }
    
    func taskCount () -> Int{
        return tasks.count
    }
    
    // タスクの追加
    func addTask (_ task: Task) {
        tasks.append(task)
        self.save()
    }
    
    // タスクの削除
    func removeTask (at: Int) {
        tasks.remove(at: at)
        self.save()
    }
    
    func editTask () {
        self.save()
    }
    
    func save () {
        taskRepository.save(tasks) {
            print ("☀️保存しました！")
            // デリゲートを使ってフックを作っている。保存したら実行
            self.delegate?.saved()
        }
    }
    
    func load() {
        taskRepository.load(completion: { (tasks) in
            self.tasks = tasks
            // デリゲートでフック。読み出したら実行
            self.delegate?.loaded()
        })
    }
    
    func clear () {
        tasks = []
    }
}
