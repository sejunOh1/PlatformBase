package unicore.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BcryptVerifier {
    public static void main(String[] args) {
        // 1) 해시로 바꾸고 싶은 평문을 여기에 입력하세요
        String rawPassword = "admin1234";

        // 2) BCryptPasswordEncoder 생성
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        // 3) 해시 생성
        String hashed = encoder.encode(rawPassword);

        // 4) 결과 출력
        System.out.println("Raw   : " + rawPassword);
        System.out.println("Hashed: " + hashed);
    }
}