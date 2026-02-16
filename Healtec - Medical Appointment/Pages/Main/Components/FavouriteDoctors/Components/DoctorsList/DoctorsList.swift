import UIKit

final class DoctorsListView: UIView {
    
    private var doctors: [DoctorsModel] = []
    
    private let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 65) / 2, height: 205)
        layout.minimumLineSpacing = 15
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        setupView()
        fetchDoctors()
    }
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 65) / 2, height: 205)
        layout.minimumLineSpacing = 15
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(coder: coder)
        setupView()
        fetchDoctors()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.register(DoctorsCell.self, forCellWithReuseIdentifier: "DoctorsCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func fetchDoctors() {
        Task {
            do {
                let result = try await DoctorsService().getDoctors()
                self.doctors = result
                
                await MainActor.run {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Ошибка загрузки данных:", error)
            }
        }
    }
}

extension DoctorsListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        doctors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DoctorsCell",
            for: indexPath
        ) as! DoctorsCell
        
        cell.configure(with: doctors[indexPath.item])
        return cell
    }
}
