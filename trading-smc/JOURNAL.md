# Journal — Paper trading SMC

| Capital de départ | Capital actuel | Trades | Gagnants | Perdants | P&L | Drawdown max |
|---|---|---|---|---|---|---|
| 1 000,00 $ | 1 000,00 $ | 0 | 0 | 0 | 0,00 $ | 0 % |

Règles : voir [STRATEGIE.md](STRATEGIE.md).

---

## Positions ouvertes

_Aucune._

## Ordres en attente (fictifs)

| # | Placé (UTC) | Actif | Modèle | Sens | Limite | Stop | TP1 / TP2 | Taille | Risque | R:R TP2 | Expire |
|---|---|---|---|---|---|---|---|---|---|---|---|
| O1 | 2026-09-28 03:31 | BTC | B (POI 4H) | LONG | 82 700 | 81 600 | 85 000 / 87 300 | 0,004545 BTC (376 $) | 5 $ (0,5 %) | 4,2 | 2026-09-29 03:31 |
| O2 | 2026-09-28 03:31 | XAUUSD | B (OB 1H premium) | SHORT | 4 258 | 4 272 | 4 227 / 4 150 | 0,357 oz (1 520 $) | 5 $ (0,5 %) | 7,7 | 2026-09-29 03:31 |

- O1 : sous la liquidité 82 875 (SSL), dans le FVG 4H 81 879 – 84 778, stop sous l'origine de l'impulsion (81 720). Prix au placement : 83 260.
- O2 : dans l'OB 1H 4 257,5 – 4 266 (premium de la jambe 4 316 → 4 194), stop au-dessus de l'OB. Prix au placement : 4 197.
- Risque total ouvert si les deux s'exécutent : 1 %.

## Scalps (modèle S, 0,25 % = 2,50 $)

| # | Placé (UTC) | Actif | Sens | Entrée | Stop | TP | Taille | Statut |
|---|---|---|---|---|---|---|---|---|
| S1 | 03:34 | BTC | SHORT limite | 83 300 | 83 470 | 82 960 | 0,0147 BTC | en attente |
| S2 | 03:34 | XAUUSD | SHORT limite | 4 201,5 | 4 205,0 | 4 194,5 / 4 190,5 (2R / 3,1R) | 0,714 oz | en attente |
| S3 | 03:34 | ETH | LONG (déclencheur) | sweep 2 635 + MSS 1m | sous la mèche | 2R | à calculer | alerte |

- S1 : 15m et 1m baissiers (plus bas décroissants depuis 00:15). Vente sur retour dans la zone 83 280 – 83 330, stop au-dessus du dernier sommet 1m (83 436). TP juste au-dessus de la SSL 82 875.
- S2 : or en range 4 193,6 – 4 203,3 au plus bas, biais baissier. Vente sous le haut du range, cible la SSL 4 193,6.
- S3 : ETH à 2 644, proche de la SSL 2 635 (4H). Achat seulement après sweep + MSS 1m.

## Alertes modèle A (entrée confirmée, 1 %)

- **ETH LONG** : sweep de 2 635 ou 2 600 puis MSS 15m → entrée au 50 % du FVG. Prix : 2 644 (proche de la liquidité).
  Si ETH se déclenche avant O1, **O1 est annulé** (pas BTC et ETH longs en même temps).
- **BTC LONG** : si sweep de 82 875 + MSS 15m **sans** exécution de O1 → entrée modèle A à la place.

## Setups en surveillance

### 2026-09-28 03:26 UTC — analyse de départ (session Asie, aucune entrée)

**BTC — 83 374 $ — biais HAUSSIER (setup LONG A)**
- 1D : au-dessus des EMA 20/50/200, ADX 43,6 (tendance haussière forte), RSI 60.
- 4H : impulsion 81 720 → 87 396, puis correction en range 82 875 – 85 300. Prix en discount de l'impulsion (50 % = 84 558).
- Zone : FVG 4H 81 879 – 84 778, partiellement comblé.
- Liquidité visée par le sweep : plus bas à **82 875** (25/09) et 83 183.
- **Déclencheur** : sweep sous 82 875 (zone 82 000 – 82 875), puis CHoCH haussier 15m.
- TP1 ≈ 85 000 / 85 160 (haut de range) — TP2 87 396 (sommet 4H).
- **Invalidé** si clôture 4H sous 81 700.

**ETH — 2 650 $ — biais HAUSSIER (setup LONG B)**
- 4H : impulsion 2 564 → 2 807, range 2 600 – 2 724. Prix en discount (50 % = 2 685).
- Liquidité : plus bas à **2 635** (24/09) et **2 600** (25/09).
- **Déclencheur** : sweep de 2 635 ou 2 600, puis CHoCH haussier 15m.
- TP1 ≈ 2 724 — TP2 2 807.
- **Invalidé** si clôture 4H sous 2 564.
- ⚠️ Corrélé à BTC : on prend seulement le premier des deux setups qui se déclenche.

**XAUUSD — 4 195 $ — biais BAISSIER (setup SHORT C)**
- 1D : sous l'EMA 20, RSI 29,6 (vient d'entrer en survente) → risque de rebond à court terme.
- 4H : BOS baissier, cassure du plus bas 4 234 (15/09). Prix au plus bas → **on ne vend pas ici** (mauvais R:R).
- Zone premium : OB 1H 4 257,5 – 4 266 + FVG 1H 4 231,5 – 4 257,5 (50 % de la jambe 4 316 → 4 194 = 4 255).
- **Déclencheur** : retour dans 4 250 – 4 266 pendant Londres ou New York, puis CHoCH baissier 15m.
- SL ≈ 4 272 — TP1 4 194 — TP2 4 150. R:R ≈ 4.
- **Invalidé** si clôture 1H au-dessus de 4 281.

---

## Historique des trades

| # | Date ouverture (UTC) | Actif | Sens | Entrée | Stop | TP1 / TP2 | Taille | Sortie | Frais | P&L $ | R | Respect checklist | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
