CREATE TABLE creditcard (
  id INT AUTO_INCREMENT,
  name VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE service (
  id INT AUTO_INCREMENT,
  content VARCHAR(100),
  PRIMARY KEY (id)
);

CREATE TABLE creditcard_service (
  creditcard_id INT,
  service_id INT,
  PRIMARY KEY (creditcard_id, service_id),
  FOREIGN KEY (creditcard_id) REFERENCES creditcard(id),
  FOREIGN KEY (service_id) REFERENCES service(id)
);

CREATE TABLE creditcard_service_user (
  creditcard_id INT,
  service_id INT,
  PRIMARY KEY (creditcard_id, service_id)
/*
  FOREIGN KEY (creditcard_id) REFERENCES creditcard_service(creditcard_id),
  FOREIGN KEY (service_id) REFERENCES creditcard_service(service_id)
*/
);

CREATE TABLE creditcard_service_result (
  creditcard_id INT,
  score FLOAT,
  PRIMARY KEY (creditcard_id, score),
  FOREIGN KEY (creditcard_id) REFERENCES creditcard(id)  
);

CREATE TABLE creditcard_service_result_zscore (
  creditcard_id INT,
  zscore FLOAT,
  PRIMARY KEY (creditcard_id, zscore),
  FOREIGN KEY (creditcard_id) REFERENCES creditcard(id)  
);


INSERT INTO creditcard (id, name) VALUES 
	(01, 'Orico Card THE POINT'), (02, '楽天カード'), (03, '三井住友VISAゴールドカード'), (04, 'エポスカード'), (05, 'Yahoo! JAPANカード'),
	(06, '三井住友VISAクラシックカード'), (07, 'Orico Card THE POINT PREMIUM GOLD'), (08, 'dカード GOLD'), (09, 'イオンカードセレクト'), 
	(10, 'JCB CARD W'), (11, 'REX CARD（レックスカード）'), (12, 'ビックカメラSuicaカード'), (13, '楽天ゴールドカード'), (14, 'リクルートカード'), 
	(15, 'イオンカード（WAON一体型）'), (16, 'イオンSuicaカード'), (17, 'dカード'), (18, 'アメリカン・エキスプレス・ゴールド・カード'),
	(19, '三菱UFJニコス VIASOカード'), (20, '「ビュー・スイカ」カード'), (21, 'JALカード CLUB-Aゴールドカード'), (22, 'セゾンカードインターナショナル'), 
	(23, 'ライフカード'), (24, '三井住友VISAプラチナカード'), (25, '楽天プレミアムカード'), (26, 'JCBゴールド'), (27, '三井住友VISAデビュープラスカード'), 
	(28, '出光カードまいどプラス'), (29, 'セブンカード・プラス'), (30, 'アメリカン・エキスプレス・カード'), (31, 'スターウッド プリファード ゲスト アメリカン・エキスプレス・カード'), 
	(32, 'JCBプラチナ'), (33, 'MUFGカード ゴールド'), (34, 'JALカード CLUB-Aカード'), (35, 'コスモ・ザ・カード・オーパス'), (36, 'MUFGカード・プラチナ・アメリカン・エキスプレス・カード'), 
	(37, 'JCB一般カード'), (38, 'ファミマTカード'), (39, 'ACマスタカード'), (40, '三井ショッピングカード《セゾン》'), (41, '三井住友VISAプライムゴールドカード'), 
	(42, 'ルミネカード'), (43, 'JCB CARD W plus L'), (44, 'Orico Card THE PLATINUM'), (45, 'NTTグループカード'), (46, 'ANAアメリカン・エキスプレス・カード'), 
	(47, 'セディナカード'), (48, 'JALカードSuica'), (49, 'シェル-Pontaクレジットカード'), (50, 'エポスプラチナカード');
	--, (), (), (), (), (), (), ;

INSERT INTO service (id, content) VALUES 
	(01, '入会キャンペーンを実施している！'), (02, 'ポイント還元率が高い'), (03, '“Amazon.co.jp” でのネットショッピングがお得になる！'), (04, '“Yahoo!ショッピング” でのネットショッピングがお得になる！'), 
	(05, '“楽天市場” でのネットショッピングがお得になる！'), (06, '街なかの買い物でちょっとしたお得がある！'), (07, '“セブンイレブン” におけるコンビニ支払いがお得に！'), 
	(08, '“ローソン” におけるコンビニ支払いがお得に！'), (09, '“ファミリーマート” におけるコンビニ支払いがお得に！'), (10, 'スーパーでの買い物がお得になる！'), 
	(11, '月々のスマホの支払いでお得になることができる！'), (12, '電車に乗るときにお得になる！そして乗り降りが便利になる！'), (13, 'ガソリンスタンドで使うとお得になる！'), 
	(14, 'このカードがあると空港ラウンジを利用することができる！'), (15, 'ANAマイルを有効的に貯めることができる！'), (16, 'JALマイルを有効的に貯めることができる！'), 
	(17, 'このカードは即日発行が可能！');
	
INSERT INTO service (id, content) VALUES 
	(21, '年会費は常に “無料”！'), (22, '年会費は “1円以上5,000円未満”'), (23, '年会費は “5,000円以上15,000円未満”'), (24, '年会費は “15,000円以上25,000円未満”'), 
	(25, '年会費は “25,000円以上”'), (26, '初年度のみ 年会費は無料！'), (27, '一定の条件を満たせば、年会費は無料！'); 

INSERT INTO service (id, content) VALUES 
	(31, '付帯保険として “海外旅行傷害保険” が付いている！'), (32, '付帯保険として “国内旅行傷害保険” が付いている！'), (33, '付帯保険として “ショッピング保険” が付いている！'), 
	(34, '付帯保険として “航空便遅延保険” が付いている！'), 
	(41, 'このカードは “プラチナカード”'), (42, 'このカードは “ゴールドカード”'), (43, 'このカードは “リボ払い専用カード”'), 
	(51, 'Tポイントを貯めることができる！'), (52, 'Pontaポイントを貯めることができる！'), (53, '楽天スーパーポイントを貯めることができる！'), 
	(61, '国際ブランド： “VISA” を扱っている'), (62, '国際ブランド： “Mastercard” を扱っている'), (63, '国際ブランド： “JCB” を扱っている'), 
	(64, '国際ブランド： “American Express（AMEX）” を扱っている'), (65, '国際ブランド： “Diners Club” を扱っている'); 


	

--select1の格納（付帯サービス）
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (01, 01), (01, 02), (01, 03), (01, 04), (01, 05);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (02, 01), (02, 02), (02, 05), (02, 06);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (03, 01), (03, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (04, 01), (04, 06), (04, 10), (04, 17);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (05, 01), (05, 02), (05, 04);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (06, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (07, 01), (07, 02), (07, 03), (07, 04), (07, 05);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (08, 01), (08, 02), (08, 08), (08, 11), (08, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (09, 01), (09, 10);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (10, 01), (10, 02), (10, 03), (10, 06), (10, 07);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (11, 01), (11, 02);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (12, 01), (12, 06), (12, 12);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (13, 01), (13, 02), (13, 05), (13, 06), (13, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (14, 01), (14, 02);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (15, 01), (15, 10);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (16, 01), (16, 10);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (17, 01), (17, 02), (17, 08), (17, 11);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (18, 01), (18, 14), (18, 15);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (19, 01), (19, 11);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (20, 01), (20, 12);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (21, 01), (21, 06), (21, 14), (21, 16);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (22, 01), (22, 06), (22, 10), (21, 17);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (23, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (24, 01), (24, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (25, 01), (25, 02), (25, 05), (25, 06), (25, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (26, 01), (26, 06), (26, 07), (26, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (27, 01), (27, 02);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (28, 13);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (29, 01), (29, 07);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (30, 01), (30, 14), (30, 15);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (31, 14), (31, 15), (31, 16);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (32, 03), (32, 07);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (33, 01), (33, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (34, 01), (34, 06), (34, 16);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (35, 01), (35, 10), (35, 13);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (36, 01), (36, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (37, 01), (37, 06), (37, 07);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (38, 01), (38, 09);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (39, 17);
--INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (40, 00);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (41, 01), (41, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (42, 01), (42, 06), (42, 17);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (43, 01), (43, 02), (43, 03), (43, 06), (43, 07);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (44, 02), (44, 03), (44, 04), (44, 05), (44, 13), (44, 14);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (45, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (46, 01), (46, 06), (46, 14), (46, 15);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (47, 01), (47, 06), (47, 07);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (48, 01), (48, 06), (48, 12), (48, 16);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (49, 01), (49, 02), (49, 13);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (50, 06), (50, 10), (50, 14);


--select2の格納（年会費）
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES 
	(01, 21), (02, 21), (03, 23), (04, 21), (05, 21), (06, 22), (06, 27), (07, 22), (08, 23), (09, 21), (10, 21), 
	(11, 21), (12, 22), (12, 26), (12, 27), (13, 22), (14, 21), (15, 21), (16, 21), (17, 22), (17, 26), (17, 27), (18, 25), (18, 26), (19, 21), (20, 22), 
	(21, 24), (22, 21), (23, 21), (24, 25), (25, 23), (26, 23), (26, 26), (27, 22), (27, 26), (27, 27), (28, 21), (29, 22), (29, 26), (29, 27), (30, 23), (30, 26), 
	(31, 25), (32, 25), (33, 22), (33, 26), (34, 23), (35, 21), (36, 25), (37, 22), (37, 26), (37, 27), (38, 21), (39, 21), (40, 21),  
	(41, 23), (41, 26), (42, 22), (42, 26), (43, 21), (44, 24), (45, 21),(45, 27),(46, 23),(47, 21),(48, 22), (48, 26), (49, 22), (49, 26), (49, 27), (50, 25); 

--select3の格納（保険、種類、ポイント、国際ブランド）
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES 
	(01, 62), (01, 63), (02, 31), (02, 53), (02, 61), (02, 62), (02, 63), (03, 31), (03, 32), (03, 33), (03, 42), (03, 61), (03, 62), (04, 31), (04, 61), 
	(05, 33), (05, 51), (05, 61), (05, 62), (05, 63), (06, 31), (06, 33), (06, 61), (06, 62), (07, 31), (07, 32), (07, 33), (07, 42), (07, 62), (07, 63),  
	(08, 31), (08, 32), (08, 33), (08, 34), (08, 42), (08, 61), (08, 62), (09, 33), (09, 61), (09, 62), (09, 63), (10, 31), (10, 33), (10, 63), 
	(11, 31), (11, 32), (11, 61), (12, 31), (12, 32), (12, 61), (12, 63), (13, 31), (13, 42), (13, 53), (13, 61), (13, 62), (13, 63), 
	(14, 31), (14, 32), (14, 33), (14, 61), (14, 62), (14, 63), (15, 33), (15, 61), (15, 62), (15, 63), (16, 31), (16, 32), (16, 33), (16, 61), (16, 62), (16, 63), 
	(17, 33), (17, 61), (17, 62), (18, 31), (18, 32), (18, 33), (18, 34), (18, 42), (18, 64), (19, 31), (19, 33), (19, 62), 
	(20, 31), (20, 32), (20, 61), (20, 62), (20, 63), (21, 31), (21, 32), (21, 33), (21, 34), (21, 42), (21, 61), (21, 62), (21, 63), (22, 61), (22, 62), (22, 63), 
	(23, 61), (23, 62), (23, 63), (24, 31), (24, 32), (24, 33), (24, 34), (24, 41), (24, 61), (24, 62), 
	(25, 31), (25, 32), (25, 33), (25, 42), (25, 53), (25, 61), (25, 62), (25, 63), (26, 31), (26, 32), (26, 33), (26, 34), (26, 42), (26, 63), (27, 33), (27, 61), 
	(28, 61), (28, 62), (28, 63), (28, 64), (29, 33), (29, 61), (29, 63), (30, 31), (30, 32), (30, 33), (30, 64), 
	(31, 31), (31, 32), (31, 33), (31, 34), (31, 42), (31, 64), (32, 31), (32, 32), (32, 33), (32, 34), (32, 41), (32, 63), 
	(33, 31), (33, 32), (33, 33), (33, 34), (33, 42), (33, 61), (33, 62), (33, 63), (34, 31), (34, 32), (34, 33), (34, 61), (34, 62), (34, 63), 
	(35, 33), (35, 61), (35, 62), (35, 63), (36, 31), (36, 32), (36, 33), (36, 34), (36, 41), (36, 64), (37, 31), (37, 32), (37, 33), (37, 63), 
	(38, 33), (38, 51), (38, 63), (39, 43), (39, 62), (40, 61), (40, 62), (40, 63), (40, 64), (41, 31), (41, 32), (41, 33), (41, 42), (41, 61), (41, 62), 
	(42, 31), (42, 32), (42, 61), (42, 62), (42, 63), (43, 31), (43, 33), (43, 63), (44, 31), (44, 32), (44, 33), (44, 41), (44, 62), (45, 33), (45, 61), (45, 62), 
	(46, 31), (46, 32), (46, 33), (46, 64), (47, 33), (47, 61), (47, 62), (47, 63), (48, 31), (48, 32), (48, 63), (49, 31), (49, 33), (49, 52), (49, 61), (50, 31), (50,32), (50, 41), (50, 61);
