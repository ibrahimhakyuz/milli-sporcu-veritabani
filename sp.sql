USE MilliSporcuDb;
GO


-- Bir sporcu için "Özel Antrenman" kaydı oluşturur.'Antrenman' tablosuna kayıt ekler ve sporcunun 'SporcuPuan' tablosundaki puanını +5 artırır


-- *************
-- Oluşturulacak nesnenin veri tabanında var olup olmadığını kontrol eden ve varsa silen kod bölümü
IF OBJECT_ID('dbo.sp_OzelAntrenmanEkle', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_OzelAntrenmanEkle;
END
GO

IF OBJECT_ID('dbo.SporcuPuan', 'U') IS NULL
BEGIN
    THROW 50000, 'SporcuPuan tablosu bulunamadi. Once create.sql ve veriler.sql dosyalarini calistirin.', 1;
END
GO


-- *************
-- Kodun kendisi
CREATE PROCEDURE dbo.sp_OzelAntrenmanEkle
(
    @SporcuId INT,
    @EgitmenId INT,
    @AntrenmanYeriId INT,
    @BaslangicTarihi DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @BitisTarihi DATETIME = DATEADD(MINUTE, 90, @BaslangicTarihi);
        DECLARE @AyId INT;

        IF NOT EXISTS (SELECT 1 FROM Personel WHERE personelID = @SporcuId AND gorevId = 1)
            THROW 50001, 'Gecerli bir sporcu id girilmelidir.', 1;

        IF NOT EXISTS (SELECT 1 FROM Personel WHERE personelID = @EgitmenId AND gorevId = 2)
            THROW 50002, 'Gecerli bir egitmen id girilmelidir.', 1;

        IF NOT EXISTS (SELECT 1 FROM AntrenmanYeri WHERE antrenmanYeriId = @AntrenmanYeriId)
            THROW 50003, 'Gecerli bir antrenman yeri id girilmelidir.', 1;

        SELECT @AyId = a.ayId
        FROM Ay a
        INNER JOIN Yil y ON a.yilId = y.yilId
        WHERE y.yil = YEAR(@BaslangicTarihi)
          AND a.ayId = (
              SELECT MIN(a2.ayId) + MONTH(@BaslangicTarihi) - 1
              FROM Ay a2
              WHERE a2.yilId = y.yilId
          );

        IF @AyId IS NULL
            THROW 50004, 'Antrenman tarihi icin Yil/Ay kaydi bulunamadi.', 1;

        INSERT INTO Antrenman (baslangicTarihSaat, bitisTarihSaat, sporcuId, egitmenId, ayId, antrenmanYeriId)
        VALUES (@BaslangicTarihi, @BitisTarihi, @SporcuId, @EgitmenId, @AyId, @AntrenmanYeriId);

        UPDATE SporcuPuan
        SET mevcutPuan = mevcutPuan + 5 
        WHERE personelId = @SporcuId;

        IF @@ROWCOUNT = 0
        BEGIN
            INSERT INTO SporcuPuan (personelId, mevcutPuan)
            VALUES (@SporcuId, 5);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        ;THROW;
    END CATCH
END
GO


-- *************
-- Test kodu

-- test senaryosu
-- id=3 olan sporcu için bir antrenman ekleyelim ve puanının artıp artmadığını görelim.

DELETE FROM Antrenman
WHERE sporcuId = 3 AND CAST(baslangicTarihSaat AS DATE) = '2025-12-01';

UPDATE SporcuPuan SET mevcutPuan = 0 WHERE personelId = 3;

-- 1. işlemden önceki durum
SELECT 'ISLEMDEN ONCE' AS Durum, p.Ad, sp.mevcutPuan 
FROM SporcuPuan sp 
JOIN Personel p ON sp.personelId = p.personelID 
WHERE sp.personelId = 3;

-- 2. sp'yi çalıştırma
EXEC dbo.sp_OzelAntrenmanEkle 
    @SporcuId = 3, 
    @EgitmenId = 59, 
    @AntrenmanYeriId = 1, 
    @BaslangicTarihi = '2025-12-01 10:00:00';

-- 3. işlemden sonraki durum: puan artmış ve antrenman eklenmiş olmalı
SELECT 'ISLEMDEN SONRA' AS Durum, p.Ad, sp.mevcutPuan 
FROM SporcuPuan sp 
JOIN Personel p ON sp.personelId = p.personelID 
WHERE sp.personelId = 3;

-- antrenmanı kontrol edelim
SELECT TOP 1 * FROM Antrenman WHERE sporcuId = 3 ORDER BY antrenmanId DESC;
