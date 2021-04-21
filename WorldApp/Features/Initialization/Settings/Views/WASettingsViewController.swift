//
//  WASettingsViewController.swift
//  WorldApp
//
//  Created by Alex on 6.03.21.
//

import UIKit

class WASettigsViewController: WAViewController {

    enum Cities: String, CaseIterable {
        case chicago, minsk, gomel, cardiff, moscow, paris, kyiv, cairo

        static var stringCities: [String] {
            Cities.allCases.map { (city) -> String in
                return city.rawValue.capitalized
            }
        }
    }

    private lazy var cityTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 28)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = self.picker
        textField.inputAccessoryView = self.doneToolBar
        // чтобы отобразить тулбар над пикером

        return textField
    }()

    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    // создаем тулбар для того, чтобы можно было убирать пикер по нажатию на кнопку готово
    private lazy var doneToolBar: UIToolbar = {
        let toolbar = UIToolbar()

        toolbar.tintColor = .black
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), // раздвинули кнопки
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        ]

        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "Settings"

        self.view.addSubview(self.cityTextField)

//        let blueView = UIView()
//        blueView.backgroundColor = .blue
//        self.mainView.addSubview(blueView)

        self.cityTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(25)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(50)
        }

//        blueView.snp.makeConstraints { (make) in
//            make.top.equalTo(cityTextField.snp.bottom).offset(25)
//            make.left.right.equalToSuperview().inset(25)
//            make.height.equalTo(1250)
//            make.bottom.equalToSuperview()
//        }
//        // установили констрейнты
    }

    @objc func doneTapped() {
        // скрываем клавиатуру
        self.cityTextField.resignFirstResponder()
    }

    @objc func cancelTapped() {
        self.cityTextField.resignFirstResponder()
    }
}

extension WASettigsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Cities.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Cities.stringCities[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        выбранное значение сетаем в текстовое поле
        self.cityTextField.text = Cities.stringCities[row]
    }
}
