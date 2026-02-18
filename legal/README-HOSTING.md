# 🏋️ FitCoach - Hosting dokumentów prawnych

## 📁 Pliki do hostingu

W folderze `legal/` znajdują się następujące pliki HTML:

- `privacy-policy.html` - Polityka Prywatności (WYMAGANE przez Google Play i App Store)
- `terms-of-service.html` - Regulamin (WYMAGANE przez Google Play i App Store)
- `help-center.html` - Centrum Pomocy / FAQ (opcjonalne, ale zalecane)

## 🚀 Opcje hostingu

### Opcja 1: GitHub Pages (ZALECANE - DARMOWE)

1. **Utwórz repozytorium na GitHub:**
   ```bash
   cd FitCoach
   git init
   git add legal/
   git commit -m "Add legal documents"
   ```

2. **Stwórz publiczne repo na GitHub:**
   - Przejdź na https://github.com/new
   - Nazwa: `fitcoach` (lub inna)
   - Publiczne
   - Create repository

3. **Push plików:**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/fitcoach.git
   git branch -M main
   git push -u origin main
   ```

4. **Włącz GitHub Pages:**
   - Idź do Settings → Pages
   - Source: Deploy from a branch
   - Branch: main, folder: / (root)
   - Save

5. **Twoje linki będą:**
   ```
   https://YOUR_USERNAME.github.io/fitcoach/legal/privacy-policy.html
   https://YOUR_USERNAME.github.io/fitcoach/legal/terms-of-service.html
   https://YOUR_USERNAME.github.io/fitcoach/legal/help-center.html
   ```

6. **Zaktualizuj linki w aplikacji:**
   - Otwórz `fitCoach/src/screens/client/ClientSettingsScreen.tsx`
   - Zamień `yourusername` na swoją nazwę użytkownika GitHub
   - Otwórz `fitCoach/src/screens/trainer/TrainerSettingsScreen.tsx`
   - Zamień `yourusername` na swoją nazwę użytkownika GitHub

### Opcja 2: Netlify (DARMOWE, łatwe)

1. **Zainstaluj Netlify CLI:**
   ```bash
   npm install -g netlify-cli
   ```

2. **Deploy:**
   ```bash
   cd legal/
   netlify deploy --prod
   ```

3. **Twoje linki:**
   ```
   https://YOUR_SITE_NAME.netlify.app/privacy-policy.html
   https://YOUR_SITE_NAME.netlify.app/terms-of-service.html
   https://YOUR_SITE_NAME.netlify.app/help-center.html
   ```

### Opcja 3: Vercel (DARMOWE)

1. **Zainstaluj Vercel CLI:**
   ```bash
   npm install -g vercel
   ```

2. **Deploy:**
   ```bash
   cd legal/
   vercel --prod
   ```

### Opcja 4: Własny hosting

Jeśli masz już hosting (np. nazwa.pl, home.pl):
1. Uploaduj pliki HTML przez FTP
2. Ustaw uprawnienia: 644
3. Sprawdź dostępność pod: `https://twojastrona.pl/privacy-policy.html`

## ✅ Checklist przed publikacją w sklepach

### KRYTYCZNE (MUSISZ MIEĆ):

- [ ] Privacy Policy dostępna pod publicznym URL
- [ ] Terms of Service dostępne pod publicznym URL
- [ ] Linki w aplikacji zaktualizowane (ClientSettingsScreen.tsx, TrainerSettingsScreen.tsx)
- [ ] Linki działają (otwieraj się w przeglądarce)
- [ ] Email supportowy skonfigurowany: support@fitcoach.app (lub własny)

### OPCJONALNE (ale zalecane):

- [ ] Help Center dostępne pod publicznym URL
- [ ] Własna domena (np. fitcoach.app) zamiast github.io
- [ ] SSL/HTTPS włączony (GitHub Pages i Netlify mają to domyślnie)

## 🔧 Konfiguracja emaila supportowego

### Opcja 1: Gmail Business (płatne, profesjonalne)

1. Google Workspace: https://workspace.google.com
2. Stwórz konto: support@fitcoach.app
3. Koszt: ~6 USD/miesiąc

### Opcja 2: Zoho Mail (DARMOWE do 5 użytkowników)

1. Rejestracja: https://www.zoho.com/mail/
2. Dodaj domenę fitcoach.app (lub swoją)
3. Stwórz konto: support@fitcoach.app
4. Skonfiguruj MX records u dostawcy domeny

### Opcja 3: Własny email (jeśli masz hosting)

Jeśli masz hosting z cPanel:
1. Email Accounts → Create
2. support@fitcoach.app (lub @twojastrona.pl)
3. Sprawdź czy działa: wyślij testowego maila

### Tymczasowe rozwiązanie:

Jeśli nie masz jeszcze domeny/emaila, użyj Gmail:
```javascript
// W plikach Settings:
Linking.openURL('mailto:twoj.email@gmail.com?subject=FitCoach Support')
```

## 📝 Aktualizacja linków w aplikacji

Po uzyskaniu finalnych URL-i:

1. **ClientSettingsScreen.tsx** (linia ~169-178):
```typescript
const handlePrivacyPolicy = useCallback(() => {
  Linking.openURL('https://YOUR_GITHUB_USERNAME.github.io/fitcoach/legal/privacy-policy.html').catch(() => {
    Alert.alert('Błąd', 'Nie można otworzyć polityki prywatności')
  })
}, [])

const handleTerms = useCallback(() => {
  Linking.openURL('https://YOUR_GITHUB_USERNAME.github.io/fitcoach/legal/terms-of-service.html').catch(() => {
    Alert.alert('Błąd', 'Nie można otworzyć regulaminu')
  })
}, [])

const handleSupportContact = useCallback(() => {
  Linking.openURL('mailto:support@YOUR_DOMAIN.com?subject=Pytanie od klienta FitCoach').catch(() => {
    Alert.alert('Błąd', 'Nie można otworzyć klienta email')
  })
}, [])
```

2. **TrainerSettingsScreen.tsx** - te same zmiany

3. **Testowanie:**
```bash
cd fitCoach
npm start
# Otwórz aplikację, przejdź do Ustawień, kliknij linki
```

## 🚨 UWAGA dla Google Play Store

Google Play wymaga:
- **Privacy Policy URL** - podajesz w Play Console → App Content → Privacy Policy
- **Email kontaktowy** - wymagany w Store Listing
- Link musi być dostępny publicznie (bez logowania)
- Link musi zawierać WSZYSTKIE informacje o zbieranych danych

## 🚨 UWAGA dla Apple App Store

Apple wymaga:
- **Privacy Policy URL** - podajesz w App Store Connect → App Privacy
- **Support URL** - opcjonalnie link do help-center.html
- Privacy Policy musi opisywać WSZYSTKIE uprawnienia (kamera, galeria, powiadomienia)

## 📋 Następne kroki

1. **Teraz:**
   - [ ] Wybierz opcję hostingu (zalecane: GitHub Pages)
   - [ ] Uploaduj pliki i uzyskaj URL-e
   - [ ] Zaktualizuj linki w aplikacji
   - [ ] Przetestuj czy linki działają

2. **Przed publikacją:**
   - [ ] Uruchom migrację SQL: `add-notification-settings.sql`
   - [ ] Uruchom migrację SQL: `add-bio-column.sql` (jeśli jeszcze nie)
   - [ ] Zbuduj aplikację: `eas build`
   - [ ] Przetestuj na prawdziwym urządzeniu

3. **W Play Console / App Store Connect:**
   - [ ] Wklej URL Privacy Policy
   - [ ] Wklej email supportowy
   - [ ] Wypełnij Data Safety / App Privacy

## 💡 Wskazówki

- **Backupy:** Zachowaj kopię plików HTML lokalnie
- **Wersjonowanie:** Data aktualizacji dokumentów jest ważna (już dodana w HTML)
- **Zmian:** Przy większych zmianach w Privacy Policy powiadom użytkowników
- **Języki:** Obecnie dokumenty są po polsku - jeśli planujesz ekspansję międzynarodową, przygotuj wersje angielskie

---

**Potrzebujesz pomocy?** Napisz na support@fitcoach.app 💪
