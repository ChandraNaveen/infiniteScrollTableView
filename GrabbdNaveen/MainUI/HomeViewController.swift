//
//  HomeViewController.swift
//  GrabbdNaveen
//
//  Created by Naveen Chandra on 10/01/20.
//  Copyright © 2020 Naveen Chandra. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView = UITableView()
    var data = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurTableView()
        loadData()
        
    }
    
    func configurTableView()
    {
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        self.view = tableView
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- loadData
       func loadData()
       {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=dd42a11a001b4867b2af49fcab30f9a2")
           var header: Dictionary<String, String> = ["Content-Type": "application/json"]
           let request =  Alamofire.request(url!, method:.get, parameters: nil,encoding: JSONEncoding.default,headers: header)
                   .validate(statusCode: 200..<500)
                   .validate(contentType: ["application/json"])
           request.responseJSON
               {
               response in
               switch response.result {
               case .success(let data):
                   let json = JSON(data)
                   print(json)
                   if let errorMessage = json["errors"][0]["message"].string
                   {
                       print( errorMessage)
                       let actionController: UIAlertController = UIAlertController(title: "Oops", message: "\(errorMessage)", preferredStyle: .alert)

                       let cancelAction: UIAlertAction = UIAlertAction(title: "ok", style: .cancel)
                       { action -> Void in

                       }
                       actionController.addAction(cancelAction)
                       self.present(actionController, animated: true, completion: nil)
                   }
                   else{
                        DispatchQueue.main.async(execute:{
                           let dataDictionary =  json["articles"].arrayObject
                           self.parseData(jsonArray: dataDictionary ?? [])
                       })
                   }
               case .failure(let error):
                 
                   print("Failed to load \(error.localizedDescription)")
                   let actionVC: UIAlertController = UIAlertController(title: "Oops", message: "\(error.localizedDescription)", preferredStyle: .alert)
                   let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .cancel) {
                       actionVC -> Void in
                   }
                   actionVC.addAction(cancelAction)
                   self.present(actionVC, animated: true, completion: nil)

               }

           }

       }


       // parse data
       func parseData(jsonArray:Array<Any>)
       {


           var tempArray = [DataModel]()
           let json = JSON(jsonArray)

           for (index, _) in  json.enumerated()
           {
               let news = json[index]
         
                   let title =  news["title"].stringValue
                   let author = news["author"].string
                   let date = news["publishedAt"].stringValue
                   let imgURL = news["urlToImage"].stringValue
                   let source = news["source"]["name"].stringValue
                   let desc = news["description"].stringValue
                   
                   let dataModel = DataModel(title: title, author: author, date: date, imgURL: imgURL, source: source, desc: desc)
                   tempArray.append(dataModel)
           }
           self.data = tempArray
           self.tableView.reloadData()
       }

    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as! NewsTableViewCell
        
    
        let news = data[indexPath.row]
        
        cell.titleLabel.text = news.title
        cell.authorLabel.text = news.author
        cell.dateLabel.text = news.date
        cell.sourceLabel.text = news.source
        cell.descriptionLabel.text = news.desc
        //cell.imageView?.image = news.code
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
