# Stratégie SMC — Paper trading

Compte **fictif** : 1 000 $ de départ, risque **1 % par trade (10 $)**.
Prix réels moon-x, exécution simulée. Aucun ordre réel n'est passé.

Marchés : **BTC**, **ETH** (futures USDT) et **XAUUSD** (or, CFD).

---

## 1. Principe

On trade **dans le sens de la structure du timeframe supérieur**, uniquement :
1. après une **prise de liquidité** (sweep d'un plus haut / plus bas évident),
2. suivie d'un **changement de structure** (CHoCH / MSS) sur le timeframe d'entrée,
3. avec une entrée sur le **retour dans une zone** (Order Block ou FVG) en discount (achat) ou premium (vente).

Pas de sweep + CHoCH + zone = pas de trade.

## 2. Timeframes

| Rôle | TF | Question |
|---|---|---|
| Biais | 1D + 4H | Tendance haussière ou baissière ? Où est la liquidité ? |
| Zone | 1H | Quel OB/FVG non mitigé dans la bonne moitié du range ? |
| Entrée | 15m (5m si besoin) | Sweep + CHoCH dans la zone ? |

## 3. Définitions (règles objectives)

- **Swing high / low** : bougie dont le plus haut (bas) dépasse celui des 2 bougies de chaque côté.
- **BOS** : clôture de bougie au-delà du dernier swing dans le sens de la tendance.
- **CHoCH / MSS** : première clôture au-delà du dernier swing **contraire** à la tendance locale.
- **FVG** : écart entre le plus haut de la bougie 1 et le plus bas de la bougie 3 (ou inverse), laissé par une bougie 2 impulsive.
- **Order Block** : dernière bougie opposée avant l'impulsion qui crée le BOS/CHoCH. Valide seulement si l'impulsion laisse un FVG.
- **Liquidité** : doubles plus hauts/bas, plus haut/bas de la veille, de la semaine, de session Asie, niveaux ronds.
- **Premium / Discount** : au-dessus / en dessous de 50 % du dernier swing 4H (Fibonacci 0,5). On achète en discount, on vend en premium.

## 4. Checklist d'entrée (tout doit être OUI)

1. Biais 4H clair (ou 1D si le 4H est en range) — noté avant de regarder le 15m.
2. Prix en discount (long) ou premium (short) du swing 4H.
3. Zone 1H identifiée (OB ou FVG non touché).
4. **Sweep** d'une liquidité visible dans ou juste avant la zone.
5. **CHoCH** 15m par clôture de bougie dans le sens du trade.
6. Entrée : limite au 50 % du FVG ou à l'ouverture de l'OB 15m créé par le CHoCH.
7. Stop : au-delà du point extrême du sweep (+ buffer : 0,1 % crypto, 1,5 $ or).
8. **R:R ≥ 2** jusqu'à TP2, sinon on ne prend pas le trade.
9. Pas d'annonce macro majeure (CPI, NFP, FOMC) dans les 30 minutes.
10. Pas plus de 2 positions ouvertes en même temps ; pas BTC et ETH dans le même sens simultanément (corrélation).

## 5. Gestion du trade

- **Taille** = 10 $ / distance au stop. Levier ≤ 10x (la taille compte, pas le levier).
- **TP1** = liquidité interne la plus proche (≈ 1,5–2R) → on sécurise 50 % et le stop passe au point d'entrée.
- **TP2** = liquidité externe (swing 4H opposé) → on ferme le reste.
- Ordre limite non déclenché après 8 bougies 15m (2 h) → annulé.
- Invalidation structurelle (clôture 1H au-delà du stop avant l'entrée) → annulé.

## 6. Sessions (UTC)

| Session | Horaires | Usage |
|---|---|---|
| Asie | 00:00–06:00 | Construit la liquidité (range). On observe, on ne trade pas. |
| **Londres** | 07:00–10:00 | Killzone : sweep du range Asie. |
| **New York** | 12:30–15:30 | Killzone : continuation ou retournement. |

Or : entrées uniquement pendant Londres et New York.

## 7. Garde-fous

- **Perte max journalière : -2 %** (2 stops) → arrêt pour la journée.
- **Perte max hebdo : -5 %** → arrêt jusqu'à la semaine suivante et révision.
- 3 pertes d'affilée → pause de 24 h et revue des trades.
- Frais simulés : **0,05 % par côté** (taker) inclus dans chaque P&L.
- Une limite est considérée exécutée si le prix **traverse** le niveau (pas seulement le touche).

## 8. Critères pour passer au vrai compte

Après **au moins 30 trades** ou **4 semaines** (le plus long des deux) :

| Critère | Seuil |
|---|---|
| Profit factor | ≥ 1,3 |
| Espérance | ≥ +0,25 R / trade |
| Drawdown max | ≤ 8 % |
| Respect des règles | 100 % (aucun trade hors checklist) |

Si un seul critère échoue → on ajuste **une** règle et on refait 30 trades.

Passage en réel : même risque en % (1 %). Avec 19,60 $, 1 % = 0,20 $ :
vérifier d'abord la taille minimale d'ordre et le poids des frais sur moon-x.
**Chaque ordre réel sera confirmé par toi avant exécution.**
