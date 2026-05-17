USE MilliSporcuDb;
GO

-- fonksiyon parametre olarak aldığı sporcu id ve yıl bilgisine göre o sporcunun o yıl içerisindeki toplam antrenman süresini hesaplar


-- *************
-- Oluşturulacak nesnenin veri tabanında var olup olmadığını kontrol eden ve varsa silen kod bölümü
IF OBJECT_ID('dbo.fn_SporcuYillikAntrenmanSuresi', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_SporcuYillikAntrenmanSuresi;
GO

-- *************
-- Kodun kendisi
CREATE FUNCTION dbo.fn_SporcuYillikAntrenmanSuresi (@SporcuId INT,@Yil INT)

RETURNS INT 
AS
BEGIN
    DECLARE @ToplamSure INT;

    SELECT @ToplamSure = SUM(antrenmanSuresi)
    FROM Antrenman
    WHERE sporcuId = @SporcuId 
      AND YEAR(baslangicTarihSaat) = @Yil;

    -- sonuç NULL ise yani o yıl hiç antrenman yapmadıysa 0 döndür
    IF @ToplamSure IS NULL
        SET @ToplamSure = 0;

    RETURN @ToplamSure;
END
GO

-- *************
-- Test kodu -> id'si 1 olan sporcunun 2025 antrenman süresi
SELECT 
    p.Ad + ' ' + p.Soyad AS Sporcu,
    dbo.fn_SporcuYillikAntrenmanSuresi(p.personelId, 2025) AS [istenen_yil_antrenman_suresi]
FROM Personel p
WHERE p.personelId = 1;
