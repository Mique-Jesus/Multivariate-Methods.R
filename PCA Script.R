
#################################################
#                    EJERCICIO 1
#################################################

##Carga de datos##
data1<-read.table(file.choose(),header=T)
data<-as.matrix(data1)
data

##Media, matriz de var/cov  y de correlaciones##
m<-colSums(data)/48 #obtengo un vector de medias
m
matriz_centrada<-t(t(data)-m) #Obtengo la matriz centrada a partir de la resta de los valores cada variable con su respectiva media

s<-cov(matriz_centrada) #Realiza matriz de varianzas y covarianzas (también podría hacerse directamente sobre data, las varianzas y cov son las mismas que en la matriz centrada)
s
r<-cor(matriz_centrada)
r

###############################################
##Calculo de componentes principales "a mano"##
e<-eigen(s) #cálculo de autovalores y autovectores
e
lambda<-e$value #Agarro solo los autovalores
autov<-e$vectors #Agarro solo los autovectores

#Propiedades
totalvar<-sum(lambda) #la suma de los autovalores deber ser igual a...
totalvar2<-sum(diag(s)) #...la suma de las varianzas de las variables 

#Decido con cuántas componentes quedarme
varcomp1<-lambda[1]/totalvar #se calcula el porcentaje de varianza/información retenida por el componente 1
varcomp2<-lambda[2]/totalvar #y así sucesivamente para cada componente

#Calculo scores para los n casos de los componentes
scores<-t(t(autov) %*% t(matriz_centrada)) #multiplico los autovectores transpuestos por la matriz centrada transpuesta, luego transpongo esos resultados para obtener los scores
scores[,1:4] #selecciono las puntuaciones de los componentes que he elegido, que en este caso son 4


###############################################
##Caculo componentes principales con comandos##
sol_pca<-princomp(x=data,cor = FALSE) #cor indica si se correrá el análisis sobre la matriz de correlaciones o sobre la de varianzas y covarianzas

sol_pca$sdev^2 #muestra los autovalores "aproximados" (cantidad de información/varianza original que ha captado de manera general cada componente) *por una cuestión de redondeo, los autovalores calculados con este método no son exactos
summary(sol_pca) #muestra las desviaciones estándar (raiz cuadrada de los autovalores/varianzas), los porcentajes y porcentajes acumulados de información/varianza original que ha captado cada componente

sol_pca$loading #autovectores (cargas de información de las variables originales que posee cada componente)
sol_pca$loading[,1] #puedo seleccionar las cargas del 1er componente si deseo
sol_pca$loading[,2] #puedo seleccionar las cargas del 2do componente si deseo


##Graficos##
plot(sol_pca,type="l",ylim=c(0,70)) #gráfica de los autovalores (gráfico codo), ayuda a determinar el número de componentes a elegir

library(factoextra)
library(corrplot)
eig.val<-get_eigenvalue(sol_pca)
eig.val
fviz_eig(sol_pca,addlabels=TRUE,ylim=c(0,100)) #gráfica de los autovalores expresados en porcentaje

var<-get_pca_var(sol_pca)
var$cor
corrplot(var$contrib,is.corr=FALSE) #gráfica de los autovectores
fviz_contrib(sol_pca,choice="var",axes=1,top=10,ylim=c(0,30)) #gráfica del autovector/cargas del 1er componente
fviz_contrib(sol_pca,choice="var",axes=2,top=10,ylim=c(0,100)) #gráfica del autovector/cargas del 2do componente

library(FactoMineR)
sol<-PCA(data,graph=FALSE)
plot.PCA(sol,choix="var") #gráfica de correlaciones
fviz_pca_var(sol,col.var="contrib",gradient.cols=c("blue","yellow","red"))

plot.PCA(sol,choix="ind") #gráfica de posicionamiento de individuos en las dos primeras dimensiones


##Calculo puntuaciones (scores)##
sol_pca$scores
sol_pca$scores[,1:4] #selecciono las puntuaciones de los componentes que he elegido, que en este caso son 4




#####################################################################
#                        EJERCICIO 2
#####################################################################

##Carga de datos##
data2<-read.table(file.choose(),header=T)
data<-as.matrix(data2)
data


s<-cov(data)
s

#transformacion""
data22<-log(data)

s2<-cov(data22)
s2
r2<-cor(data22)
r2

boxplot(data)
boxplot(data22)


##PCA##

invest_pca<-princomp(data22,cor=TRUE,score=TRUE)
summary(invest_pca)

#numero de componentes##
plot(invest_pca,type="l")

var<-invest_pca$sdev^2
var
regla2<-mean(var)
regla2

#tamaño y forma##
invest_pca$loading

#factoextra##
library(factoextra)
library(corrplot)

eig.val<-get_eigenvalue(invest_pca)
eig.val

fviz_eig(invest_pca,addlabels=TRUE,ylim=c(0,100))

#vizualiacion de contribucion de cada variable##
var<-get_pca_var(invest_pca)
var$cor
corrplot(var$contrib,is.corr=FALSE)

fviz_contrib(invest_pca,choice="var",axes=1,top=10,ylim=c(0,30))
fviz_contrib(invest_pca,choice="var",axes=2,top=10,ylim=c(0,100))

##individuos""
library(FactoMineR)
pca<-PCA(data22,graph=FALSE)
plot.PCA(pca,choix="ind")




#####################################################################
#                        EJERCICIO 3
#####################################################################
data2<-read.table(file.choose(),header=T)
data<-as.matrix(data2)
data
summary(data)

cor(data)

jugo_pca<-princomp(data,score=TRUE)
summary(jugo_pca)

jugo_pca$loading


library(factoextra)
library(FactoMineR)

jug<-PCA(data,graph=FALSE)

jug$eig
plot(jugo_pca,type="l")

jug$var

plot.PCA(jug,choix="var")
fviz_pca_var(jug,col.var="contrib",gradient.cols=c("blue","yellow","red"))
##nota pra prox cuatri = calcular a mano las contribuciones""

plot.PCA(jug,choix="ind")


