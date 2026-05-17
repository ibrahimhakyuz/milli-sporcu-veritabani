USE MilliSporcuDb;
GO


-- Sporcuların seçilen yılda yaptığı antrenman için performans analizini, antrenman süresi, antrenman yılı ve sporcunun ülkesini listeler


-- *************
-- Oluşturulacak nesnenin veri tabanında var olup olmadığını kontrol eden ve varsa silen kod bölümü
IF OBJECT_ID('dbo.vw_SporcuPerformansKarnesi', 'V') IS NOT NULL
    DROP VIEW dbo.vw_SporcuPerformansKarnesi;
GO


-- *************
-- Kodun kendisi
CREATE VIEW dbo.vw_SporcuPerformansKarnesi
AS SELECT
    p.personelID,
    p.ad + ' ' + p.soyad AS SporcuAdSoyad,
    u.ulkeAd AS Ulke,
    
    A.Yil AS AntrenmanYili,

    perf.YillikAntrenmanDakikasi,

    CASE 
        WHEN perf.YillikAntrenmanDakikasi >= 300 THEN 'Yüksek Performans'
        WHEN perf.YillikAntrenmanDakikasi BETWEEN 120 AND 299 THEN 'Orta Performans '
        ELSE 'Yetersiz Çalışma'
    END AS PerformansDurumu

    FROM 
        Personel p
        INNER JOIN Ulke u ON p.ulkeKodu = u.ulkeId
        INNER JOIN (
            SELECT DISTINCT sporcuId, YEAR(baslangicTarihSaat) AS Yil 
            FROM Antrenman
        ) A ON p.personelID = A.sporcuId
        CROSS APPLY (
            SELECT dbo.fn_SporcuYillikAntrenmanSuresi(p.personelID, A.Yil) AS YillikAntrenmanDakikasi
        ) perf

    WHERE 
        p.gorevId = 1;
GO


-- *************
-- Test kodu

--  Bana 2024 yılının analizini getir
SELECT 
    v.SporcuAdSoyad,
    v.Ulke,                
    v.AntrenmanYili,
    v.YillikAntrenmanDakikasi,
    v.PerformansDurumu
FROM 
    dbo.vw_SporcuPerformansKarnesi v
    INNER JOIN Personel p ON v.personelID = p.personelID
WHERE 
    v.AntrenmanYili = 2024 
ORDER BY 
    v.YillikAntrenmanDakikasi DESC;

