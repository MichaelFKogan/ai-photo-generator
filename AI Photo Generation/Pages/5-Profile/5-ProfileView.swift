//
//  ProfileView.swift
//  AI Photo Generation
//
//  Created by Mike K on 10/9/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile header
                    HStack(alignment: .top, spacing: 16) {
                        // Profile image
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue)
                            )
                        
                        VStack(alignment: .leading, spacing: 12) {
                            VStack(spacing: 4) {
                                Text("Your Name")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text("@username")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            // Stats
                            HStack(spacing: 32) {
                                VStack {
                                    Text("24")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Text("Creations")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                VStack {
                                    Text("156")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Text("Likes")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                VStack {
                                    Text("89")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal)
                    
                    // Edit profile button
                    Button(action: {}) {
                        Text("Edit Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // User's creations grid
                    VStack(alignment: .leading, spacing: 16) {
                        Text("My Creations")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                            ForEach(0..<15, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .aspectRatio(1, contentMode: .fit)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.title3)
                                            .foregroundColor(.gray)
                                    )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView().environmentObject(authViewModel)) {
                        Image(systemName: "gearshape.fill")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
