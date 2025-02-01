package com.salre.main.login;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class SignUpService {
	@Autowired
    private ApplicationContext applicationContext;
    
    private static String impKey;
    private static String impSecret;
    
    @PostConstruct
    public void init() {
        Properties props = (Properties) applicationContext.getBean("apikey");
        impKey = props.getProperty("impKey");
        impSecret = props.getProperty("impSecret");
    }

	public static HashMap getAccessToken(String impUid) {
		HashMap map = new HashMap<>();
		System.out.println("impUid");
		
		String strUrl = "https://api.iamport.kr/users/getToken"; // 토큰 요청 API URL
		String access_token = "";
		String phone = "";
		String name = "";

		try {
			URL url = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // URL Http 연결 생성

			// POST 요청
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);// outputStream으로 post 데이터를 넘김

			conn.setRequestProperty("content-Type", "application/json");
			conn.setRequestProperty("Accept", "application/json");

			// 파라미터 설정
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

			JSONObject requestData = new JSONObject();
			requestData.put("imp_key", impKey);
			requestData.put("imp_secret", impSecret);

			bw.write(requestData.toString());
			bw.flush();
			bw.close();

			int resposeCode = conn.getResponseCode();

			System.out.println("�����ڵ� =============" + resposeCode);
			if (resposeCode == 200) {// ����
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				StringBuilder sb = new StringBuilder();
				String line;
				while ((line = br.readLine()) != null) {
					sb.append(line + "\n");
				}

				br.close();

				// 토큰 응답 처리
				String response = sb.toString();
				JsonParser parser = new JsonParser();
				JsonObject responseJson = parser.parse(response).getAsJsonObject();
				access_token = responseJson.getAsJsonObject("response").get("access_token").getAsString();
				System.out.println("Access Token: " + access_token);

				// 인증정보를 통해 사용자 정보 가져오기
				String getPaymentUrl = "https://api.iamport.kr/certifications/" + impUid;
				HttpURLConnection getConn = (HttpURLConnection) new URL(getPaymentUrl).openConnection();
				getConn.setRequestMethod("GET");
				getConn.setRequestProperty("Content-Type", "application/json");
				getConn.setRequestProperty("Authorization", "Bearer " + access_token);

				int getResponseCode = getConn.getResponseCode();
				System.out.println("GET 응답코드 =============" + getResponseCode);

				if (getResponseCode == 200) { // 성공
					BufferedReader getBr = new BufferedReader(new InputStreamReader(getConn.getInputStream()));
					StringBuilder getResponseSb = new StringBuilder();
					String getLine;
					while ((getLine = getBr.readLine()) != null) {
						getResponseSb.append(getLine).append("\n");
					}
					getBr.close();

					String getResponse = getResponseSb.toString();
					System.out.println("GET 응답 데이터: " + getResponse);
					JsonParser parser1 = new JsonParser();
					JsonObject phoneJson1 = parser1.parse(getResponse).getAsJsonObject();

					// 전화번호 값 가져오기
					phone = phoneJson1.getAsJsonObject("response").get("phone").getAsString();
					System.out.println("phone: " + phone);

					map.put("phone", phone);
					// 이름 값 가져오기
					name = phoneJson1.getAsJsonObject("response").get("name").getAsString();
					System.out.println("이름>>>>>" + name);
					map.put("name", name);

				} else {
					System.out.println("GET 요청 실패 메시지:  " + getConn.getResponseMessage());
				}
			} else {
				System.out.println(conn.getResponseMessage());
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return map;
	}

}
