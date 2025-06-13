//
//  Profile.swift
//  CampusNavigator
//
//  Created by Geeneth on 2025-06-13.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var profileImage: UIImage? = nil
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Image
                    ZStack(alignment: .bottomTrailing) {
                        Group {
                            if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray.opacity(0.6))
                            }
                        }
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .shadow(radius: 4)

                        Button(action: {
                            isImagePickerPresented.toggle()
                        }) {
                            Image(systemName: "camera.fill")
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .offset(x: -10, y: -10)
                    }
                    .padding(.top, 40)

                    // User Info
                    VStack(spacing: 12) {
                        ProfileInfoCard(title: "Full Name", value: "John Doe")
                        ProfileInfoCard(title: "Date of Birth", value: "2001-05-15")
                        ProfileInfoCard(title: "Address", value: "123 Apple Lane, Cupertino, CA")
                        ProfileInfoCard(title: "Student ID", value: "STU123456")
                        ProfileInfoCard(title: "Student Email", value: "john.doe@university.edu")
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("My Profile")
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $profileImage)
            }
        }
    }
}

// MARK: - Info Card View
struct ProfileInfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
                .fontWeight(.medium)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
        }
    }
}
