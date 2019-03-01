//
//  AddViewController.swift
//  todo
//
//  Created by 中村太一 on 2018/09/22.
//  Copyright © 2018年 中村太一. All rights reserved.
//

import UIKit
import GoogleMaps

class TaskViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let taskService = TaskService.shared

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var mapCanvasView: UIView!
    
    let defaultLatitude = 35.6675497
    let defaultLongitude = 139.7137988
    let defaultZoomLevel:Float = 14.0
    let locationManager = CLLocationManager()
    
    var mapView: GMSMapView!
    let marker = GMSMarker();
    
    var lat:Double = 0
    var lng:Double = 0
    
    
    var selectedTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lat = defaultLatitude
        lng = defaultLongitude

        if let selectedTask = self.selectedTask {
            self.title = "編集"
            self.titleTextField.text = selectedTask.title
            self.noteTextView.text = selectedTask.note
            lat = selectedTask.latitude
            lng = selectedTask.longitude
            
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: defaultZoomLevel)
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: mapCanvasView.frame.height)
        
        self.mapView = GMSMapView.map(withFrame: frame, camera: camera)
        self.mapView.isMyLocationEnabled = true;
        self.mapView.settings.myLocationButton = true;
        self.mapView.delegate = self

        self.locationManager.activityType = .other
        // 精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 更新イベントの生成に必要な、水平方向の最小移動距離（メートル単位）
        self.locationManager.distanceFilter = 50
        // 開始
        self.locationManager.startUpdatingLocation()
        // delegate
        self.locationManager.delegate = self
        
        
        mapCanvasView.addSubview(mapView)
        
        
        marker.position.latitude = lat
        marker.position.longitude = lng
        marker.map = mapView
//        mapView.animate(toLocation: marker.position)
        
        // これで位置情報の取得が始まる
        //self.locationManager.startUpdatingLocation()
        
        // これで位置情報の取得が止まる。deinitで呼ぶなど。
        //self.locationManager.stopUpdatingLocation()
        
    }
    
    // マーカー以外をクリックしたら。
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.marker.position = coordinate
//        mapView.animate(toLocation: coordinate)
    }
    
    // 位置が変化したら呼び出される。CLLocationManagerDelegateプロトコル
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print("緯度:\(location.coordinate.latitude) 経度:\(location.coordinate.longitude) 取得時刻:\(location.timestamp.description)")
        }
    }
    
    @IBAction func didTouchSaveButton(_ sender: Any) {
        guard let title = titleTextField.text else {
            return
        }
        
        let coordinate = marker.position
        
        
        if (title.isEmpty) {
            showAlert("タイトルを入力して下さい。")
            return
        }

        if let selectedTask = self.selectedTask {
            selectedTask.title = title
            selectedTask.note = noteTextView.text
            selectedTask.latitude = coordinate.latitude
            selectedTask.longitude = coordinate.longitude
            taskService.editTask()
        } else {
            let task = Task()
            task.title = title
            task.note = noteTextView.text
            task.latitude = coordinate.latitude
            task.longitude = coordinate.longitude
            taskService.addTask(task)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    deinit {
        print ("TaskViewControllerが削除されたよ")
    }
}
