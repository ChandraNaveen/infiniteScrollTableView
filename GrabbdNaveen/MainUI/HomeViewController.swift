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
    var dataIsBeingLoaded = false
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
    
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        self.view = tableView
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- loadData
       func loadData()
       {
        
        if dataIsBeingLoaded == true
        {
            return
        }
        
        
       
        self.startLoading()
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=dd42a11a001b4867b2af49fcab30f9a2")
           let header: Dictionary<String, String> = ["Content-Type": "application/json"]
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
                    self.stopLoading()
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
                             self.stopLoading()
                           let dataDictionary =  json["articles"].arrayObject
                           self.parseData(jsonArray: dataDictionary ?? [])
                       })
                   }
               case .failure(let error):
                self.stopLoading()
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
           self.data.append(contentsOf: tempArray)
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
        let url = URL(string: news.imgURL!)
        cell.itemImageView.sd_setImage(with: url, completed: nil)
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
      {
//        if indexPath.row == data.count-1
//        {
//            //just randomly call the api
//            self.loadData()
//        }
    }
    
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height {
               loadData()
        }

    }
  
     // MARK: - HUD
     func startLoading()
     {
        //main flag for continuos load
        dataIsBeingLoaded = true
        
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.large;
        activityIndicator.startAnimating();
        

     }

     func stopLoading(){
        //main flag for continuos load
          dataIsBeingLoaded = false
        
         activityIndicator.stopAnimating();
        

     }
     
    
}
