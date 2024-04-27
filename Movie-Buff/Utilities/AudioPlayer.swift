//
//  AudioPlayer.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/24/24.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playAudio(filename: String, fileType: String) {
    if let path = Bundle.main.path(forResource: filename, ofType: fileType) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Cannot play audio")
        }
    }
}
