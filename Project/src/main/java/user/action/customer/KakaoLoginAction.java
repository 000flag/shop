package user.action.customer;

import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class KakaoLoginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String code = request.getParameter("code"); // 카카오 인증 코드
        String clientId = "274018667b4194489ad21f128fe91165"; // 카카오 REST API 키
        String redirectUri = "http://localhost:8080/Controller?type=kakaoCallback";

        try {
            // 1. 액세스 토큰 요청
            String accessToken = getAccessToken(code, clientId, redirectUri);

            // 2. 사용자 정보 요청
            if (accessToken != null) {
                JSONObject userInfo = getUserInfo(accessToken);

                if (userInfo != null) {
                    // 사용자 정보를 세션에 저장
                    HttpSession session = request.getSession();
                    String nickname = userInfo.getJSONObject("properties").getString("nickname");
                    session.setAttribute("nickname", nickname);
                    System.out.println("카카오 로그인 성공: " + nickname);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "/user/customer/jsp/index.jsp"; // 로그인 성공 후 메인 페이지로 이동
    }

    // 액세스 토큰 요청 메서드
    private String getAccessToken(String code, String clientId, String redirectUri) throws Exception {
        URL url = new URL("https://kauth.kakao.com/oauth/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        String params = "grant_type=authorization_code" +
                "&client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&code=" + code;

        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes());
            os.flush();
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseString = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseString.append(line);
            }
            br.close();

            JSONObject jsonResponse = new JSONObject(responseString.toString());
            return jsonResponse.getString("access_token");
        } else {
            System.out.println("액세스 토큰 요청 실패");
        }

        return null;
    }

    // 사용자 정보 요청 메서드
    private JSONObject getUserInfo(String accessToken) throws Exception {
        URL url = new URL("https://kapi.kakao.com/v2/user/me");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseString = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseString.append(line);
            }
            br.close();

            return new JSONObject(responseString.toString());
        } else {
            System.out.println("사용자 정보 요청 실패");
        }

        return null;
    }
}
