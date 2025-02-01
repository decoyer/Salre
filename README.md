# 살래?
P2P Realty Marketplace with *Spring Framework*

using *MySQL Database*

## Details
![Salre](https://github.com/user-attachments/assets/16600a3a-562a-4674-85e8-58f550d33003)

### <div align="center">찾고, 보고, 사고 내가 원하는 부동산</div>

## Key Features
- ```회원 관리```
- ```매물 관리```
- ```온라인 계약```
- ```알림 서비스```
- ```커뮤니티(채팅, 게시판)```
- ```대출상품 추천```

## Getting Started
![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)

```http://localhost:8080/salre/```

```
apikey.properties
mysqlDB.properties
database.sql
```
- *apikey.properties* ```..\src\main\webapp\WEB-INF\spring\```
  - 본인인증 API 키 발급 필요([포트원 API 가이드](https://developers.portone.io/opi/ko/extra/identity-verification/v1/phone/readme?v=v1))
  - 카카오맵 API 키 발급 필요([카카오맵 API 가이드](https://apis.map.kakao.com/web/guide/))

    ```INI
    # 예시
    
    # 본인인증 API
    impKey=imp12345678
    impKey2=1234567890123456
    impSecret=TkclfeBw4uAaPWgeY5fRdOeifqSHLVA0BnB0CWY8sOuCWXEVlBCcHXD1xEhNINFVXL53du4DwPwLRz8B

    channelKey={channel-key-b2bd2116-d93d-4316-8838-951c47abfb02}

    # 카카오맵 API
    appkey=tpvp23hi47ldx0qxeqb3gzltxmdzw2aq
    ```
- *mysqlDB.properties* ```..\src\main\webapp\WEB-INF\spring\```
  - 데이터베이스 정보 입력(다른 DBMS로 대체 가능)

    ```INI
    # 예시
    
    driverClassName=com.mysql.cj.jdbc.Driver
    url=jdbc:mysql://localhost:3306/salre?characterEncoding=UTF-8
    username=root
    password=1234
    ```
- *database.sql*
  - MySQL 기준 작성
  - 데이터 추가, 수정, 삭제(유동적으로 활용 가능)

## Tasks
- [ ] 관리자 페이지 기능 개선
- [ ] 게시물 검색 및 정렬 기능 구현
- [ ] 채팅방 이미지 첨부 지원
- [ ] 전자서명 본인인증 프로세스 추가
- [ ] 대출상품 기반 매물 추천
