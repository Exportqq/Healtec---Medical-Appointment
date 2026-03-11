import UIKit

final class DoctorsListFavouriteCV: UIView {

    var onDoctorSelected: ((DoctorsModel) -> Void)?

    private var allDoctors: [DoctorsModel] = []
    private var doctors: [DoctorsModel] = []      
    private var filterDoctors: [DoctorsModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 65) / 2, height: 205)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.register(DoctorsCell.self, forCellWithReuseIdentifier: "ProductCardCell")
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
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func fetchDoctors() {
        Task {
            do {
                let doctor = try await DoctorsService().getDoctors()
                self.allDoctors = doctor
                self.doctors = doctor
                
                print("Все болезни у всех врачей:", allDoctors.map { $0.diseases })
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Ошибка загрузки данных:", error)
            }
        }
    }

    func filterDoctors(by filter: String) {
        if filter.contains("All") {
            doctors = allDoctors
        } else {
            let cleaned = filter.components(separatedBy: " ").last?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
            
            doctors = allDoctors.filter { doctor in
                doctor.diseases.contains { disease in
                    disease.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == cleaned
                }
            }
        }
        print("Отображаемые врачи:", doctors.map { $0.name })
        collectionView.reloadData()
    }
    
    func filterDoctorsByName(_ name: String) {
        
        if name.isEmpty {
            doctors = allDoctors
        } else {
            doctors = allDoctors.filter { $0.name.lowercased().contains(name.lowercased())}
        }
        
        collectionView.reloadData()
    }
}

extension DoctorsListFavouriteCV: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(doctors.count, 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCardCell", for: indexPath) as? DoctorsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: doctors[indexPath.item])
        return cell
    }
}

extension DoctorsListFavouriteCV: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDoctor = doctors[indexPath.item]
        onDoctorSelected?(selectedDoctor)
    }
}



