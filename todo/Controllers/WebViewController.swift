//
//  WebViewController.swift
//  todo
//
//  Created by 中村太一 on 2019/02/09.
//  Copyright © 2019 中村太一. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myURL = URL(string: "https://www.google.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    

    @IBAction func didTouchCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
