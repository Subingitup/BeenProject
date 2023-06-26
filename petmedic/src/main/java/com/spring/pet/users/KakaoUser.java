package com.spring.pet.users;

public class KakaoUser {
    private long id;
    private String nickname;
    private String profileImage;
    private String email;

    private String phone;

    public KakaoUser(long id, String nickname, String profileImage, String email, String phone) {
        this.id = id;
        this.nickname = nickname;
        this.profileImage = profileImage;
        this.email = email;
        this.phone = phone;
    }

    public long getId() {
        return id;
    }

    public String getNickname() {
        return nickname;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }
}
