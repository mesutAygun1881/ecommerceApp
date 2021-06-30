//
//  ViewController.swift
//  e-commerce
//
//  Created by Mesut Aygün on 30.06.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var sections = [SectionType]()

    
    let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        table.register(ProductCellViewModels.self, forCellReuseIdentifier: ProductCellViewModels.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GeldiGeliyor"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureSection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
            case .productPhoto :
                return 1
            case .productInfo(let viewModels):
                return viewModels.count
            case .productRelated(let viewModels):
                return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
            case .productPhoto(let images) :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else {
                    fatalError()
                }
                cell.configure(with: images)
                return cell
            case .productInfo(let viewModels) :
                let viewModel = viewModels[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.configure(with : viewModel)
                return cell
                
            case .productRelated(let viewModels) :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCellViewModels.identifier, for: indexPath) as? ProductCellViewModels else {
                    fatalError()
                }
                cell.configure(with: viewModels[indexPath.row])
                return cell
                
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hello"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        
        return sectionType.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
            case .productPhoto :
                return view.frame.size.width
            case .productInfo :
                return UITableView.automaticDimension
            case .productRelated :
                return 100
        }
    }
    
    private func configureSection(){
        sections.append(.productPhoto(images : [
        UIImage(named: "kulaklik"),
        UIImage(named: "huaweikulak"),
        UIImage(named: "kulaklik3")
        ].compactMap({ $0 })))
        
        sections.append(.productInfo(viewModels : [
            TextCell(text: "1MORE ESS6001T COLORBUDS BLUETOOTH 5.0 KULAKLIK ESS6001T COLORBUDS BLUETOOTH ESS6001T COLORBUDS BLUETOOTH", font: .systemFont(ofSize: 15)),
            TextCell(text: "Fiyat : 250 TL", font: .systemFont(ofSize: 20))
        ]))
        sections.append(.productRelated(viewModels : [
        
        ProductCellView(image: UIImage(named: "bkulak"), title: "SONY"),
        ProductCellView(image: UIImage(named: "bbkulak"), title: "SAMSUNG"),
        ProductCellView(image: UIImage(named: "huaweikulak"), title: "RL"),
        ProductCellView(image: UIImage(named: "kulaklik"), title: "CREATIVE"),
        ProductCellView(image: UIImage(named: "bbkulak"), title: "SAMSUNG")
    
        ]))
    }
}

enum SectionType {
    case productPhoto(images : [UIImage])
    case productInfo(viewModels : [TextCell])
    case productRelated(viewModels : [ProductCellView])
    
    var title : String? {
        switch self {
            case .productRelated :
                return "Benzer Markalar"
            default :
                return nil
        }
    }
}

struct TextCell {
    let text : String
    let font : UIFont
}

extension UITableViewCell {
    func configure(with viewModel : TextCell){
        textLabel?.text = viewModel.text
        textLabel?.numberOfLines = 0
        textLabel?.font = viewModel.font
        
    }
}
