
import UIKit
import UIKit
import MediaPlayer
import AVFoundation


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate  {
    
    
    @IBOutlet var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Songs"
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.tableView?.rowHeight = UITableViewAutomaticDimension;
                    self.tableView?.estimatedRowHeight = 60.0;
                    self.tableView?.reloadData()
                }
            } else {
                print("Error")
            }
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
        return (MPMediaQuery.songs().collections?.count)!
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath:IndexPath ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MusicPlayerCell",
            for: indexPath) as! MusicPlayerCell
        cell.titleLabel.text = query.items?[indexPath.row].title
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "musicPlayerVC") as! PlayerViewController
        player.prepareToPlay()
        selectedIndex = indexPath.row
        self.present(nextViewController, animated:false, completion:nil)
    }
}



