//
//  ViewController.swift
//  OurosJewels
//
//  Created by Hiren Chauhan on 13/09/22.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var sarNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func saveButton(_ sender: Any) {
        let insertStatementString = "INSERT INTO TEMP (TEMPCOLUMN1, TEMPCOLUMN2) VALUES (?, ?);"
        var insertStatementQuery : OpaquePointer?
        if(sqlite3_prepare_v2(dbQueue, insertStatementString, -1, &insertStatementQuery, nil)) == SQLITE_OK {
            sqlite3_bind_text(insertStatementQuery, 1, nameTF.text ?? "", -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatementQuery, 2, sarNameTF.text ?? "", -1, SQLITE_TRANSIENT)
            
            if(sqlite3_step(insertStatementQuery)) == SQLITE_DONE {
                
                nameTF.text = ""
                sarNameTF.text = ""
                
                nameTF.becomeFirstResponder()
                print("Successfully inserted the Record")
            } else {
                print("Error")
            }
            sqlite3_finalize(insertStatementQuery)
        }
    }
    
    @IBAction func updateButton(_ sender: Any) {
        let updateStatementString = "UPDATE TEMP SET TEMPCOLUMN2 = '\(sarNameTF.text!)' WHERE TEMPCOLUMN1 = '\(nameTF.text!)';"
        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(dbQueue, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {

            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("\nSuccessfully updated row.")
            } else {
                print("\nCould not update row.")
            }
        } else {
            print("\nUPDATE statement is not prepared")
        }
        sqlite3_finalize(updateStatement)
    }
}


