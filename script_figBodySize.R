rm(list=ls())

source('~/owncloud/SuiteMaster/func_tempDEP_BAU.R') ## call for temperature dependance functions
source('~/owncloud/SuiteMaster/func_logPHeff.R')
setwd("~/GitHub/Talk_CSBQ/figuresAz")
########## Interaction strength for different primary producer body-mass (constant ratio) ##########
####################################################################################################

mP=seq(1*10^-4,1,0.001)
mH=mP*10^3
mC=mH*10^3

mu_seq=rep(0,length(mP))
zP_seq=rep(0,length(mP))
zH_seq=rep(0,length(mH))
aPH_seq=rep(0,length(mH))
zC_seq=rep(0,length(mC))
aHC_seq=rep(0,length(mC))


topt=298

for (i in 1:length(mP)) {
  par_mu_max=c(mu0=3*10^10,mP=mP[i],bmu=-0.25,topt=298,E=0.65,E2=1.15)
  mu_seq[i]=rBAU(temp=topt,par_br=par_mu_max)
  
  par_zP=c(zP0=0.8*10^10,mP[i],bzP=-0.25,topt=298,E=0.65,E2=1.15)
  zP_seq[i]=rBAU(temp=topt,par_br=par_zP)    
  
  par_zH=c(zH0=10^10,mH[i],bzH=-0.25,topt=298,E=0.65,E2=1.15)
  zH_seq[i]=rBAU(temp=topt,par_br=par_zH)
  
  par_aPH=c(aPH0=2*10^11,mH[i],baPH=0.05,topt=298,E=0.65,E2=1.15)
  aPH_seq[i]=rBAU(temp=topt,par_br=par_aPH)
  
  par_zC=c(zC0=0.6*10^11,mC[i],bzC=-0.25,topt=298,E=0.65,E2=1.15)
  zC_seq[i]=rBAU(temp=topt,par_br=par_zC)  
  
  par_aHC=c(aHC0=2*10^11,mC[i],baHC=0.05,topt=298,E=0.65,E2=1.15)
  aHC_seq[i]=rBAU(temp=topt,par_br=par_aHC)
}


# Fixed parameters
D=0.8   # dilution rate
Nin=15  # nutrient input concentrations 
ePH=0.45 # conversion efficieny
q=6     # C:N ratio
APH=0.7 # attack success probability
ks=0.8  # half saturation constant

AHC=0.8 # attack success probability herbivore-carnivore
eHC=0.85 # conversion efficieny herbivore-carnivore


paramBM=list(d=D,Nin=Nin,q=q,effPH=ePH,APH=APH,effHC=eHC,
             AHC=AHC,mu=mu_seq,zP=zP_seq,zH=zH_seq,aPH=aPH_seq,zC=zC_seq,aHC=aHC_seq)


## Plot interaction strength per capita


pdf("ISpcBS.pdf",width=5,height=5)
par(xaxs='i',yaxs='i')

par(mgp = c(1.5, 0.6, 0), tck = -.01, family = 'sans')

plot(mH,log(aHC_seq),axes=F,ann=F,type='n')
axis(1,at=c(min(mH),max(mH)), labels=c(0.1,1000))
axis(2,at=c(0.2,0.3,0.4,0.5),labels=c(0.2,0.3,0.4,0.5),las=2)

mtext(text="Per capita interaction strength",side=2,line=2.2,font=1,cex=1)

mtext(text='Body-mass',side=1,line=1.5,font=1,cex=1)

abline(v=min(mH))
abline(h=min(log(aHC_seq)))
lines(mH,log(aHC_seq))


dev.off()


## Interaction strength per population

ISpop=function(para)  {
  with(as.list(para),{
    
    ## Equilibrial biomasses
    ## NP
    Pequ1=((q*d*Nin)/(zP+d))-(d/mu)
    
    ## NPH
    Pequ2=(zH+d)/(effPH*aPH*APH)
    Nequ2=(d*Nin)/(d+mu*Pequ2)
    Hequ2=(q*mu*Nequ2-zP-d)/(aPH*APH)
    
    ## NPHC
    Hequ3=(zC+d)/(effHC*aHC*AHC)
    Nequ3=(zP+d+(aPH*APH*Hequ3))/(q*mu)
    Pequ3=(d*Nin-d*Nequ3)/(mu*Nequ3)
    Cequ3=((effPH*aPH*APH*Pequ3)-zH-d)/(aHC*AHC)
    
    ## Interaction strength per population
    
    ISpopHequ2=Hequ2*aPH
    ISpopHequ3=Hequ3*aPH
    ISpopCequ3=Cequ3*aHC
    
    return(list(ISpH2=ISpopHequ2,ISpH3=ISpopHequ3,ISpC3=ISpopCequ3))
    
  })
}

ISpopLBM=ISpop(paramBM)

pdf("ISpopBS.pdf",width=5,height=5)
par(xaxs='i',yaxs='i')

par(mgp = c(1.5, 0.6, 0), tck = -.01, family = 'sans')

plot(mH,log(ISpopLBM$ISpC3),axes=F,ann=F,type='n')
axis(1,at=c(min(mH),max(mH)), labels=c(0.1,1000))
axis(2,at=round(seq(min(log(ISpopLBM$ISpC3)),max(log(ISpopLBM$ISpC3)),length.out=4),1),
     labels=round(seq(min(log(ISpopLBM$ISpC3)),max(log(ISpopLBM$ISpC3)),length.out=4),1),las=2)

mtext(text="Per population interaction strength",side=2,line=2.2,font=1,cex=1)

mtext(text='Body-mass',side=1,line=1.5,font=1,cex=1)

abline(v=min(mH))
abline(h=min(log(ISpopLBM$ISpC3)))
lines(mH,log(ISpopLBM$ISpC3))


dev.off()


## Plot net interaction strength

resNISBM=logPHeff(paramBM)


pdf("ISnetBS.pdf",width=5,height=5)
par(xaxs='i',yaxs='i')

par(mgp = c(1.5, 0.6, 0), tck = -.01, family = 'sans')

plot(mH,log(resNISBM$lHeff3),axes=F,ann=F,type='n')
axis(1,at=c(min(mH),max(mH)), labels=c(0.1,1000))
axis(2,at=round(seq(min(log(resNISBM$lHeff3)),max(log(resNISBM$lHeff3)),length.out=4),1),
     labels=round(seq(min(log(resNISBM$lHeff3)),max(log(resNISBM$lHeff3)),length.out=4),1),las=2)

mtext(text="Net interaction strength",side=2,line=2.2,font=1,cex=1)

mtext(text='Body-mass',side=1,line=1.5,font=1,cex=1)

abline(v=min(mH))
abline(h=min(log(resNISBM$lHeff3)))
lines(mH,log(resNISBM$lHeff3))


dev.off()


