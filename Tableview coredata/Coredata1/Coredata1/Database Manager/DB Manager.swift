//
//  DB Manager.swift
//  Coredata1
//
//  Created by Mac on 02/01/25.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    init() {
        db = createAndOpen()
    }
    private func createAndOpen() -> OpaquePointer? {
        var db : OpaquePointer?
        do {
            let documentDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Student.sqlite")
            if sqlite3_open(documentDir.path, &db) == SQLITE_OK{
                print("open\(documentDir.path)")
                print("database create and open successfully...")
                return db
            }else{
                print("database allready exit")
                return db
            }
        }catch{
            print(error.localizedDescription)
        }
    return nil
    }
    
    func createUserTable(){
        var createStatement : OpaquePointer?
        let createTableQuery = "CREATE TABLE IF NOT EXISTS User(name TEXT,email TEXT,userId TEXT PRIMARY KEY,phoneNo TEXT,city TEXT,pincode Text)"
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createStatement, nil) == SQLITE_OK{
            if sqlite3_step(createStatement) == SQLITE_DONE{
                print("User table create successfully...")
            }else{
                print("unable to create user table...")
            }
        }else{
            print("unable to prepare create atble statement")
        }
    }
    typealias success = ()->()
    func insertValuesUser(user : User,successClosure:success){
        var insertStatement : OpaquePointer?
        let insertQuery = "INSERT INTO User(name,emailId,userId,phomeNO,city,pincode) VALUES(?,?,?,?,?,?)"
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK{
            
            let nameNS  = user.name as NSString
            let nameText = nameNS.utf8String
            sqlite3_bind_text(insertStatement, 1, nameText, -1, nil)
            
            let emailIdNS  = user.emailId as NSString
            let emailIdText = emailIdNS.utf8String
            sqlite3_bind_text(insertStatement, 2, emailIdText, -1, nil)
            
            let userIdNS  = user.userId as NSString
            let userIdText = userIdNS.utf8String
            sqlite3_bind_text(insertStatement, 5, userIdText, -1, nil)
            
            let phoneNONS  = user.phoneNO as NSString
            let phoneNOText = phoneNONS.utf8String
            sqlite3_bind_text(insertStatement, 3, phoneNOText, -1, nil)
            
            let cityNS  = user.city as NSString
            let cityText = cityNS.utf8String
            sqlite3_bind_text(insertStatement, 4, cityText, -1, nil)
       
            let pincodeNS  = user.pincode as NSString
            let pincodeText = pincodeNS.utf8String
            sqlite3_bind_text(insertStatement, 6, pincodeText, -1, nil)
        
          if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("user added succ.......")
          }else{
            print("unable to add")
          }
        }else{
            print("unable to prepare query!!!")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func displayUsers() -> [User]? {
        var selectStatement : OpaquePointer?
        let selectQuery = "SELECT * FROM User"
        var users = [User]()
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectStatement, nil) == SQLITE_OK{
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                
                guard let name_CStr = sqlite3_column_text(selectStatement, 0) else {
                    print("error while getting name from db!!")
                    continue
                }
                let name = String(cString: name_CStr)
                
                guard  let emailId_CStr = sqlite3_column_text(selectStatement, 1)else{
                    print("error while getting gender from db!")
                    continue
                }
                let emailId = String(cString: emailId_CStr)
                
                guard  let userId_CStr = sqlite3_column_text(selectStatement, 4)else{
                    print("error while getting userId from db!")
                    continue
                }
                let userId = String(cString: userId_CStr)
                

                guard  let phoneNO_CStr = sqlite3_column_text(selectStatement, 2)else{
                    print("error while getting address from db!")
                    continue
                }
                let phoneNO = String(cString: phoneNO_CStr)
                
                guard  let city_CStr = sqlite3_column_text(selectStatement, 3)else{
                    print("error while getting gender from db!")
                    continue
                }
                let city = String(cString: city_CStr)
                
                
                guard  let pincode_CStr = sqlite3_column_text(selectStatement, 5)else{
                    print("error while getting password from db!")
                    continue
                }
                let pincode = String(cString: pincode_CStr)
                let user = User(name: name, emailId: emailId, userId: userId, phoneNO: phoneNO, city: city, pincode: pincode)
                users.append(user)
            }
            sqlite3_finalize(selectStatement)
            return users
        }else{
            print("unable to prepare statement")
        }
        return nil
    }
    
    func searchUser(searchedText:String, userId: String) -> [User]? {
        var searchStatement: OpaquePointer?
        var user = [User]()
        let query = "SELECT * FROM USER WHERE userId = '\(userId)' AND name LIKE '\(searchedText)%'"
        
        if sqlite3_prepare_v2(db, query, -1, &searchStatement, nil) == SQLITE_OK{
            while sqlite3_step(searchStatement) == SQLITE_ROW {
                
                guard let name_CStr = sqlite3_column_text(searchStatement, 0) else {
                    print("error while getting name from db!!")
                    continue
                }
                let name = String(cString: name_CStr)
                guard  let emailId_CStr = sqlite3_column_text(searchStatement, 1)else{
                    print("error while getting address from db!")
                    continue
                }
                let emailId = String(cString: emailId_CStr)
               
                guard  let userId_CStr = sqlite3_column_text(searchStatement, 11)else{
                    print("error while getting userId from db!")
                    continue
                }
                let userId = String(cString: userId_CStr)
                
                guard  let city_CStr = sqlite3_column_text(searchStatement, 2)else{
                    print("error while getting gender from db!")
                    continue
                }
                let city = String(cString: city_CStr)
                
                guard  let phoneNO_CStr = sqlite3_column_text(searchStatement, 3)else{
                    print("error while getting contact from db!")
                    continue
                }
                let phoneNO = String(cString: phoneNO_CStr)
                
                guard  let pincode_CStr = sqlite3_column_text(searchStatement, 4)else{
                    print("error while getting email from db!")
                    continue
                }
                let pincode = String(cString: pincode_CStr)
        
                let User = User(name: name, emailId: emailId, userId: userId, phoneNO: phoneNO, city: city, pincode: pincode )
                user.append(User)
            }
            sqlite3_finalize(searchStatement)
            return user
        }else{
            print("unable to prepare statement")
        }
        return nil
    }
}

    
