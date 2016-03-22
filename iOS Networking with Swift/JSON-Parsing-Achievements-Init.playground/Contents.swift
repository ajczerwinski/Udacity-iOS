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
        
        if achievementPoints > 10 {
            print("We got one!")
        }
        
    }
    print(arrayOfAchievmentsDictionaries[44]["points"]!)
    
    
}

parseJSONAsDictionary(parsedAchievementsJSON)
