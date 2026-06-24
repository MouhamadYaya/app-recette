# Monevo — Mémoire du Projet

## Identité
- **Nom** : Monevo (expense manager)
- **Bundle ID** : à renommer depuis SwiftSupabaseStarter
- **Icône** : cochon tirelire blanc sur fond navy (#18284A) — fichier fourni
- **Palette** : Navy `#18284A` · Bleu clair `#C2D8ED` · Vert `#22C47A` · Rouge `#FF4E6A` · Blanc · Gris `#8A94A6`
- **Font** : SF Pro (system-ui iOS)
- **Base** : SwiftSupabaseStarter (Supabase Auth + Swift)

---

## Architecture des écrans (prototype Claude Design)

### Onboarding (19 steps)
| Step | Écran |
|------|-------|
| 0 | Bienvenue — logo Monevo + CTA |
| 1 | Accroche 💡 "Maîtrisez votre argent" |
| 2 | Intro questions (mascotte chien) |
| 3 | Q1 — Âge |
| 4 | Q2 — Expérience financière |
| 5 | Q3 — Stress financier |
| 6 | Communauté (interlude) |
| 7 | Q4 — Dépenses mensuelles |
| 8 | Q5 — Méthode de gestion |
| 9 | Q6 — Crédit |
| 10 | Q7 — Dettes |
| 11 | Q8 — Partage des finances |
| 12 | Q9 — Abonnements |
| 13 | Q10 — Factures |
| 14 | Fonctionnalités activées selon réponses |
| 15 | Social proof |
| 16–18 | Paywall (3 écrans, fond sombre) |

### App principale (4 onglets)
| Onglet | Sous-onglets |
|--------|-------------|
| Aperçu | Aperçu · Dépenses · Liste |
| Budget | Programmer · Il reste · Informations |
| Calendrier | Vue mois + transactions du jour |
| Paramètres | Profil · Connexion bancaire |

### Modals
- Ajout de transaction (bouton +)
- Connexion bancaire
- Paramètres budget

---

## Structure des fichiers (cible)

```
Monevo/
├── Models/
│   ├── Transaction.swift
│   ├── Category.swift
│   ├── Budget.swift
│   ├── UserProfile.swift
│   ├── OnboardingAnswers.swift
│   └── Feedback.swift
├── ViewModels/
│   ├── AuthViewModel.swift        ✅ existant
│   ├── TransactionViewModel.swift
│   ├── BudgetViewModel.swift
│   └── OnboardingViewModel.swift
├── Views/
│   ├── Onboarding/
│   │   ├── OnboardingFlow.swift
│   │   ├── WelcomeView.swift
│   │   ├── OnboardingQuestionView.swift
│   │   ├── PaywallView.swift
│   │   └── ...
│   ├── Main/
│   │   ├── MainTabView.swift
│   │   ├── Apercu/
│   │   ├── Budget/
│   │   ├── Calendrier/
│   │   └── Parametres/
│   └── Components/
│       ├── MonevoLogo.swift
│       └── ...
├── Repositories/
│   ├── SupabaseAuthRepository.swift  ✅ existant (+ MockAuthRepository)
│   ├── TransactionRepository.swift
│   └── BudgetRepository.swift
└── Utils/
    ├── MonevoStyles.swift            (remplace UIStyles.swift)
    ├── SupabaseManager.swift         ✅ existant
    └── Extensions.swift              ✅ existant
```

---

## Base de données Supabase (schéma cible)

```sql
-- Profils utilisateurs
profiles (id, user_id, display_name, avatar_url, currency, created_at)

-- Réponses onboarding
onboarding_answers (id, user_id, age_range, financial_experience, financial_stress,
                    monthly_expenses, management_method, has_credit, has_debts,
                    shares_finances, subscriptions_count, bills_count,
                    completed_at, created_at)

-- Catégories
categories (id, user_id, name, icon, color, type[income/expense], is_default, created_at)

-- Transactions
transactions (id, user_id, category_id, amount, type[income/expense],
              description, date, created_at)

-- Budgets
budgets (id, user_id, category_id, amount, period[monthly/weekly],
         start_date, created_at)

-- Feedbacks
feedback (id, user_id, rating, message, screen, app_version, created_at)
```

---

## Suivi des phases

### Phase 1 — Setup & Infrastructure ⏳ EN COURS
- [x] Fichier memory.md créé
- [x] Modèles Swift créés (Transaction, Category, Budget, UserProfile, OnboardingAnswers, Feedback)
- [x] MonevoStyles.swift (design system Monevo)
- [ ] Renommer le projet Xcode en Monevo
- [ ] Configurer Supabase (credentials réels)
- [ ] Créer les tables Supabase (SQL)
- [ ] Configurer l'icône de l'app

### Phase 2 — Onboarding ⬜ À FAIRE
- [ ] OnboardingViewModel
- [ ] WelcomeView (step 0)
- [ ] LightbulbView (step 1)
- [ ] QuestionsIntroView (step 2)
- [ ] OnboardingQuestionView (steps 3-5, 7-13)
- [ ] CommunityView (step 6)
- [ ] FeaturesView (step 14)
- [ ] SocialProofView (step 15)
- [ ] PaywallView (steps 16-18)
- [ ] OnboardingFlow coordinator

### Phase 3 — App principale ⬜ À FAIRE
- [ ] MainTabView
- [ ] Aperçu (3 sous-onglets)
- [ ] Budget (3 sous-onglets)
- [ ] Calendrier
- [ ] Paramètres
- [ ] Modal ajout transaction

### Phase 4 — Fonctionnalités transverses ⬜ À FAIRE
- [ ] TransactionViewModel + Repository
- [ ] BudgetViewModel + Repository
- [ ] Connexion bancaire (modal)
- [ ] Notifications

---

## Journal des changements

| Date | Action |
|------|--------|
| 2026-06-24 | Analyse du prototype HTML Claude Design |
| 2026-06-24 | Fix crash Xcode Preview (MockAuthRepository) |
| 2026-06-24 | Création memory.md |
| 2026-06-24 | Modèles Swift Phase 1 créés |
| 2026-06-24 | MonevoStyles.swift (design system) |

---

## Notes techniques
- Le projet tourne sur branche `claude/blissful-cori-j0mvlb`
- Le push GitHub est bloqué par permissions (403) depuis le container cloud
- Appliquer les changements localement via `git pull` une fois les permissions réglées
- Prototype HTML : `22ad50c3-Fynn__Interface_Financie_re.html` (Claude Design export)
