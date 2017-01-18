//
//  ViewController.swift
//  Collector
//
//  Created by YED on 26.09.2016.
//  Copyright © 2016 YED. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox
import CoreData

class ViewController: UIViewController {
    
    var isPlaying: Bool = false
    var selectedMode:String = ""
    var selectedType: String = ""
    var counterForThree = 0
    var counterForTenMin = 0
    
    var timer = Timer()
    var timer2 = Timer()
    let motionManager = CMMotionManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var lblMode: UILabel!
    
    @IBOutlet var btnAction: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lblMode.text = selectedMode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblMode.text = selectedMode
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lblMode.text = selectedMode
    }

    
    
    func countToThree() {
        counterForThree = counterForThree + 1
        print(counterForThree)
        if counterForThree == 4 {
            
            timer.invalidate()
            counterForThree = 0
            btnAction.setBackgroundImage(UIImage(named: "Stop"), for: .normal)
            startCollectingData()
        }
    }
    
    func countToTenMin() {
        
        counterForTenMin = counterForTenMin + 1
        
        if counterForTenMin == 610 {
            stopCollectingData()
            counterForTenMin = 0
            btnAction.setBackgroundImage(UIImage(named: "Play"), for: .normal)
            isPlaying = false
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        
    }
    
    
    @IBAction func play(_ sender: AnyObject) {
        
        if selectedMode != "" {
            if isPlaying {
                
                isPlaying = false
                sender.setBackgroundImage(UIImage(named: "Play"), for: .normal)
                stopCollectingData()
                
            } else {
                
                isPlaying = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countToThree), userInfo: nil, repeats: true)
                
                
            }
  
        } else {
            createAlert(title: "Uyarı", message: "Lütfen bir ulaşım türü seçiniz.")
        }
        
    }
    
    
    
    
    
    
    
    func startCollectingData() {
        
        timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.countToTenMin), userInfo: nil, repeats: true)
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (data, error) in
                
                if error != nil {
                    self.createAlert(title: "Error", message: "Sensor Error")
                } else {
                   
                    
                    let newdata = NSEntityDescription.insertNewObject(forEntityName: "SensorData", into: self.context)
                    
                    newdata.setValue((data?.userAcceleration.x)!, forKey: "ax")
                    newdata.setValue(data?.userAcceleration.y, forKey: "ay")
                    newdata.setValue(data?.userAcceleration.z, forKey: "az")
                    
                    newdata.setValue(data?.rotationRate.x, forKey: "gx")
                    newdata.setValue(data?.rotationRate.y, forKey: "gy")
                    newdata.setValue(data?.rotationRate.z, forKey: "gz")
                    
                    newdata.setValue(self.selectedMode, forKey: "mode")
                    newdata.setValue(self.selectedType, forKey: "type")
                    
                }
                
                
                
            })
        }

    }
    
    
    
    func stopCollectingData() {
        
        motionManager.stopDeviceMotionUpdates()
        timer2.invalidate()
        
    }
    
    
    
    
    func createAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
        
        
    }


}
