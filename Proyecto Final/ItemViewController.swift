//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Pablo Cesar Gutierrez on 15/11/15.
//  Copyright © 2015 Geek Corporation S.R.L. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldBloodType: UITextField!
    @IBOutlet weak var textViewSurgeries: UITextView!
    @IBOutlet weak var textViewDiseases: UITextView!
    
    var currentItem: NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if(currentItem != nil) {
            textFieldName.text = currentItem.valueForKey("name") as! String
            textFieldBloodType.text = currentItem.valueForKey("bloodType") as! String
            textViewSurgeries.text = currentItem.valueForKey("surgeries") as! String
            textViewDiseases.text = currentItem.valueForKey("diseases") as! String
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePress(sender: UIBarButtonItem) {
        // Reference to our app delegate
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext
        let en = NSEntityDescription.entityForName("MedicalHistory", inManagedObjectContext: contxt)
        if (currentItem != nil) {
            currentItem.setValue(textFieldName.text, forKey: "name");
            currentItem.setValue(textFieldBloodType.text, forKey: "bloodType");
            currentItem.setValue(textViewSurgeries.text, forKey: "surgeries");
            currentItem.setValue(textViewDiseases.text, forKey: "diseases");
        } else {
            let newMedicalHistory = MedicalHistory(entity:en!, insertIntoManagedObjectContext:contxt)
            newMedicalHistory.name = textFieldName.text!
            newMedicalHistory.bloodType = textFieldBloodType.text!
            newMedicalHistory.surgeries = textViewSurgeries.text!
            newMedicalHistory.diseases = textViewDiseases.text!
        }
        
        do {
            try contxt.save()
        } catch _ {
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
        // reference Moc
        // Create instance of pur data model and initialize
        // Map our properties
        // save our context
        // navigation back to root

    }
    

}