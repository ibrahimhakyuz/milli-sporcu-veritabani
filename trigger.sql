USE MilliSporcuDb;
GO

-- 'Antrenman' tablosuna kayıt eklendiğinde devreye girer. Sporcunun aynı gün içinde başka antrenmanı varsa "Aşırı Yüklenme" gerekçesiyle işlemi iptal eder.


-- *************
-- Oluşturulacak nesnenin veri tabanında var olup olmadığını kontrol eden ve varsa silen kod bölümü
IF OBJECT_ID('dbo.trg_AntrenmanKontrol', 'TR') IS NOT NULL DROP TRIGGER dbo.trg_AntrenmanKontrol;
GO

IF OBJECT_ID('dbo.SporcuPuan', 'U') IS NULL
BEGIN
    THROW 50000, 'SporcuPuan tablosu bulunamadi. Once create.sql ve veriler.sql dosyalarini calistirin.', 1;
END
GO


-- *************
-- Kodun kendisi
CREATE TRIGGER dbo.trg_AntrenmanKontrol
ON Antrenman
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CakismanSayisi INT;
    
    SELECT @CakismanSayisi = COUNT(*)
    FROM Antrenman a
    INNER JOIN INSERTED i ON a.sporcuId = i.sporcuId
    WHERE CAST(a.baslangicTarihSaat AS DATE) = CAST(i.baslangicTarihSaat AS DATE)
      AND a.antrenmanId <> i.antrenmanId;

    IF @CakismanSayisi > 0
    BEGIN
        ROLLBACK TRANSACTION;
        THROW 50005, 'HATA (TRIGGER): Sporcunun bugun zaten antrenmani var. Asiri yuklenme yapilamaz.', 1;
    END

    PRINT 'TRIGGER ONAYLADI: Antrenman cakismasi yok.';
END
GO


-- *************
-- Test kodu

PRINT ' ';
PRINT '==================================================';
PRINT ' TEST SENARYOSU BAŞLIYOR ';
PRINT '==================================================';

-- önce id'si 1 olan sporcu için o tarihteki eski kayıtlarını siliyoruz.
DELETE FROM Antrenman 
WHERE sporcuId = 1 AND CAST(baslangicTarihSaat AS DATE) = '2025-12-02';

-- puanını da sıfırlayalım ki artışı net görelim
UPDATE SporcuPuan SET mevcutPuan = 0 WHERE personelId = 1;


-- BAŞARILI KAYIDIN OLACAĞI SENARYO
PRINT ' ';
PRINT 'ADIM 1: Başarılı Kayıt Ekleniyor...';

-- sp ile 2025-12-02 gününe antrenman ekliyorum
EXEC dbo.sp_OzelAntrenmanEkle 
    @SporcuId = 1, 
    @EgitmenId = 59, 
    @AntrenmanYeriId = 1, 
    @BaslangicTarihi = '2025-12-02 10:00:00';

-- Sonucu İletilere Yazdır
DECLARE @PuanAdim1 INT;
SELECT @PuanAdim1 = mevcutPuan FROM SporcuPuan WHERE personelId = 1;
PRINT '--> ADIM 1 SONUCU: İşlem bitti. Güncel Puan: ' + CAST(@PuanAdim1 AS VARCHAR);


-- HATALI KAYIDIN OLACAĞI SENARYO
PRINT ' ';
PRINT 'ADIM 2: Hatalı Kayıt (Çakışma) deneniyor...';

-- aynı güne (2025-12-02) ama farklı saate tekrar eklemeye çalışıyorum trigger "Bugün dolu" demeli ve işlemi iptal etmeli yani puan artmamalı

BEGIN TRY
    EXEC dbo.sp_OzelAntrenmanEkle 
        @SporcuId = 1, 
        @EgitmenId = 59, 
        @AntrenmanYeriId = 1, 
        @BaslangicTarihi = '2025-12-02 14:00:00'; 
END TRY
BEGIN CATCH
    PRINT '--------------------------------------------------';
    PRINT 'TRIGGER DEVREYE GİRDİ!';
    PRINT ERROR_MESSAGE();
    PRINT '--------------------------------------------------';
END CATCH


-- puan hala 5 ise trigger çalışmıştır eğer 10 olduysa trigger çalışmamıştır
-- Sonucu PRINT ile yazdırıyorum
DECLARE @SonPuan INT;
SELECT @SonPuan = mevcutPuan FROM SporcuPuan WHERE personelId = 1;

PRINT ' ';
IF @SonPuan = 5
    PRINT '>>> SONUÇ: TRIGGER BAŞARIYLA ÇALIŞTI (PUAN ARTMADI).';
ELSE
    PRINT '>>> HATA: TRIGGER ÇALIŞMADI (PUAN ARTTI!).';
