//
//  JSON-Parsing-Hearthstone-Solution.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = NSBundle.mainBundle().pathForResource("hearthstone_basic_set", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = NSData(contentsOfFile: pathForHearthstoneJSON!)

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! NSJSONSerialization.JSONObjectWithData(rawHearthstoneJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    var numCostRatioItems = 0
    var sumCostRatio: Double = 0.0
    
    var numCostForRarityItemsDictionary = [String:Int]()
    var sumCostForRarityDictionary = [String:Int]()
    
    let rarities = ["Free", "Common"]
    
    for rarity in rarities {
        numCostForRarityItemsDictionary[rarity] = 0
        sumCostForRarityDictionary[rarity] = 0
    }
    
    guard let arrayOfBasicSetCardDictionaries = parsedHearthstoneJSON["Basic"] as? [[String:AnyObject]] else {
        print("Cannot find key 'Basic' in \(parsedHearthstoneJSON)")
        return
    }
    
    for cardDictionary in arrayOfBasicSetCardDictionaries {
        
        guard let cardType = cardDictionary["type"] as? String else {
            print("Cannot find key 'type' in \(cardDictionary)")
            return
        }
        
        if cardType == "Minion" {
            
            guard let attack = cardDictionary["attack"] as? Int else {
                print("Cannot find key 'attack' in \(cardDictionary)")
                return
            }
            
            guard let manaCost = cardDictionary["cost"] as? Int else {
                print("Cannot find key 'cost' in \(cardDictionary)")
                return
            }
            
            if manaCost == 5 {
                print("found a minion with cost of 5")
            }
            
            if let cardText = cardDictionary["text"] as? String where cardText.rangeOfString("Battlecry") != nil {
                print("This minion has the battlecry effect")
            }
        }
        
        if cardType == "Weapon" {
            
            guard let durability = cardDictionary["durability"] as? Int else {
                print("Cannot find key 'durability' in \(cardDictionary)")
                return
            }
            
            if durability == 2 {
                print("found a weapon with durability of 5")
            }
        }
    }
    for rarity in rarities {
        
    }
    
    
    
    
    
//    print(parsedHearthstoneJSON)
//    guard let basicData = parsedHearthstoneJSON["Basic"] as? [[String:AnyObject]] else {
//        print("Cannot find key 'Basic' in \(parsedHearthstoneJSON)")
//        return
//    }
//    
//    
//    guard let nameData = basicData[0]["type"] as? String else {
//        print("Cannot find key 'name' in \(basicData)")
//        return
//    }
//    print(nameData)
//
//    for item in basicData {
//        let type = nameData["cost"]
//        print(type)
//    }
    
}

parseJSONAsDictionary(parsedHearthstoneJSON)
