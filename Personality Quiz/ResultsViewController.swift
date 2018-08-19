//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Lewis Luck on 15/8/18.
//  Copyright © 2018 Fortune Inc. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    @IBOutlet weak var resultImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    var responses: [Answer]!
    
    func calculatePersonalityResult() {
        var answersFrequency: [LOTRCharacter: Int] = [:]
        let responseTypes = responses.map{$0.type}
        for type in responseTypes {
            answersFrequency[type] = (answersFrequency[type] ?? 0) + 1
        }
        let mostCommonAnswer = answersFrequency.sorted{$0.1 > $1.1}.first!.key
        resultDescription.text = mostCommonAnswer.description
        if mostCommonAnswer == .gandalf {
            resultTitle.text = "You are Gandalf!"
            resultImage.image = #imageLiteral(resourceName: "Gandalf")
        } else if mostCommonAnswer == .frodo {
            resultImage.image = #imageLiteral(resourceName: "Frodo")
            resultTitle.text = "You are Frodo!"
        } else if mostCommonAnswer == .gollum {
            resultImage.image = #imageLiteral(resourceName: "Gollum")
            resultTitle.text = "You are Gollum!"
        } else if mostCommonAnswer == .legolas {
            resultImage.image = #imageLiteral(resourceName: "Legolas")
            resultTitle.text = "You are Legolas!"
        }
    }
    
    
}
