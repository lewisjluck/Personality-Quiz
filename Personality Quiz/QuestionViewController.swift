//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by Lewis Luck on 15/8/18.
//  Copyright © 2018 Fortune Inc. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //stack views
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var singleStackView: UIStackView!
    
    //question
    @IBOutlet weak var questionLabel: UILabel!
    
    //imageStack images outlets
    @IBOutlet weak var imageStackOne: UIButton!
    @IBOutlet weak var imageStackTwo: UIButton!
    @IBOutlet weak var imageStackThree: UIButton!
    @IBOutlet weak var imageStackFour: UIButton!
    
    //multipleStack labels outlets
    @IBOutlet weak var multipleStackOne: UILabel!
    @IBOutlet weak var multipleStackTwo: UILabel!
    @IBOutlet weak var multipleStackThree: UILabel!
    @IBOutlet weak var multipleStackFour: UILabel!
    
    //multipleStack switch outlets
    @IBOutlet weak var switchOne: UISwitch!
    @IBOutlet weak var switchTwo: UISwitch!
    @IBOutlet weak var switchThree: UISwitch!
    @IBOutlet weak var switchFour: UISwitch!
    
    
    //rangeStack labels outlets
    @IBOutlet weak var rangeStackOne: UILabel!
    @IBOutlet weak var rangeStackTwo: UILabel!
    
    //singleStack buttons outlets
    @IBOutlet weak var singleStackOne: UIButton!
    @IBOutlet weak var singleStackTwo: UIButton!
    @IBOutlet weak var singleStackThree: UIButton!
    @IBOutlet weak var singleStackFour: UIButton!
    
    //progress bar
    @IBOutlet weak var progressBar: UIProgressView!
    
    //answers array
    var answersChosen: [Answer] = []
    
    //range outlet
    @IBOutlet weak var rangeSlider: UISlider!
    
    
    @IBAction func singleButton(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case singleStackOne:
            answersChosen.append(currentAnswers[0])
        case singleStackTwo:
            answersChosen.append(currentAnswers[1])
        case singleStackThree:
            answersChosen.append(currentAnswers[2])
        case singleStackFour:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleButton() {
        let currentAnswers = questions[questionIndex].answers
        
        if switchOne.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if switchTwo.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if switchThree.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if switchFour.isOn {
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangeButton() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangeSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    @IBAction func imageButton(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        switch sender.image(for: .normal) {
        case currentAnswers[0].image:
            answersChosen.append(currentAnswers[0])
        case currentAnswers[1].image:
            answersChosen.append(currentAnswers[1])
        case currentAnswers[2].image:
            answersChosen.append(currentAnswers[2])
        case currentAnswers[3].image:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    func updateUI() {
        multipleStackView.isHidden = true
        imageStackView.isHidden = true
        singleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = questions[questionIndex].answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        navigationItem.title = "Question \(questionIndex+1)"
        progressBar.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .image:
            updateImageStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .single:
            updateSingleStack(using: currentAnswers)
        case .range:
            updateRangeStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleStackOne.setTitle(answers[0].text, for: .normal)
        singleStackTwo.setTitle(answers[1].text, for: .normal)
        singleStackThree.setTitle(answers[2].text, for: .normal)
        singleStackFour.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        switchOne.isOn = false
        switchTwo.isOn = false
        switchThree.isOn = false
        switchFour.isOn = false
        multipleStackOne.text = answers[0].text
        multipleStackTwo.text = answers[1].text
        multipleStackThree.text = answers[2].text
        multipleStackFour.text = answers[3].text
    }
    
    func updateRangeStack(using answers: [Answer]) {
        rangeStackView.isHidden = false
        rangeSlider.setValue(0.5, animated: false)
        rangeStackOne.text = answers.first?.text
        rangeStackTwo.text = answers.last?.text
    }
    
    func updateImageStack(using answers: [Answer]) {
        imageStackView.isHidden = false
            imageStackOne.setImage(answers[0].image, for: .normal)
            imageStackTwo.setImage(answers[1].image, for: .normal)
            imageStackThree.setImage(answers[2].image, for: .normal)
            imageStackFour.setImage(answers[3].image, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    var questionIndex = 1
    
    var questions: [Question] = [
        Question(text: "What is your weapon of choice?", type: .image, answers: [
            Answer(text: "Bow", type: .legolas, image: #imageLiteral(resourceName: "Bow")),
            Answer(text: "Sting", type: .frodo, image: #imageLiteral(resourceName: "Sting")),
            Answer(text: "Staff", type: .gandalf, image: #imageLiteral(resourceName: "Staff")),
            Answer(text: "Teeth", type: .gollum, image: #imageLiteral(resourceName: "Hands"))
            ]),
        
        Question(text: "What is your favourite food?", type: .single, answers: [
            Answer(text: "Fish", type: .gollum, image: nil),
            Answer(text: "Cake", type: .frodo, image: nil),
            Answer(text: "Bread", type: .legolas, image: nil),
            Answer(text: "Steak", type: .gandalf, image: nil)
            ]),
        
        Question(text: "How much do you like the great outdoors?", type: .range, answers: [
            Answer(text: "Not at all", type: .frodo, image: nil),
            Answer(text: "A little. Sometimes.", type: .gandalf, image: nil),
            Answer(text: "I'm good with them", type: .gollum, image: nil),
            Answer(text: "I love them", type: .legolas, image: nil)
            ]),
        
        Question(text: "Where is your dream home?", type: .image, answers: [
            Answer(text: "Mirkwood", type: .legolas, image: #imageLiteral(resourceName: "Mirkwood")),
            Answer(text: "Minas Tirith", type: .gandalf, image: #imageLiteral(resourceName: "Minas Tirith")),
            Answer(text: "Hobbiton", type: .frodo, image: #imageLiteral(resourceName: "Hobbiton")),
            Answer(text: "Misty Mountains", type: .gollum, image: #imageLiteral(resourceName: "Misty Mountains"))
            ]),
        
        Question(text: "What are your dreams?", type: .multiple, answers: [
            Answer(text: "Power", type: .gollum, image: nil),
            Answer(text: "Peace", type: .gandalf, image: nil),
            Answer(text: "Saving the Environment", type: .legolas, image: nil),
            Answer(text: "Home and Family", type: .frodo, image: nil)
            ])
    ]
   

}
