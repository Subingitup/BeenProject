package com.spring.pet.users;

import org.json.JSONObject;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

@Component
public class KakaoService {
    public String getAccessToken(String code) {
        String accessToken = null;
        try {
            // HTTP POST 요청을 만듭니다.
            String url = "https://kauth.kakao.com/oauth/token";
            
            
  //          String body = "grant_type=authorization_code" +
   //                 "&client_id=1a705d08cde8b1fe4e40ecb2ddbe8d45" +
//                    "&redirect_uri=http://www.petmedic.kro.kr/kakaologin" +
//                    "&code=" + code;
            String body = "grant_type=authorization_code" +
            		"&client_id=1a705d08cde8b1fe4e40ecb2ddbe8d45" +
            		"&redirect_uri=http://localhost:8090/kakaologin" +
            		"&code=" + code;
            
            
            
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
            con.setDoOutput(true);

            // 요청 본문을 전송합니다.
            OutputStreamWriter wr = new OutputStreamWriter(con.getOutputStream(), "utf-8");
            wr.write(body);
            wr.flush();

            // 응답을 읽어옵니다.
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // 응답에서 access token 값을 추출합니다.
            JSONObject jsonObj = new JSONObject(response.toString());
            accessToken = jsonObj.getString("access_token");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return accessToken;
    }

    public KakaoUser getUserInfo(String accessToken) {
        KakaoUser user = null;
        try {
            // HTTP GET 요청을 만듭니다.
            String url = "https://kapi.kakao.com/v2/user/me";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", "Bearer " + accessToken);

            // 응답을 읽어옵니다.
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // 응답에서 사용자 정보를 추출합니다.
            JSONObject jsonObj = new JSONObject(response.toString());
            long id = jsonObj.getLong("id");
            String nickname = jsonObj.getJSONObject("properties").getString("nickname");
            // String profileImage = jsonObj.getJSONObject("properties").getString("profile_image");
            String email = jsonObj.getJSONObject("kakao_account").getString("email");

            // API에서 사용자 정보 추가한후에 아래 phone에서 가져오도록 수정하면 됩니다.
            String phone = "";
            user = new KakaoUser(id, nickname, "", email, phone);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
}