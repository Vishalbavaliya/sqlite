//
//  AppDelegate.swift
//  OurosJewels
//
//  Created by Hiren Chauhan on 13/09/22.
//

import UIKit
import SQLite3

var dbQueue: OpaquePointer!
var dbURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

var sds: OpaquePointer!
var sdsd = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dbQueue = cerateAndOpenDatabase()
        
        if (createTables() == false) {
            print("Error in Createing Table")
        } else {
            print("YAY! Table Created")
        }
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func cerateAndOpenDatabase() -> OpaquePointer? {
        
        var db: OpaquePointer?
        let url = NSURL(fileURLWithPath: dbURL)
        
        if let pathComponent = url.appendingPathComponent("TEST.sqlite") {
            let filePath = pathComponent.path
            if sqlite3_open(filePath, &db) == SQLITE_OK {
                print("Successfully opened the database :) at \(filePath)")
                return db
            } else {
                print("Could not open Database")
            }
        } else {
            print("File path is not available")
        }
        return db
    }
    
    func createTables() -> Bool {
        var bRetVal: Bool = false
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS TEMP (TEMPCOLUMN1 TEXT NULL, TEMPCOLUMN2 TEXT NULL)", nil, nil, nil)
        if(createTable != SQLITE_OK) {
            print("Not able to table create")
            bRetVal = false
        } else {
            bRetVal = true
        }
        return bRetVal
    }
    
}

//        let selectStatementString = "SELECT TEMPCOLUMN1, TEMPCOLUMN2 FROM TEMP"
//        var selectStatementQuery: OpaquePointer?
//        var sShowData: String!
//        sShowData = ""
//
//        if sqlite3_prepare_v2(dbQueue, selectStatementString, -1, &selectStatementQuery, nil) == SQLITE_DONE {
//            while sqlite3_step(selectStatementQuery) == SQLITE_ROW {
//                sShowData += String(cString: sqlite3_column_text(selectStatementQuery, 0)) + "\t\t" + String(cString:sqlite3_column_text(selectStatementQuery, 1)) + "\n"
//            }
//            sqlite3_finalize(selectStatementQuery)
//        }
