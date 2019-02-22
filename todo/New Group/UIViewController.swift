//
//  UIViewController.swift
//  todo
//
//  Created by 中村太一 on 2019/02/09.
//  Copyright © 2019 中村太一. All rights reserved.
//

import UIKit
extension UIViewController {
    // UIViewControllerやUIViewControllerを継承するクラス下記の関数を使えるようにしている。
    func alert(_ title: String, _ message: String, _ closedHandler: (()->Void)?) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("閉じる")
            if let closedHandler = closedHandler {
                closedHandler()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
