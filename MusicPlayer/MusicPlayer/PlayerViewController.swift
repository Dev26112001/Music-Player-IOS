//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Devjyoti Mohanty on 22/01/23.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let playPauseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure(){
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                print("urlstring is nil")
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else{
                print("player is nil")
                return
            }
            
            player.volume = 0.5
            
            player.play()
            
        }
        
        catch {
            print("error occurred")
        }
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumNameLabel.frame.size.height + 690,
                                     width: holder.frame.size.width-20,
                                     height: 70)
        songNameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumNameLabel.frame.size.height + 10 + 500,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        albumNameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumNameLabel.frame.size.height + 10 + 340,
                                       width: holder.frame.size.width-20,
                                       height: 70)
        artistNameLabel.font = UIFont.boldSystemFont(ofSize: 21)
        
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        
       
        let nextButton = UIButton()
        let backButton = UIButton()
        
        
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 70
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: 600,
                                       width: size,
                                       height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: 600,
                                  width: size,
                                  height: size)
        
        backButton.frame = CGRect(x: 20,
                                  y: 600,
                                  width: size,
                                  height: size)
        
        
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-60,
                                            width: holder.frame.size.width-40,
                                            height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSliderSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
    }
    
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapNextButton(){
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPlayPauseButton(){
        if player?.isPlaying == true{
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
            })
        }
        else{
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                                   y: 10,
                                                   width: self.holder.frame.size.width-20,
                                                   height: self.holder.frame.size.width-20)
            })
        }
        
    }
    
    
    @objc func didSliderSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if  let player = player {
            player.stop()
        }
    }
    

}
