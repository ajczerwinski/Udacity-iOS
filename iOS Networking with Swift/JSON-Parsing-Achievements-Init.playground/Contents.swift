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
    
    var numAchievements = 0
    var sumAchievements: Double = 0.0
    
    guard let arrayOfCategoryDictionaries = parsedAchievementsJSON["categories"] as? [[String:AnyObject]] else {
        print("Cannot find key 'categories' in \(parsedAchievementsJSON)")
        return
    }
    
    for categoryDictionary in arrayOfCategoryDictionaries {
        guard let matchmakingCategory = categoryDictionary["matchmaking"] as? String else {
            print("not working")
            return
        }
    }
    
    guard let arrayOfAchievmentsDictionaries = parsedAchievementsJSON["achievements"] as? [[String:AnyObject]] else {
        print("Cannot find key 'achievements' in \(parsedAchievementsJSON)")
        return
    }
    
    print(parsedAchievementsJSON)
    for achievementDictionary in arrayOfAchievmentsDictionaries {
        guard let achievementPoints = achievementDictionary["points"] as? Int else {
            print("Cannot find key 'points' in \(achievementDictionary)")
            return
        }
        
        numAchievements++
        sumAchievements += Double(achievementPoints)
//        print(sumAchievements / Double(numAchievements))
        
        
        if achievementPoints > 10 {
            print("We got one!")
        }
        
        if let titleText = achievementDictionary["title"] as? String where titleText.rangeOfString("Cool Running") != nil {
            print("Here is what you must do to achieve the 'Cool Running' achievement: \(achievementDictionary["description"]!)")
        }
        
    }
    
    let averageOfAchievements = sumAchievements / Double(numAchievements)
    print(averageOfAchievements)
    print(arrayOfAchievmentsDictionaries[44]["points"]!)
    
    
}

parseJSONAsDictionary(parsedAchievementsJSON)
