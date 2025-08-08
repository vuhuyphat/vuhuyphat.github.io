name: AI X1000 – Scan & Broadcast
on:
  schedule:
    - cron: "*/10 * * * *"   # chạy mỗi 10 phút (UTC)
  workflow_dispatch:

permissions:
  contents: write

jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: "20"

      - name: Build latest.json (scan multiple sources + score)
        run: |
          node - <<'NODE'
          import fs from 'fs';
          import fetch from 'node-fetch';

          const cfg = JSON.parse(fs.readFileSync('config.json','utf8'));
          const topN = (cfg.feeds?.top_n)||10;

          const sources = {
            coingecko_markets: async () => {
              const url='https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=volume_desc&per_page=50&page=1&price_change_percentage=1h,24h,7d';
              return await (await fetch(url)).json();
            },
            coinlore_tickers: async () => {
              const url='https://api.coinlore.net/api/tickers/?start=0&limit=50';
              const j = await (await fetch(url)).json();
              return j?.data || [];
            }
          };

          function scoreCG(c){
            const s =
              (Number(c.price_change_percentage_1h_in_currency)||0)*0.4 +
              (Number(c.price_change_percentage_24h_in_currency)||0)*0.35 +
              (Number(c.price_change_percentage_7d_in_currency)||0)*0.25 +
              Math.log10((Number(c.total_volume)||1));
            return s;
          }
          function scoreCL(c){
            const ch24 = Number(c.percent_change_24h)||0;
            const vol  = Number(c.volume24)||0;
            const s = ch24*0.7 + Math.log10(vol||1);
            return s;
          }

          async function compose(){
            let items = [];
            for (const key of (cfg.feeds?.sources||['coingecko_markets'])) {
              try{
                const data = await sources[key]();
                if (key==='coingecko_markets') {
                  items = items.concat(
                    data.map(c=>({
                      source:'coingecko', id:c.id, symbol:c.symbol?.toUpperCase(), name:c.name,
                      price:Number(c.current_price)||0,
                      ch1h:Number(c.price_change_percentage_1h_in_currency)||0,
                      ch24h:Number(c.price_change_percentage_24h_in_currency)||0,
                      ch7d:Number(c.price_change_percentage_7d_in_currency)||0,
                      vol24h:Number(c.total_volume)||0,
                      score: scoreCG(c),
                      link:`https://www.coingecko.com/en/coins/${c.id}`
                    }))
                  );
                } else if (key==='coinlore_tickers') {
                  items = items.concat(
                    data.map(c=>({
                      source:'coinlore', id:c.id, symbol:c.symbol, name:c.name,
                      price:Number(c.price_usd)||0,
                      ch24h:Number(c.percent_change_24h)||0,
                      vol24h:Number(c.volume24)||0,
                      score: scoreCL(c),
                      link:`https://www.coinlore.com/coin/${(c.name||'').toLowerCase().replace(/\\s+/g,'-')}`
                    }))
                  );
                }
              }catch(e){ /* ignore */ }
            }
            // gộp theo symbol, lấy item có score cao nhất
            const best = {};
            for (const it of items) {
              if (!it.symbol) continue;
              const k = it.symbol.toUpperCase();
              if (!best[k] || it.score > best[k].score) best[k]=it;
            }
            const out = Object.values(best)
              .sort((a,b)=>b.score-a.score)
              .slice(0, topN);

            const payload = {
              generated_at: new Date().toISOString(),
              brand: cfg.site.brand,
              items: out
            };
            fs.mkdirSync('data',{recursive:true});
            fs.writeFileSync('data/latest.json', JSON.stringify(payload,null,2));
            return out;
          }

          const top = await compose();
          // Save a short summary for broadcast
          const lines = top.map(x=>`${x.symbol}: $${x.price} (${(x.ch24h||0).toFixed(2)}%)`).join(' | ');
          fs.writeFileSync('data/summary.txt', `🔥 TOP: ${lines}`);
          NODE

      - name: Commit updated data
        run: |
          git config user.name  "ai-x1000-bot"
          git config user.email "ai@lightunfold.eth"
          git add data/latest.json data/summary.txt
          git commit -m "data: refresh $(date -u +'%Y-%m-%dT%H:%M:%SZ')" || echo "no changes"
          git push || true

      - name: Broadcast to Telegram (optional)
        if: ${{ secrets.TELEGRAM_BOT_TOKEN && secrets.TELEGRAM_CHAT_ID }}
        env:
          BOT: ${{ secrets.TELEGRAM_BOT_TOKEN }}
          CHAT: ${{ secrets.TELEGRAM_CHAT_ID }}
        run: |
          MSG="$(cat data/summary.txt)"
          curl -s "https://api.telegram.org/bot${BOT}/sendMessage" \
            -d "chat_id=${CHAT}" -d "text=${MSG}" -d "disable_web_page_preview=true" >/dev/null || true

      - name: Broadcast to Discord (optional)
        if: ${{ secrets.DISCORD_WEBHOOK_URL }}
        env:
          WH: ${{ secrets.DISCORD_WEBHOOK_URL }}
        run: |
          MSG="$(cat data/summary.txt | sed 's/"/\\"/g')"
          curl -s -H "Content-Type: application/json" -X POST \
            -d "{\"content\":\"${MSG}\"}" "$WH" >/dev/null || true

      - name: Broadcast to X/Twitter (optional)
        if: ${{ secrets.X_BEARER_TOKEN }}
        env:
          X_BEARER_TOKEN: ${{ secrets.X_BEARER_TOKEN }}
        run: |
          MSG="$(cat data/summary.txt | cut -c1-270)"
          curl -s -X POST "https://api.twitter.com/2/tweets" \
           -H "Authorization: Bearer ${X_BEARER_TOKEN}" \
           -H "Content-Type: application/json" \
           -d "{\"text\":\"${MSG}\"}" >/dev/null || true
