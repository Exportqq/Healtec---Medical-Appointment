import UIKit

final class TopDoctorsCV: UIView {
    
    var onDoctorSelected: ((DoctorsModel) -> Void)?
    
    private var topDoctors: [DoctorsModel] = []
    
    private var topDoctorsWithFiveStars: [DoctorsModel] {
        topDoctors.filter { abs($0.rating - 5.0) < 0.01 }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 108)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
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
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func fetchDoctors() {
        Task {
            do {
                let doctors = try await DoctorsService().getDoctors()
                self.topDoctors = doctors
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Ошибка загрузки данных:", error)
            }
        }
    }
}

extension TopDoctorsCV: UICollectionViewDataSource {
    
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

extension TopDoctorsCV: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDoctor = topDoctorsWithFiveStars[indexPath.item]
        onDoctorSelected?(selectedDoctor)
    }
}
