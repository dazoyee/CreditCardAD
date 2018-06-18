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

INSERT INTO creditcard (id, name) VALUES 
	(01, 'Orico Card THE POINT'), (02, '楽天カード'), (03, '三井住友VISAゴールドカード'), (04, 'エポスカード'), (05, 'Yahoo! JAPANカード');
/*
INSERT INTO creditcard (id, name) VALUES 
	(01, 'Orico Card THE POINT'), (02, '楽天カード'), (03, '三井住友VISAゴールドカード'), (04, 'エポスカード'), (05, 'Yahoo! JAPANカード'),
	(06, '三井住友VISAクラシックカード'), (07, 'Orico Card THE POINT PREMIUM GOLD'), (08, 'dカード GOLD'), (09, 'イオンカードセレクト'), 
	(10, 'JCB CARD W'), (11, 'レックスカード'), (12, 'ビックカメラSuicaカード'), (13, '楽天ゴールドカード'), (14, 'リクルートカード'), 
	(15, 'イオンカード（WAON一体型）'), (16, 'イオンSuicaカード'), (17, 'dカード'), (18, 'アメリカン・エキスプレス・ゴールド・カード'),
	(19, '三菱UFJニコス VIASOカード'), (20, '「ビュー・スイカ」カード');
*/

INSERT INTO service (id, content) VALUES 
	(01, '入会キャンペーン実施中'), (02, 'ポイント還元率が高い'), (03, 'ネットショッピングでお得(Amazon.co.jp)'), (04, 'ネットショッピングでお得(Yahoo!ショッピング)'), 
	(05, 'ネットショッピングでお得(楽天市場)');	
/*
INSERT INTO service (id, content) VALUES 
	(01, '入会キャンペーン実施中'), (02, 'ポイント還元率が高い'), (03, 'ネットショッピングでお得'), (04, '街なかのショッピングでお得'), (05, 'コンビニでお得'), 
	(06, 'スーパーでお得'), (07, 'カフェやレストランでお得'), (08, '携帯電話でお得'), (09, '電車でお得/便利'), (10, 'ガソリンスタンドでお得'), 
	(11, '健康相談サービス'), (12, 'ホテル予約サイトで割引あり'), (13, '空港ラウンジを利用できる'), (14, 'ANAマイルをためる'), (15, 'JALマイルをためる'), 
	(16, 'Apple Payに追加できる'), (17, '即日発行できる');
	
*/

INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (01, 01), (01, 02), (01, 03), (01, 04), (01, 05);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (02, 01), (02, 02), (02, 05);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (03, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (04, 01);
INSERT INTO creditcard_service (creditcard_id, service_id) VALUES (05, 01), (05, 02), (05, 04);
