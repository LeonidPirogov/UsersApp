//
//  UsersMapViewController.swift
//  UsersApp
//
//  Created by Leonid on 05.09.2025.
//

import UIKit
import MapKit

final class UsersMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    private let store = UsersStore()
    private var index = AnnotationIndex()
    
    var singleUser: User? { didSet { focusIfPossibleOrDefer() } }
    private var pendingFocusUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(UserPinView.self, forAnnotationViewWithReuseIdentifier: UserPinView.reuseID)
        loadUsers()
    }
    
    private func loadUsers() {
        store.load { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                    switch result {
                    case .success(let userAnnotations):
                        self.index.rebuild(from: userAnnotations)
                        self.mapView.addAnnotations(userAnnotations)

                        if self.pendingFocusUser == nil && self.singleUser == nil {
                            self.mapView.showAnnotations(userAnnotations, animated: true)
                        } else {
                            self.focusIfPossibleOrDefer()
                        }

                    case .failure(let error):
                        let alert = UIAlertController(
                            title: "Ошибка загрузки",
                            message: error.localizedDescription,
                            preferredStyle: .alert
                        )
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    
    private func focusIfPossibleOrDefer() {
        guard let user = singleUser else { return }
            if isViewLoaded {
                focus(on: user)
            } else {
                pendingFocusUser = user
            }
    }
    
    private func focus(on user: User) {
        
        guard let userAnnotation = index.find(user) else { pendingFocusUser = user; return }

        let region = MKCoordinateRegion(
            center: userAnnotation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        )
        mapView.setRegion(region, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.mapView.selectAnnotation(userAnnotation, animated: true)
        }
        pendingFocusUser = nil
    }
}

// MARK: - MKMapViewDelegate
extension UsersMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        return mapView.dequeueReusableAnnotationView(withIdentifier: UserPinView.reuseID, for: annotation)
    }
        
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl
    ) {
        guard let userAnnotation = view.annotation as? UserAnnotation else { return }
        MapRouter(navigationController: navigationController).showDetails(for: userAnnotation.user)
    }
}
