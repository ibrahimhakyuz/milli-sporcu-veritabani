-- 1. Veritabanını Oluştur
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'MilliSporcuDb')
BEGIN
    CREATE DATABASE MilliSporcuDb;
END
GO

-- 2. Veritabanını Kullanıma Al
USE MilliSporcuDb;
GO

-- 3. Tabloları Oluşturmaya Başla

CREATE TABLE Ulke (
    ulkeId INT IDENTITY(1,1) PRIMARY KEY,
    ulkeAd VARCHAR(20) NOT NULL
);
GO

CREATE TABLE Sehir (
    sehirId INT IDENTITY(1,1) PRIMARY KEY,
    sehirAd VARCHAR(20) NOT NULL,
    ulkeKodu INT FOREIGN KEY REFERENCES Ulke(ulkeId) NOT NULL
);
GO

CREATE TABLE Gorev (
    gorevId INT IDENTITY(1,1) PRIMARY KEY,
    gorevAd VARCHAR(50) NOT NULL
);
GO

CREATE TABLE SporDali (
    sporDaliId INT IDENTITY(1,1) PRIMARY KEY,
    sporDaliAd VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Brans (
    bransId INT IDENTITY(1,1) PRIMARY KEY,
    bransAd VARCHAR(50) NOT NULL,
    sporDaliId INT FOREIGN KEY REFERENCES SporDali(sporDaliId) NOT NULL 
);
GO

CREATE TABLE kanGurubu (
    kanGrubuID INT IDENTITY(1,1) PRIMARY KEY,
    kanGurubuAd VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Personel (
    personelID INT IDENTITY(1,1) PRIMARY KEY,
    TC CHAR(11) UNIQUE NOT NULL,
    ad VARCHAR(20) NOT NULL,
    soyad VARCHAR(20) NOT NULL,
    cinsiyet SMALLINT NOT NULL,
    dogumT DATE NOT NULL,
    yas AS DATEDIFF(YEAR, dogumT, GETDATE()), -- Hesaplanmış alan
    telefonNo CHAR(10) UNIQUE CHECK(telefonNo LIKE '5[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    eposta VARCHAR(100) UNIQUE CHECK (eposta LIKE '_%@_%._%'),
    
    ulkeKodu INT FOREIGN KEY REFERENCES Ulke(ulkeId),
    sehirKodu INT FOREIGN KEY REFERENCES Sehir(sehirId),
    gorevId INT FOREIGN KEY REFERENCES Gorev(gorevId),
    kanGurubuID INT FOREIGN KEY REFERENCES kanGurubu(kanGrubuID),
    bransId INT FOREIGN KEY REFERENCES Brans(bransId),
    CONSTRAINT CK_Personel_Cinsiyet CHECK (cinsiyet IN (0, 1))
);
GO

CREATE TABLE SporcuPuan (
    puanId INT IDENTITY(1,1) PRIMARY KEY,
    personelId INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Personel(personelID),
    mevcutPuan INT NOT NULL DEFAULT 0,
    CONSTRAINT CK_SporcuPuan_MevcutPuan CHECK (mevcutPuan >= 0)
);
GO

CREATE TABLE Yil (
    yilId INT IDENTITY(1,1) PRIMARY KEY,
    yil INT NOT NULL UNIQUE
);
GO

CREATE TABLE Ay (
    ayId INT IDENTITY(1,1) PRIMARY KEY,
    ayAdi VARCHAR(20) NOT NULL,
    yilId INT FOREIGN KEY REFERENCES Yil(yilId) NOT NULL,
    CONSTRAINT UQ_YilAy UNIQUE (yilId, ayAdi)
);
GO

CREATE TABLE Turnuva (
    turnuvaId INT IDENTITY(1,1) PRIMARY KEY,
    turnuvaAd VARCHAR(50) NOT NULL,
    baslangicTarihi DATE NOT NULL,
    bitisTarihi DATE NOT NULL,
    ayId INT FOREIGN KEY REFERENCES Ay(ayId) NOT NULL,
    CONSTRAINT CK_Turnuva_Tarih CHECK (bitisTarihi >= baslangicTarihi)
);
GO

CREATE TABLE Salon (
    salonId INT IDENTITY(1,1) PRIMARY KEY,
    salonAd VARCHAR(50) NOT NULL,
    turnuvaId INT FOREIGN KEY REFERENCES Turnuva(turnuvaId) NOT NULL,
    ulkeKodu INT FOREIGN KEY REFERENCES Ulke(ulkeId) NOT NULL,
    sehirKodu INT FOREIGN KEY REFERENCES Sehir(sehirId) NOT NULL
);
GO

CREATE TABLE Musabaka (
    musabakaId INT IDENTITY(1,1) PRIMARY KEY,
    turnuvaId INT FOREIGN KEY REFERENCES Turnuva(turnuvaId) NOT NULL,
    salonId INT FOREIGN KEY REFERENCES Salon(salonId) NOT NULL,
    musabakaAd VARCHAR(50) NOT NULL,
    baslangicTarihi DATETIME NOT NULL,
    bitisTarihi DATETIME NOT NULL,
    sporDaliId INT FOREIGN KEY REFERENCES SporDali(sporDaliId) NOT NULL,
    CONSTRAINT CK_Musabaka_Tarih CHECK (bitisTarihi >= baslangicTarihi)
);
GO

CREATE TABLE PersonelMusabaka (
    personelId INT FOREIGN KEY REFERENCES Personel(personelID) NOT NULL,
    musabakaId INT FOREIGN KEY REFERENCES Musabaka(musabakaId) NOT NULL,
    bitirmeSirasi INT,
    PRIMARY KEY (personelId, musabakaId)
);
GO

CREATE TABLE MadalyaTuru (
    madalyaTuruId INT IDENTITY(1,1) PRIMARY KEY,
    madalyaAd VARCHAR(20) NOT NULL UNIQUE 
);
GO

CREATE TABLE Madalya (
    madalyaId INT IDENTITY(1,1) PRIMARY KEY,
    personelId INT NOT NULL FOREIGN KEY REFERENCES Personel(personelID),
    musabakaId INT NOT NULL FOREIGN KEY REFERENCES Musabaka(musabakaId),
    bransId INT NOT NULL FOREIGN KEY REFERENCES Brans(bransId),
    madalyaTuruId INT NOT NULL FOREIGN KEY REFERENCES MadalyaTuru(madalyaTuruId)
);
GO

CREATE TABLE AntrenmanYeri (
    antrenmanYeriId INT IDENTITY(1,1) PRIMARY KEY,
    antrenmanYeriAd VARCHAR(100) NOT NULL,
    ulkeKodu INT FOREIGN KEY REFERENCES Ulke(ulkeId) NULL,
    sehirKodu INT FOREIGN KEY REFERENCES Sehir(sehirId) NULL
);
GO

CREATE TABLE Antrenman (
    antrenmanId INT IDENTITY(1,1) PRIMARY KEY,
    baslangicTarihSaat DATETIME NOT NULL,
    bitisTarihSaat DATETIME NOT NULL,
    antrenmanSuresi AS DATEDIFF(MINUTE, baslangicTarihSaat, bitisTarihSaat),
    
    sporcuId INT NOT NULL FOREIGN KEY REFERENCES Personel(PersonelID),           
    egitmenId INT NOT NULL FOREIGN KEY REFERENCES Personel(PersonelID),         
    ayId INT FOREIGN KEY REFERENCES Ay(ayId) NOT NULL,
    antrenmanYeriId INT FOREIGN KEY REFERENCES AntrenmanYeri(antrenmanYeriId) NOT NULL,
    CONSTRAINT CK_Antrenman_Tarih CHECK (bitisTarihSaat > baslangicTarihSaat)
);
GO

CREATE TABLE Olcum (
    olcumId INT IDENTITY(1,1) PRIMARY KEY,
    personelId INT FOREIGN KEY REFERENCES Personel(personelID) NOT NULL,
    ayId INT FOREIGN KEY REFERENCES Ay(ayId) NOT NULL,
    kilo DECIMAL(5,2) NOT NULL,  
    boy DECIMAL(5,2) NOT NULL,
    CONSTRAINT UQ_Olcum_PersonelAy UNIQUE (personelId, ayId),
    CONSTRAINT CK_Olcum_Kilo CHECK (kilo > 0),
    CONSTRAINT CK_Olcum_Boy CHECK (boy > 0)
);
GO
