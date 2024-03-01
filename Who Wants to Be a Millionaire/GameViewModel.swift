//
//  GameViewModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Ilya Paddubny on 27.02.2024.
//

import Foundation
import AVFoundation


protocol GameDelegate: AnyObject {
    func selectCurrectAnswer(_ correctAnswer: String)
    func proceedToTheNextQuestion(_ question: Question, questionNumber: Int)
    func onShowTheQuestion(_ question: Question, questionNumber: Int)
    
    
    func endGame(moneyWon: Int)
    func updateTimerLabel(_ timeRemaining: Int)
    
    func fiftyFiftyButtonUsed(wrongAnswer1: String, wrongAnswer2: String)
    func audienceHelpButtonUsed(audienceAnswer: String)
    func callFriendButtonUsed(friendsAnswer: String)
    
    
    func takeMoneyButtonTapped()
}

protocol EndGameDelegate: AnyObject {
    func endGame(moneyWon: Int)
}


class GameViewModel {
    weak var gameDelegate: GameDelegate? //QuestionViewController
    weak var endGame: EndGameDelegate? //progress VC
    
    let dataManager = DataManager()
    var helpButtonsInactive = false
    private var audioPlayer: AVAudioPlayer?
    
    private var questions: [Question] = []
    
    private var currentQuestionIndex = 0
    
    private var timer: Timer?
    private var remainingTime = 30
    
    private var hasFiftyFiftyUsed = false
    private var hasAudienceHelpUsed = false
    private var hasFriendCall = false
    
    init() {
        loadQuestions()
    }
    
    
    func loadQuestions() {
        let dummyData = generateDummyQuestions()
        questions = dummyData
        
//        dataManager.fetchDataOnline { [weak self] result in
//            switch result {
//            case .success(let questionsByLevel):
//                for (level, questions) in questionsByLevel {
//                    self?.questions.append(contentsOf: questions)
//                    print(questions.count)
//                }
//            case.failure(let error):
//                print("⚠️ Failed to load questions: \(error.localizedDescription)")
//
//            }
//        }
    }
    
    func generateDummyQuestions() -> [Question] {
        let questions: [Question] = [
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "General Knowledge",
                question: "What is the capital of France?",
                correctAnswer: "Paris",
                incorrectAnswers: ["London", "Berlin", "Rome"]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Science",
                question: "What is the chemical symbol for water?",
                correctAnswer: "H2O",
                incorrectAnswers: ["CO2", "O2", "NaCl"]
            ),
            Question(
                type: "multiple",
                difficulty: "hard",
                category: "History",
                question: "In which year did World War II end?",
                correctAnswer: "1945",
                incorrectAnswers: ["1939", "1941", "1943"]
            ),
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "Geography",
                question: "What is the largest ocean on Earth?",
                correctAnswer: "Pacific Ocean",
                incorrectAnswers: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean"]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Entertainment",
                question: "Who directed the movie 'Inception'?",
                correctAnswer: "Christopher Nolan",
                incorrectAnswers: ["Steven Spielberg", "Martin Scorsese", "Quentin Tarantino"]
            )
        ]
        
        return questions
    }
    
    func startGame() {
        playTimeTickingSound()
        helpButtonsInactive = false
        currentQuestionIndex = 0
        gameDelegate?.onShowTheQuestion(questions[currentQuestionIndex], questionNumber: currentQuestionIndex+1)
    }
    
    private func displayQuestion() {
        // Отображение вопроса и вариантов ответов
    }
    
    
    private func startTimer() {
        // Запуск таймера
    }
    
    private func stopTimer() {
        // Остановка таймера
    }
    
    
    func selectAnswer(_ selectedAnswer: String) {
        //  answer is selected
        playDecisionMadeSound()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // After 3 seconds, show the correct answer
            self.showCorrectAnswer()
            self.helpButtonsInactive = false
            
            if selectedAnswer == self.questions[self.currentQuestionIndex].correctAnswer {
                // answer is correct.
                self.currectAnswerLogic()
                
            } else {
                // answer is wrong
                self.wrongAnswerLogic()
                
            }
        }
    }
    
    private func currectAnswerLogic() {
        self.playCorrectAnswerSound()
        
        //подождать 2 секунды...
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.currentQuestionIndex += 1
            self.gameDelegate?.proceedToTheNextQuestion(self.questions[self.currentQuestionIndex], questionNumber: self.currentQuestionIndex + 1)
        }
        
        //TODO: если вопрос не последний - оповести делегат, о переходе к следующему вопросу:
        
        //TODO: если вопрос был последний - надо проиграть звук победи и опосестить делегат об окончании игры с суммой выйгрыша = 1 миллион (делегат должен реализовать разделение логики, если сумма выигрыша не = 0)
    }
    
    private func wrongAnswerLogic() {
        self.playWrongAnswerSound()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //подождать 3 секунды...
                //опосестить делегат об окончании игры с суммой выйгрыша = 0 (делегат должен реализовать разделение логики, если сумма выигрыша = 0)
                switch self.currentQuestionIndex {
                case 0..<5:
                    self.gameDelegate?.endGame(moneyWon: 0)
                case 6..<10:
                    self.gameDelegate?.endGame(moneyWon: 1000)
                case 11..<15:
                    self.gameDelegate?.endGame(moneyWon: 32000)
                default:
                    print("Answer is not within the specified ranges")
                }
                
        }
    }
    
    private func showCorrectAnswer() {
        // Показать правильный ответ после ответа пользователя
        gameDelegate?.selectCurrectAnswer(questions[currentQuestionIndex].correctAnswer)
    }
    
    
    // MARK: - Help buttons intents
    func fiftyFiftyButtonTapped() {
        if !hasFiftyFiftyUsed, !helpButtonsInactive {
            print("fiftyFiftyButtonTapped")
            // Реализация подсказки "50/50"
            // Удаление двух неверных ответов
            gameDelegate?.fiftyFiftyButtonUsed(wrongAnswer1: questions[currentQuestionIndex].incorrectAnswers[0], wrongAnswer2: questions[currentQuestionIndex].incorrectAnswers[1])
            hasFiftyFiftyUsed = true
            helpButtonsInactive = true
        }
    }
    
    func audienceHelpButtonTapped() {
        if !hasAudienceHelpUsed, !helpButtonsInactive {
            print("audienceHelpButtonTapped")
            // Зал должен ответить на вопрос правильно с вероятностью 70%
            
            let audienceAnswer = getBoolWithProbability(of: 70) ? questions[currentQuestionIndex].correctAnswer : questions[currentQuestionIndex].incorrectAnswers.first
            
            gameDelegate?.audienceHelpButtonUsed(audienceAnswer: audienceAnswer ?? "No answer")
            
            hasAudienceHelpUsed = true
            helpButtonsInactive = true
        }
    }
    
    func callFriendButtonTapped() {
        if !hasFriendCall, !helpButtonsInactive {
            print("phoneFriendButtonTapped")
            // Звонок другу с вероятностью 80% даст правильный ответ
            
            let friendsAnswer = getBoolWithProbability(of: 80) ? questions[currentQuestionIndex].correctAnswer : questions[currentQuestionIndex].incorrectAnswers.first
            
            gameDelegate?.callFriendButtonUsed(friendsAnswer: friendsAnswer ?? "No answer")
            
            hasFriendCall = true
            helpButtonsInactive = true
        }
    }
    
    func takeMoneyButtonTapped() {
        // Реализация кнопки "Забрать деньги"
        
    }
    
    
    func getBoolWithProbability(of percent: Int) -> Bool {
        // Generate a random number between 0 and 99
        let randomNumber = Int.random(in: 0...percent)
        
        // Probability of 80%
        if randomNumber < 80 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Sounds
    private func playGameStartsSound() {
        playSound("sound_game_starts")
    }
    
    private func playDecisionMadeSound() {
        playSound("sound_decision_made")
    }
    
     private func playCorrectAnswerSound() {
        playSound("sound_right_answer")
    }
    
    private func playTimeTickingSound() {
        playSound("sound_time_ticking")
    }
    
    private func playWrongAnswerSound() {
        playSound("sound_wrong_answer")
    }
    
    private func playSound(_ soundName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    
}
