//
//  MailVC.swift
//  Collector
//
//  Created by YED on 3.10.2016.
//  Copyright © 2016 YED. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class MailVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet var lblCount: UILabel!
    var selectedMode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateLabel()
        
        
        
    }
    
    
    func updateLabel() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SensorData")
        fetchRequest.predicate = NSPredicate(format: "mode = %@", selectedMode)
        
        do {
            let fetchEntities = try self.context.fetch(fetchRequest)
            
            lblCount.text = "\(fetchEntities.count)"
            
            
        } catch let error as NSError {
            self.createAlert(title: "Hata", message: error.description)
        }
        
    }
    
    
    
    
    @IBAction func mail(_ sender: AnyObject) {
        
        let str = createCsvString()
        
        let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let emailViewController = configuredMailComposeViewController(data: data! as NSData)
        if MFMailComposeViewController.canSendMail() {
            self.present(emailViewController, animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func deleteData(_ sender: AnyObject) {
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SensorData")
        fetchRequest.predicate = NSPredicate(format: "mode = %@", selectedMode)
        
        do {
            let fetchEntities = try self.context.fetch(fetchRequest)
            
            for entity in fetchEntities {
                self.context.delete(entity as! NSManagedObject)
            }
            
            //try coord.executeRequest(deleteRequest, withContext: context)
            try context.save()
            context.reset()
            updateLabel()
            
            self.createAlert(title: "Başarılı", message: "Bilgiler Silindi")
        } catch let error as NSError {
            debugPrint(error)
            self.createAlert(title: "Hata", message: "Bilgiler Silinemedi")
        }
        
    }
    
    
    func createCsvString() -> String {
        
        var ax: Float?
        var ay: Float?
        var az: Float?
        var gx: Float?
        var gy: Float?
        var gz: Float?
        var mode: String?
        var type: String?
        
        var exportString = NSLocalizedString("ax, ay, az, gx, gy, gz, mode, type\n", comment: "")
        
        
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SensorData")
        fetchRequest.predicate = NSPredicate(format: "mode = %@", selectedMode)
        let fetchSort = NSSortDescriptor(key: "mode", ascending: true)
        fetchRequest.sortDescriptors = [fetchSort]
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                
                ax = result.value(forKey: "ax") as? Float
                ay = result.value(forKey: "ay") as? Float
                az = result.value(forKey: "az") as? Float
                gx = result.value(forKey: "gx") as? Float
                gy = result.value(forKey: "gy") as? Float
                gz = result.value(forKey: "gz") as? Float
                mode = result.value(forKey: "mode") as? String
                type = result.value(forKey: "type") as? String
                
                exportString += "\(ax!), \(ay!), \(az!), \(gx!), \(gy!), \(gz!), \(mode!), \(type!)\n"
                
            }
            
        } catch {
            print(error)
        }
        
        return exportString
        
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController(data: NSData) -> MFMailComposeViewController {
        let emailController = MFMailComposeViewController()
        emailController.mailComposeDelegate = self
        emailController.setSubject("CSV File")
        emailController.setMessageBody("", isHTML: false)
        
        // Attaching the .CSV file to the email.
        emailController.addAttachmentData(data as Data, mimeType: "text/csv", fileName: "Sample.csv")
        
        return emailController
    }
    
    
    func createAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
        
        
    }
   
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
