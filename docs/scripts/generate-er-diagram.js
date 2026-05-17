const fs = require("fs");
const path = require("path");

const root = path.resolve(__dirname, "..");
const outFile = path.join(root, "assets", "er-diagram.svg");

const tables = [
  {
    id: "ULKE",
    x: 80,
    y: 90,
    title: "Ulke",
    columns: ["ulkeId PK", "ulkeAd"],
  },
  {
    id: "SEHIR",
    x: 80,
    y: 250,
    title: "Sehir",
    columns: ["sehirId PK", "sehirAd", "ulkeKodu FK"],
  },
  {
    id: "GOREV",
    x: 80,
    y: 450,
    title: "Gorev",
    columns: ["gorevId PK", "gorevAd"],
  },
  {
    id: "KAN_GURUBU",
    x: 80,
    y: 610,
    title: "KanGurubu",
    columns: ["kanGrubuID PK", "kanGurubuAd"],
  },
  {
    id: "SPOR_DALI",
    x: 80,
    y: 810,
    title: "SporDali",
    columns: ["sporDaliId PK", "sporDaliAd"],
  },
  {
    id: "BRANS",
    x: 80,
    y: 990,
    title: "Brans",
    columns: ["bransId PK", "bransAd", "sporDaliId FK"],
  },
  {
    id: "PERSONEL",
    x: 500,
    y: 220,
    title: "Personel",
    columns: [
      "personelID PK",
      "TC UK",
      "ad",
      "soyad",
      "cinsiyet",
      "dogumT",
      "yas computed",
      "telefonNo UK",
      "eposta UK",
      "ulkeKodu FK",
      "sehirKodu FK",
      "gorevId FK",
      "kanGurubuID FK",
      "bransId FK",
    ],
  },
  {
    id: "SPORCU_PUAN",
    x: 500,
    y: 670,
    title: "SporcuPuan",
    columns: ["puanId PK", "personelId FK UK", "mevcutPuan"],
  },
  {
    id: "YIL",
    x: 960,
    y: 90,
    title: "Yil",
    columns: ["yilId PK", "yil UK"],
  },
  {
    id: "AY",
    x: 960,
    y: 250,
    title: "Ay",
    columns: ["ayId PK", "ayAdi", "yilId FK"],
  },
  {
    id: "TURNUVA",
    x: 1360,
    y: 110,
    title: "Turnuva",
    columns: ["turnuvaId PK", "turnuvaAd", "baslangicTarihi", "bitisTarihi", "ayId FK"],
  },
  {
    id: "SALON",
    x: 1360,
    y: 370,
    title: "Salon",
    columns: ["salonId PK", "salonAd", "turnuvaId FK", "ulkeKodu FK", "sehirKodu FK"],
  },
  {
    id: "MUSABAKA",
    x: 1360,
    y: 650,
    title: "Musabaka",
    columns: [
      "musabakaId PK",
      "turnuvaId FK",
      "salonId FK",
      "musabakaAd",
      "baslangicTarihi",
      "bitisTarihi",
      "sporDaliId FK",
    ],
  },
  {
    id: "PERSONEL_MUSABAKA",
    x: 960,
    y: 1120,
    title: "PersonelMusabaka",
    columns: ["personelId PK FK", "musabakaId PK FK", "bitirmeSirasi"],
  },
  {
    id: "MADALYA",
    x: 1780,
    y: 650,
    title: "Madalya",
    columns: ["madalyaId PK", "personelId FK", "musabakaId FK", "bransId FK", "madalyaTuruId FK"],
  },
  {
    id: "MADALYA_TURU",
    x: 1780,
    y: 920,
    title: "MadalyaTuru",
    columns: ["madalyaTuruId PK", "madalyaAd UK"],
  },
  {
    id: "ANTRENMAN_YERI",
    x: 960,
    y: 810,
    title: "AntrenmanYeri",
    columns: ["antrenmanYeriId PK", "antrenmanYeriAd", "ulkeKodu FK", "sehirKodu FK"],
  },
  {
    id: "ANTRENMAN",
    x: 500,
    y: 900,
    title: "Antrenman",
    columns: [
      "antrenmanId PK",
      "baslangicTarihSaat",
      "bitisTarihSaat",
      "antrenmanSuresi computed",
      "sporcuId FK",
      "egitmenId FK",
      "ayId FK",
      "antrenmanYeriId FK",
    ],
  },
  {
    id: "OLCUM",
    x: 960,
    y: 540,
    title: "Olcum",
    columns: ["olcumId PK", "personelId FK", "ayId FK", "kilo", "boy"],
  },
];

const relationships = [
  ["ULKE", "SEHIR", "1", "N"],
  ["ULKE", "PERSONEL", "1", "N"],
  ["SEHIR", "PERSONEL", "1", "N"],
  ["GOREV", "PERSONEL", "1", "N"],
  ["KAN_GURUBU", "PERSONEL", "1", "N"],
  ["SPOR_DALI", "BRANS", "1", "N"],
  ["BRANS", "PERSONEL", "1", "N"],
  ["PERSONEL", "SPORCU_PUAN", "1", "0..1"],
  ["YIL", "AY", "1", "N"],
  ["AY", "TURNUVA", "1", "N"],
  ["TURNUVA", "SALON", "1", "N"],
  ["ULKE", "SALON", "1", "N"],
  ["SEHIR", "SALON", "1", "N"],
  ["TURNUVA", "MUSABAKA", "1", "N"],
  ["SALON", "MUSABAKA", "1", "N"],
  ["SPOR_DALI", "MUSABAKA", "1", "N"],
  ["PERSONEL", "PERSONEL_MUSABAKA", "1", "N"],
  ["MUSABAKA", "PERSONEL_MUSABAKA", "1", "N"],
  ["PERSONEL", "MADALYA", "1", "N"],
  ["MUSABAKA", "MADALYA", "1", "N"],
  ["BRANS", "MADALYA", "1", "N"],
  ["MADALYA_TURU", "MADALYA", "1", "N"],
  ["ULKE", "ANTRENMAN_YERI", "1", "N"],
  ["SEHIR", "ANTRENMAN_YERI", "1", "N"],
  ["PERSONEL", "ANTRENMAN", "1", "N sporcu"],
  ["PERSONEL", "ANTRENMAN", "1", "N egitmen"],
  ["AY", "ANTRENMAN", "1", "N"],
  ["ANTRENMAN_YERI", "ANTRENMAN", "1", "N"],
  ["PERSONEL", "OLCUM", "1", "N"],
  ["AY", "OLCUM", "1", "N"],
];

const width = 2180;
const height = 1380;
const tableWidth = 260;
const headerHeight = 36;
const rowHeight = 24;

function escapeXml(value) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

function tableHeight(table) {
  return headerHeight + table.columns.length * rowHeight + 14;
}

function bounds(table) {
  return {
    x: table.x,
    y: table.y,
    w: tableWidth,
    h: tableHeight(table),
  };
}

function center(table) {
  const b = bounds(table);
  return { x: b.x + b.w / 2, y: b.y + b.h / 2 };
}

function edgePoint(from, to) {
  const b = bounds(from);
  const c1 = center(from);
  const c2 = center(to);
  const dx = c2.x - c1.x;
  const dy = c2.y - c1.y;

  if (Math.abs(dx) / b.w > Math.abs(dy) / b.h) {
    return {
      x: dx >= 0 ? b.x + b.w : b.x,
      y: c1.y + (dy / Math.abs(dx || 1)) * (b.w / 2),
    };
  }

  return {
    x: c1.x + (dx / Math.abs(dy || 1)) * (b.h / 2),
    y: dy >= 0 ? b.y + b.h : b.y,
  };
}

const tableMap = new Map(tables.map((table) => [table.id, table]));

function drawRelationship(fromId, toId, fromCard, toCard, index) {
  const from = tableMap.get(fromId);
  const to = tableMap.get(toId);
  const start = edgePoint(from, to);
  const end = edgePoint(to, from);
  const midX = (start.x + end.x) / 2;
  const midY = (start.y + end.y) / 2;
  const curve = Math.min(120, Math.abs(end.x - start.x) / 3);
  const direction = end.x >= start.x ? 1 : -1;
  const offset = ((index % 3) - 1) * 18;
  const c1 = { x: start.x + curve * direction, y: start.y + offset };
  const c2 = { x: end.x - curve * direction, y: end.y - offset };

  return `
    <path class="rel" d="M ${start.x.toFixed(1)} ${start.y.toFixed(1)} C ${c1.x.toFixed(1)} ${c1.y.toFixed(1)}, ${c2.x.toFixed(1)} ${c2.y.toFixed(1)}, ${end.x.toFixed(1)} ${end.y.toFixed(1)}" />
    <text class="cardinality" x="${(start.x + (c1.x - start.x) * 0.35).toFixed(1)}" y="${(start.y + (c1.y - start.y) * 0.35 - 4).toFixed(1)}">${escapeXml(fromCard)}</text>
    <text class="cardinality" x="${(end.x + (c2.x - end.x) * 0.35).toFixed(1)}" y="${(end.y + (c2.y - end.y) * 0.35 - 4).toFixed(1)}">${escapeXml(toCard)}</text>
  `;
}

function columnClass(column) {
  if (column.includes("PK")) return "pk";
  if (column.includes("FK")) return "fk";
  if (column.includes("UK")) return "uk";
  return "field";
}

function drawTable(table) {
  const b = bounds(table);
  const rows = table.columns
    .map((column, index) => {
      const y = table.y + headerHeight + 22 + index * rowHeight;
      return `
        <text class="${columnClass(column)}" x="${table.x + 16}" y="${y}">${escapeXml(column)}</text>
      `;
    })
    .join("");

  return `
    <g class="table" id="${table.id}">
      <rect class="table-bg" x="${b.x}" y="${b.y}" width="${b.w}" height="${b.h}" rx="8" />
      <rect class="table-header" x="${b.x}" y="${b.y}" width="${b.w}" height="${headerHeight}" rx="8" />
      <path class="header-square" d="M ${b.x} ${b.y + 28} H ${b.x + b.w} V ${b.y + headerHeight} H ${b.x} Z" />
      <text class="table-title" x="${b.x + 16}" y="${b.y + 24}">${escapeXml(table.title)}</text>
      ${rows}
    </g>
  `;
}

const svg = `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" role="img" aria-labelledby="title desc">
  <title id="title">Milli Sporcu Yönetim ve Performans Takip Veritabanı ER Diyagramı</title>
  <desc id="desc">SQL Server şemasındaki tabloları ve foreign key ilişkilerini gösteren ER diyagramı.</desc>
  <style>
    .canvas { fill: #f8fafc; }
    .title { fill: #0f172a; font-family: Segoe UI, Arial, sans-serif; font-size: 30px; font-weight: 700; }
    .subtitle { fill: #475569; font-family: Segoe UI, Arial, sans-serif; font-size: 16px; }
    .rel { fill: none; stroke: #64748b; stroke-width: 2; opacity: 0.82; }
    .cardinality { fill: #334155; font-family: Segoe UI, Arial, sans-serif; font-size: 13px; font-weight: 700; paint-order: stroke; stroke: #f8fafc; stroke-width: 4px; }
    .table-bg { fill: #ffffff; stroke: #cbd5e1; stroke-width: 1.4; filter: drop-shadow(0 8px 14px rgba(15, 23, 42, 0.08)); }
    .table-header { fill: #1e293b; }
    .header-square { fill: #1e293b; }
    .table-title { fill: #ffffff; font-family: Segoe UI, Arial, sans-serif; font-size: 16px; font-weight: 700; }
    .pk { fill: #b91c1c; font-family: Consolas, Menlo, monospace; font-size: 13px; font-weight: 700; }
    .fk { fill: #1d4ed8; font-family: Consolas, Menlo, monospace; font-size: 13px; font-weight: 650; }
    .uk { fill: #7c3aed; font-family: Consolas, Menlo, monospace; font-size: 13px; font-weight: 650; }
    .field { fill: #334155; font-family: Consolas, Menlo, monospace; font-size: 13px; }
    .legend-title { fill: #0f172a; font-family: Segoe UI, Arial, sans-serif; font-size: 14px; font-weight: 700; }
    .legend-text { fill: #334155; font-family: Segoe UI, Arial, sans-serif; font-size: 13px; }
  </style>
  <rect class="canvas" width="${width}" height="${height}" />
  <text class="title" x="80" y="48">Milli Sporcu Yönetim ve Performans Takip Veritabanı</text>
  <text class="subtitle" x="80" y="76">Güncel SQL Server şemasına göre hazırlanmış ER diyagramı</text>

  ${relationships.map((rel, index) => drawRelationship(...rel, index)).join("")}
  ${tables.map(drawTable).join("")}

  <g transform="translate(1780, 1160)">
    <rect class="table-bg" x="0" y="0" width="320" height="130" rx="8" />
    <text class="legend-title" x="18" y="30">Notasyon</text>
    <text class="legend-text" x="18" y="58">PK: Primary Key</text>
    <text class="legend-text" x="18" y="82">FK: Foreign Key</text>
    <text class="legend-text" x="18" y="106">UK: Unique Key, computed: hesaplanan alan</text>
  </g>
</svg>
`;

fs.mkdirSync(path.dirname(outFile), { recursive: true });
fs.writeFileSync(outFile, svg, "utf8");
console.log(`Generated ${outFile}`);
