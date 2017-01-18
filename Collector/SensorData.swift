//
//  SensorData.swift
//  Collector
//
//  Created by YED on 3.10.2016.
//  Copyright © 2016 YED. All rights reserved.
//

import UIKit
import CoreData

class SensorData: NSManagedObject {
    
    @NSManaged var ax: Float
    @NSManaged var ay: Float
    @NSManaged var az: Float
    @NSManaged var gx: Float
    @NSManaged var gy: Float
    @NSManaged var gz: Float
    @NSManaged var mode: String
    @NSManaged var type: String
    

}
