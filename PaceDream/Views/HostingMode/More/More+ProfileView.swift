////
//  More+ProfileView.swift
//  bug-free-goggles
//
//  Created by Mac on 26/07/2023.
//

import SwiftUI

struct More_ProfileView: View {
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                AvatarView(imageName: "moc_profilePic", borderColor: .blue, borderWidth: 0.0)
                VStack(alignment:.leading){
                    Text("Sihyun Chae")
                        .font(.circular(size: 18,weight: .medium))
                    Text("View and edit profile")
                        .font(.circular(size: 15,weight: .book))
                        .foregroundColor(.darkIndigo)
                }
                
                Spacer()
            }
            .padding(.leading,10)
            Divider()
                .padding(.horizontal)
            
            SwitchModeButton(title: "Switch to guest mode", action: {
            })
                .padding(.top,20)
            //HStack{
            VStack(alignment: .leading,spacing: 25) {
                
                ProfileListItem(title:"Account",icon: "person.crop.circle")
                ProfileListItem(title:"Transaction History",icon: "list.clipboard")
                ProfileListItem(title:"Tax Information",icon: "list.bullet.rectangle")
                ProfileListItem(title:"Gift Card",icon: "gift")
                ProfileListItem(title:"How PaceDream works",icon: "key.horizontal")
                ProfileListItem(title:"Contact Support",icon: "headphones")
                ProfileListItem(title:"Legal",icon: "list.star")
            }
            
            .padding(10)
            
            
            
            Divider()
                .padding(.horizontal)
                .padding(.top)
            LogoutButton()
                .frame(maxWidth: .infinity,alignment:.center)
                .padding(.top,30)
            
            Spacer()
            
        }
        .background(Color("GrayBackground"))
        .padding()
    }
}

struct LogoutButton: View {
    var body: some View {
        Button(action: {
            
        }) {
            Label("Logout", systemImage: "power")
                .labelStyle(.titleAndIcon)
            
        }
        
        .frame(maxWidth: 140)
        .font(.circular(size: 17, weight: .medium))
        .padding(.vertical, 14)
        .foregroundColor(.red)
        .background(
            Color.red.opacity(0.3)
        )
        .clipShape(Capsule())
    }
}

struct ProfileListItem: View {
    let title: String
    let icon: String
    var body: some View {
        HStack {
            Image(systemName:icon)
                .bold()
                .frame(width:25,height: 25)
                .padding(.trailing,10)
            Text(title)
                .font(.circular(size: 20,weight:.book))
            
        }
        .foregroundColor(.black.opacity(0.7))
    }
}
struct SwitchModeButton: View {
    var title:String
    let action: () -> Void
     
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.darkIndigo)
                    .frame(height: 55)
                
                HStack {
                    
                    Text(title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.headline)
                }
            }
            .padding(.horizontal, 10)
        }
       
    }
}
struct AvatarView: View {
    let imageName: String
    let borderColor: Color
    let borderWidth: CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 65, height: 65)
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: borderWidth))
    }
}

struct More_ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        More_ProfileView()
    }
}
