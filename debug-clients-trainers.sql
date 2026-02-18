-- ============================================
-- DEBUG: Sprawdź klientów i ich trenerów
-- ============================================
-- Uruchom w Supabase SQL Editor żeby zobaczyć co się dzieje
-- ============================================

-- Pokaż wszystkich klientów i ich trenerów
SELECT 
    c.id as client_id,
    c.first_name,
    c.last_name,
    c.email,
    c.trainer_id,
    t.first_name as trainer_first_name,
    t.last_name as trainer_last_name,
    t.email as trainer_email,
    c.created_at,
    c.updated_at
FROM profiles c
LEFT JOIN profiles t ON c.trainer_id = t.id
WHERE c.role = 'client'
ORDER BY c.created_at DESC;

-- ============================================
-- Sprawdź zaproszenia
-- ============================================

SELECT 
    ci.invitation_code,
    ci.client_email,
    ci.status,
    ci.created_at,
    ci.accepted_at,
    ci.expires_at,
    t.first_name as trainer_name,
    c.first_name as client_name
FROM client_invitations ci
JOIN profiles t ON ci.trainer_id = t.id
LEFT JOIN profiles c ON ci.client_id = c.id
ORDER BY ci.created_at DESC
LIMIT 10;

-- ============================================
-- NAPRAW: Jeśli klient nie ma trenera ale ma zaakceptowane zaproszenie
-- ============================================

-- Zobacz klientów bez trenera którzy mają zaakceptowane zaproszenie
SELECT 
    c.id as client_id,
    c.first_name,
    c.last_name,
    ci.trainer_id as should_be_trainer_id,
    t.first_name as trainer_name
FROM profiles c
JOIN client_invitations ci ON c.id = ci.client_id
JOIN profiles t ON ci.trainer_id = t.id
WHERE c.role = 'client'
  AND c.trainer_id IS NULL
  AND ci.status = 'accepted';

-- Jeśli widzisz wyniki powyżej, uruchom to aby naprawić:
-- UPDATE profiles 
-- SET trainer_id = (
--     SELECT trainer_id FROM client_invitations 
--     WHERE client_id = profiles.id 
--     AND status = 'accepted' 
--     LIMIT 1
-- )
-- WHERE id IN (
--     SELECT c.id 
--     FROM profiles c
--     JOIN client_invitations ci ON c.id = ci.client_id
--     WHERE c.role = 'client'
--       AND c.trainer_id IS NULL
--       AND ci.status = 'accepted'
-- );
