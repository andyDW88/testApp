//
//  ViewController.swift
//  testProj507
//
//  Created by Andy W on 05/07/2022.
//

import UIKit
import RealmSwift
import Realm

class ViewController: UIViewController {
    
    let app = App(id: "clienttest-ypxpr")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        app.login(credentials: Credentials.emailPassword(email: "andy", password: "123456")) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                case .success(let user):
                    print("Login as \(user.id) succeeded!")
                    // Continue below
                    user.refreshCustomData()
                    print("This user custom data email is \(user.customData["email"])")
                    self.openRealm(user: user)
                }
            }
        }
        
        
    }
    
    
    func openRealm(user: User) {
        let config = user.flexibleSyncConfiguration(initialSubscriptions: { subs in
            subs.append(
                QuerySubscription<testDatum>(name: "all-data"))
        })
        Realm.asyncOpen(configuration: config) {
            result in
            switch result {
            case .failure(let error):
                print("\(error.localizedDescription)")
            case .success(let realm):
                let data = realm.objects(testDatum.self)
                print("N elements: \(data.count)")
                guard let _data = data.first else {
                    print("There is no data retrieved")
                    return
                }
            }
        }
    }
    
}

