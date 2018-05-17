 //
//  CartViewController.swift
//  moltin iOS Example
//
//  Created by Craig Tweedy on 03/04/2018.
//

import UIKit
import moltin

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    @IBOutlet weak var buyNowButtonLabel: UIButton!
    
    let moltin: Moltin = Moltin(withClientID: "j6hSilXRQfxKohTndUuVrErLcSJWP15P347L6Im0M4", withLocale: Locale(identifier: "en_US"))

    var cartItems: [CartItem] = []
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buyNowButtonLabel.setTitle("Buy Now", for: .normal)
        tableView.register(UINib(nibName: "CheckoutItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckoutCell")
        self.tableView.rowHeight = 120.0
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        moltin.cart.get(forID: AppDelegate.cartID) { (result) in
            if case .success(let cart) = result {
                DispatchQueue.main.async {
                    self.cartTotalLabel.text = cart.meta.displayPrice.withTax.formatted
                }

            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func checkout(_ sender: Any) {
//        let window: UIWindow = UIApplication.shared.keyWindow!
//        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, UIScreen.main.scale)
//        window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
//        let screenCapture: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        let controller = CheckoutViewController.init(nibName: "CheckoutViewController", bundle: nil)
//        controller.screenCapture = screenCapture
//
//        self.present(controller, animated: false, completion: nil)
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountCheckoutViewController") as? AccountCheckoutViewController

        self.navigationController?.pushViewController(vc!, animated: true)

//        self.present(controller, animated: false, completion: nil)

    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath) as! CheckoutItemTableViewCell
        let cartItem = self.cartItems[indexPath.row]

        cell.qtyLabel.text = String(cartItem.quantity)
        cell.priceNameLabel.text = cartItem.meta.displayPrice.withTax.value.formatted
        cell.productNameLabel.text = cartItem.name
        cell.productImage.load(urlString: self.product?.mainImage?.link["href"])

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = "Click checkout to test order"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove from cart"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
