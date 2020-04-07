//
//  LibaryViewController.swift
//  AudioRecorder
//
//  Created by Mateo Larrea Ferro on 4/7/20.
//  Copyright © 2020 Mateo Larrea Ferro. All rights reserved.
//

import UIKit
import AudioKit

class LibraryViewController: UITableViewController {

    var recordings = [String]()
    var players = [AKPlayer]()
    var mixer:AKMixer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecordingNames()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do{
            for fileName in recordings {
                let file = try AKAudioFile(readFileName: fileName, baseDir: .documents)
                let player = AKPlayer(audioFile: file)
                player.isLooping = false
                players.append(player)
            }
        }
        catch {
            print("Cannot read recordings")
        }
        
        mixer = AKMixer(players)
        AudioKit.output = mixer
        
        do {
            try AudioKit.start()
        }
        catch {
            print("Cannot Start AudioKit")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        do{
            try AudioKit.stop()
        }
        catch {
            print("Cannot stop AudioKit")
        }
    }
    
    func getRecordingNames(){
        let filePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = filePaths[0]
        do {
            try recordings = FileManager.default.contentsOfDirectory(atPath: fileURL.path)
        } catch {
            print("Failed to load contents of directory")
            print(error)
        }
        
        //Sort to make sure it respects the time order of recording
        recordings.sort()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        //Create new cell if it does not exist
        if(cell == nil){
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }

        //Assign file name to the cell
        let url = URL(fileURLWithPath: recordings[indexPath.row])
        cell?.textLabel?.text = url.deletingPathExtension().lastPathComponent

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Stop all playback first
        for player in players {
            if player.isPlaying {
                player.stop()
            }
        }
        
        //Play the selected audio file
        players[indexPath.row].play()
    }
}
