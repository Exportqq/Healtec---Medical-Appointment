import UIKit

final class TopDoctorsListCV: UIView, UICollectionViewDataSource {
    
    private var topDoctors: [DoctorsModel] = []
    private var topDoctorsWithFiveStars: [DoctorsModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 90, height: 120)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.register(TopDoctorsCell.self, forCellWithReuseIdentifier: "TopDoctorsCell")
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceHorizontal = true
        cv.clipsToBounds = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fetchDoctors()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        fetchDoctors()
    }
    
    private func setupView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func fetchDoctors() {
        Task {
            do {
                let doctors = try await DoctorsService().getDoctors()
                self.topDoctors = doctors
                self.topDoctorsWithFiveStars = doctors.filter { $0.rating == 5.0 }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Ошибка загрузки данных:", error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        topDoctorsWithFiveStars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopDoctorsCell", for: indexPath) as? TopDoctorsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: topDoctorsWithFiveStars[indexPath.item])
        return cell
    }
}
