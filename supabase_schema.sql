-- MonEvo — Schéma Supabase
-- Exécuter dans l'éditeur SQL de ton projet Supabase

-- ─── PROFILES ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS profiles (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
  display_name TEXT,
  avatar_url  TEXT,
  currency    TEXT DEFAULT 'EUR',
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own profile"   ON profiles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (user_id, display_name)
  VALUES (NEW.id, NEW.raw_user_meta_data->>'display_name');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- ─── ONBOARDING ANSWERS ─────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS onboarding_answers (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id               UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL UNIQUE,
  age_range             TEXT,
  financial_experience  TEXT,
  financial_stress      TEXT,
  monthly_expenses      TEXT,
  management_method     TEXT,
  credit_situation      TEXT,
  debt_situation        TEXT,
  finance_sharing_mode  TEXT,
  subscriptions_count   TEXT,
  bills_count           TEXT,
  completed_at          TIMESTAMPTZ,
  created_at            TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE onboarding_answers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can manage own onboarding" ON onboarding_answers
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);


-- ─── CATEGORIES ─────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS categories (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  name       TEXT NOT NULL,
  icon       TEXT NOT NULL DEFAULT '📦',
  color      TEXT NOT NULL DEFAULT '#8A94A6',
  type       TEXT NOT NULL CHECK (type IN ('income', 'expense')),
  is_default BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view default and own categories" ON categories
  FOR SELECT USING (is_default = TRUE OR auth.uid() = user_id);
CREATE POLICY "Users can manage own categories" ON categories
  FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- Catégories par défaut
INSERT INTO categories (name, icon, color, type, is_default) VALUES
  ('Alimentation',  '🍽️', '#FF6B6B', 'expense', TRUE),
  ('Transport',     '🚗', '#4ECDC4', 'expense', TRUE),
  ('Logement',      '🏠', '#45B7D1', 'expense', TRUE),
  ('Courses',       '🛒', '#96CEB4', 'expense', TRUE),
  ('Abonnements',   '📱', '#FFEAA7', 'expense', TRUE),
  ('Santé',         '💊', '#DDA0DD', 'expense', TRUE),
  ('Loisirs',       '🎭', '#F0A500', 'expense', TRUE),
  ('Revenus',       '💰', '#22C47A', 'income',  TRUE)
ON CONFLICT DO NOTHING;


-- ─── TRANSACTIONS ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS transactions (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  amount      NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
  type        TEXT NOT NULL CHECK (type IN ('income', 'expense')),
  description TEXT,
  date        DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can manage own transactions" ON transactions
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE INDEX idx_transactions_user_date ON transactions(user_id, date DESC);


-- ─── BUDGETS ─────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS budgets (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  category_id UUID REFERENCES categories(id) ON DELETE CASCADE NOT NULL,
  amount      NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
  period      TEXT NOT NULL DEFAULT 'monthly' CHECK (period IN ('weekly', 'monthly')),
  start_date  DATE NOT NULL DEFAULT DATE_TRUNC('month', CURRENT_DATE),
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, category_id, period, start_date)
);

ALTER TABLE budgets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can manage own budgets" ON budgets
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);


-- ─── FEEDBACK ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS feedback (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  rating      INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
  message     TEXT,
  screen      TEXT,
  app_version TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE feedback ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can insert feedback" ON feedback
  FOR INSERT WITH CHECK (auth.uid() = user_id OR user_id IS NULL);
CREATE POLICY "Users can view own feedback" ON feedback
  FOR SELECT USING (auth.uid() = user_id);
