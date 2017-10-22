//
//  CadastrarProduto.swift
//  ComprasUSA
//
//  Created by Admin on 10/22/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CadastrarProduto: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var gerenciadorObjetos: NSManagedObjectContext!
    
    @IBOutlet weak var image: UIImageView!
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var ProductName: UITextField!
    @IBOutlet weak var IsCard: UISwitch!
    @IBOutlet weak var ProductValue: UITextField!
    @IBOutlet weak var ProductState: UITextField!
    
    @IBAction func btCadastro(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        gerenciadorObjetos = appDelegate.persistentContainer.viewContext
        
        
        let usuario = NSEntityDescription.insertNewObject(forEntityName: "Products", into: gerenciadorObjetos)
        let value:Double
        
        do {
            try value = Double(self.ProductValue.text!)!
            print("Sucesso ao converter!")
        } catch {
            print("Erro ao converter!")
        }
        usuario.setValue(self.ProductName.text, forKey: "product_name")
        usuario.setValue(self.ProductState.text, forKey: "product_state")
        usuario.setValue(value, forKey: "product_value")
        usuario.setValue(self.IsCard.isOn, forKey: "is_card")
        if image.image != nil {
            //usuario.setValue(image.image, forKey: "product_photo")
        }
        
        do {
            try gerenciadorObjetos.save()
            self.navigationController?.popToRootViewController(animated: true)
            print("Dados salvos!")
        } catch {
            print("Erro ao salvar dados!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGesture:)))
        imagePicker.delegate = self
        
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(tapGesture: UITapGestureRecognizer) {
        
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imagemRecuperda = info[UIImagePickerControllerOriginalImage] as! UIImage
        image.image = imagemRecuperda
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
