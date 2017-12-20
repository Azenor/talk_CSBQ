######## FIGURE PER POP AND NET INTERACTION STRENGTH ########
#################################################
setwd("~/GitHub/Talk_CSBQ/figuresAz")
rm(list=ls())


#### Functions to compute net strength of trophic cascade ####
###  log(Heff3), log(Peff2) & log(Peff3)   ###

## BA unimodal model
rBAU=function(temp,par_br,uni=1) {
  #input: temp=temperature range
  #       par_br=parameter vector
  #parameters:
  r0=par_br[[1]]  #scaling coefficient
  m=par_br[[2]]   #body-mass
  b=par_br[[3]]   #allometric scaling coefficient
  tpk=par_br[[4]] #optimal temperature
  E=par_br[[5]]   #activation energy
  Ed=par_br[[6]]  #deactivaiton energy
  k=8.617*10^-5   #Boltzmann constant
  # uni : specify if unimodal or exponential BA model
  
  if (uni==0) {
    l=1
  } else {
    l=1/(1+exp(-1/(k*temp)*(Ed-(Ed/tpk+k*log(E/(Ed-E)))*temp))) #decline phase
  }
  return(BR=r0*m^b*exp(-E/(k*temp))*l)
}


logPHeff=function(para)  {
  with(as.list(para),{

    ## Equilibrial biomasses

    # NP
    Pequ=((q*d*Nin)/(zP+d))-(d/mu)

    ## NPH
    Pequ2=(zH+d)/(effPH*aPH*APH)
    Nequ2=(d*Nin)/(d+mu*Pequ2)
    Hequ2=(q*mu*Nequ2-zP-d)/(aPH*APH)

    ## NPHC
    Hequ3=(zC+d)/(effHC*aHC*AHC)
    Nequ3=(zP+d+(aPH*APH*Hequ3))/(q*mu)
    Pequ3=(d*Nin-d*Nequ3)/(mu*Nequ3)
    Cequ3=((effPH*aPH*APH*Pequ3)-zH-d)/(aHC*AHC)


    ## Strength of trophic cascade
    StrP2=log(Pequ/Pequ2)
    StrP3=log(Pequ2/Pequ3)
    StrH3=log(Hequ2/Hequ3)

    return(list(lPeff2=StrP2,lPeff3=StrP3,lHeff3=StrH3,Hequ2=Hequ2))

  })
}

## Temperature

temp_seq=seq(285,315,length.out=50)

## Body mass

mP=1.34*10^-4 # primary producer body-mass
mH=1.34*10^-2 # herbivore body-mass
mC=1.34       # carnivore body-mass

### Parameters temperature dependent

par_aPH=c(aPH0=2*10^11,mH,baPH=0.05,topt=298,E=0.65,E2=1.15)
aPH_seq=rBAU(temp=temp_seq,par_br=par_aPH)

par_aHC=c(aHC0=2*10^11,mC,baHC=0.05,topt=298,E=0.65,E2=1.15)
aHC_seq=rBAU(temp=temp_seq,par_br=par_aHC)

# Fixed parameters
D=0.8   # dilution rate
Nin=15  # nutrient input concentrations
ePH=0.45 # conversion efficieny
q=6     # C:N ratio
APH=0.7 # attack success probability
ks=0.8  # half saturation constant

AHC=0.8 # attack success probability herbivore-carnivore
eHC=0.85 # conversion efficieny herbivore-carnivore

topt=298

# Parameters temperature dependent
par_mu_max=c(mu0=3*10^10,mP,bmu=-0.25,topt=298,E=0.65,E2=1.15)
mu_seq=rBAU(temp=temp_seq,par_br=par_mu_max)

par_zP=c(zP0=0.8*10^10,mP,bzP=-0.25,topt=298,E=0.65,E2=1.15)
zP_seq=rBAU(temp=temp_seq,par_br=par_zP)

par_zH=c(zH0=10^10,mH,bzH=-0.25,topt=298,E=0.65,E2=1.15)
zH_seq=rBAU(temp=temp_seq,par_br=par_zH)

par_zC=c(zC0=0.6*10^11,mC,bzC=-0.25,topt=298,E=0.65,E2=1.15)
zC_seq=rBAU(temp=temp_seq,par_br=par_zC)

param=list(d=D,Nin=Nin,q=q,effPH=ePH,APH=APH,effHC=eHC,
           AHC=AHC,mu=mu_seq,zP=zP_seq,zH=zH_seq,aPH=aPH_seq,zC=zC_seq,aHC=aHC_seq)

resNIS=logPHeff(param)

# IS pop
IP_H2=log(resNIS$Hequ2*aPH_seq)

pdf("ISpop.pdf",width=5,height=5)

par(xaxs='i',yaxs='i')

par(mgp = c(1.5, 0.6, 0), tck = -.01, family = 'sans')

plot(temp_seq,IP_H2,lwd=2,axes=F,ann=F,type='n')
axis(1,at=seq(min(temp_seq),max(temp_seq),10),labels=seq(min(temp_seq),max(temp_seq),10))
axis(2,at=round(seq(min(IP_H2),max(IP_H2),length.out=4),3),
     labels=round(seq(min(IP_H2),max(IP_H2),length.out=4),1),las=2)

mtext(text="Per population interaction strength",side=2,line=2,font=1,cex=1)
mtext(text='Temperature',side=1,line=1.5,font=1,cex=1)

lines(temp_seq,IP_H2)
abline(v=topt,col='darkgray',lwd=2)
abline(v=min(temp_seq))


dev.off()




## Net interaction strength


NIS_P2=resNIS$lPeff2
NIS_P3=resNIS$lPeff3
NIS_H3=resNIS$lHeff3

pdf("NetIS.pdf",width=5,height=5)

par(xaxs='i',yaxs='i')

par(mgp = c(1.5, 0.6, 0), tck = -.01, family = 'sans')

plot(temp_seq,NIS_P2,axes=F,ann=F,type='n')
axis(1,at=seq(min(temp_seq),max(temp_seq),10),labels=seq(min(temp_seq),max(temp_seq),10))
axis(2,at=round(seq(min(NIS_P2),max(NIS_P2),length.out=4),3),
labels=round(seq(min(NIS_P2),max(NIS_P2),length.out=4),1),las=2)

mtext(text="Net interaction strength",side=2,line=2,font=1,cex=1)
mtext(text='Temperature',side=1,line=1.5,font=1,cex=1)

lines(temp_seq,NIS_P2)
abline(v=topt,col='darkgray',lwd=2)
abline(v=min(temp_seq))
dev.off()
