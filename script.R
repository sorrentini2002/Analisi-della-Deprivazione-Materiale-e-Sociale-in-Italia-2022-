library(RM.weights)
library(arm)
library(questionr)
library(eRm)
library(ltm)
library(RColorBrewer)
library(ggplot2)

dati=EUSILC_IT_2022
# studio delle variabili
str(dati)

#primo quesito

# tasso di povertà monetaria in italia:

# - nel campione:
p_st_camp=prop.table(table(dati$Poverty))[2]
# margine di errore:
marg_err_c=1.96*sqrt((p_st_camp*(1-p_st_camp))/length(dati$Poverty))
# intervallo di confidenza:
conf_int_c=c(p_st_camp-marg_err_c,p_st_camp+marg_err_c)
# regola successo insuccesso:
length(dati$Poverty)*p_st_camp>=10 & length(dati$Poverty)*(1-p_st_camp)>=10

# - all'intera popolazione:
p_st=prop.table(wtd.table(dati$Poverty,weights = dati[,"weights"]))[2]

#secondo quesito:

# sub data set composto da soli items:
items=dati[,9:21]
#calcolo del rawscore:
raw_score <- apply(items,1,sum)
table(raw_score)
prop.table(wtd.table(raw_score,weights = dati$weights))

#creo variabile che associa il valore di rawscore ad ogni unità:
dati$raw_score <- apply(items,1,sum)
#distribuzione di frequenze del rawscore:
hist( raw_score,freq = F,xlab = "Raw Score",ylab = "Densità",main = "Distribuzione di frequenze del raw score",col = c(rep("green", 4), rep("yellow", 2), rep("red", 7)),include.lowest = TRUE,xlim = c(0, 13)  )
axis(1, at = 1:13, labels = 1:13)
lines(density(raw_score, bw = 0.5), col = "blue", lwd = 2)
abline(v = mean(raw_score), lty = 2,lwd = 2)

# tasso di deprivazione a livello campionario:
descriptive=tab.weight(wt=dati$weights, XX=items)
prev_camp<-cbind("Threshold"=c(5,7),"Levels"=c("deprivato", "severamente deprivato"), 
            Prev=1-cumsum(descriptive$RS.rel)[c(5, 7)])
# tasso di deprivazione a livello nazionale:
prev_pop<-cbind("Threshold"=c(5,7),"Levels"=c("deprivato", "severamente deprivato"), 
            Prev=1-cumsum(descriptive$RS.rel.w)[c(5, 7)])

# terzo quesito:

#percentuale a rischio povertà che non si può permettere l'accesso ad internet:
perc_no_int=prop.table(wtd.table(dati$internet_home[dati$Poverty==1]==1,weights = dati$weights[dati$Poverty==1]))[2]

# quarto quesito:

#maggior numero di risposte affermative:
which.max(descriptive$Perc.Yes.w)

# alpha di Cronbach:
cron.alpha<-cronbach.alpha(items)$alpha

# matrice delle correlazioni:
corr_Com.Index <- cor(items)

#variazione dell'alpha di Cronbach all'eliminazione di un solo items alla volta:
Disc<-NULL
for( j in 1:dim(items)[2]){
  
  Disc<-rbind(Disc, c(cronbach.alpha(items[, -j])$alpha, 
                      cor(items[, j], raw_score)))
}

colnames(Disc)<-c("alpha", "item_cor")
Disc

# rawscore relativi:
cbind('Weighted rs rel' = descriptive$RS.rel.w, 
      'Unweighted rs rel' = descriptive$RS.rel)
# rawscore assoluti:
cbind('Weighted rs abs' = descriptive$RS.abs.w, 
      'Unweighted rs abs' = descriptive$RS.abs)

#quinto quesito:

#percentuale di popolazione italiana a rischio povertà:
perc_pov_risk=prop.table(wtd.table(dati$raw_score>=7 | dati$Poverty==1,weights = dati[,"weights"]))[2]

# sesto quesito:

#grado di severità per ciascun items ordinato in modo crescente
fit.rm<-RM(items, sum0=TRUE)
delta<- -fit.rm$betapar

# ordine degli items in base alla severità stimata:
sort(round(delta, 2))
par(mfrow=c(1,3))
par(cex.axis = 1.2)
barplot(sort(round(delta, 2)),names.arg = c(2,4,6,10,1,3,7,11,13,9,8,12,5),space = 2,main = "Grado di severità degli items",col = colorRampPalette(c("yellow", "red"))(length(descriptive$Perc.Yes.w)),las = 1,, cex.names = 1.5)
abline(h = mean(sort(round(delta, 2))), lty = 2)

# grafico del tratto latente stimato in funzione del rawscore:
pers.dati <- person.parameter(fit.rm)
plot(pers.dati, xlab="Raw score", ylab="tratto latente", main="Grafico delle abilita' stimate in funzione dei Raw score")
axis(1, at = 1:13, labels = 1:13)

#settimo quesito:

# ICC poste sullo stesso grafico
plotjointICC(fit.rm, item.subset=c(3,4,12), legend= TRUE, xlim=c(-7,7), xlab="Grado di deprivazione materiale", ylab="Probabilita' di risposta affermativa", col=c("red", "blue", "black"), main="Curva caratteristica degli items",legpos = "bottomright", cex=0.5,lwd = 2)
abline(h=0.5)
abline(v=c(1.82,-3,0.17),lty=2,col=c("black","blue","red"))

# osservo i valori di infit:
analisi=itemfit(pers.dati)
analisi$i.infitMSQ[c(3,4,12)]

#ottavo quesito:

# stima dei vari tratti latenti
pers.dati <- person.parameter(fit.rm)
# non considero individui con tratto nullo o pari a 13
beta<-round(pers.dati$thetapar$NAgroup1, 3) 

# calcolo l'infit dei rispondenti
fit.individui<-personfit(pers.dati) 

# osservo gli inidividui con infit superiore a 100:
sort(fit.individui$p.fit,decreasing=T)[1:111]
# esempi di pattern di risposta non logici:
rbind(items[rownames(items)==86,])
rbind(items[rownames(items)==2224,])

# nono quesito:

#creo una variabile che associ il valore di tratto latente a ciascun individuo
dati$tratto_latente=round(pers.dati$theta.table$`Person Parameter`,2)

par(mfrow=c(1,2))
#boxplot del tratto latente e del reddito
boxplot(dati$Income ~ dati$tratto_latente, col = c(rep("green", 5), rep("orange", 2), rep("red", 7)),
        xlab = "Livello di tratto latente", ylab = "Reddito disponibile")
title("Boxplot tra reddito e tratto latente", font.main = 4)

# distribuzione del tratto latente per ogni generazione:

dati$generation<-ifelse(dati$Age<=35, 'giovani',
                         ifelse(dati$Age>35 & dati$Age<=65,  'adulti',
                                ifelse(dati$Age>65 & dati$Age<=75,  'anziani',
                                       "vecchi")))

a=rprop(wtd.table(dati$tratto_latente,dati$generation,weights = dati$weights))
dati_rprop <- data.frame(
  tratto_latente = c(rep(-4.85, 4), rep(-3.66, 4), rep(-2.55, 4), rep(-1.72, 4), rep(-1.07, 4),
                     rep(-0.52, 4), rep(-0.05, 4), rep(0.39, 4), rep(0.83, 4), rep(1.27, 4),
                     rep(1.77, 4), rep(2.37, 4), rep(3.24, 4), rep(4.18, 4)),
  generation = rep(c("adulti", "anziani", "giovani", "vecchi"), times = 14),
  weights = c(51.9, 13.3, 23.6, 11.2, 48.4, 13.9, 21.8, 15.9, 44.9, 13.5, 21.9, 19.7,
              47.2, 13.0, 21.8, 18.0, 47.8, 12.8, 26.5, 12.9, 51.0, 13.4, 24.2, 11.4,
              54.1, 15.2, 21.2, 9.5, 46.6, 15.8, 23.3, 14.3, 51.5, 9.1, 21.3, 18.1,
              57.3, 14.8, 19.0, 8.8, 40.6, 14.0, 40.9, 4.4, 60.1, 9.7, 24.8, 5.4,
              43.9, 8.5, 37.3, 10.3, 19.4, 28.9, 51.7, 0.0)
)

dati_rprop$generation <- factor(dati_rprop$generation, levels = c("giovani", "adulti", "anziani", "vecchi"))
colori_personalizzati<- c("#FF0000", "#FF6600", "#FFCC00", "#FFFF00", "#99FF33", "#66FF66", "#33FF99", "#00FFCC", "#00FFFF", "#0066FF", "#0033FF", "#0000FF")


ggplot(dati_rprop, aes(x = as.factor(tratto_latente), y = weights, fill = generation)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Rappresentazione Grafica delle Percentuali",
       x = "Tratto Latente",
       y = "Percentuali") +
  theme_minimal() +
  coord_flip() +
  scale_y_continuous(limits = c(0, 100)) +
  scale_fill_manual(values = setNames(colori_personalizzati, unique(dati_rprop$generation)))+
  theme(plot.title = element_text(hjust = 0.5))



