//
//  JSON-Parsing-Achievements-Solution.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = NSBundle.mainBundle().pathForResource("achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = NSData(contentsOfFile: pathForAchievementsJSON!)

/* Error object */
var parsingAchivementsError: NSError? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAchievementsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    // Set initial variables to store the achievement count and sum
    var numAchievements = 0
    var sumAchievements: Double = 0.0
    
    // Create array to hold the categoryIds for "Matchmaking" categories
    var matchMakingIds: [Int] = []
    
    // Create dictionary to store the counts for "Matchmaking" categories
    var categoryCounts: [Int: Int] = [:]
    
    
    // Get top level categories
    guard let arrayOfCategoryDictionaries = parsedAchievementsJSON["categories"] as? [[String:AnyObject]] else {
        print("Cannot find key 'categories' in \(parsedAchievementsJSON)")
        return
    }
    
    // Store all "Matchmaking" categories
    for categoryDictionary in arrayOfCategoryDictionaries {
        
        if let title = categoryDictionary["title"] as? String where title == "Matchmaking" {
            
            guard let children = categoryDictionary["children"] as? [NSDictionary] else {
                print("Cannot find key 'children' in \(categoryDictionary)")
                return
            }
            
            for child in children {
                
                guard let categoryId = child["categoryId"] as? Int else {
                    print("Cannot find key 'categoryId' in \(child)")
                    return
                }
                
                matchMakingIds.append(categoryId)
            }
        }
    }
    
    // Get top level achievements
    guard let arrayOfAchievmentsDictionaries = parsedAchievementsJSON["achievements"] as? [[String:AnyObject]] else {
        print("Cannot find key 'achievements' in \(parsedAchievementsJSON)")
        return
    }
    
//    print(parsedAchievementsJSON)
    
    for achievementDictionary in arrayOfAchievmentsDictionaries {
        
        // Find achievement points in the data
        guard let achievementPoints = achievementDictionary["points"] as? Int else {
            print("Cannot find key 'points' in \(achievementDictionary)")
            return
        }
        
        // Count total number of achievements and sum of total points
        numAchievements++
        sumAchievements += Double(achievementPoints)
        
        // Count the number of achievements with a point value of more than 10
        if achievementPoints > 10 {
            print("We got one!")
        }
        
        // Access the "Cool Running" achievement's description and see how to achieve it in the game
        if let titleText = achievementDictionary["title"] as? String where titleText.rangeOfString("Cool Running") != nil {
            print("Here is what you must do to achieve the 'Cool Running' achievement: \(achievementDictionary["description"]!)")
        }
        
        // Add to category counts
        guard let categoryId = achievementDictionary["categoryId"] as? Int else {
            print("Cannot find key 'categoryId' in \(achievementDictionary)")
            return
        }
        
        // If the category doesn't have a key in the dictionary, set it to 0
        if categoryCounts[categoryId] == nil {
            categoryCounts[categoryId] = 0
        }
        
        // Count the number of matchmaking a
        if let currentCount = categoryCounts[categoryId] {
            categoryCounts[categoryId] = currentCount + 1
        }
        
        
    }
    
    var matchmakingAchievementCount = 0
    
    // Count the number of "Matchmaking" achievements
    for matchmakingId in matchMakingIds {
        if let categoryCount = categoryCounts[matchmakingId] {
            matchmakingAchievementCount += categoryCount
        }
    }
    
    // Print the result
    print("\(matchmakingAchievementCount) achievements belong to the \"Matchmaking\" category")
    
    let averageOfAchievements = sumAchievements / Double(numAchievements)
    print(averageOfAchievements)
    print(arrayOfAchievmentsDictionaries[44]["points"]!)
    
    
}

parseJSONAsDictionary(parsedAchievementsJSON)
