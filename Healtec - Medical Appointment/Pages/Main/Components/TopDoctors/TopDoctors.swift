import UIKit

final class TopDoctorsCV: UIView {
    
    var onDoctorSelected: ((DoctorsModel) -> Void)?
    
    private var topDoctors: [DoctorsModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 108)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.register(TopDoctorsCell.self, forCellWithReuseIdentifier: "TopDoctorsCell")
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
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
            collectionView.bottomAnchor.constraint(equalTo:  bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func fetchDoctors() {
        Task {
            do {
                let doctor = try await DoctorsService().getDoctors()
                self.topDoctors = doctor
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
        return min(topDoctors.count, 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopDoctorsCell", for: indexPath) as? TopDoctorsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: topDoctors[indexPath.item])
        return cell
    }
}

extension TopDoctorsCV: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDoctor = topDoctors[indexPath.item]
        onDoctorSelected?(selectedDoctor)
    }
}



