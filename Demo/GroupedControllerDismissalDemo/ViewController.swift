//
//  ViewController.swift
//  GroupedControllerDismissalDemo
//
//  Created by Sergey Ladeiko on 6/30/20.
//

import UIKit
import GroupedControllerDismissal

func r() -> CGFloat {
    return CGFloat(arc4random_uniform(100)) / CGFloat(100)
}

class VC: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: r(), green: r(), blue: r(), alpha: 1)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIViewController.dismissModalAsGrouped = true

        // Do any additional setup after loading the view.
    }

    @IBAction func show(_ sender: Any) {

        let c1 = VC()
        let c2 = VC()
        let c3 = VC()

        present(c1, animated: true, completion: {
            c1.present(c2, animated: true, completion: {
                c2.present(c3, animated: true, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
            })
        })
    }

}

