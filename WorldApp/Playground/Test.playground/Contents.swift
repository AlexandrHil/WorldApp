//: A UIKit based Playground for presenting user interface
import UIKit
import PlaygroundSupport

class PhotoView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chicago.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.maskedCorners = [.layerMinXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var imageName: UILabel = {
        let label = UILabel()
        label.text = "Chicago"
        label.font = UIFont.boldSystemFont(ofSize: 25)

        return label
    }()

    private lazy var imageDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The City of Chicago covers an area of 60,000 hectares and sits 176 meters (578 feet) above sea level on the southwestern shore of Lake Michigan. At 190 km wide and 495 km long, its the 5th largest body of fresh water in the world."

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initView()
    }

    init() {
        super.init(frame: CGRect.zero)

        self.initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = UIColor.lightGray

        self.layer.cornerRadius = 15

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = CGSize(width: 0, height: 0)

        self.addSubview(self.imageView)
        self.addSubview(self.imageName)
        self.addSubview(self.imageDescription)
    }

    override func updateConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            self.imageName.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 15),
            self.imageName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.imageName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            self.imageDescription.topAnchor.constraint(equalTo: self.imageName.bottomAnchor, constant: 5),
            self.imageDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            self.imageDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 15),
            self.imageDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15)
        ])

        super.updateConstraints()
    }
}
class MyViewController: UIViewController {

    private lazy var contentView = PhotoView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.view.addSubview(contentView)

        self.setUpConstraints()
    }

    func setUpConstraints() {
        self.view.addConstraints([
            NSLayoutConstraint(item: self.contentView, attribute: .top, relatedBy: .equal,
                               toItem: self.view, attribute: .top,
                               multiplier: 1, constant: 100),
            NSLayoutConstraint(item: self.contentView, attribute: .left, relatedBy: .equal,
                               toItem: self.view, attribute: .left,
                               multiplier: 1, constant: 50),
            NSLayoutConstraint(item: self.contentView, attribute: .right, relatedBy: .equal,
                               toItem: self.view, attribute: .right,
                               multiplier: 1, constant: -50),
            NSLayoutConstraint(item: self.contentView, attribute: .height, relatedBy: .equal,
                               toItem: nil, attribute: .notAnAttribute,
                               multiplier: 1, constant: 250)
        ])
    }
}
// Present the view controller in the Live View window
let controller = MyViewController()
PlaygroundPage.current.liveView = MyViewController().view
