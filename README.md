# MensApp
MensApp è un'applicazione che mette in contatto chi vuole mangiare e le mense (mensa, cantine universitarie, bar-ristoranti), permettendo di consultare il menù del giorno, ordinare i piatti da ritirare in un giorno e un orario scelti, e alle mense di gestire ordini, sedi e disponibilità in tempo reale.

NB: L'app è solo una demo quindi __I tuoi dati restano sul tuo dispositivo.__ L'app non usa server né servizi cloud: tutte le informazioni — account, preferenze, allergie e ordini — vengono salvate in un database locale (SQLite) sullo stesso dispositivo su cui usi l'app. Per questo puoi __iscriverti senza problemi__: nessun dato viene inviato su internet, e se disinstalli l'app, i dati vengono eliminati con essa.

## L'app ha due volti, due tipi di utente:

### 1. Il Cliente

Da quando si registra (con i suoi dati, le sue __allergie__ e le sue __preferenze alimentari__ come vegano, vegetariano, senza glutine…), il cliente può:

- __Scoprire le mense nella sua città__ e salvarle tra i __preferiti__ con un tocco.
- __Consultare il menù del giorno__ di ogni mensa, organizzato per categorie (primi, secondi, contorni, dolci, bevande, bar), con foto, descrizione e prezzo.
- __Essere protetto dalle allergie__: se un piatto contiene un allergene che l'utente ha dichiarato, viene segnalato/bloccato; idem per i piatti non compatibili con le sue preferenze alimentari.
- __Ordinare__: si compone un carrello con le quantità, si sceglie __giorno e orario di ritiro__ (controllati sugli orari di apertura della mensa, con almeno un'ora di anticipo) e si possono lasciare note per la cucina.
- __Seguire i propri ordini__ con uno stato chiaro: *Ricevuto → In preparazione → Pronto → Ritirato* (o *Rifiutato*), potendo __cancellare__ l'ordine entro il limite previsto.
- __Rivedere lo storico__ dei propri ordini e __ripetere un ordine passato__ con pochi tap, scegliendo nuovamente giorno e orario.
- __Gestire il profilo__: dati anagrafici, allergie e preferenze aggiornabili in qualsiasi momento.

### 2. Il Gestore della mensa

Chi possiede o gestisce una mensa può:

- __Registrare la propria struttura__ (nome, indirizzo, città, telefono, partita IVA, foto) e __amministrarne più sedi__ con un unico account.
- __Compilare il catalogo piatti__: inserire, modificare ed eliminare piatti per categoria, con __foto, prezzo, descrizione, allergeni e preferenze__ associate.
- __Comporre il menù di ogni giorno__, scegliendo quali piatti proporre e impostando per ciascuno la __quantità disponibile__ (obbligatoria): quando le porzioni finiscono, il piatto esce automaticamente dal menù.
- __Definire gli orari di apertura__ giorno per giorno, con l'app che mostra automaticamente se la mensa è __aperta o chiusa "adesso"__.
- __Gestire gli ordini in arrivo__: vederli nel dettaglio (cliente, piatti, totali, note, orario di ritiro), aggiornarli lungo il flusso di lavoro e raggrupparli per giorno, includendo quelli già ritirati.
