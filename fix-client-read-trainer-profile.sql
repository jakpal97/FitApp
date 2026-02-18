-- ============================================
-- NAPRAWA: Klienci mogą czytać profil swojego trenera
-- ============================================
-- Data: 2026-02-18
-- Problem: Klient ma trainer_id ale nie może odczytać profilu trenera (NULL)
-- Rozwiązanie: Dodaj politykę SELECT dla klientów
-- 
-- Uruchom w Supabase Dashboard → SQL Editor
-- ============================================

-- Dodaj politykę która pozwala klientom czytać profil swojego trenera
CREATE POLICY "Klienci widzą profil swojego trenera"
ON profiles FOR SELECT
USING (
    -- Klient może zobaczyć profil trenera jeśli jego trainer_id = id tego profilu
    id IN (
        SELECT trainer_id 
        FROM profiles 
        WHERE user_id = auth.uid()
        AND trainer_id IS NOT NULL
    )
);

-- Komunikat sukcesu
DO $$
BEGIN
    RAISE NOTICE '✅ Polityka została utworzona!';
    RAISE NOTICE '✅ Klienci mogą teraz czytać profil swojego trenera';
    RAISE NOTICE '✅ Chat powinien działać!';
END $$;

-- ============================================
-- KONIEC MIGRACJI
-- ============================================

-- Debug (opcjonalnie - sprawdź wszystkie polityki):
-- SELECT policyname, cmd, qual 
-- FROM pg_policies 
-- WHERE tablename = 'profiles' AND cmd = 'SELECT'
-- ORDER BY policyname;
