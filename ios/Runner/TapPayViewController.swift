//
//  TapPayViewController.swift
//  Runner
//
//  Created by Yulin Shin on 2023/4/23.
//

import UIKit
import TPDirect

class TapPayViewController: UIViewController {
  //MARK: - @IBOutlet

  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var payButton: UIButton!
  var tpdForm : TPDForm!
  var tpdCard : TPDCard!
    var didPayAction: ((String) -> Void)?

  override func viewDidLoad() {
      super.viewDidLoad()
      // 1. Setup TPDForm With Your Customized CardView(260, 70)
      self.tpdForm = TPDForm.setup(withContainer: cardView)
      self.tpdCard = TPDCard.setup(self.tpdForm)
      self.tpdForm.setErrorColor(UIColor.red)
      
      // 2. Use callback Get Status
      self.tpdForm.onFormUpdated { (status) in
        self.payButton.isEnabled = status.isCanGetPrime()
        self.payButton.alpha = (status.isCanGetPrime()) ? 1.0 : 0.25
      }
      self.payButton.isEnabled = false
      self.payButton.alpha = 0.25
    }
    
    
    @IBAction func pay(_ sender: Any) {
        tpdCard.onSuccessCallback { (prime, cardInfo, cardIdentifier, merchantReferenceInfo) in

          print("Prime : \(prime!), LastFour : \(cardInfo!.lastFour!)")
          print("Bincode : \(cardInfo!.bincode!), Issuer : \(cardInfo!.issuer!), cardType : \(cardInfo!.cardType), funding : \(cardInfo!.funding) ,country : \(cardInfo!.country!) , countryCode : \(cardInfo!.countryCode!) , level : \(cardInfo!.level!)")
            self.didPayAction?(prime!)

        }.onFailureCallback { (status, message) in

          print("status : \(status) , Message : \(message)")

        }.getPrime()
    }
}
