---
title: A consumer-resource model to assess the effects of temperature on interaction strength
subtitle:
author: |
  | \textbf{Azenor Bideault}
  | Supervisors: Dominique Gravel & Michel Loreau \newline
institute: Université de Sherbooke
date: \today
language: english
---

## Temperature: major environmental gradient
\centering
Mean annual temperatures
\includegraphics[width=1\linewidth]{figuresAz/AnmeanTempST.pdf}
\smallcitation{Worldclim data}

## Effects of temperature
\begincols
  \column{0.48\textwidth}
  \centering
    Metabolic rate \par
    \includegraphics[width=0.4\linewidth]{figuresAz/cell.png}\par
    \vspace{1cm}
    \pause
    Biological rates (growth rate) \par
    \includegraphics[width=0.5\linewidth]{figuresAz/fish_pop.pdf}
    \pause
    \hfill\column{0.48\textwidth}
    \centering
    Body-size \par
    \includegraphics[width=0.6\linewidth]{figuresAz/size.pdf}\par
    \vspace{1cm}
    \pause
    Species distribution \par
    \includegraphics[width=0.8\linewidth]{figuresAz/world.pdf} \par

\stopcols


## Landscape-level effects of trophic interactions

\centering
  \includegraphics[width=0.7\linewidth]{figuresAz/estes2011.png}\par
\smallcitation{Estes \textit{et al} 2011}


## Effects of temperature on trophic regulation
\centering
  \input{figuresAz/schema2.tex}\par


## Effects of temperature on trophic regulation

\centering
\input{figuresAz/schemaFlGrasse.tex}\par
\smallcitation{Beveridge et al 2010, Kratina et al 2012, Shurin et al 2012}


# Model

## Tri-trophic model
\begincols
  \column{0.48\textwidth}
    \centering
    \input{figuresAz/schema_model.tex}\par
    \hfill\column{0.48\textwidth}

$\mu$
: growth rate

$a$
: attack rate

$z$
: mortality rate

\stopcols

## Temperature dependence of organisms' biological rates

\begincols
\column{0.48\textwidth}
\centering
\includegraphics[width=1\linewidth]{figuresAz/MTE.pdf}

\hfill\column{0.48\textwidth}

$$
	r(T)= r_0 \textbf{m}^{\beta} exp^{\biggl(-\dfrac{\textbf{E}}{k\textbf{T}}\biggr)}\mathlarger{L}(T)
$$

&nbsp;

$r(T)$
: biological rate

$m$
: body-mass

$E$
: activation energy

$T$
: temperature

$L(T)$
: decreasing phase

$\beta$, $r_0$, $k$
: constants

\stopcols
\smallcitation{Gillooly et al 2001, Brown et al 2004, Savage et al 2004, Pawar et al 2015}

# Direct and indirect effects of temperature on trophic regulation

## Interaction strength measures

  \centering
  \input{figuresAz/schema_FNI1.tex}\par

## Direct and indirect effects of temperature

Direct effect on biological traits \par
\includegraphics[width=0.2\linewidth]{figuresAz/fish_pop.pdf} \par
\vspace{1cm}

Indirect effect through decreasing body-size \par

\includegraphics[width=0.2\linewidth]{figuresAz/size.pdf}

# Results

## Direct effect of temperature on biological traits
\centering
\includegraphics[width=0.4\linewidth]{figuresAz/fish_pop.pdf} \par


## Temperature dependence of interaction strength measures are consistent
\centering
Effect of herbivore on primary producers
\vspace{1cm}

\begincols
  \column{.33\textwidth}
  \centering
  Per capita
  \includegraphics[width=1.1\linewidth]{figuresAz/ISpc.pdf}
  \column{.33\textwidth}
  \centering
  Per population
  \includegraphics[width=1.1\linewidth]{figuresAz/ISpop.pdf}

  \column{.33\textwidth}
  \centering
  Net
  \includegraphics[width=1.1\linewidth]{figuresAz/NetIS.pdf}

\stopcols

## Heterogeneous dependencies


\centering
Effect of carnivores on herbivores
&nbsp;

| Fixed parameters     | IS per population       | IS net                  |
|:---------------------|:-----------------------:|:-----------------------:|
| $\emptyset$          | $\cap$                  | $\cap$                  |
| $a_{hc}$             | $\cap$                  | $\textcolor{red}{\cup}$ |
| $a_{ph}$, $a_{hc}$   | $\textcolor{red}{\cup}$ | $\textcolor{red}{\cup}$ |
| H: $a_{ph}$, $z_h$   | $\textcolor{red}{\cup}$ | $\cap$                  |
| C: $a_{hc}$, $z_c$   | $\cap$                  | $\textcolor{red}{\cup}$ |


$a$
: attack rate

$z$
: mortality rate


## Indirect effect of temperature through decreasing body-size
\centering
\includegraphics[width=0.7\linewidth]{figuresAz/size.pdf}


## Indirect effect of temperature through decreasing body-size
\centering
Effect of carnivores on herbivores
\vspace{1cm}

\begincols
  \column{.33\textwidth}
\centering
Per capita
\includegraphics[width=1.1\linewidth]{figuresAz/ISpcBS.pdf}
\column{.33\textwidth}
\pause
\centering
Per population
\includegraphics[width=1.1\linewidth]{figuresAz/ISpopBS.pdf}

\column{.33\textwidth}
\pause
\centering
Net
\includegraphics[width=1.1\linewidth]{figuresAz/ISnetBS.pdf}

\stopcols


## Effect of temperature on interaction strength through biological traits

\centering
\includegraphics[width=0.3\linewidth]{figuresAz/fish_pop.pdf} \par

- Temperature dependence of different interaction strength measures are consistent
- Heterogeneous dependencies: variations according to which parameters are temperature dependent

## Indirect effect of temperature on interaction strength
 \centering
 \includegraphics[width=0.3\linewidth]{figuresAz/size.pdf} \par

- Temperature can indirectly decrease or increase interaction strength
- The indirect effect of temperature on trophic regulation through decreasing body-size may enhance or decrease its direct effect on biological traits


## Various effects of temperature on interaction strength

\centering
Temperature has numerous and potentially conflicting effects on interaction strength: \par
\vspace{1cm}
developping a framework that integrates various effects of temperature on interaction strength is key in understanding food web dynamics



## Merci de votre attention
