//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Devjyoti Mohanty on 21/01/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func configureSongs() {
        
        songs.append(Song(name: "Besharam Rang",
                          albumName: "Pathan Song",
                          artistName: "Shilpa Rao",
                          imageName: "cover1",
                          trackName: "song1"))
        
        
        songs.append(Song(name: "Munda Sona",
                          albumName: "Shehzada Song",
                          artistName: "Diljit Dosanth",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "Mann Meri Jaan",
                          albumName: "Kinglum",
                          artistName: "King",
                          imageName: "cover3",
                          trackName: "song3"))
        
        
        songs.append(Song(name: "Besharam Rang",
                          albumName: "Pathan Song",
                          artistName: "Shilpa Rao",
                          imageName: "cover1",
                          trackName: "song1"))
        
        
        songs.append(Song(name: "Munda Sona",
                          albumName: "Shehzada Song",
                          artistName: "Diljit Dosanth",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "Mann Meri Jaan",
                          albumName: "Kinglum",
                          artistName: "King",
                          imageName: "cover3",
                          trackName: "song3"))
        
        songs.append(Song(name: "Besharam Rang",
                          albumName: "Pathan Song",
                          artistName: "Shilpa Rao",
                          imageName: "cover1",
                          trackName: "song1"))
        
        
        songs.append(Song(name: "Munda Sona",
                          albumName: "Shehzada Song",
                          artistName: "Diljit Dosanth",
                          imageName: "cover2",
                          trackName: "song2"))
        
        songs.append(Song(name: "Mann Meri Jaan",
                          albumName: "Kinglum",
                          artistName: "King",
                          imageName: "cover3",
                          trackName: "song3"))
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else{
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    
    


}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}

