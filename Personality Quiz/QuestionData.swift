//
//  QuestionData.swift
//  Personality Quiz
//
//  Created by Lewis Luck on 15/8/18.
//  Copyright © 2018 Fortune Inc. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    var text: String
    var type: QuestionType
    var answers: [Answer]
    
    init(text: String, type: QuestionType, answers:[Answer]) {
        self.answers = answers
        self.text = text
        self.type = type
    }
}

enum QuestionType {
    case single, multiple, range, image
}

struct Answer {
    var text: String
    var type: LOTRCharacter
    var image: UIImage?
}

enum LOTRCharacter {
    case frodo, legolas, gandalf, gollum
    
    var description: String {
        switch self {
        case .frodo:
            return "A Hobbit of the Shire, Frodo Baggins is one of the most important characters in Lord of the Rings. Frodo, with his trusty friend Sam, takes the Ring to Mount Doom, and there destroys it."
        case .legolas:
            return "A Sindarin Elf of Mirkwood, Legolas is the only elf in the fellowship. He, alongside dwarf Gimli and future king Aragorn, trek across Middle Earth, and save the kingdoms of Men from the forces of darkness."
        case .gandalf:
            return "A Maiar and Istari, Mithrandir, or the Wizard Gandalf, is a powerful wielder of magic. He accompanies the fellowship, and proves key to the downfall of Sauron."
        case .gollum:
            return "Originally a hobbit in the Vales of Anduin, Smeagol, or Gollum, was corrupted by the ring. Consumed by desire for it, Gollum follows it across the face of Middle Earth, and, eventually, meets it for a final time."
        }
    
        
    
    }
    
}









