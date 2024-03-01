//
//  SoundManager.swift
//  Who Wants to Be a Millionaire
//
//  Created by Maryna Bolotska on 29/02/24.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(fileName: String, fileExtension: String) {
        guard let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}


