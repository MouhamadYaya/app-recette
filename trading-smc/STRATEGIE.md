# Stratégie SMC (Smart Money Concepts) : guide complet et plan de trading

Compte **fictif** (paper trading) : 1 000 $ de départ. Prix réels moon-x, exécution simulée.
Marchés : **BTC**, **ETH** (futures USDT) et **XAUUSD** (or, CFD).

---

# PARTIE 1 : les concepts SMC

## 1.1 L'idée de base

Les gros acteurs (banques, fonds, market makers) ont besoin de **liquidité** pour remplir leurs ordres :
ils ont besoin que d'autres vendent quand ils achètent, et inversement. Cette liquidité se trouve
là où les traders particuliers placent leurs stops : sous les plus bas évidents et au-dessus des plus hauts évidents.

Le prix va donc souvent :
1. **chercher la liquidité** (casser un plus bas pour déclencher les stops),
2. **se retourner** avec force (déplacement),
3. **revenir** dans la zone de départ du mouvement (OB / FVG) avant de continuer.

La SMC consiste à lire cette séquence et à entrer au point 3, avec un stop derrière le point 1.

## 1.2 Structure de marché

| Terme | Définition | Utilité |
|---|---|---|
| **Swing high / low** | Bougie dont le plus haut (bas) dépasse les 2 bougies de chaque côté | Points de référence de la structure |
| **Tendance haussière** | Plus hauts et plus bas de plus en plus hauts (HH / HL) | Biais long |
| **Tendance baissière** | LH / LL | Biais short |
| **BOS** (Break of Structure) | **Clôture** au-delà du dernier swing, dans le sens de la tendance | Confirme la continuation |
| **CHoCH** (Change of Character) | Première **clôture** au-delà du dernier swing, **contre** la tendance locale | Premier signal de retournement |
| **MSS** (Market Structure Shift) | CHoCH accompagné d'un déplacement (grosse bougie + FVG) | CHoCH de qualité, celui qu'on trade |
| **Structure externe** | Swings du timeframe supérieur (4H / 1D) | Donne le biais et les objectifs finaux |
| **Structure interne** | Swings à l'intérieur d'une jambe (1H / 15m) | Donne le timing d'entrée |

Une mèche au-delà d'un niveau **n'est pas** un BOS : c'est un sweep. Seule la clôture compte.

## 1.3 Liquidité

| Type | Où | Notation |
|---|---|---|
| **Buy-side liquidity (BSL)** | Au-dessus des plus hauts : stops des vendeurs et ordres d'achat en cassure | BSL |
| **Sell-side liquidity (SSL)** | Sous les plus bas : stops des acheteurs | SSL |
| **Equal highs / lows** | Doubles sommets ou doubles creux | Liquidité très attirante |
| **Plus haut / bas de la veille (PDH / PDL)** | Journalier | Cibles fréquentes |
| **Range asiatique** | Plus haut / bas de 00:00–06:00 UTC | Souvent balayé à Londres |
| **Inducement (IDM)** | Petit plus bas interne juste avant une zone | Piège qui doit être pris **avant** que la zone soit valide |

**Sweep (prise de liquidité)** : le prix dépasse le niveau en mèche ou brièvement, puis revient de l'autre côté.
C'est le déclencheur principal de la stratégie.

## 1.4 Zones d'intérêt (POI)

| Zone | Définition | Validité |
|---|---|---|
| **FVG** (Fair Value Gap) | Trou entre le plus haut de la bougie 1 et le plus bas de la bougie 3 (haussier), ou l'inverse | Non comblé à plus de 50 % |
| **Order Block (OB)** | Dernière bougie de couleur opposée avant l'impulsion qui casse la structure | L'impulsion doit laisser un FVG ; l'OB ne doit pas avoir été retesté |
| **Breaker block** | OB qui a été cassé ; il change de rôle (support ↔ résistance) | Après un sweep + CHoCH |
| **Premium / Discount** | Au-dessus / en dessous de 50 % de la jambe considérée | On achète en discount, on vend en premium |
| **OTE** (Optimal Trade Entry) | Retracement 62 %–79 % de la jambe | Zone d'entrée préférée si un OB/FVG s'y trouve |

## 1.5 Temps : sessions et killzones (UTC)

| Session | Horaires | Comportement typique |
|---|---|---|
| Asie | 00:00–06:00 | Range, construction de la liquidité |
| **Londres** | 07:00–10:00 | Sweep du range asiatique, vrai mouvement de la journée |
| **New York** | 12:30–15:30 | Continuation ou retournement du mouvement de Londres |
| Fin NY | 19:00–22:00 | Faible, on évite |

Modèle **AMD** (Power of 3) : **A**ccumulation (Asie), **M**anipulation (sweep à Londres), **D**istribution (vrai mouvement).

---

# PARTIE 2 : le processus d'analyse (top-down)

À faire pour chaque actif, dans cet ordre, **avant** de regarder le 15m :

1. **1D** : tendance (EMA 20/50, structure) + liquidité externe (PDH/PDL, plus haut / bas de la semaine).
2. **4H** : dernière jambe (impulsion), son 50 %, BOS/CHoCH récents, FVG et OB non mitigés.
   → **Biais** : long, short ou neutre (neutre = pas de trade).
3. **1H** : POI précis dans la bonne moitié (discount pour long, premium pour short), liquidité interne proche.
4. **Écrire le scénario** dans le journal : zone, liquidité à prendre, déclencheur, stop, TP1, TP2, invalidation.
5. **15m / 5m** : attendre le déclencheur dans la zone.

---

# PARTIE 3 : les deux modèles d'entrée

## Modèle A : entrée confirmée (modèle principal) — risque 1 %

Toutes les conditions sont obligatoires :
1. Biais 4H défini.
2. Prix dans un POI 1H/4H, côté discount (long) ou premium (short).
3. **Sweep** d'une liquidité (SSL pour un long, BSL pour un short) dans ou juste avant le POI.
4. **MSS 15m** : clôture au-delà du dernier swing interne, avec un déplacement qui laisse un FVG.
5. Entrée : limite au **50 % du FVG** créé par le MSS, ou à l'ouverture de l'OB 15m.
6. Stop : au-delà de la mèche du sweep + buffer (0,1 % crypto ; 1,5 $ sur l'or).
7. R:R ≥ 2 jusqu'à TP2.

## Modèle B : entrée anticipée sur POI HTF — risque 0,5 %

Pour ne pas rater les retournements rapides qui ne donnent pas de retest :
1. POI **4H** très clair (FVG ou OB 4H non mitigé) avec une liquidité évidente juste avant (equal lows/highs, swing récent).
2. Ordre **limite placé à l'avance** juste après la liquidité, à l'intérieur du POI.
3. Stop derrière le POI entier (ou derrière l'origine de l'impulsion).
4. R:R ≥ 3 jusqu'à TP2 (on compense l'absence de confirmation).
5. Annulé si le biais 4H change avant exécution.

Si le modèle A se déclenche au même endroit, on garde un seul des deux trades.

---

# PARTIE 4 : gestion du risque

| Règle | Valeur |
|---|---|
| Risque modèle A | 1 % du capital (10 $ au départ) |
| Risque modèle B | 0,5 % (5 $) |
| Taille de position | Risque $ ÷ distance entrée–stop |
| Levier max | 10x (le risque est défini par le stop, pas par le levier) |
| Positions ouvertes max | 2 ; jamais BTC et ETH dans le même sens (corrélation) |
| Risque total ouvert max | 2 % |
| Perte max journalière | -2 % → arrêt jusqu'au lendemain |
| Perte max hebdomadaire | -5 % → arrêt et revue |
| Série de pertes | 3 pertes d'affilée → 24 h de pause + revue |
| Frais simulés | 0,05 % du notionnel par côté (taker), inclus dans le P&L |

## Gestion du trade

1. **TP1** = liquidité interne la plus proche (≥ 1,5R) → on ferme 50 % et le stop passe au point d'entrée (break-even).
2. **TP2** = liquidité externe (swing 4H opposé) → on ferme le reste.
3. Après TP1, si un nouveau BOS 15m se forme dans le sens du trade, on remonte le stop sous le dernier HL (long) ou au-dessus du dernier LH (short).
4. Ordre limite non exécuté après 2 h (modèle A) ou 24 h (modèle B) → annulé.
5. Pas de déplacement du stop pour « laisser respirer » le trade. Jamais.

---

# PARTIE 5 : règles du paper trading (simulation honnête)

- Exécution vérifiée sur les bougies 15m moon-x : une limite est **exécutée** si le prix **traverse** le niveau (pas seulement le touche).
- Si une même bougie touche le stop et le TP, on considère que le **stop** est touché en premier (hypothèse pessimiste).
- Chaque trade est écrit **avant** l'entrée (scénario), puis mis à jour à la sortie. Pas de réécriture après coup.
- Chaque trade reçoit une note de respect des règles (oui / non). Un trade hors règles compte quand même dans le P&L.

---

# PARTIE 6 : plan de progression

## Phase 1 : paper trading (maintenant)
- Durée : au moins **30 trades** ou **4 semaines** (le plus long des deux).
- Contrôles : ouverture de Londres (07:05 UTC), New York (12:35 UTC), plus des contrôles horaires quand un ordre ou une position est actif.

## Phase 2 : validation (critères pour passer en réel)

| Critère | Seuil |
|---|---|
| Profit factor | ≥ 1,3 |
| Espérance | ≥ +0,25 R / trade |
| Taux de réussite | ≥ 35 % (avec R:R moyen ≥ 2) |
| Drawdown max | ≤ 8 % |
| Respect des règles | 100 % sur les 20 derniers trades |

Si un critère échoue : on ajuste **une seule** règle, on documente le changement ici, et on refait 30 trades.

## Phase 3 : réel en micro
- Capital réel actuel : 19,60 USDT. À 1 % de risque, cela fait 0,20 $ par trade : vérifier d'abord la **taille minimale d'ordre** et le poids des frais sur moon-x.
- Mêmes règles, même journal, mêmes critères sur 20 trades.
- **Chaque ordre réel est confirmé par toi avant exécution.**

## Phase 4 : augmentation
- Uniquement après la phase 3 validée, et on augmente le capital, jamais le % de risque.

---

# PARTIE 7 : revue

- **Chaque jour** : mise à jour du journal (trades, respect des règles, capital).
- **Chaque semaine** : stats (win rate, R moyen, profit factor, drawdown), meilleurs / pires setups par actif et par session.
- **Tous les 30 trades** : décision garder / ajuster / abandonner un actif ou un modèle.

---

# PARTIE 8 : modèle S — scalping SMC (1m / 5m)

Trades courts (quelques minutes à 1 h), plusieurs par session.

| Élément | Règle |
|---|---|
| Biais | Structure **15m** (dernier BOS). Contre-tendance autorisée **uniquement** sur une liquidité 1H/4H (modèle A/B) |
| Zone | FVG ou OB **1m / 5m** en premium (short) ou discount (long) de la dernière jambe 5m |
| Déclencheur | Sweep d'un plus haut / bas **1m** + MSS 1m (clôture) — ou ordre limite dans la zone si le biais 15m est clair |
| Stop | Au-delà du sweep. **Minimum 0,20 %** sur crypto, **3 $** sur l'or (sinon les frais mangent le R) |
| Objectif | **2R minimum** ; 50 % à 1R + stop à l'entrée si le prix y arrive en moins de 5 bougies 1m |
| Risque | **0,25 %** par scalp (2,50 $) |
| Durée max | 45 min : si ni TP ni SL, sortie au marché |
| Max | 2 scalps ouverts ; 8 scalps par jour ; arrêt après 3 scalps perdants d'affilée |
| Frais simulés | Entrée limite 0,02 %, sortie au marché 0,05 % (crypto) ; or : 0,30 $/oz de spread par côté |

Suivi : contrôle toutes les 2–3 minutes pendant qu'un scalp est actif, vérification sur les bougies 1m.
