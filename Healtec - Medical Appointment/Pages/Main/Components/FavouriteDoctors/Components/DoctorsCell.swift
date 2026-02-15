import UIKit

final class DoctorsCell: UICollectionViewCell {
    private let card = DoctorCardUIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with doctor: DoctorsModel) {
        card.doctorInfo.doctorName.text = doctor.name
        card.doctorInfo.doctorSpeciality.text = doctor.specialty
        card.doctorInfo.doctorRaiting.text = "\(doctor.rating)"
        card.doctorImage.image = doctor.image
    }
}

//let id: Int
//let name: String
//let specialty: String
//let rating: Double
//let photo: String
//let experience: String
//let patientsCount: String
//let reviewsCount: String
//let description: String
//let diseases: [String]
