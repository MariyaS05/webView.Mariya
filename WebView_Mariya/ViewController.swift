//
//  ViewController.swift
//  WebView_Mariya
//
//  Created by Мария  on 25.10.22.
//ДЗ: Сделать браузер с базовым фунционалом - вперед, назад, обновить и ввести урл(использовать UISearchBar)(можно посмотреть на NavigationController с SearchBar)
import UIKit
import WebKit

class ViewController: UIViewController {
    let gesture =  UISwipeGestureRecognizer()
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonGoForward: UIButton!
    lazy var searchBar =  UISearchBar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
       searchBar.delegate = self
        searchBar.textContentType = .URL

        customButton()
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.isHidden = false
        gesture.addTarget(self, action: #selector(handleSwipeGesture))
        gesture.direction = .down
        gesture.direction = .right
        view.addGestureRecognizer(gesture)
    }
    
    
    @IBAction func buttonGoBackTapped(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func buttonGoForwardTapped(_ sender: UIButton) {
        webView.goForward()
    }
    private func customButton(){
        let buttonBackImage = UIImage(systemName: "arrow.backward")
        let buttonForwardImage =  UIImage(systemName: "arrow.right")
        buttonGoBack.setImage(buttonBackImage, for: .normal)
        buttonGoForward.setImage(buttonForwardImage, for: .normal)
    }
    @objc  func handleSwipeGesture(_ sender : UISwipeGestureRecognizer){
        switch sender.direction {
        case .down :
            print("ghh")
            webView.reload()
        case .right :
            webView.goBack()
            print("Go back")
        default:
            return
        }
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let url = URL(string: "https://\(searchBar.text!)") else { return  }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)

    }
}
