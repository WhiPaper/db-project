USE pc_room_management;

-- 피시방 회원 등급제 테이블 초기화
-- 1. DIAMOND 등급 추가
INSERT INTO `Grades` 
( 
    `gradeName`, 
    `minSpend`, 
    `discountRate`  
) 
VALUES 
( 
    'DIAMOND', 
    '1000000', 
    '10'  
);
-- 2. PLATINUM 등급 추가
INSERT INTO `Grades` 
( 
    `gradeName`, 
    `minSpend`, 
    `discountRate`  
) 
VALUES 
( 
    'PLATINUM', 
    '700000', 
    '7'  
);
-- 3. GOLD 등급 추가
INSERT INTO `Grades` 
( 
    `gradeName`, 
    `minSpend`, 
    `discountRate`  
) 
VALUES 
( 
    'GOLD', 
    '500000', 
    '5'  
);
-- 4. SILVER 등급 추가
INSERT INTO `Grades` 
( 
    `gradeName`, 
    `minSpend`, 
    `discountRate`  
) 
VALUES 
( 
    'SILVER', 
    '300000', 
    '3'  
);
-- 5. BRONZE 등급 추가
INSERT INTO `Grades` 
( 
    `gradeName`, 
    `minSpend`, 
    `discountRate`  
) 
VALUES 
( 
    'BRONZE', 
    '0', 
    '0'  
);

-- member 테이블 임시 데이터 삽입
INSERT INTO member (pc_room_id, name, phone, email, grade, remainTime) VALUES
('koiwa', '박종훈', '01025910321', 'koiwathrill@naver.com', 'DIAMOND', 180),
('sdfwz', '김민수', '01012345678', 'kimminsu@example.com', 'PLATINUM', 120),
('wknfl', '이영희', '01098765432', 'leeyounghee@example.com', 'GOLD', 60);

-- products 테이블 임시 데이터 삽입
INSERT INTO products (productName, currentPrice, timeValue, stock) VALUES
('새우탕면', 1000, 60, 100),
('짜장면', 900, 60, 100),
('카레라이스', 1200, 60, 50),
('콜라', 1500, 0, 200),
('사이다', 1500, 0, 200),
('3시간권', 5000, 180, 100),
('5시간권', 8000, 300, 50),
('10시간권', 15000, 600, 30);