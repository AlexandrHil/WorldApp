//
//  WAPlacesViewController.swift
//  WorldApp
//
//  Created by Alex on 6.03.21.
//

import UIKit

class WAPlacesViewController: UITableViewController {

    // MARK: - models

    private var places: [WAPlace] = WADefaults.sh.places {
        didSet {
            WADefaults.sh.places = self.places // 2. после редактирования всё сохранится
            self.filteredPlaces = self.places   // 1. для визуального отображения
        }
    }

    // массив отфильтрованный
    private lazy var filteredPlaces: [WAPlace] = self.places

    // MARK: - gui variables

    // создаем сёрч-бар
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.barTintColor = UIColor(named: "navBarColor")
        search.tintColor = UIColor.green
        search.searchTextField.textColor = .systemBlue
        search.placeholder = "search smth"
        search.sizeToFit()

        return search
    }()

    // MARK: - life cycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Places"

        self.tableView.keyboardDismissMode = .onDrag   // клава прячется при скролле
        self.tableView.allowsSelection = true
        self.tableView.separatorStyle = .singleLine
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(WAPlaceCell.self,
                                forCellReuseIdentifier: WAPlaceCell.reuseIdentifier)

        self.tableView.tableHeaderView = self.searchBar
        self.searchBar.delegate = self

        // добавляем возможность удаления строк таблицы

//        self.tableView.setEditing(true, animated: true)

        self.navigationItem.rightBarButtonItems = [self.editButtonItem]
    }

      // MARK: - likeNotification

    //отправляем уведомления
    private func sendLikeActionNotification(id: UUID) {
//        print("NOTIFICATION RECEIVED ON FAV CONTROLLER")
//        NotificationCenter.default.post(Notification(name: .placeLikeAction))
        let notificationInfo: [String: UUID] = ["id": id]
        NotificationCenter.default.post(name: .placeLikeAction,
                                        object: nil,
                                        userInfo: nil)
    }

      // MARK: - table view

//    // количество секций
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    // верхний хэдэр
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section header"
//    }

//    // секция справа от ячейки
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return ["1", "2", "3"]
//    }
//
    // количество ячеек таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredPlaces.count
    }

    // настройка ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt  indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WAPlaceCell.reuseIdentifier,
                                                 for: indexPath) as? WAPlaceCell ?? WAPlaceCell()

//        cell.backgroundColor = .lightGray
//        cell.textLabel?.text = "\(self.places[indexPath.row])"
//        cell.imageView?.image = UIImage(named: "chicago")
//        cell.detailTextLabel?.text = "Hello, I'm description"
//        cell.accessoryType = .detailButton
//        cell.setCellData(imageName: self.places[indexPath.row],
//                         imageDescription: self.description)

        // поменяли places на filteredPlaces
        cell.setCell(model: self.filteredPlaces[indexPath.row])
        cell.favouriteWasTapped = { [weak self] in    // предотвращает leaking cycle
            self?.places[indexPath.row].isFavourite.toggle()
            self?.sendLikeActionNotification(id: (self?.places[indexPath.row].id)!)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "You selected:",
                                      message: self.places[indexPath.row].title,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Оk", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("tapped")

        //        1. delete and reload all table view
        //        self.places.remove(at: indexPath.row)
        //        self.tableView.reloadData()
        //
        //        2. uppercase selected city and reload current cell
        //        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) was deselected")
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //        return .insert

        if indexPath.row == 0 {
            return .insert
        } else {
            return .delete
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:    // удаляем ячейки
            self.places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            print("try to insert cells")
        default:
            break
        }
    }

    //возможность двигать ячейки
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.places.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        self.tableView.reloadData()  // чтобы не было повторов в ячейках
    }

    //запрещаем пользователю искать во время редактирования (скрываем сёрчбар во время редактирования)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        self.searchBar.searchTextField.resignFirstResponder()   // прячет клаву при эдит
        self.searchBar.isHidden = editing
    }
}

//чтобы сёрч искал
extension WAPlacesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // блокируем эдит во время поиска
        self.navigationItem.rightBarButtonItems = searchText.isEmpty ? [self.editButtonItem] : nil
//        if searchText.isEmpty {
//            self.filteredPlaces = self.places
//        } else {
//            self.filteredPlaces = self.places.filter({ (place: WAPlace) -> Bool in
//                place.title.lowercased().contains(searchText.lowercased())
//            })
//            self.filteredPlaces = self.places.filter { $0.title.lowercased().contains(searchText.lowercased()) }
//        }
        self.filteredPlaces = searchText.isEmpty
            ? self.places
            : self.places.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    self.tableView.reloadData()
    }
}
