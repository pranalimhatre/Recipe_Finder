//
//  SQLDataIO.swift
//  Test2
//
//  Created by Bansari_19473 on 4/1/17.
//  Copyright © 2017 Pranali_19462. All rights reserved.
//

import UIKit


struct Category {
    var categoryId: Int!
    var categoryName: String!
    
    init(categoryId: Int, categoryName: String) {
        self.categoryId = categoryId
        self.categoryName = categoryName        }
}

struct RecipeDetails {
    var recipeId: Int!
    var recipeName: String!
    var recipeImage: String!
    var recipeTime: Double!
    
    init(recipeId: Int, recipeName: String, recipeTime: Double, recipeImage: String) {
        self.recipeId = recipeId
        self.recipeName = recipeName
        self.recipeImage = recipeImage
        self.recipeTime = recipeTime
    }
}

struct RecipeReminderDetails {
    var recipeId: Int!
    var recipeName: String!
    var recipeReminderMsg: String!
    var recipePrepTime: Double!
    
    init(recipeId: Int, recipeName: String, recipePrepTime: Double, recipeReminderMsg: String) {
        self.recipeId = recipeId
        self.recipeName = recipeName
        self.recipePrepTime = recipePrepTime
        self.recipeReminderMsg = recipeReminderMsg
    }
}

struct RecipeDetailsPage {
    var recipeId: Int!
    var recipeName: String!
    var recipeInstruction: String!
    var recipeTime: Double!
    var recipeImage: String!
    
    init(recipeId: Int, recipeName: String, recipeTime: Double, recipeInstruction: String, recipeImage: String) {
        self.recipeId = recipeId
        self.recipeName = recipeName
        self.recipeTime = recipeTime
        self.recipeInstruction = recipeInstruction
        self.recipeImage = recipeImage
    }
}

struct IngredientListRecipeDetailsPage {
    var ingredientId: Int!
    var ingredientMeasurement: String!
    var ingredientName: String!
    
    init(ingredientId: Int, ingredientMeasurement: String, ingredientName: String){
        self.ingredientId = ingredientId
        self.ingredientMeasurement = ingredientMeasurement
        self.ingredientName = ingredientName
    }
}

class SQLDataIO: NSObject {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let DBURL = DocumentsDirectory.appendingPathComponent("dailyMealAppDB.sqlite")
    
    static var itemsString: [String] = []
    static var itemsInt: [Int] = []
    
    static func getRecipeReminderDetails() -> [RecipeReminderDetails]{
        
        itemsString = []
        
        var recipeReminderDetailArray = [RecipeReminderDetails]()
        
        let SQL = "SELECT RecipeId, RecipeName, RecipeIReminderMsg, RecipePrepTime FROM Recipe"
        var databaseRows: [[String]] = [[]]
        databaseRows = getRows(SQL, numColumns: 4)
        
        for i in 0..<databaseRows.count
        {
            var row: [String] = databaseRows[i]
            
            if row.count > 0
            {
                recipeReminderDetailArray += [
                    RecipeReminderDetails(recipeId: Int(row[0])!, recipeName: row[1], recipePrepTime: Double(row[3])!, recipeReminderMsg: row[2])]
            }
        }
        
        
        printRowsString(databaseRows)
        return recipeReminderDetailArray
    }
    
    static func getIngredientListRecipeDetailPage(Index: Int) -> [IngredientListRecipeDetailsPage]{
        
        itemsString = []
        
        var ingredientListRecipeDetailsPageArray = [IngredientListRecipeDetailsPage]()
        
        let SQL = "SELECT IngredientRecipeTrans.IngredientId, IngredientMeasurement, IngredientName FROM IngredientRecipeTrans left join Ingredient on ingredient.IngredientId = IngredientRecipeTrans.IngredientId WHERE RecipeId = \(Index)"
        var databaseRows: [[String]] = [[]]
        databaseRows = getRows(SQL, numColumns: 3)
        
        for i in 0..<databaseRows.count
        {
            var row: [String] = databaseRows[i]
            
            if row.count > 0
            {
                ingredientListRecipeDetailsPageArray += [
                    IngredientListRecipeDetailsPage(ingredientId: Int(row[0])!, ingredientMeasurement: row[1], ingredientName: row[2])]
            }
        }
        
        
        //printRowsStringWithoutSpace(databaseRows)
        return ingredientListRecipeDetailsPageArray
    }
    
    static func getRecipeDetailPage(index: Int) -> [RecipeDetailsPage]{
        
        itemsString = []
        
        var recipeDetailsPageArray = [RecipeDetailsPage]()
        
        let SQL = "SELECT RecipeId, RecipeName, RecipeInstruction, RecipeTime, RecipePhoto FROM Recipe WHERE RecipeId = \(index)"
        var databaseRows: [[String]] = [[]]
        databaseRows = getRows(SQL, numColumns: 5)
        
        for i in 0..<databaseRows.count
        {
            var row: [String] = databaseRows[i]
            
            if row.count > 0
            {
                recipeDetailsPageArray += [
                    RecipeDetailsPage(recipeId: Int(row[0])!, recipeName: row[1], recipeTime: Double(row[3])!, recipeInstruction: row[2], recipeImage: row[4])]
            }
        }
        
        
        printRowsStringWithoutSpace(databaseRows)
        return recipeDetailsPageArray
    }

    
    static func fetchIngredientCategory() -> [Category]{
        
        itemsString = []
        
        var categoryArray = [Category]()
        
        let SQL = "SELECT * FROM Category"
        var databaseRows: [[String]] = [[]]
        databaseRows = getRows(SQL, numColumns: 2)
        
        for i in 0..<databaseRows.count
        {
            var row: [String] = databaseRows[i]
            
            if row.count > 0
            {
                categoryArray += [
                    Category(categoryId: Int(row[0])!, categoryName: row[1])]
                
            }
        }
        
        
        printRowsString(databaseRows)
        return categoryArray
    }
    
    static func fetchRecipeDetails(ingredientList: String) -> [RecipeDetails]{
        
        itemsString = []
        
        var recipeListArray = [RecipeDetails]()
        
        let SQL = "SELECT RecipeId, RecipeName, RecipePhoto, RecipeTime FROM Recipe where recipeId in (select recipeId from IngredientRecipeTrans where ingredientId in ("+ingredientList+"))"
        var databaseRows: [[String]] = [[]]
        databaseRows = getRows(SQL, numColumns: 4)
        
        for i in 0..<databaseRows.count
        {
            var row: [String] = databaseRows[i]
            
            if row.count > 0
            {
                recipeListArray += [
                    RecipeDetails(recipeId: Int(row[0])!, recipeName: row[1], recipeTime: Double(row[3])!, recipeImage: row[2])]
            }        }
        
        
        printRowsString(databaseRows)
        return recipeListArray
    }
    
    static func getIngredientName(index:Int) -> [String]
    {
        itemsString = []
        var dbCommand: String = ""
        
        var databaseRows: [[String]] = [[]]
        
        dbCommand = "select ingredientName from Ingredient WHERE categoryId = \(index)"
        
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil)
        
        while sqlite3_step(getStatement) == SQLITE_ROW{
            sqlite3_column_text(getStatement, 0)
        }
        
        databaseRows = getIngredientDB(dbCommand, numColumns: 1)
        printRowsString(databaseRows)
        
        return itemsString
    }
    
    static func getIngredientId(index:Int) -> [String]
    {
        itemsString = []
        
        var dbCommand: String = ""
        
        var databaseRows: [[String]] = [[]]
        
        dbCommand = "select ingredientId from Ingredient WHERE categoryId = \(index)"
        
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil)
        
        while sqlite3_step(getStatement) == SQLITE_ROW{
            sqlite3_column_text(getStatement, 0)
        }
        
        databaseRows = getIngredientIdDB(dbCommand, numColumns: 1)
        printRowsString(databaseRows)
        
        return itemsString
    }
    
    static func getIngredientImage(index:Int) -> [String]
    {
        itemsString = []
        
        var dbCommand: String = ""
        
        var databaseRows: [[String]] = [[]]
        
        dbCommand = "select ingredientImage from Ingredient WHERE categoryId = \(index)"
        
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil)
        
        while sqlite3_step(getStatement) == SQLITE_ROW{
            sqlite3_column_text(getStatement, 0)
        }
        
        databaseRows = getIngredientIdDB(dbCommand, numColumns: 1)
        printRowsStringWithoutSpace(databaseRows)
        
        return itemsString
    }
    
    
    
    //MARK: Print Rows
    
    static func printRowsString(_ rows: [[String]])
    {
        for i in 0..<rows.count
        {
            var rowValue = "";
            
            var row: [String] = rows[i]
            
            for j in 0..<row.count
            {
                rowValue += String(format: " %@", row[j])
            }
            
            if (rowValue != "")
            {
                itemsString.append(rowValue)
            }
        }
        
    }
    
    static func printRowsStringWithoutSpace(_ rows: [[String]])
    {
        for i in 0..<rows.count
        {
            var rowValue = "";
            
            var row: [String] = rows[i]
            
            for j in 0..<row.count
            {
                rowValue += String(format: "%@", row[j])
            }
            
            if (rowValue != "")
            {
                itemsString.append(rowValue)
            }
        }
        
    }
    
    static func printRowsInt(_ rows: [[Int]])
    {
        for i in 0..<rows.count
        {
            var rowValue:Int = 0;
            
            var row: [Int] = rows[i]
            
            for j in 0..<row.count
            {
                rowValue += row[j]
            }
            
            if (rowValue != 0)
            {
                itemsInt.append(rowValue)
            }
        }
        
    }
    
    
    //MARK:  Open Database
    
    static func openDatabase() -> OpaquePointer {
        var db: OpaquePointer? = nil
        //if sqlite3_open(DBURL.absoluteString, &db) == SQLITE_OK {
        //do nothing
        if sqlite3_open("/Users/pranali/Downloads/Database/dailyMealAppDB.sqlite", &db) == SQLITE_OK{
       // if sqlite3_open("/Users/bansari_19473/Downloads/Database/dailyMealAppDB.sqlite", &db) == SQLITE_OK{
        } else {
            print("Unable to open database. ")
        }
        return db!
    }
    
    
    /*static func insertDatabase(_ dbCommand: String){
     var statement:OpaquePointer? = nil
     let db: OpaquePointer = SQLDataIO.openDatabase()
     var errMsg:UnsafeMutablePointer<Int8>? = nil
     var result = sqlite3_exec(db, dbCommand, nil, nil, &errMsg)
     }*/
    
    //MARK:  Update Database
    
    static func updateDatabase(_ dbCommand: String)
    {
        var updateStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                //do nothing
            } else {
                print("Could not updateDatabase")
            }
        } else {
            print("updateDatabase dbCommand could not be prepared")
        }
        
        sqlite3_finalize(updateStatement)
        
        sqlite3_close(db)
        
    }
    
    //MARK:  Get DBValue
    
    static func dbValue(_ dbCommand: String) -> String
    {
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        var value: String? = nil
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil) == SQLITE_OK {
            if sqlite3_step(getStatement) == SQLITE_ROW {
                
                let getResultCol = sqlite3_column_text(getStatement, 0)
                value = String(cString: UnsafePointer(getResultCol!))
            }
            
        } else {
            print("dbValue statement could not be prepared")
        }
        
        sqlite3_finalize(getStatement)
        
        sqlite3_close(db)
        
        if (value == nil)
        {
            value = ""
        }
        
        return value!
    }
    
    
    
    //MARK: Get Next ID
    
    static func nextID(_ tableName: String!) -> Int
    {
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        let dbCommand = String(format: "select ID from %@ order by ID desc limit 1", tableName)
        
        var value: Int32? = 0
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil) == SQLITE_OK {
            if sqlite3_step(getStatement) == SQLITE_ROW {
                
                value = sqlite3_column_int(getStatement, 0)
            }
            
        } else {
            print("dbValue statement could not be prepared")
        }
        
        sqlite3_finalize(getStatement)
        
        sqlite3_close(db)
        
        var id: Int = 1
        if (value != nil)
        {
            id = Int(value!) + 1
        }
        
        return id
    }
    
    
    //MARK: Get DB Int
    
    static func dbInt(_ dbCommand: String!) -> Int
    {
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        var value: Int32? = 0
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil) == SQLITE_OK {
            if sqlite3_step(getStatement) == SQLITE_ROW {
                
                value = sqlite3_column_int(getStatement, 0)
            }
            
        } else {
            print("dbValue statement could not be prepared")
        }
        
        sqlite3_finalize(getStatement)
        
        sqlite3_close(db)
        
        var int: Int = 1
        if (value != nil)
        {
            int = Int(value!)
        }
        
        
        return int
    }
    
    
    //MARK:  Get Rows
    
    static func getRows(_ dbCommand: String, numColumns: Int) -> [[String]]
    {
        var outputArray: [[String]] = [[]]
        
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil) == SQLITE_OK {
            while sqlite3_step(getStatement) == SQLITE_ROW {
                
                var rowArray: [String] = []
                
                for i in  0..<numColumns
                {
                    let val = sqlite3_column_text(getStatement, Int32(i))
                    let valStr = String(cString: UnsafePointer(val!))
                    rowArray.append(valStr)
                    //print("col: \(i) | value:\(valStr)")
                }
                
                outputArray.append(rowArray)
                
            }
            
        } else {
            print("getRows statement could not be prepared")
        }
        
        sqlite3_finalize(getStatement)
        
        sqlite3_close(db)
        
        return outputArray
    }
    
    
    static func getIngredientDB(_ dbCommand: String, numColumns: Int) -> [[String]]
    {
        var outputArray: [[String]] = [[]]
        
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil) == SQLITE_OK {
            while sqlite3_step(getStatement) == SQLITE_ROW {
                
                var rowArray: [String] = []
                
                for i in  0..<numColumns
                {
                    let val = sqlite3_column_text(getStatement, Int32(i))
                    let valStr = String(cString: UnsafePointer(val!))
                    rowArray.append(valStr)
                    //print("col: \(i) | value:\(valStr)")
                }
                
                outputArray.append(rowArray)
                
            }
            
        } else {
            print("getRows statement could not be prepared")
        }
        
        sqlite3_finalize(getStatement)
        
        sqlite3_close(db)
        
        return outputArray
    }
    
    
    static func getIngredientIdDB(_ dbCommand: String, numColumns: Int) -> [[String]]
    {
        var outputArray: [[String]] = [[]]
        
        var getStatement: OpaquePointer? = nil
        
        let db: OpaquePointer = SQLDataIO.openDatabase()
        
        if sqlite3_prepare_v2(db, dbCommand, -1, &getStatement, nil) == SQLITE_OK {
            while sqlite3_step(getStatement) == SQLITE_ROW {
                
                var rowArray: [String] = []
                
                for i in  0..<numColumns
                {
                    let val = sqlite3_column_text(getStatement, Int32(i))
                    let valStr = String(cString: UnsafePointer(val!))
                    rowArray.append(valStr)
                    //print("col: \(i) | value:\(valStr)")
                }
                
                outputArray.append(rowArray)
                
            }
            
        } else {
            print("getRows statement could not be prepared")
        }
        
        sqlite3_finalize(getStatement)
        
        sqlite3_close(db)
        
        return outputArray
    }
    
    
    
    
}
