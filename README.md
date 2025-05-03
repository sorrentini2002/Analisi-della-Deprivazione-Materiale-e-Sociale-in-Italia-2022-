# Esercitazione sulla Deprivazione Sociale e Materiale in Italia (EU-SILC 2022)

## 📝 Sommario
- [Introduzione](#introduzione)
- [Obiettivi del Progetto](#obiettivi-del-progetto)
- [Dataset Utilizzato](#dataset-utilizzato)
- [Metodologia](#metodologia)
- [Risultati Principali](#risultati-principali)
- [Requisiti Tecnici](#requisiti-tecnici)
- [Come Eseguire l'Analisi](#come-eseguire-lanalisi)
- [Contributi](#contributi)
- [Licenza](#licenza)
- [Contatti](#contatti)
- [Acknowledgments](#acknowledgments)

---

## Introduzione
Questo progetto si concentra sull'analisi della deprivazione sociale e materiale in Italia, utilizzando i dati dell'indagine **EU-SILC (European Union Statistics on Income and Living Conditions)** 2022. L'obiettivo è esplorare le dinamiche della povertà monetaria e delle barriere che limitano l'accesso ai beni e ai servizi essenziali per una vita dignitosa.

La deprivazione sociale e materiale non si limita alla povertà monetaria, ma integra anche fattori come l'accesso a beni essenziali, la connessione internet, le vacanze annuali e altre variabili che riflettono la qualità della vita.

---

## Obiettivi del Progetto
1. Misurare il livello di deprivazione materiale e sociale in Italia utilizzando la scala di misurazione dell'Eurostat.
2. Analizzare la distribuzione della deprivazione all'interno della popolazione italiana, con particolare attenzione a gruppi vulnerabili (ad esempio, giovani e anziani).
3. Valutare la validità e l'affidabilità della scala di misurazione adottata da Eurostat.
4. Confrontare i risultati italiani con le tendenze europee.
5. Identificare pattern significativi utilizzando approcci classici e moderni (come il modello di Rasch).

---

## Dataset Utilizzato
Il dataset utilizzato proviene dall'indagine **EU-SILC 2022**, con particolare focus sull'Italia. I dati includono informazioni relative a:

- **Povertà monetaria**: Indicatore basato sul reddito disponibile equivalente.
- **Deprivazione materiale**: Risposte a domande relative all'accesso a beni e servizi essenziali.
- **Caratteristiche demografiche**: Età, reddito familiare, livello di istruzione, ecc.

Il dataset è stato ponderato per garantire la rappresentatività a livello nazionale.

---

## Metodologia

### 1. **Analisi Classica**
- **Scala di Deprivazione Materiale**: Calcolo del punteggio grezzo per ogni individuo basato sulle risposte alle domande del survey.
- **Distribuzione dei Punteggi**: Esame della distribuzione dei punteggi per identificare la percentuale di individui deprivati e severamente deprivati.
- **Affidabilità della Scala**: Calcolo dell'indice **α di Cronbach** per valutare la coerenza interna della scala.

### 2. **Analisi Moderna (Modello di Rasch)**
- **Stima dei Parametri**: Utilizzo del metodo di massima verosimiglianza condizionata per stimare il tratto latente (livello di deprivazione) di ciascun individuo.
- **Grado di Severità degli Items**: Determinazione del livello di deprivazione necessario per rispondere positivamente a ciascun item.
- **Analisi Diagnostica**: Verifica dell'adattamento dei dati al modello di Rasch tramite le statistiche **Infit**.

### 3. **Analisi Demografica**
- **Correlazione con il Reddito**: Analisi della relazione tra il tratto latente di deprivazione e il reddito disponibile.
- **Generazioni**: Analisi della distribuzione della deprivazione tra giovani (<35 anni), adulti, anziani (>75 anni) e persone di età avanzata.

---

## Risultati Principali

### 1. **Tasso di Povertà Monetaria**
- **Nel campione**: 17,4% della popolazione.
- **Stima per l'intera popolazione italiana**: 19,3%.
- **Confronto con Eurostat**: 20,1% (2022).

### 2. **Deprivazione Materiale**
- **51,4%** della popolazione risponde "no" a tutte le domande di deprivazione.
- **11%** della popolazione è deprivata (risponde "sì" a 5 o più items).
- **6%** della popolazione è severamente deprivata (risponde "sì" a 7 o più items).

### 3. **Items Chiave**
- L'item con il maggior numero di risposte affermative riguarda **le vacanze annuali** (35%).
- Altri items significativi: **spese impreviste** (33%), **sostituzione di mobili usurati** (19%).

### 4. **Gruppi Vulnerabili**
- **Giovani (<35 anni)**: Frequenza più elevata di deprivazione severa.
- **Anziani (>75 anni)**: Frequenza ridotta nella categoria di deprivazione massima.

### 5. **Affidabilità della Scala**
- **Indice α di Cronbach**: 0,83 (buona affidabilità).
- Suggerimento per l'Eurostat: Eliminazione di alcuni items ridondanti (ad esempio, "nuovi vestiti" e "denaro per sé").

---

## Requisiti Tecnici

### Strumenti Necessari:
- **Ambiente di Programmazione**: R / RStudio
- **Librerie R**: `RM.weights`, `arm`, `questionr`, `eRm`, `ltm`, `RColorBrewer`, `ggplot2`
- **Dataset**: EU-SILC 2022 (Italia)
- **Software**: R e RStudio

---

## Come Eseguire l'Analisi

### 1. **Clonare il Repository**
```bash
git clone https://github.com/sorrentini.2002/Analisi-della-Deprivazione-Materiale-e-Sociale-in-Italia-2022-.git
````

### 2. **Installare le Librerie R**

```r
install.packages(c("RM.weights", "arm", "questionr", "eRm", "ltm", "RColorBrewer", "ggplot2"))
```

### 3. **Caricare il Dataset**

```r
library(RM.weights)
library(arm)
library(questionr)
library(eRm)
library(ltm)
library(RColorBrewer)
library(ggplot2)

data <- read.csv("path/to/EUSILC_IT_2022.csv")
```

### 4. **Eseguire l'Analisi**

Consultare il file `code.R` per gli script dettagliati. Eseguire i comandi step-by-step per riprodurre i grafici e le tabelle.

### 5. **Visualizzare i Risultati**

I grafici e le tabelle saranno salvati nella cartella `output/`.

---

## Contributi

Se desideri contribuire al progetto, puoi:

* Segnalare errori nei dati o nell'analisi.
* Proporre miglioramenti metodologici.
* Aggiungere nuove visualizzazioni o analisi avanzate.

Fai **pull requests** o apri **issue** per discutere suggerimenti!

---

## Licenza

Questo progetto è rilasciato sotto la **MIT License**. Vedi il file `LICENSE` per ulteriori dettagli.

---

## Contatti

Per domande o commenti, contatta:

* **Matteo Sorrentini**
* **Simone Santonati**
* **Federico Trionfetti**
* **Alessio Maria Zagarella**
* **Alessia Tonizzo**
* **Roberta Varone**

---

## Acknowledgments

Grazie all'**Eurostat** per aver reso disponibili i dati **EU-SILC 2022**. Questo progetto è stato sviluppato nel contesto dell'esercitazione del **11 dicembre 2023**.

```
