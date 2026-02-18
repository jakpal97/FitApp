-- ============================================
-- NAPRAWA: Usuń błędną politykę i dodaj poprawną
-- ============================================
-- Data: 2026-02-18
-- Problem: Poprzednia polityka powodowała infinite recursion
-- Rozwiązanie: Użyj funkcji pomocniczej
-- 
-- Uruchom w Supabase Dashboard → SQL Editor
-- ============================================

-- KROK 1: Usuń błędną politykę
DROP POLICY IF EXISTS "Klienci widzą profil swojego trenera" ON profiles;

-- KROK 2: Stwórz funkcję pomocniczą (SECURITY DEFINER = omija RLS)
CREATE OR REPLACE FUNCTION get_my_trainer_id()
RETURNS UUID
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
    SELECT trainer_id 
    FROM profiles 
    WHERE user_id = auth.uid()
    LIMIT 1;
$$;

-- KROK 3: Dodaj poprawną politykę używając funkcji
CREATE POLICY "Klienci widzą profil swojego trenera"
ON profiles FOR SELECT
USING (
    -- Profil który czytamy to profil trenera zalogowanego klienta
    id = get_my_trainer_id()
);

-- Komunikat sukcesu
DO $$
BEGIN
    RAISE NOTICE '✅ Błędna polityka usunięta!';
    RAISE NOTICE '✅ Funkcja get_my_trainer_id() utworzona!';
    RAISE NOTICE '✅ Nowa poprawna polityka utworzona!';
    RAISE NOTICE '✅ Brak infinite recursion - chat powinien działać!';
END $$;

-- ============================================
-- KONIEC MIGRACJI
-- ============================================
