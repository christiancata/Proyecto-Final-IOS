//
//  MedicalHistory.swift
//  Proyecto Final
//
//  Created by Pablo Cesar Gutierrez on 15/11/15.
//  Copyright © 2015 Geek Corporation S.R.L. All rights reserved.
//

import UIKit
import CoreData
@objc (MedicalHistory)


class MedicalHistory: NSManagedObject {
    @NSManaged var name:String
    @NSManaged var bloodType:String
    @NSManaged var allergies:String
    @NSManaged var diseases:String
}