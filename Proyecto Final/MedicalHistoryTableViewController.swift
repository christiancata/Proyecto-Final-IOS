//
//  MedicalHistoryTableViewController.swift
//  Proyecto Final
//
//  Created by Christian Cata on 15/11/15.
//  Copyright © 2015 Geek Corporation S.R.L. All rights reserved.
//

import UIKit
import CoreData

class MedicalHistoryTableViewController: UITableViewController {
    
    var myList:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let freq = NSFetchRequest (entityName: "MedicalHistory")
        
        myList = try! context.executeFetchRequest(freq)
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "update") {
            var seletedIndex = self.tableView.indexPathForSelectedRow?.row
            var selectedItem: NSManagedObject = myList[seletedIndex!] as! NSManagedObject
            let desti = segue.destinationViewController as! ItemViewController
            desti.currentItem = selectedItem
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID: NSString = "TableCell"
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as UITableViewCell!
        //cell.textLabel!.text = "test"
        
        var data:NSManagedObject = myList[indexPath.row] as! NSManagedObject
        cell.textLabel?.text = data.valueForKey("name") as? String
        cell.detailTextLabel?.text = data.valueForKey("bloodType") as? String
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var deletedItem:NSManagedObject = myList[indexPath.row] as! NSManagedObject
            contxt.deleteObject(deletedItem)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
        do {
            try contxt.save()
        } catch _ {
        };
    }

}