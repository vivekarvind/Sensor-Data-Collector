//
//  SettingsVC.swift
//  Collector
//
//  Created by YED on 1.10.2016.
//  Copyright © 2016 YED. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var selectedBtn:String = ""
    
    @IBOutlet var segmentCont: UISegmentedControl!
    @IBOutlet var btnAraba: UIButton!
    @IBOutlet var btnMarmaray: UIButton!
    @IBOutlet var btnMetro: UIButton!
    @IBOutlet var btnMetrobus: UIButton!
    @IBOutlet var btnTramvay: UIButton!
    @IBOutlet var btnHafif: UIButton!
    @IBOutlet var bntOtobus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
        
    
    @IBAction func selectMode(_ sender: UIButton) {
        
        updateButtonBG()
        
        switch sender {
        case btnAraba:
            btnAraba.setBackgroundImage(UIImage(named: "Araba - Circle - S"), for: .normal)
            selectedBtn = "ARABA"
        case btnMarmaray:
            btnMarmaray.setBackgroundImage(UIImage(named: "Marmaray - Circle - S"), for: .normal)
            selectedBtn = "MARMARAY"
        case btnMetro:
            btnMetro.setBackgroundImage(UIImage(named: "Metro - Circle - S"), for: .normal)
            selectedBtn = "METRO"
        case btnMetrobus:
            btnMetrobus.setBackgroundImage(UIImage(named: "Metrobüs - Circle - S"), for: .normal)
            selectedBtn = "METROBUS"
        case btnTramvay:
            btnTramvay.setBackgroundImage(UIImage(named: "Tramvay - Circle - S"), for: .normal)
            selectedBtn = "TRAMVAY"
        case btnHafif:
            btnHafif.setBackgroundImage(UIImage(named: "Hafif_Raylı - Circle - S"), for: .normal)
            selectedBtn = "HAFIF RAYLI"
        case bntOtobus:
            bntOtobus.setBackgroundImage(UIImage(named: "Otobüs - Circle - S"), for: .normal)
            selectedBtn = "OTOBUS"
        default:
            break
        }
        
    }
    
    func updateButtonBG() {
        btnAraba.setBackgroundImage(UIImage(named: "Araba - Circle - U"), for: .normal)
        btnMarmaray.setBackgroundImage(UIImage(named: "Marmaray - Circle - U"), for: .normal)
        btnMetro.setBackgroundImage(UIImage(named: "Metro - Circle - U"), for: .normal)
        btnMetrobus.setBackgroundImage(UIImage(named: "Metrobüs - Circle - U"), for: .normal)
        btnTramvay.setBackgroundImage(UIImage(named: "Tramvay - Circle - U"), for: .normal)
        btnHafif.setBackgroundImage(UIImage(named: "Hafif_Raylı - Circle - U"), for: .normal)
        bntOtobus.setBackgroundImage(UIImage(named: "Otobüs - Circle - U"), for: .normal)
    }

    
    @IBAction func closeSettings(_ sender: AnyObject) {
        performSegue(withIdentifier: "showMain", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMain" {
            
            
            let destinationVC = segue.destination as! ViewController
            destinationVC.selectedMode = selectedBtn
            if segmentCont.selectedSegmentIndex == 0{
                destinationVC.selectedType = "sit"
                
            } else {
                destinationVC.selectedType = "stand"
                
            }
            
            
        }
    }
    

}
