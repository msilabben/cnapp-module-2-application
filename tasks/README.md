# Workshop - modul 2: Sikker kode og pipeline herding 

Temaet for denne workshoppen er sikker kode og pipeline herding. Vi skal gå gjennom tre temaer: utviklingsmiljø, pipeline og git repository. Det vil være oppgaver knyttet til hver av disse temaene.

Krav: 
- GitHub bruker
- (Valgfritt) IDE
    - Oppgavene som krever kodeendring, kan enten gjøres lokalt på din maskin, eller bruke GitHub Desktop.

### Oppsett
1. Gi GitHub brukernavnet til fasilitator, slik at dere kan bli invitert til organisasjonen: "msilabben". 
2. Godkjenn invitasjonen
3. Gå til [cnapp-module](https://github.com/msilabben/cnapp-module)
4. Klikk på "Fork" inne på cnapp-module repoet, oppe til høyre
5. Velg organisasjonen "msilabben" som eier.
6. Trykk på "<> Code", og enten clone ned repoet lokalt på maskinen din eller trykk på headeren "Codespaces" og velg "Create codespace on main". 


Si ifra til fasilitator hvis dere møter på problemer. 


## Oppgaver - Utviklingsmiljø 

### Legg til ny epostaddresse 
1. Trykk på ditt brukerikon og velg "settings". Deretter trykk på "Emails". 
2. Under "Keep my email addresses private" kan dere toggle en knapp for å skru dette på. 
3. I teksten under toggle-knappen, og i teksten over eposten deres øverst på siden, vil dere finne en epost-addresse som ligner på: "<tall>+<brukernavn>@users.noreply.github.com", kopier denne epostaddressen. 
4. I GitHub Codespaces, i terminalen din, skriv inn: `git config user.email "<tall>+<brukernavn>@users.noreply.github.com"`. 
5. Legg til en setning i filen README.md 
6. Hvis dere ikke har en terminal åpen nederst i vinduet, trykk på hamburgermenyen i venstre hjørne, klikk på "terminal" deretter "new terminal". 
7. I terminalen, åpne en ny branch med kommandoen `git checkout -b "developer_environment"`.
8. Skriv `git status` og se at README.md ligger i listen over forandrede filer. Sjekk forandringene i filen med kommandoen `git diff README.md`. Legg til filen i commiten med kommandoen `git add README.md`. Commit forandringene med kommandoen `git commit -m "update readme"`. 
9. Sjekk ut `git log` og se at den siste commiten er fra author: <brukernavn> med eposten du nettopp la til i git config. 

 
### Commit en hemmelighet
1. I filen "secret.txt", kopier den siste linjen, og lim den inn under den siste.  
2. Gå til .gitleaks.toml, og forandre linken som inkluderer "secret", slik at den ikke lenger ignorer secret.txt. For eks. forandre "secret" til "secrt". 
3. I terminalen, "add"/legg til både ".gitleaks.toml" og "secret.txt". 
4. I terminal skriv inn `pre-commit install`, og deretter `pre-commit`. Se at den finner nøkkelen som ble lagt til i "secret.txt". 
5. Fiks ".gitleaks.toml" ved å kjøre `git restore --staged .gitleaks.toml`, og `git restore .gitleaks.toml`. 


### Signerte commits
**Commit som noen andre**
1. I terminalen, sjekk loggen til git (`git log`) for se om det er en bruker du kan commite for.
2. Kopier brukernes nav og epost, og oppdater din egen git config med det nye navnet og eposten: 
- `git config user.email "43639886+collinlokken@users.noreply.github.com"`
- `git config user.name "Christopher Collin Løkken"`
3. Gjør en vilkårlig forandring, legg de til og commit dem, og push til GitHub. 
4. Gå til GitHub og se på commiten, og legg merke til hvilken bruker som committet forandringene. 
5. Gå tilbake til codespaces, og sett eposten og navnet til ditt eget igjen. 

**Signer commit**

1. I terminal, skriv inn `ssh-keygen -t ed25519 -C "navn@epost.com"`. 
2. Kopier den offentlige nøkkelen. Det kan gjøres med å printe ut innholdet i filen og kopiere den. Print ut innholdet med `cat /home/vscode/.ssh/id_ed25519.pub` (pass på at filnavnet er korrekt) og legg den til på GitHub brukeren din. 
    - Inne på GitHub, trykk på ditt brukerikon og velg "settings". 
    - Velg deretter "SSH and GPG keys". 
    - Trykk "New SSH key"
    - Skriv inn ett navn for nøkkelen, velg "signing key" og kopier inn den offentlige nøkkelen. 
    - Trykk på "Add SSH key" 
3. For å legge inn nøkkelen på GitHub brukeren din, for dette repoet, kjør `git config user.signingkey PRIVAT_KEY_PATH`
4. For å signere en commit, legg til flagget `-s` slik som følgende: `git commit -s -m "din commit melding"`. For å slippe å legge til `-s` ved hver commit, kjør `git config --global commit.gpgsign true` og `git config --global gpg.format ssh`. 
5. Gjør en forandring i README.md, legg til forandringene og commit med valgfri commit-melding.
6. Push forandringene med kommandoen `git push`. Hvis du ikke har pushet noe til denne branchen enda, så vil du få opp kommandoen `git push --set-upstream origin developer_environment`. Kjør denne før du kjører `git push` igjen. 
7. Gå til GitHub og bytt branch fra "main" til "developer_environment". Klikk på ikonet av en klokke med en pil rundt som forestiller commits. 
8. Observer at den siste commiten har fått en "Verified" boks ved siden av seg. 


## Oppgaver - pipelines

### Legge til kjøring av test i pipeline
1. Aktiver test ved å åpne .github/workflows/pull-request.yml, skroll ned til "backend-tests", og på linja med kommentaren, enten fjern linja eller sett den til "true".  
2. Gå til backend/test/test_app.py og forandre status koden fra 200 til 100. 
3. Add både "pull-requet.yml" filen og "test_app.py" filen. Commit med valgfri commit melding og push forandringene til GitHub. 
4. Gå til GitHub, og gå til headeren "Actions". Hvis det er en grønn knapp der hvor det står: "I understand my workflows, go ahead and enable them", trykk på den knappen. Hvis det ikke er en slik knapp der, så trenger du ikke gjøre noe. 
5. Deretter, lag en pull request, enten ved å klikke på den grønne knappen på repository forssiden som spør om du vil lage en pull request, eller ved å klikke på overskriften "Pull request", og deretter på den grønne knappen "New pull request". Husk å velge riktige branch, det skal på "base" være "main" (pass på at det er main-branchen i ditt eget repo, og ikke original repoet), mens "compare" skal være "developer_environment". 
6. Inne på pull-requesten, se at det har blitt kjørt en workflow, og at "pull request / backend-test / pytest" har feilet. Workflowen kan også bli sett fra headeren "Actions".  
7. Gå tilbake til codespacet og forandre status koden fra 100 til 200 i filen "backend/test/test_app.py". 
8. Legg til forandringene, commit med valgfri melding og push til branchen. 
9. Gå tilbake til GitHub og til den samme pull requesten, og observer at workflowen kjører, og at denne gangen så passerer sjekken. 

### Legg til secret scanning i pipeline
1. Gå til codespacet, og til filen ".github/workflows/pull-request.yml". 
2. Aktiver "pre-commit" og "gitleaks" i filen ved å enten fjerne linjen hvor det er en kommentar eller sett "if" til "true". 
3. Legg til forandringene, commit med valgfri melding og push til branchen.
4. Gå til GitHub og sjekk pipeline, se at workflowen kjører vellykket. 

### Legg til trivy 
1. Gå til codespacet, og til filen ".github/workflows/pull-request.yml".
2. Aktiver "trivy" i filen ved å enten fjerne linjen hvor det er en kommentar eller sett "if" til "true". 
3. Legg til forandringene, commit med valgfri melding og push til branchen.
4. Gå til GitHub og sjekk pipeline, se at "code scanning results / trivy" kjører vellykket. 
5. For å se listen over feil, trykk på linken "code scanning results/trivy", og velg på "view all branch results". 
6. Finn erroren "image user should not be root" i "backend/Dockerfile". 
7. Fiks denne feilen ved å åpne "backend/dockerfile" i codespaces. Kommenter inn linjene om bruker som er kommentert ut i filen
8. Legg til forandringene, commit med valgfri melding og push til branchen.
9. Gå til GitHub og sjekk workflowen. Se at "code scanning results / trivy" kjører vellykket. Sjekk også inne på oversikten til trivy, og se at feilen har forsvunnet fra listen.  


### Legg til Semgrep
1. Gå til codespacet, og til filen ".github/workflows/pull-request.yml".
2. Aktiver "semgrep" i filen ved å enten fjerne linjen hvor det er en kommentar eller sett "if" til "true". 
3. Legg til forandringene, commit med valgfri melding og push til branchen.
4. Gå til GitHub og sjekk pipeline, se at "code scanning results / semgrep OSS" kjører vellykket. 
5. For å se listen over feil, trykk på linken "code scanning results / semgrep OSS", og velg på "view all branch results". 


### Legg til OPA 
1. Gå til codespacet, og til filen ".github/workflows/pull-request.yml".
2. Aktiver "OPA" i filen ved å enten fjerne linjen hvor det er en kommentar eller sett "if" til "true".
3. Gå så til filen "policy/trivy.rego", og sett "config: max_high" til å være "1" istedet for "5". 
4. Gå så til filen "policy/smegrep.rego", og sett "config: max_error" til å være "1" istedet for "5". 
5. Legg til forandringene, commit med valgfri melding og push til branchen. 
6. Gå til GitHub, og se på workflowen til pull requesten at "pull request / opa" feiler. Trykk på lenken "pull request / opa"-lenken, og trykk på "Summary" i høyre hjørne. Se at OPA er avhengig av de to semgrep og trivy. 
7. Trykk på OPA, og se at den feiler på steget "verify trivy finding". 
8. Gå tilbake til codespaces og resett konfigurasjonen fra "1" til "5" i både "policy/trivy.rego" og "policy/semgrep.rego". 
9. Legg til forandringene, commit med valgfri melding og push til branchen. 
10. Gå til GitHub, og se på workflowen til pull requesten at "pull request / opa" kjører vellykket. 

### Legg til release pipeline
1. Godkjenn PR'en ved å trykke på "Merge pull request" og deretter "Confirm merge".
2. Gå til "Actions" og se at en "Merge pull request" workflow kjører. Trykk på workflowen, og se at "release-please" har kjørt vellykket.  
3. Gå tilbake til "Pull request" og se at release-please opprettet en PR i "pull request" som heter "Chore: release main". Trykk på PR'en. Observer at den samme workflowen har kjørt igjen. 
4. Se at versjonene har blitt oppdatert. 
5. Merge PR'en.

### SBoM
1. På hovedsiden til repoet, gå til releases på høyre siden, og klikk på en av releasene. 
2. Gå til assets. 
3. Klikk på sbom-filen, og last ned json fila.
4. Se gjennom filem og observer at det er en liste over prosjektets pakker i dette tidspunktet. 

### Scheduled pipeline 
1. Observer i PR'er at dependabot har kjørt og laget PR'er. Hvis det ikke er noen PR'er der, se i det originalet repoet. 
2. Velg en PR som starter med "build(deps)".. 
3. Se at den samme workflowen som kjører i de tidligere pipelinene, kjører også nå. Siden sjekkene vil kjøre på dependabot sin PR, og dermed vil de andre sjekkene fange opp eventuelle ting som dependabot introduserer. 


## Git - repository 

### Branch protection 
1. Bytt branch til main med `git checkout main`. 
2. Gjør en vilkårlig forandring i en fil. 
3. Legg til forandringene, og commiten med en valgfri commit-melding. 
4. Push forandringene til main direkte. 
5. Gå til GitHub, og observer at forandringene ble gjort på main. 
6. Gå til settings på repo, og klikk på "branches". Så klikk på "Add classic branch protection rules". 
7. Så gi regelsettet et navn, deretter klikk på regelen "Require a pull request before merging", deretter avklikk "Reuire approvals", og tilslutt klik på "Require review from Code Owners". 
8. Tryk så på den grønne knappen "create". 
9. Gjør om på det du gjorde istad på steg 2. Legg til og commit forandringene, og prøv å push til main. Hvis ikke det funker, prøv `git push --force`. 

### CODEOWNERS
1. ... 

### Evil fork 
1. Gå til codespaces, og bytt branch til main (`git checkout main`), og hent inn de nyeste endringene fra main (`git pull`). Bytt til en annen branch (`git checkout -b "evil_branch"`). 
2. Ta en titt på filen ".github/workflows/warn-big-pr.yml". Se i koden at den vil kjøre scriptet "bin/pr_comment.sh", og sender inn to verdier til det scriptet: "GITHUB_TOKEN" og "PR_THRESHOLD". 
3. Gå til filen "bin/pr_comment.sh", og kommenter inn linjen som printer ut GitHub tokenen. 
4. Legg til filene, commit med valgfri commitmelding, og push forandringene. 
5. Gå til GitHub og opprett en ny pull request. Det skal nå gjøres enn pull request mot det originale repoet "msilabben/cnapp-module", så pass på at mottaker repoet er riktig. Godkjenn at det blir laget en ny pr. 
6. Gå til PR'en og se at jobben kjører. 

