
import UIKit
import AVFoundation
import CoreMedia
import MediaPlayer

class PlayerViewController: UIViewController {
    
    var dur = 0.0
    var timer = Timer()
    
    @IBOutlet weak var playpausebutton: UIButton!
    @IBOutlet weak var audioslider: UISlider!
    @IBOutlet weak var currenttimeLabel: UILabel!
    @IBOutlet weak var playbackTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func previousButton(_ sender: Any) {
        if selectedIndex != 0
        {
            selectedIndex = selectedIndex - 1
            player.nowPlayingItem = query.items?[selectedIndex]
            player.play()
            
        }
        else
        {
            player.nowPlayingItem = query.items?[selectedIndex]
            player.play()
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        selectedIndex = selectedIndex + 1
        player.nowPlayingItem = query.items?[selectedIndex]
        player.play()
        timer.invalidate()
        play()
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "listVC") as! ViewController
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    
    @IBAction func playpauseButton(_ sender: Any) {
        if playpausebutton.titleLabel?.text == "PLAY"
        {
            player.play()
            playpausebutton.setTitle("PAUSE", for: .normal)
        }
        else
        {
            player.pause()
            playpausebutton.setTitle("PLAY", for: .normal)
        }
    }
    
    
    @IBAction func audioSlider(_ sender: Any) {
        player.currentPlaybackTime = TimeInterval(audioslider.value * 60)
    }
    
    
    func play()
    {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateplayertime), userInfo: nil, repeats: true)
        titleLabel.text = query.items?[selectedIndex].title
        dur = ((query.items?[selectedIndex].playbackDuration)! / 60)
        print(dur)
        let c:String = String(format:"%.2f", dur)
        playbackTimeLabel.text = c
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playpausebutton.setTitle("PAUSE", for: .normal)
        currenttimeLabel.text = "0:0:0"
        titleLabel.text = query.items?[selectedIndex].title
        player.nowPlayingItem = query.items?[selectedIndex]
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateplayertime), userInfo: nil, repeats: true)
        dur = ((query.items?[selectedIndex].playbackDuration)! / 60)
        let c:String = String(format:"%.2f", dur)
        playbackTimeLabel.text = c
        audioslider.minimumValue = 0
        audioslider.maximumValue = Float(dur)
        audioslider.isContinuous = false
        audioslider.value = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func updateplayertime()
    {
        let x = ((player.currentPlaybackTime) / 60)
        let y = (player.currentPlaybackTime)
        self.currenttimeLabel.text = ("\(intmax_t(y/3600)):\(intmax_t((y.truncatingRemainder(dividingBy: 3600))/60)):\(intmax_t(y.truncatingRemainder(dividingBy: 60)))")
        self.audioslider.setValue(Float(x), animated: true)
        
    }
}
