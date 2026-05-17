USE MilliSporcuDb;
GO


-- Sistemde en sık yapılan sorgulardan biri "Belirli bir şehirdeki personeli listeleme" işlemidir.


SET STATISTICS IO ON;
GO


-- *************
-- Oluşturulacak nesnenin veri tabanında var olup olmadığını kontrol eden ve varsa silen kod bölümü
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Personel_Sehir_Sorgusu' AND object_id = OBJECT_ID('Personel'))
BEGIN
    DROP INDEX IX_Personel_Sehir_Sorgusu ON Personel;
END
GO

PRINT ' ';
PRINT '>>> DURUM 1: INDEX YOKKEN SORGULAMA <<<';


SELECT Ad, Soyad, TC
FROM Personel
WHERE sehirKodu = 1;
GO


PRINT ' ';
PRINT '>>> DURUM 2: INDEX OLUŞTURULUYOR... <<<';


CREATE NONCLUSTERED INDEX IX_Personel_Sehir_Sorgusu
ON Personel (sehirKodu)
INCLUDE (Ad, Soyad, TC);
GO

PRINT ' ';
PRINT '>>> DURUM 3: INDEX VARKEN SORGULAMA (AYNI SORGU) <<<';


SELECT Ad, Soyad, TC
FROM Personel
WHERE sehirKodu = 1;
GO


SET STATISTICS IO OFF;
