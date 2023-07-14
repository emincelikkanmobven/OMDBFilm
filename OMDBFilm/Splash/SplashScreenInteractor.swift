//
//  SplashScreenInteractor.swift
//  OMDBFilm
//
//  Created by Emin Çelikkan on 14.07.2023.
//

import Foundation
import Alamofire
import FirebaseRemoteConfig

protocol SplashScreenBusinessLogic: AnyObject {
    func checkConnectionStatus()
    func getConfigText()
}

protocol SplashScreenDataStore: AnyObject {
    
}

final class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore {
    
    var presenter: SplashScreenPresentationLogic?
    var worker: SplashScreenWorkingLogic = SplashScreenWorker()
    var networkManager = NetworkReachabilityManager()
    
    func getConfigText() {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetch { status, error in
            if status == .success {
                remoteConfig.activate { [weak self] changed, error in
                    guard let self else { return }
                    let remoteConfigText = remoteConfig.configValue(forKey: "splashText").stringValue ?? "Loodos default text"
                    self.presenter?.presentConfigText(remoteConfigText)
                }
            } else {
                self.presenter?.presentErrorWithMessage(error?.localizedDescription ?? "RemoteConfig failed.")
            }
        }
    }
    
     func checkConnectionStatus() {
        if networkManager?.isReachable ?? false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let self else { return }
                presenter?.presentHomePage()
                     }
        } else {
            //Presenting Error message decided there instead of presenter, to any case if service response has any
            // error message parameters. otherwise these parameters should be decided at presenter.
            presenter?.presentErrorWithMessage("Internet Baglantinizi Kontrol Ediniz.")
        }
    }

}
