<!doctype html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>LightUnfold • Web3 AI X1000</title>

  <!-- SEO / Social -->
  <meta name="description" content="Trang Web3 AI tự động 24/7 • 20,000+ AI • 200+ quốc gia • thanh toán nhanh • affiliate • cập nhật liên tục">
  <meta property="og:title" content="LightUnfold • Web3 AI X1000">
  <meta property="og:description" content="Trang Web3 AI tự động 24/7 • quét QR thanh toán • cơ hội nổi bật cập nhật liên tục">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://vuhuyphat.github.io/">
  <meta name="theme-color" content="#0b0f13">

  <style>
    :root{
      --bg:#0b0f13;--card:#0f141a;--line:#1c2633;--text:#e9eef4;
      --muted:#96a9bd;--accent:#ffb02e;--brand:#7dc1ff;
    }
    *{box-sizing:border-box}
    body{margin:0;background:var(--bg);color:var(--text);font:16px/1.55 system-ui,-apple-system,Segoe UI,Roboto}
    header,section,footer{max-width:1000px;margin:0 auto;padding:20px}
    .hero{padding:28px 20px 12px}
    h1{margin:6px 0 10px;font-size:26px}
    .muted{color:var(--muted)}
    .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:14px}
    .card{background:var(--card);border:1px solid var(--line);border-radius:16px;padding:16px}
    .pill{display:inline-flex;align-items:center;gap:8px;padding:6px 10px;border:1px solid var(--line);border-radius:999px;margin:0 8px 8px 0}
    .pill a{color:var(--brand);text-decoration:none}
    .row{display:flex;gap:10px;flex-wrap:wrap}
    .btn{display:inline-block;background:var(--accent);color:#201400;border:0;border-radius:10px;padding:10px 14px;font-weight:700;cursor:pointer}
    .op{border-top:1px dashed var(--line);padding:10px 0}
    .flex{display:flex;gap:12px;align-items:center}
    .pay{display:flex; gap:12px; align-items:center; border:1px solid var(--line); border-radius:12px; padding:12px}
    .pay img{width:84px;height:84px;border-radius:10px;background:#000;object-fit:cover}
    .pay b{display:block;margin-bottom:4px}
    .link{color:var(--brand);text-decoration:none}
    footer{color:var(--muted);text-align:center;padding:28px 20px 40px}
    code{background:#000;padding:2px 6px;border-radius:6px}
    .badge{display:inline-block;padding:3px 8px;border-radius:999px;border:1px solid var(--line);color:var(--muted);font-size:12px}
    .ok{color:#13c27a}
    .fail{color:#ff6b6b}
  </style>

  <!-- Config nhúng (1 file duy nhất) -->
  <script type="application/json" id="app-config">
  {
    "site": {
      "brand": "LightUnfold • Web3 AI X1000",
      "ens": "lightunfold.eth",
      "tagline": "20,000+ AI • 200+ quốc gia • 200+ ngôn ngữ • tự động 24/7 • chuyển đổi X1000"
    },
    "payments": {
      "eth": "0x54E15A7b6d4213beE87800432A151d794638E3C2",
      "usdt_erc20": "0x5da80d0f7e2df3cb0aa73d6a942bbe36b046b8f0",
      "momo": "0567892030",
      "vietcombank": "9567892030",
      "paypal": "vumumabada@gmail.com"
    },
    "affiliates": [
      { "name": "Binance",  "url": "https://www.binance.com/vi/register?ref=GRO_20338_9V44N" },
      { "name": "AlgosOne", "url": "https://algosone.page.link/MbtR" }
    ],
    "feeds": { "top_n": 10 },
    "schedule": { "refresh_minutes": 10 }
  }
  </script>

  <!-- PWA nhẹ để cache offline -->
  <script>
    if ('serviceWorker' in navigator){
      const sw = `
        const ASSETS = ['/', '/index.html'];
        self.addEventListener('install', e=>{
          e.waitUntil(caches.open('x1000-v1').then(c=>c.addAll(ASSETS)));
          self.skipWaiting();
        });
        self.addEventListener('activate', e=>self.clients.claim());
        self.addEventListener('fetch', e=>{
          const u = new URL(e.request.url);
          if (u.origin===location.origin) {
            e.respondWith(caches.match(e.request).then(r=>r||fetch(e.request)));
          }
        });
      `;
      const blob = new Blob([sw],{type:'text/javascript'});
      navigator.serviceWorker.register(URL.createObjectURL(blob)).catch(()=>{});
    }
  </script>
</head>
<body>
<header class="hero">
  <div class="row">
    <span class="pill">ENS: <b id="ens">—</b></span>
    <span class="pill">Heartbeat: <span id="hb">—</span></span>
    <span class="pill"><a href="data/latest.json" target="_blank">data</a></span>
  </div>
  <h1 id="brand">—</h1>
  <div id="tagline" class="muted">—</div>
</header>

<section class="card">
  <div class="flex" style="justify-content:space-between">
    <h3 style="margin:0">🔥 Cơ hội nổi bật</h3>
    <span id="updated" class="badge">đang tải…</span>
  </div>
  <div id="opps"></div>
</section>

<section class="card">
  <h3 style="margin:0 0 8px">💳 Thanh toán</h3>
  <div id="pays" class="grid"></div>
  <div class="muted" style="margin-top:6px">Quét QR / nhấn vào để thanh toán nhanh. Sau khi thanh toán, liên hệ <code id="pp"></code>.</div>
</section>

<section class="card">
  <h3 style="margin:0 0 8px">🤝 Affiliate</h3>
  <div id="affs" class="grid"></div>
</section>

<footer>
  © <span id="year"></span> LightUnfold • Phi tập trung & mở rộng 24/7
</footer>

<script>
(async function(){
  // --- utils ---
  const $ = sel => document.querySelector(sel);
  const el = (t,attrs={}) => Object.assign(document.createElement(t),attrs);
  const fmt = n => Number(n).toLocaleString('en-US',{maximumFractionDigits:8});
  const ago = (t)=>{
    try{
      const d=new Date(t); const sec=(Date.now()-d.getTime())/1000;
      if(sec<90) return `${Math.round(sec)}s`;
      const m=sec/60; if(m<90) return `${Math.round(m)}m`;
      const h=m/60; if(h<36) return `${Math.round(h)}h`;
      const dd=h/24; return `${Math.round(dd)}d`;
    }catch{ return '—';}
  };
  const qr = (text,size=240)=>`https://api.qrserver.com/v1/create-qr-code/?size=${size}x${size}&qzone=2&data=${encodeURIComponent(text)}`;

  // --- load config (nhúng, không cần file ngoài) ---
  const cfg = JSON.parse(document.getElementById('app-config').textContent);

  // --- header ---
  $('#brand').textContent = cfg.site.brand || 'AI X1000';
  $('#ens').textContent = cfg.site.ens || '—';
  $('#tagline').textContent = cfg.site.tagline || 'Trang Web3 AI tự động 24/7';
  $('#year').textContent = new Date().getFullYear();
  $('#pp').textContent = cfg.payments?.paypal || '';

  // --- payments (QR tự sinh) ---
  const pays = [];
  if (cfg.payments?.eth) {
    const link = `ethereum:${cfg.payments.eth}`;
    pays.push({name:'ETH (EVM)', id: cfg.payments.eth, qr: qr(link), href: link, hint:'Quét ví EVM / Metamask'});
  }
  if (cfg.payments?.usdt_erc20) {
    const link = `ethereum:${cfg.payments.usdt_erc20}`;
    pays.push({name:'USDT (ERC20)', id: cfg.payments.usdt_erc20, qr: qr(link), href: link, hint:'USDT mạng ERC20'});
  }
  if (cfg.payments?.momo) {
    const link = `https://nhantien.momo.vn/${cfg.payments.momo}`;
    pays.push({name:'MoMo', id: cfg.payments.momo, qr: qr(link), href: link, hint:'Mở MoMo để thanh toán'});
  }
  if (cfg.payments?.vietcombank) {
    const link = `https://img.vietqr.io/image/VCB-${cfg.payments.vietcombank}-compact.png`;
    // Dùng trực tiếp ảnh VietQR làm QR
    pays.push({name:'Vietcombank', id: cfg.payments.vietcombank, qr: link, href: link, hint:'Quét VietQR'});
  }
  if (cfg.payments?.paypal) {
    const user = cfg.payments.paypal.split('@')[0];
    const link = `https://www.paypal.com/paypalme/${encodeURIComponent(user)}`;
    pays.push({name:'PayPal', id: cfg.payments.paypal, qr: qr(link), href: link, hint:'PayPal.me'});
  }

  const $pays = $('#pays');
  if (!pays.length) $pays.innerHTML = `<div class="muted">Chưa cấu hình phương thức thanh toán.</div>`;
  for (const p of pays) {
    const card = el('div',{className:'pay'});
    const img  = el('img',{src:p.qr, alt:p.name});
    const box  = el('div');
    box.innerHTML = `<b>${p.name}</b>
      <div class="muted" style="word-break:break-all">${p.id}</div>
      <div style="margin-top:6px">
        <a class="link" href="${p.href}" target="_blank" rel="noopener">Mở / Sao chép</a>
      </div>`;
    card.append(img, box);
    $pays.append(card);
  }

  // --- affiliates (thêm UTM tự động) ---
  const $affs = $('#affs');
  if (Array.isArray(cfg.affiliates) && cfg.affiliates.length){
    for (const a of cfg.affiliates){
      const u = new URL(a.url);
      u.searchParams.set('utm_source','x1000');
      u.searchParams.set('utm_medium','affiliate');
      u.searchParams.set('utm_campaign','site');
      const c = el('div',{className:'card'});
      c.innerHTML = `<b>${a.name}</b><div style="height:6px"></div>
        <a class="link" href="${u.toString()}" target="_blank" rel="noopener">Mở liên kết</a>`;
      $affs.append(c);
    }
  } else {
    $affs.innerHTML = `<div class="muted">Chưa có link affiliate.</div>`;
  }

  // --- cơ hội nổi bật / heartbeat từ data/latest.json (nếu workflow đang chạy) ---
  async function loadData(){
    try{
      const r = await fetch('data/latest.json?ts='+Date.now(), {cache:'no-store'});
      if (!r.ok) throw new Error('no data');
      const j = await r.json();
      $('#hb').innerHTML = `<span class="ok">online</span>`;
      $('#updated').textContent = `updated ${ago(j.generated_at)} ago`;
      const list = Array.isArray(j.items) ? j.items : [];
      const $opps = $('#opps');
      if (!list.length) {
        $opps.innerHTML = `<div class="muted">Chưa có dữ liệu xếp hạng.</div>`;
        return;
      }
      $opps.innerHTML = list.map(x=>`
        <div class="op">
          <div class="row" style="justify-content:space-between">
            <div><b>${x.symbol || x.name}</b> · $${fmt(x.price || 0)}</div>
            <div class="badge">${x.source || ''}</div>
          </div>
          <div class="muted">24h: ${(x.ch24h??0).toFixed(2)}% · Vol24h: ${fmt(x.vol24h||0)}</div>
          <div style="margin-top:6px">
            <a class="link" href="${x.link||'#'}" target="_blank" rel="noopener">Chi tiết</a>
          </div>
        </div>
      `).join('');
    }catch(e){
      $('#hb').innerHTML = `<span class="fail">offline</span>`;
      $('#updated').textContent = 'chưa có dữ liệu (sẽ tự cập nhật khi workflow chạy)';
      $('#opps').innerHTML = `<div class="muted">Hệ thống đang khởi tạo, quay lại sau vài phút…</div>`;
    }
  }
  loadData();
  // Tự refresh phần data (nhẹ nhàng, không spam)
  setInterval(loadData, Math.max(2, (cfg.schedule?.refresh_minutes||10)) * 60 * 1000);
})();
</script>
</body>
</html>
