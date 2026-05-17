
USE MilliSporcuDb;
GO

-- Ülkeler
INSERT INTO Ulke (ulkeAd) VALUES ('Türkiye'), ('Almanya');

-- Şehirler (çoğu Türkiye'den)
INSERT INTO Sehir (sehirAd, ulkeKodu) VALUES 
('İstanbul', 1), ('Ankara', 1), ('İzmir', 1), 
('Bursa', 1), ('Antalya', 1), ('Alanya', 1),('Konya', 1),
('Kayseri', 1), ('Gaziantep', 1), ('Trabzon', 1),
('Berlin', 2), ('Münih', 2);
-- Spor Dalları
INSERT INTO SporDali (sporDaliAd) VALUES ('Atletizm'), ('Yüzme'), ('Tenis');

-- Branşlar
INSERT INTO Brans (bransAd, sporDaliId) VALUES 
('100m koşu', 1), ('Uzun atlama', 1), 
('Serbest stil', 2), ('Kelebek stil', 2),
('Tek erkekler', 3), ('Tek kadınlar', 3);

-- Görev
INSERT INTO Gorev (gorevAd) VALUES ('Sporcu'), ('Antrenör');

-- Kan Grupları
INSERT INTO kanGurubu (kanGurubuAd) VALUES 
('A+'), ('A-'), ('B+'), ('B-'), ('AB+'), ('AB-'), ('0+'), ('0-');


-- 8 sporcu - 100m koşu (bransId = 1)
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111111101', 'Ali', 'Yılmaz', 1, '2000-05-10', '5011111111', 'ali1@example.com', 1, 1, 1, 1, 1),
('11111111102', 'Ayşe', 'Demir', 0, '2002-03-15', '5011111112', 'ayse2@example.com', 1, 2, 1, 2, 1),
('11111111103', 'Mehmet', 'Kaya', 1, '1999-07-20', '5011111113', 'mehmet3@example.com', 1, 3, 1, 3, 1),
('11111111104', 'Zeynep', 'Çelik', 0, '2001-01-05', '5011111114', 'zeynep4@example.com', 1, 4, 1, 4, 1),
('11111111105', 'Burak', 'Koç', 1, '2003-12-25', '5011111115', 'burak5@example.com', 1, 5, 1, 1, 1),
('11111111106', 'Fatma', 'Yıldız', 0, '2000-09-10', '5011111116', 'fatma6@example.com', 1, 6, 1, 2, 1),
('11111111107', 'Emre', 'Aslan', 1, '2004-02-12', '5011111117', 'emre7@example.com', 1, 1, 1, 2, 1),
('11111111108', 'Elif', 'Güneş', 0, '2001-11-30', '5011111118', 'elif8@example.com', 1, 2, 1, 2, 1),
('11156111108', 'Ayşe', 'Ateş', 0, '2001-08-30', '5011151118', 'ayşe05@example.com', 1, 1, 1, 2, 1),
('11111781108', 'Berrak', 'Kahraman', 0, '2002-01-30', '5061111118', 'berrakkah@example.com', 1, 5, 1, 2, 1),
('12411111108', 'Osman', 'Ay', 1, '2000-05-30', '5061561118', 'osman1ay@example.com', 1, 6, 1, 2, 1);

-- 8 sporcu - Uzun atlama (bransId = 2)
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111111109', 'Hasan', 'Öztürk', 1, '2000-08-22', '5011111119', 'hasan9@example.com', 1, 7, 1, 1, 2),
('11111111110', 'Merve', 'Aydın', 0, '1998-06-14', '5011111120', 'merve10@example.com', 1, 8, 1, 2, 2),
('11111111111', 'Umut', 'Kurt', 1, '2002-01-17', '5011111121', 'umut11@example.com', 1, 5, 1, 3, 2),
('11111111112', 'Naz', 'Kaplan', 0, '2001-09-25', '5011111122', 'naz12@example.com', 1, 5, 1, 4, 2),
('11111111113', 'Kemal', 'Yavuz', 1, '1999-03-03', '5011111123', 'kemal13@example.com', 1, 2, 1, 1, 2),
('11111111114', 'Melisa', 'Akar', 0, '2000-10-09', '5011111124', 'melisa14@example.com', 1, 5, 1, 2, 2),
('11111111115', 'Tolga', 'Er', 1, '2003-06-19', '5011111125', 'tolga15@example.com', 1, 8, 1, 3, 2),
('11111111116', 'Sena', 'Bulut', 0, '2002-04-30', '5011111126', 'sena16@example.com', 1, 6, 1, 4, 2),
('11112111116', 'Hamza', 'Taş', 1, '2002-05-05', '5023111126', 'hamza4t@example.com', 1, 3, 1, 4, 2);

-- 8 sporcu - Serbest stil (bransId = 3)
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111111117', 'Barış', 'Kalkan', 1, '2001-02-11', '5011111127', 'baris17@example.com', 1, 2, 1, 1, 3),
('11111111118', 'Ceyda', 'Şahin', 0, '2002-07-23', '5011111128', 'ceyda18@example.com', 1, 6, 1, 2, 3),
('11111111119', 'Furkan', 'Doğan', 1, '2000-11-13', '5011111129', 'furkan19@example.com', 1, 3, 1, 3, 3),
('11111111120', 'Buse', 'Yurt', 0, '1999-12-31', '5011111130', 'buse20@example.com', 1, 1, 1, 6, 3),
('11111111121', 'Gökhan', 'Taş', 1, '2003-04-05', '5011111131', 'gokhan21@example.com', 1, 6, 1, 1, 3),
('11111111122', 'Aslı', 'Uçar', 0, '2001-08-08', '5011111132', 'asli22@example.com', 1, 7, 1, 2, 3),
('11111111123', 'İbrahim', 'Can', 1, '1998-05-28', '5011111133', 'ibrahim23@example.com', 1, 8, 1, 3, 3),
('11111111124', 'Gamze', 'Altun', 0, '2000-06-12', '5011111134', 'gamze24@example.com', 1, 2, 1, 4, 3),
('11111567124', 'Dilara', 'Zengin', 0, '1999-02-12', '5084111134', 'dilaraz1@example.com', 1, 6, 1, 4, 3),
('27811111124', 'Ömer', 'Aslan', 1, '2000-02-02', '5011117634', 'ömeraslan@example.com', 1, 7, 1, 4, 3);

-- 8 sporcu - Kelebek stil (bransId = 4)
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111111125', 'Arda', 'Bozkurt', 1, '2002-03-12', '5011111135', 'arda25@example.com', 1, 6, 1, 1, 4),
('11111111126', 'Derya', 'Yalçın', 0, '2001-10-19', '5011111136', 'derya26@example.com', 1, 2, 1, 2, 4),
('11111111127', 'Onur', 'Şimşek', 1, '2000-07-01', '5011111137', 'onur27@example.com', 1, 5, 1, 3, 4),
('11111111128', 'Ece', 'Karaca', 0, '1999-09-22', '5011111138', 'ece28@example.com', 1, 3, 1, 4, 4),
('11111111129', 'Kaan', 'Türkmen', 1, '2003-11-17', '5011111139', 'kaan29@example.com', 1, 9, 1, 1, 4),
('11111111130', 'Zehra', 'Koşar', 0, '2000-02-07', '5011111140', 'zehra30@example.com', 1, 7, 1, 2, 4),
('11111111131', 'Selim', 'Durmaz', 1, '2004-01-10', '5011111141', 'selim31@example.com', 1, 6, 1, 3, 4),
('11111111132', 'İlayda', 'Kurtuluş', 0, '2001-05-27', '5011111142', 'ilayda32@example.com', 1, 5, 1, 4, 4),
('11789111132', 'Şahan', 'Kuru', 1, '2000-03-12', '5921111142', 'şahankuru@example.com', 1, 4, 1, 4, 4),
('11111187132', 'Gül', 'Adın', 0, '2001-01-27', '5011119142', 'güladın1@example.com', 1, 1, 1, 4, 4);

-- 8 sporcu - Tek erkekler (bransId = 5)
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111111133', 'Mert', 'Şahin', 1, '1999-08-13', '5011111143', 'mert33@example.com', 1, 1, 1, 1, 5),
('11111111134', 'Can', 'Işık', 1, '2000-10-10', '5011111144', 'can34@example.com', 1, 1, 1, 2, 5),
('11111111135', 'Deniz', 'Kaya', 1, '2001-03-30', '5011111145', 'deniz35@example.com', 1, 2, 1, 3, 5),
('11111111136', 'Yusuf', 'Ateş', 1, '2002-06-21', '5011111146', 'yusuf36@example.com', 1, 3, 1, 4, 5),
('11111111137', 'Tuna', 'Gök', 1, '2003-09-04', '5011111147', 'tuna37@example.com', 1, 4, 1, 1, 5),
('11111111138', 'Uğur', 'Çakır', 1, '2000-12-16', '5011111148', 'ugur38@example.com', 1, 5, 1, 2, 5),
('11111111139', 'Batuhan', 'Eser', 1, '2001-04-01', '5011111149', 'batuhan39@example.com', 1, 6,1, 3, 5),
('17611111140', 'Ömer', 'Sağlam', 1, '2002-07-18', '5011111150', 'omer40@example.com', 1, 7, 1, 4, 5),
('11134111140', 'Polat', 'Duru', 1, '2002-01-12', '5018211150', 'polatd12@example.com', 1, 8, 1, 4, 5);

-- 8 sporcu - Tek kadınlar (bransId = 6)
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111111141', 'Beyza', 'Demirtaş', 0, '2000-01-25', '5011111151', 'beyza41@example.com', 1, 1, 1, 1, 6),
('11111111142', 'Sude', 'Boz', 0, '1999-05-11', '5011111152', 'sude42@example.com', 1, 9, 1, 2, 6),
('11111111143', 'Gizem', 'Çelik', 0, '2003-06-30', '5011111153', 'gizem43@example.com', 1, 3, 1, 3, 6),
('11111111144', 'Tuğçe', 'Erkan', 0, '2001-09-12', '5011111154', 'tugce44@example.com', 1, 5, 1, 4, 6),
('11111111145', 'Hilal', 'Tan', 0, '2000-08-15', '5011111155', 'hilal45@example.com', 1, 7, 1, 1, 6),
('11111111146', 'Cansu', 'Şen', 0, '2002-03-02', '5011111156', 'cansu46@example.com', 1, 8, 1, 2, 6),
('11111111147', 'İrem', 'Bozkurt', 0, '1998-11-29', '5011111157', 'irem47@example.com', 1, 3, 1, 3, 6),
('11111111148', 'Nisa', 'Karataş', 0, '2004-04-07', '5011111158', 'nisa48@example.com', 1, 2, 1, 4, 6),
('11117451148', 'Esra', 'Özel', 0, '2003-02-07', '5016111158', 'esraozel@example.com', 1, 1, 1, 4, 6);

-- 8 100m koşu Antrönörü
INSERT INTO Personel (TC, ad, soyad, cinsiyet, dogumT, telefonNo, eposta, ulkeKodu, sehirKodu, gorevId, kanGurubuID, bransId) VALUES
('11111112133', 'Ali', 'Yılmaz', 1, '2000-05-10', '5011761111', 'ali13@example.com', 1, 1, 2, 1, 1),
('11111111214', 'Ayşe', 'Demir', 0, '2002-03-15', '5056111112', 'ayse24@example.com', 1, 2, 2, 2, 1),
('11111111215', 'Mehmet', 'Kaya', 1, '1999-07-20', '5011189113', 'mehmet53@example.com', 1, 3, 2, 3, 1),
('11111111216', 'Zeynep', 'Çelik', 0, '2001-01-05', '5011119819', 'zeynep64@example.com', 1, 4, 2, 4, 1),
('11111111217', 'Burak', 'Koç', 1, '2003-12-25', '5011119815', 'burak57@example.com', 1, 5, 2, 1, 1),
('11111111218', 'Fatma', 'Yıldız', 0, '2000-09-10', '5011311126', 'fatma68@example.com', 1, 6, 2, 2, 1),
('11111111219', 'Emre', 'Aslan', 1, '2004-02-12', '5011321127', 'emre79@example.com', 1, 1, 2, 2, 1),
('11111111220', 'Elif', 'Güneş', 0, '2001-11-30', '5011165129', 'elif80@example.com', 1, 2, 2, 2, 1),
('11156111221', 'Ayşe', 'Ateş', 0, '2001-08-30', '5018151130', 'ayşe015@example.com', 1, 1, 2, 2, 1),
('11111781222', 'Berrak', 'Kahraman', 0, '2002-01-30', '5068111131', 'berrakkah1@example.com', 1, 5, 2, 2, 1),
('12411111223', 'Osman', 'Ay', 1, '2000-05-30', '5042561132', 'osman1ay2@example.com', 1, 6,2 , 2, 1);
--

INSERT INTO SporcuPuan (personelId, mevcutPuan)
SELECT personelID, 0
FROM Personel
WHERE gorevId = 1;

-- Yıllar ve Aylar
INSERT INTO Yil (yil) VALUES (2023),(2024), (2025);
INSERT INTO Ay (ayAdi, yilId) VALUES 
('Ocak', 1), ('Şubat', 1), ('Mart', 1),('Nisan', 1), ('Mayıs', 1), ('Haziran', 1),('Temmuz', 1), ('Ağustos', 1),('Eylül', 1),('Ekim', 1),('Kasım', 1),('Aralık', 1),
('Ocak', 2), ('Şubat', 2), ('Mart', 2),('Nisan', 2), ('Mayıs', 2), ('Haziran', 2),('Temmuz', 2), ('Ağustos', 2),('Eylül', 2),('Ekim', 2),('Kasım', 2),('Aralık', 2),
('Ocak', 3), ('Şubat', 3), ('Mart', 3),('Nisan', 3), ('Mayıs', 3), ('Haziran', 3),('Temmuz', 3), ('Ağustos', 3),('Eylül', 3),('Ekim', 3),('Kasım', 3),('Aralık', 3);

-- Turnuvalar
INSERT INTO Turnuva (turnuvaAd, baslangicTarihi, bitisTarihi, ayId) VALUES
('Bahar Kupası', '2023-01-05', '2023-01-25', 1),
('Bayram Şampiyonası', '2023-04-07', '2023-04-27', 4),
('Açık Şampiyona', '2023-07-06', '2023-07-26', 7),
('Yaz Turnuvası', '2024-03-08', '2024-03-28', 15),
('Karma Şapiyona', '2024-05-05', '2024-05-25', 17),
('Zirve Kupası', '2024-08-06', '2024-08-26', 20),
('Cumhuriyet Kupası', '2025-01-07', '2025-01-27', 25),
('Gençlik Şampiyonası', '2025-03-05', '2025-03-25', 27),
('Power Arena', '2025-05-06', '2025-05-26', 29),
('Efsaneler Arenası', '2025-07-07', '2025-07-27', 31),
('Kartal Pençesi Turnuvası', '2023-09-05', '2023-09-25', 9),
('Yükseliş Turnuvası', '2024-11-07', '2024-11-27', 23),
('Elitler Madalyası', '2025-02-08', '2025-02-28', 26),
('Büyük Onur Turnuvası', '2023-06-06', '2023-06-26', 6),
('Mücadele Ruhu Turnuvası', '2024-09-05', '2024-09-25', 21);

--  Türkiye Salon
INSERT INTO Salon (salonAd, turnuvaId, ulkeKodu, sehirKodu) VALUES
('Galaksi Arena', 1, 1, 1),
('Zirve Spor Kompleksi', 2, 1, 2),
('Altın Kupa Salonu', 3, 1, 3),
('Phoenix Arena', 4, 1, 4),
('Efsane Spor Salonu', 5, 1, 5),
('Kırmızı Arena', 6, 1, 6),
('Beyaz Kartal Salonu', 7, 1, 7),
('Aslanlar Spor Tesisi', 8, 1, 8),
('Thunder Arena', 9, 1, 9),
('Şampiyonlar Salonu', 10, 1, 10),

('Vizyon Spor Merkezi', 1, 1, 2),
('Mega Arena', 2, 1, 3),
('Parlak Yıldız Spor Salonu', 3, 1, 4),
('Sonsuz Güç Arenası', 4, 1, 5),
('Kule Spor Tesisi', 5, 1, 6),
('Panter Spor Merkezi', 6, 1, 7),
('Gök Gürültüsü Arena', 7, 1, 8),
('Zafer Kompleksi', 8, 1, 9),
('Nova Spor Salonu', 9, 1, 10),
('Yıldırım Arena', 10, 1, 1),

('Kuvvet Spor Salonu', 1, 1, 3),
('Olimpik Rota Arenası', 2, 1, 4),
('Alfa Spor Tesisi', 3, 1, 5),
('Beta Arena', 4, 1, 6),
('Delta Spor Kompleksi', 5, 1, 7),
('Işık Spor Merkezi', 6, 1, 8),
('Kuzey Rüzgarı Arena', 7, 1, 9),
('Merkez Güç Salonu', 8, 1, 10),
('Yeni Nesil Arena', 9, 1, 1),
('Okyanus Spor Kompleksi', 10, 1, 2);

--  Almanya Salon
INSERT INTO Salon (salonAd, turnuvaId, ulkeKodu, sehirKodu) VALUES
('Titan Arena', 11, 2, 11),
('Omega Spor Kompleksi', 12, 2, 12),
('Kronos Salonu', 13, 2, 11),
('Nebula Arena', 14, 2, 12),
('Atlas Spor Merkezi', 15, 2, 11);


-- Turnuva 1: 2023 Ocak
INSERT INTO Musabaka (turnuvaId, salonId, musabakaAd, baslangicTarihi, bitisTarihi, sporDaliId)
VALUES
(1, 1, 'Müsabaka 1', '2023-01-05 10:00:00', '2023-01-05 12:00:00', 1),
(1,11, 'Müsabaka 2', '2023-01-15 13:00:00', '2023-01-15 15:00:00', 2),
(1, 21, 'Müsabaka 3', '2023-01-25 16:00:00', '2023-01-25 18:00:00', 3);

-- Turnuva 2: 2023 Nisan
INSERT INTO Musabaka VALUES
(2, 2, 'Müsabaka 1', '2023-04-07 11:00:00', '2023-04-07 13:00:00', 2),
(2, 12, 'Müsabaka 2', '2023-04-17 14:00:00', '2023-04-17 16:00:00', 3),
(2, 22, 'Müsabaka 3', '2023-04-27 09:00:00', '2023-04-27 11:00:00', 1);

-- Turnuva 3: 2023 Temmuz
INSERT INTO Musabaka VALUES
(3, 3, 'Müsabaka 1', '2023-07-06 12:00:00', '2023-07-06 14:00:00', 3),
(3, 13, 'Müsabaka 2', '2023-07-16 15:00:00', '2023-07-16 17:00:00', 1),
(3, 23, 'Müsabaka 3', '2023-07-26 10:00:00', '2023-07-26 12:00:00', 2);

-- Turnuva 4: 2024 Mart
INSERT INTO Musabaka VALUES
(4, 4, 'Müsabaka 1', '2024-03-08 09:00:00', '2024-03-08 11:00:00', 1),
(4, 14, 'Müsabaka 2', '2024-03-18 12:00:00', '2024-03-18 14:00:00', 3),
(4, 24, 'Müsabaka 3', '2024-03-28 14:00:00', '2024-03-28 16:00:00', 2);

-- Turnuva 5: 2024 Mayıs
INSERT INTO Musabaka VALUES
(5, 5, 'Müsabaka 1', '2024-05-05 10:00:00', '2024-05-05 12:00:00', 2),
(5, 15, 'Müsabaka 2', '2024-05-15 13:00:00', '2024-05-15 15:00:00', 1),
(5, 25, 'Müsabaka 3', '2024-05-25 16:00:00', '2024-05-25 18:00:00', 3);

-- Turnuva 6: 2024 Ağustos
INSERT INTO Musabaka VALUES
(6, 6, 'Müsabaka 1', '2024-08-06 09:00:00', '2024-08-06 11:00:00', 3),
(6, 16, 'Müsabaka 2', '2024-08-16 12:00:00', '2024-08-16 14:00:00', 2),
(6, 26, 'Müsabaka 3', '2024-08-26 14:00:00', '2024-08-26 16:00:00', 1);

-- Turnuva 7: 2025 Ocak
INSERT INTO Musabaka VALUES
(7, 7, 'Müsabaka 1', '2025-01-07 10:00:00', '2025-01-07 12:00:00', 1),
(7, 17, 'Müsabaka 2', '2025-01-17 13:00:00', '2025-01-17 15:00:00', 3),
(7, 27,  'Müsabaka 3', '2025-01-27 16:00:00', '2025-01-27 18:00:00', 2);

-- Turnuva 8: 2025 Mart
INSERT INTO Musabaka VALUES
(8, 8,  'Müsabaka 1', '2025-03-05 09:00:00', '2025-03-05 11:00:00', 3),
(8, 18,  'Müsabaka 2', '2025-03-15 12:00:00', '2025-03-15 14:00:00', 1),
(8, 28,  'Müsabaka 3', '2025-03-25 14:00:00', '2025-03-25 16:00:00', 2);

-- Turnuva 9: 2025 Mayıs
INSERT INTO Musabaka VALUES
(9, 9,  'Müsabaka 1', '2025-05-06 10:00:00', '2025-05-06 12:00:00', 2),
(9, 19,  'Müsabaka 2', '2025-05-16 13:00:00', '2025-05-16 15:00:00', 3),
(9, 29,  'Müsabaka 3', '2025-05-26 16:00:00', '2025-05-26 18:00:00', 1);

-- Turnuva 10: 2025 Temmuz
INSERT INTO Musabaka VALUES
(10, 10, 'Müsabaka 1', '2025-07-07 09:00:00', '2025-07-07 11:00:00', 1),
(10, 20, 'Müsabaka 2', '2025-07-17 12:00:00', '2025-07-17 14:00:00', 2),
(10, 30,'Müsabaka 3', '2025-07-27 14:00:00', '2025-07-27 16:00:00', 3);

-- Turnuva 11: 2023 Eylül
INSERT INTO Musabaka VALUES
(11, 31,'Müsabaka 1', '2023-09-05 10:00:00', '2023-09-05 12:00:00', 3),
(11, 31,'Müsabaka 2', '2023-09-15 13:00:00', '2023-09-15 15:00:00', 1),
(11, 31,'Müsabaka 3', '2023-09-25 16:00:00', '2023-09-25 18:00:00', 2);

-- Turnuva 12: 2024 Kasım
INSERT INTO Musabaka VALUES
(12, 32,'Müsabaka 1', '2024-11-07 09:00:00', '2024-11-07 11:00:00', 1),
(12, 32,'Müsabaka 2', '2024-11-17 12:00:00', '2024-11-17 14:00:00', 2),
(12, 32,'Müsabaka 3', '2024-11-27 14:00:00', '2024-11-27 16:00:00', 3);

-- Turnuva 13: 2025 Şubat
INSERT INTO Musabaka VALUES
(13, 33,'Müsabaka 1', '2025-02-08 10:00:00', '2025-02-08 12:00:00', 2),
(13, 33,'Müsabaka 2', '2025-02-18 13:00:00', '2025-02-18 15:00:00', 3),
(13, 33,'Müsabaka 3', '2025-02-28 16:00:00', '2025-02-28 18:00:00', 1);

-- Turnuva 14: 2023 Haziran
INSERT INTO Musabaka VALUES
(14, 34,'Müsabaka 1', '2023-06-06 09:00:00', '2023-06-06 11:00:00', 3),
(14, 34, 'Müsabaka 2', '2023-06-16 12:00:00', '2023-06-16 14:00:00', 1),
(14, 34, 'Müsabaka 3', '2023-06-26 14:00:00', '2023-06-26 16:00:00', 2);

-- Turnuva 15: 2024 Eylül
INSERT INTO Musabaka VALUES
(15, 35, 'Müsabaka 1', '2024-09-05 10:00:00', '2024-09-05 12:00:00', 1),
(15, 35, 'Müsabaka 2', '2024-09-15 13:00:00', '2024-09-15 15:00:00', 3),
(15, 35, 'Müsabaka 3', '2024-09-25 16:00:00', '2024-09-25 18:00:00', 2);

INSERT INTO PersonelMusabaka (personelId, musabakaId, bitirmeSirasi) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),

(23, 2, 1),
(24, 2, 2),
(25, 2, 3),

(42, 3, 1),
(43, 3, 2),
(44, 3, 3),

(34, 4, 1),
(35, 4, 2),
(36, 4, 3),

(55, 5, 1),
(56, 5, 2),
(57, 5, 3),

(16, 6, 1),
(17, 6, 2),
(18, 6, 3),

(42, 7, 1),
(43, 7, 2),
(44, 7, 3),

(4, 8, 1),
(2, 8, 2),
(6, 8, 3),

(42, 9, 1),
(43, 9, 2),
(44, 9, 3),

(10, 10, 1),
(4, 10, 2),
(11, 10, 3),

(51, 11, 1),
(54,11, 2),
(56, 11, 3),

(31, 12, 1),
(32, 12, 2),
(33, 12, 3),

(38, 45, 1),
(39, 45, 2),
(40, 45, 3),

(21, 42, 1),
(22, 42, 2),
(23, 42, 3),

(26, 37, 1),
(27, 37, 2),
(28, 37, 3),

(29, 33, 1),
(30, 33, 2),
(31, 33, 3),

(2, 27, 1),
(10, 27, 2),
(3, 27, 3);


INSERT INTO MadalyaTuru (madalyaAd) VALUES
('Altın'),
('Gümüş'),
('Bronz');


INSERT INTO Madalya (personelId, musabakaId, bransId, madalyaTuruId) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 1, 3),

(23, 2, 3, 1),
(24, 2, 3, 2),
(25, 2, 3, 3),

(42, 3, 5, 1),
(43, 3, 5, 2),
(44, 3, 5, 3),

(34, 4, 4, 1),
(35, 4, 4, 2),
(36, 4, 4, 3),

(55, 5, 6, 1),
(56, 5, 6, 2),
(57, 5, 6, 3),

(16, 6, 2, 1),
(17, 6, 2, 2),
(18, 6, 2, 3),

(46, 7, 5, 1),
(47, 7, 5, 2),
(48, 7, 5, 3),

(4, 8, 1, 1),
(2, 8, 1, 2),
(6, 8, 1, 3),

(25, 9, 3, 1),
(26, 9, 3, 2),
(27, 9, 3, 3),

(10, 10, 1, 1),
(4, 10, 1, 2),
(11, 10, 1, 3),

(51, 11, 6, 1),
(54, 11, 6, 2),
(56, 11, 6, 3),

(31, 12, 4, 1),
(32, 12, 4, 2),
(33, 12, 4, 3),

(38, 45, 4, 1),
(39, 45, 4, 2),
(40, 45, 4, 3),

(21, 42, 4, 1),
(22, 42, 4, 2),
(23, 42, 4, 3),

(26, 37, 4, 1),
(27, 37, 4, 2),
(28, 37, 4, 3),

(29, 33, 4, 1),
(30, 33, 4, 2),
(31, 33, 4, 3),

(2, 27, 1, 1),
(10, 27, 1, 2),
(3, 27, 1, 3);

INSERT INTO AntrenmanYeri (antrenmanYeriAd, ulkeKodu, sehirKodu) VALUES
('Zirve Performans Merkezi', 1, 1),
('Alpha Güç Kompleksi', 1, 2),
('Nova Antrenman Alanı', 1, 3),
('O2 Spor Laboratuvarı', 1, 4),
('Dinamo Kondisyon Merkezi', 1, 5),
('Vortex Eğitim Sahası', 1, 6),
('Titan Sporcu Gelişim Tesisi', 1, 7),
('Apex Dayanıklılık Merkezi', 2, 11),
('ProCore Hazırlık Salonu', 2, 12),
('Sigma Fit Kampüsü', 1, 10);

INSERT INTO Antrenman (baslangicTarihSaat, bitisTarihSaat, sporcuId, egitmenId, ayId, antrenmanYeriId) VALUES
('2025-11-03 09:00:00', '2025-11-03 10:30:00', 2, 59, 35, 2),
('2025-08-05 14:00:00', '2025-08-05 15:15:00', 2, 60,32, 3),
('2024-08-07 08:30:00', '2024-08-07 09:45:00', 2, 61, 20, 1),
('2024-06-10 17:00:00', '2024-06-10 18:00:00', 4, 62, 18, 4),
('2024-09-12 10:00:00', '2024-09-12 11:00:00', 4, 63, 21, 5),
('2024-03-13 11:30:00', '2024-03-13 12:30:00', 10, 64, 15, 6),
('2024-07-15 16:00:00', '2024-07-15 17:30:00', 10, 65, 19, 7),
('2024-11-18 13:00:00', '2024-11-18 14:20:00', 10, 66, 23, 8),
('2025-06-20 09:00:00', '2025-06-20 10:00:00', 10, 67, 30, 9),
('2025-10-22 15:00:00', '2025-10-22 16:45:00', 1, 68, 34, 10);

INSERT INTO Olcum (personelId, ayId, kilo, boy) VALUES
(2, 35, 72.5, 180.0),
(2, 34, 73.0, 180.0),
(2, 23, 69.2, 180.5),
(2, 22, 70.9, 180.5),
(4, 35, 80.0, 177.0),
(4, 34, 79.5, 177.0),
(4, 23, 79.0, 177.0),
(4, 22, 80.5, 177.0),
(10, 35, 82.5, 181.0),
(10, 34, 81.5, 181.0),
(10, 23, 82.0, 181.0),
(10, 22, 80.5, 181.0),
(10, 21, 81.0, 181.0),
(1, 35, 79.0, 170.0),
(1, 34, 79.5, 170.0),
(1, 23, 79.0, 170.0),
(1,22, 79.5, 190.0);
