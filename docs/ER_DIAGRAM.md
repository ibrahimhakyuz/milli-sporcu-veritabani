# ER Diyagramı

Bu doküman, `create.sql` dosyasındaki güncel SQL Server şemasına göre hazırlanmıştır. Yeni ve doğru ER diyagramı `docs/assets/er-diagram.svg` dosyasındadır. Düzenlenebilir Mermaid kaynak dosyası `docs/er-diagram.mmd`, SVG üretici script ise `docs/scripts/generate-er-diagram.js` altında tutulur.

![Güncel ER diyagramı](assets/er-diagram.svg)

## Mevcut PNG Diyagram Kontrolü

Mevcut ER diyagramı ana varlıkları doğru yakalıyor: `Personel`, `Turnuva`, `Müsabaka`, `Antrenman`, `Madalya`, `Ölçüm`, `Ülke`, `Şehir`, `Branş`, `Spor Dalı`, `Ay` ve `Yıl` var. Ancak SQL şemasına göre GitHub'da nihai diyagram olarak kullanmadan önce şu noktalar düzeltilmelidir:

- `SporcuPuan` tablosu diyagramda yok.
- `PersonelMusabaka` ara tablosu diyagramda açık bir varlık olarak görünmüyor; SQL'de personel-müsabaka ilişkisini bu tablo kuruyor.
- `Salon` tablosunun `Turnuva`, `Ülke` ve `Şehir` ile ilişkileri daha net gösterilmeli.
- `Madalya` tablosu sadece `MadalyaTuru` ile değil, `Personel`, `Müsabaka` ve `Branş` ile de ilişkili.
- `Antrenman` tablosunda `sporcuId` ve `egitmenId` aynı `Personel` tablosuna iki ayrı rol ile bağlanıyor; diyagramda bu iki rol ayrılmalı.
- `Olcum` tablosu `Personel` ve `Ay` ile ilişkilidir; diyagramda ölçümün ay bazlı tutulduğu netleşmeli.
- `Ay` tablosu `Yil` tablosuna bağlıdır; ayrıca `Turnuva`, `Antrenman` ve `Olcum` tabloları `Ay` üzerinden zaman boyutuna bağlanır.
- Bazı adlar SQL ile birebir aynı değil: `il` yerine `Sehir`, `kg/cm` yerine `kilo/boy`, `idGorev` yerine `gorevId` gibi.

## Güncel Şema

```mermaid
erDiagram
    ULKE {
        int ulkeId PK
        varchar ulkeAd
    }

    SEHIR {
        int sehirId PK
        varchar sehirAd
        int ulkeKodu FK
    }

    GOREV {
        int gorevId PK
        varchar gorevAd
    }

    SPOR_DALI {
        int sporDaliId PK
        varchar sporDaliAd
    }

    BRANS {
        int bransId PK
        varchar bransAd
        int sporDaliId FK
    }

    KAN_GURUBU {
        int kanGrubuID PK
        varchar kanGurubuAd
    }

    PERSONEL {
        int personelID PK
        char TC UK
        varchar ad
        varchar soyad
        smallint cinsiyet
        date dogumT
        int yas "computed"
        char telefonNo UK
        varchar eposta UK
        int ulkeKodu FK
        int sehirKodu FK
        int gorevId FK
        int kanGurubuID FK
        int bransId FK
    }

    SPORCU_PUAN {
        int puanId PK
        int personelId FK,UK
        int mevcutPuan
    }

    YIL {
        int yilId PK
        int yil UK
    }

    AY {
        int ayId PK
        varchar ayAdi
        int yilId FK
    }

    TURNUVA {
        int turnuvaId PK
        varchar turnuvaAd
        date baslangicTarihi
        date bitisTarihi
        int ayId FK
    }

    SALON {
        int salonId PK
        varchar salonAd
        int turnuvaId FK
        int ulkeKodu FK
        int sehirKodu FK
    }

    MUSABAKA {
        int musabakaId PK
        int turnuvaId FK
        int salonId FK
        varchar musabakaAd
        datetime baslangicTarihi
        datetime bitisTarihi
        int sporDaliId FK
    }

    PERSONEL_MUSABAKA {
        int personelId PK,FK
        int musabakaId PK,FK
        int bitirmeSirasi
    }

    MADALYA_TURU {
        int madalyaTuruId PK
        varchar madalyaAd UK
    }

    MADALYA {
        int madalyaId PK
        int personelId FK
        int musabakaId FK
        int bransId FK
        int madalyaTuruId FK
    }

    ANTRENMAN_YERI {
        int antrenmanYeriId PK
        varchar antrenmanYeriAd
        int ulkeKodu FK
        int sehirKodu FK
    }

    ANTRENMAN {
        int antrenmanId PK
        datetime baslangicTarihSaat
        datetime bitisTarihSaat
        int antrenmanSuresi "computed"
        int sporcuId FK
        int egitmenId FK
        int ayId FK
        int antrenmanYeriId FK
    }

    OLCUM {
        int olcumId PK
        int personelId FK
        int ayId FK
        decimal kilo
        decimal boy
    }

    ULKE ||--o{ SEHIR : "icerir"
    ULKE ||--o{ PERSONEL : "uyruk"
    SEHIR ||--o{ PERSONEL : "sehir"
    GOREV ||--o{ PERSONEL : "gorev"
    KAN_GURUBU ||--o{ PERSONEL : "kan grubu"
    SPOR_DALI ||--o{ BRANS : "icerir"
    BRANS ||--o{ PERSONEL : "brans"
    PERSONEL ||--o| SPORCU_PUAN : "puan"

    YIL ||--o{ AY : "icerir"
    AY ||--o{ TURNUVA : "donem"
    TURNUVA ||--o{ SALON : "salon"
    ULKE ||--o{ SALON : "ulke"
    SEHIR ||--o{ SALON : "sehir"
    TURNUVA ||--o{ MUSABAKA : "icerir"
    SALON ||--o{ MUSABAKA : "ev sahipligi"
    SPOR_DALI ||--o{ MUSABAKA : "spor dali"

    PERSONEL ||--o{ PERSONEL_MUSABAKA : "katilir"
    MUSABAKA ||--o{ PERSONEL_MUSABAKA : "katilim"

    PERSONEL ||--o{ MADALYA : "kazanir"
    MUSABAKA ||--o{ MADALYA : "verilir"
    BRANS ||--o{ MADALYA : "brans"
    MADALYA_TURU ||--o{ MADALYA : "tur"

    ULKE ||--o{ ANTRENMAN_YERI : "ulke"
    SEHIR ||--o{ ANTRENMAN_YERI : "sehir"
    PERSONEL ||--o{ ANTRENMAN : "sporcu"
    PERSONEL ||--o{ ANTRENMAN : "egitmen"
    AY ||--o{ ANTRENMAN : "donem"
    ANTRENMAN_YERI ||--o{ ANTRENMAN : "yer"

    PERSONEL ||--o{ OLCUM : "olculur"
    AY ||--o{ OLCUM : "donem"
```
