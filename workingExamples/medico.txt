# Encoding: UTF-8
##Introduction 

Utterance
Source bonjour ?(madame | monsieur | mademoiselle)
Target/french bonjour
EndUtterance

Utterance
Source je suis $$personne ?aujourd'hui
Source c'est moi ?(qui suis) $$personne ?aujourd'hui
Target/french je suis $$personne
EndUtterance


TrLex $$personne source="(votre|le|un) (docteur | médecin|medcin) ?(de service)" french="le docteur"
TrLex $$personne source="(votre|la|une) doctoresse" french="la doctoresse"
TrLex $$personne source="(l'infirmière|votre infirmière)" french="l'infirmière"



Utterance
Source je vais faire la consultation ?(avec vous)
Source je suis (le docteur | la doctoresse |l'infirmière |l'infirmier |l'aide soignant | l'aide soignante |l'assistant ?social | l'assistante sociale) qui va s'occuper de vous ?aujourd'hui
Source je suis (le docteur | la doctoresse |l'infirmière |l'infirmier |l'aide soignant | l'aide soignante |l'assistant ?social | l'assistante sociale) qui (va faire | fait|va réaliser) la consultation ?aujourd'hui
Source (je | c'est moi qui) vais m'occuper de vous ?aujourd'hui
Source (je | c'est moi qui) vais vous prendre en charge ?aujourd'hui
Source nous allons nous occuper de vous ?aujourd'hui
Source (je | c'est moi qui) (vais faire | fais|vais réaliser) la consultation ?aujourd'hui
Source nous (allons faire |allons réaliser) la consultation ?aujourd'hui
Target/french je vais m'occuper de vous aujourd'hui
EndUtterance


Utterance
Source $$assurance
Source ?(en cas d'hospitalisation) la couverture ?(d'assurance) est-elle $$assurance ?(en cas d'hospitalisation)
Source votre assurance ?hospitalisation est-elle $$assurance ?(en cas d'hospitalisation)
Source $avez_vous assurance ?hospitalisation $$assurance ?(en cas d'hospitalisation)
Target/french en cas d'hospitalisation, la couverture d'assurance est-elle $$assurance ?
EndUtterance

TrLex $$assurance source="privée" french="privée"
TrLex $$assurance source="semi-privée" french="semi-privée"
TrLex $$assurance source="en chambre commune" french="en chambre commune"


Utterance
Source $$état_civil
Source ?$êtes_vous $$état_civil
Target/french êtes-vous $$état_civil ?
EndUtterance

TrLex $$état_civil source="(marié| mariée)" french="marié"
TrLex $$état_civil source="célibataire" french="célibataire"
TrLex $$état_civil source="(divorcé | divorcée)" french="divorcé"
TrLex $$état_civil source="(séparée | séparée)" french="séparé"

Utterance
Source ?$êtes_vous (veuf | veuve)
Target/french êtes-vous veuf ?
EndUtterance

Utterance
Source $avez_vous un mari
Source $avez_vous une femme 
Target/french êtes-vous marié ?
EndUtterance


# Encoding: UTF-8

# Include common phrases file
include ../../resources/babeldr_phrases.txt

include ../../resources/accueil.txt
include ../../resources/medicament.txt

include babeldr_voices.txt

# Declare domain    
     
Domain
Name accueil
SourceLanguage french
TargetLanguages french lsf_ch
ExamplesFrom canonicalandsource
RobustMatching yes
NTELanguageModel BabelDr
CacheCanonicalTranslations yes
EndDomain
           
# Translation rules 



Utterance
Source $pouvez_vous (?me montrer | localiser | situer| m'indiquer | indiquer)  ?(avec (le |  votre | un)  doigt) où (est ?(localisé |localisée |situé |située) |  se trouve | se situe) $votre_douleur_gen ?(avec (le |  votre | un) doigt)
Source $pouvez_vous (?me montrer | localiser | situer| m'indiquer | indiquer)  ?(avec (le |  votre | un)  doigt) où ($avez_vous | $ça_fait) $mal_gen ?(avec (le |  votre | un) doigt)
Source $pouvez_vous (?me montrer | localiser | situer| m'indiquer | indiquer)  ?(avec (le |  votre | un)  doigt) où (sont ?(localisés |localisées |situés |situées)|  se trouvent|se situent) $vos_douleurs_gen ?(avec (le |  votre | un) doigt)
Source (montrez-moi | indiquez-moi) ?(avec (le |  votre | un)  doigt) (où (est ?(localisé |localisée |situé |située)|  se trouve | se situe) $votre_douleur_gen | où $avez_vous $mal_gen | où $ça_fait $mal_gen | où (sont ?(localisés |localisées |situés |situées)|  se trouvent|se situent) $vos_douleurs_gen) ?(avec (le |  votre | un)  doigt)
Source (où (est ?(localisé |localisée |situé |située)|  se trouve | se situe) $votre_douleur_gen | où $avez_vous $mal_gen | où $ça_fait $mal_gen | où (sont ?(localisés |localisées |situés |situées)|  se trouvent|se situent) $vos_douleurs_gen)
Source où est-ce douloureux
Source où ?(est-ce que) (c'est|cela est) douloureux
Source $pouvez_vous (?me montrer | m'indiquer | indiquer) ?(avec (le |  votre | un)  doigt) (la localisation | l'endroit| l'emplacement) $du_mal_gen ?(avec (le |  votre | un)  doigt)
Source $pouvez_vous (?me montrer | localiser | m'indiquer | indiquer)  ?(avec (le |  votre | un)  doigt) (où  $votre_douleur_gen (est ?(localisé |localisée |situé |située)|  se trouve | se situe)  | où $vos_douleurs_gen (sont ?(localisés |localisées |situés |situées) |  se trouvent | se situent)) ?(avec (le |  votre | un)  doigt)
Source (montrez-moi | indiquez-moi) ?(avec (le |  votre | un)  doigt) (où $votre_douleur_gen (est ?(localisé |localisée |situé |située)|  se trouve | se situe)  | où $vos_douleurs_gen (sont ?(localisés |localisées |situés |situées) |  se trouvent | se situent)) ?(avec (le |  votre | un)  doigt)
Source où ?(est-ce (que|qu')) $votre_douleur_gen (est |  se trouve | se situe)  ?(t-elle | t-il) 
Source où ?(est-ce (que|qu')) $vos_douleurs_gen (sont |  se trouvent | se situent) ?(t-elles | t-ils)
Source où ?(est-ce (que|qu')) $votre_douleur_gen est ?(t-elle | t-il) ?(localisé |localisée |situé |située)
Source où ?(est-ce (que|qu')) $vos_douleurs_gen sont ?(t-elles | t-ils) ?(localisés |localisées |situés |situées)
Target/french pouvez-vous me montrer avec le doigt où est la douleur ?
EndUtterance

Utterance
Source depuis combien d'heures
Target/french depuis combien d'heures ?
EndUtterance

Utterance
Source depuis combien (de jours |quand|combien de temps)
Target/french depuis combien de jours ?
EndUtterance

Utterance
Source depuis combien de semaines
Target/french depuis combien de semaines ?
EndUtterance


Utterance
Source $c_est_prem
Source $c_est_prem que ça se produit 
Target/french c'est la première fois que ça se produit ?
EndUtterance
  

Phrase
PhraseId $votre_douleur_gen
Source ( la | votre | cette) douleur 
Source ( le | votre | ce) mal 
Source (elle | il | celle-ci | celui-ci |ça)
EndPhrase

Phrase
PhraseId $vos_douleurs_gen
Source ( les | vos | ces) (douleurs | maux) 
Source (elles | ils | ceux-ci | celles-ci)
EndPhrase

Phrase
PhraseId $mal_gen
Source ( les | vos | ces) (douleurs | maux) 
Source ( la | votre | cette) douleur 
EndPhrase

Phrase
PhraseId $du_mal_gen
Source ( des | de vos | de ces) (douleurs | maux) 
Source de ( la | votre | cette) douleur 
EndPhrase  


Phrase
PhraseId $votre_douleur
Source ( la | votre | cette) douleur 
Source ( le | votre | ce) mal 
Source (elle | il | celle-ci | celui-ci |ça)
EndPhrase

Phrase
PhraseId $vos_douleurs
Source ( les | vos | ces) (douleurs | maux) 
Source (elles | ils | ceux-ci | celles-ci)
EndPhrase

TrLex $$un_médic_contre_sympt source="des stéroïdes" french="des stéroïdes"
TrLex $$un_médic_contre_sympt source="des benzodiazépines" french="des benzodiazépines"
TrLex $$un_médic_contre_sympt source="de la vitamine dé" french="de la vitamine dé"# Encoding: UTF-8

# Include common phrases file
include ../../resources/babeldr_phrases.txt

include ../../resources/suivi.txt
include ../../resources/accueil.txt

# Declare domain    
     
Domain
Name suivi
SourceLanguage french
TargetLanguages french 
ExamplesFrom canonicalandsource
RobustMatching yes
NTELanguageModel BabelDr
CacheCanonicalTranslations yes
EndDomain
           
# Translation rules    



#Region 21. Suivi

TrLex $$pour source="pour ?avoir ($irm | $radio) ?$svp" french="pour avoir un examen radiologique"
TrLex $$pour source="pour ?avoir les résultats ?$svp" french="pour avoir les résultats"
TrLex $$pour source="pour ?avoir les résultats de $lirm ?$svp" french="pour avoir les résultats de la radiologie"


# JG: not sure what these are for, but they cause a compilation error in the toy version... 
# *** Error (suivi/grammars/babeldr_french_suivi.txt, lines 34-34, domain suivi): variable $$examen_de_organe is never used
#TrLex $$examen_de_organe source="(à la tête | de la tête)" french="de la tête"
#TrLex $$examen_de_organe source="((au |du) ventre|(de | à) l'abdomen|abdominale)" french="du ventre"
#TrLex $$examen_de_organe source="de l'estomac" french="de l'estomac"

TrLex $$un_médic_contre_sympt source="une lotion" french="une lotion"
TrLex $$un_médic_contre_sympt source="(un|des) inhalations" french="des inhalations"
TrLex $$un_médic_contre_sympt source="(un|des) goutte" french="des gouttes"



Phrase
PhraseId $votre_douleur
Source ( la | votre | cette) douleur 
Source ( le | votre | ce) mal 
Source ( la | votre | cette) (douleur | migraine) (à la tête)
Source ( le | votre | ce) mal (à la tête | de tête)
Source ( la | votre | cette) douleur (au ventre | dans l'abdomen | à l'abdomen |  abdominale | de ventre | dans le ventre)
Source ( le | votre | ce) mal (au ventre | dans l'abdomen | à l'abdomen |  abdominale | de ventre | dans le ventre)
Source ( la | votre | cette) douleur ?(à la poitrine | dans la poitrine | à la poitrine | thoracique|de poitrine)
Source ( le | votre | ce) mal (à la poitrine | dans la poitrine | à la poitrine | thoracique|de poitrine)
Source (elle | il | celle-ci | celui-ci |ça)
EndPhrase

Phrase
PhraseId $vos_douleurs
Source ( les | vos | ces) (douleurs | maux) 
Source (elles | ils | ceux-ci | celles-ci)
Source ( les | vos | ces) (douleurs | maux) (à la tête | de tête)
Source ( les | vos | ces) (céphalées | migraines)
Source ( les | vos | ces) (douleurs | maux) (au ventre | dans l'abdomen | à l'abdomen |  abdominales | de ventre | dans le ventre)
Source ( les | vos | ces) (douleurs | maux) (à la poitrine | dans la poitrine | à la poitrine | thoraciques|de poitrine)
EndPhrase

######################################
# Include files

# Metadata for audio output voices 
include babeldr_voices.txt

######################################
# Encoding: UTF-8

#LITE_BLANK_AUDIO arabic_video arabic_speaker
#celle, ensainte, ...
# Include common phrases file
include ../../resources/babeldr_phrases.txt

include ../../resources/urine.txt
include ../../resources/medicament.txt

# Declare domain    
     
Domain
Name abdominal
SourceLanguage french
TargetLanguages french lsf_ch  
ExamplesFrom canonicalandsource
RobustMatching yes
NTELanguageModel BabelDr
CacheCanonicalTranslations yes
ExpandTrVars on_demand
NTEBaseLanguageModel fre-FR
NTELanguageModelWeight highest
NTEExamplesPerRule 50 1 all
EndDomain

           
# Translation rules         

######################################
# Metadata for audio output voices Fplut
include babeldr_voices.txt

# audio output files
include babeldr_audio_tigrinya.txt

# video output files (sign language)
include babeldr_lsf_ch.txt


######################################
######################################


#region 1. Where is your pain, do you have pain, .....

include ../../resources/accueil.txt

Utterance
Source vous venez parce que vous avez $mal_au_ventre
Source vous êtes venu parce que vous aviez $mal_au_ventre
Source on ma dit que vous aviez $mal_au_ventre
Source on m'a dit que vous aviez $mal_au_ventre
Source ($avez_vous | $ça_fait | $ressentez_vous | $souffrez_vous de) $mal_au_ventre
Source $c_est_douloureux ?$au_ventre
Source ((le | votre) ventre  | l'abdomen | votre abdomen) ?vous fait-il mal
Source ?(est-ce que) ((le | votre) ventre  | l'abdomen | votre abdomen) ?vous fait mal
Source $votre_douleur $est_elle $au_ventre
Source ?(est-ce que) $votre_douleur $est $au_ventre
Source $vos_douleurs $sont_elles $au_ventre
Source ?(est-ce que) $vos_douleurs $sont $au_ventre
Source on m'a dit que vous avez mal au ventre
Target/french avez-vous mal au ventre ?
EndUtterance



Utterance
Source ($avez_vous | $ça_fait | $ressentez_vous | $souffrez_vous (de|d)) $mal_au_ventre (actuellement | maintenant | en ce moment)
Source ($avez_vous | $ça_fait | $ressentez_vous) (actuellement | maintenant | en ce moment) $mal_au_ventre
Source (actuellement | maintenant | en ce moment) ($avez_vous | $ça_fait | $ressentez_vous) $mal_au_ventre
Source $c_est_douloureux ?$au_ventre (actuellement | maintenant | en ce moment)
Source $c_est_douloureux (actuellement | maintenant | en ce moment) ?$au_ventre
Source $c_est_douloureux ?$au_ventre (actuellement | maintenant | en ce moment)
Source (actuellement | maintenant | en ce moment) $c_est_douloureux (actuellement | maintenant | en ce moment) ?$au_ventre
Source ((le | votre) ventre  | l'abdomen | votre abdomen) ?vous fait-il mal (actuellement | maintenant | en ce moment)
Source ?(est-ce que) ((le | votre) ventre  | l'abdomen | votre abdomen) ?vous fait mal (actuellement | maintenant | en ce moment)
Target/french avez-vous mal au ventre maintenant ?
EndUtterance


Utterance
Source $c_est une douleur $$qualificatif_lieu_douleur
Source ?($votre_douleur) $est_elle $$qualificatif_lieu_douleur
Source ?(est-ce (que|qu')) $votre_douleur $est $$qualificatif_lieu_douleur
Source ?($vos_douleurs) $sont_elles $$qualificatif_lieu_douleur
Source $avez_vous ?eu des douleurs ?($au_ventre | abdominales) $$qualificatif_lieu_douleur
Source $avez_vous ?eu une douleur ?($au_ventre | abdominale) $$qualificatif_lieu_douleur
Source ?(est-ce (que|qu')) $vos_douleurs $sont $$qualificatif_lieu_douleur
Source $$qualificatif_lieu_douleur
Target/french la douleur au ventre est-elle $$qualificatif_lieu_douleur ?
EndUtterance


TrLex $$qualificatif_lieu_douleur source="((difficile | difficiles) à (situer | localiser)|diffus | diffuse | diffuses)" french="difficile à situer"
TrLex $$qualificatif_lieu_douleur source="?(bien) (localisée | localisé | localisés | localisées) ?$à_un_endroit" french="localisée"
TrLex $$qualificatif_lieu_douleur source="(superficielle | en surface| superficiel | superficiels | superficielles|(à la|en) surface ?(de la peau))" french="superficielle"

Phrase
PhraseId $votre_douleur
Source ( la | votre | cette) douleur ?(au ventre | dans l'abdomen | à l'abdomen |  abdominale | de ventre | dans le ventre)
Source ( le | votre | ce) mal (de | au) ventre
Source (elle | il | celle-ci | celui-ci |ça)
EndPhrase

Phrase
PhraseId $vos_douleurs
Source ( les | vos | ces) douleurs ?(au ventre | dans l'abdomen | à l'abdomen |  abdominales | de ventre | dans le ventre)
Source ( les | vos | ces) maux de ventre
Source ( les | vos | ces) symptômes 
Source (elles | ils | ceux-ci | celles-ci)
EndPhrase

TrLex $$depuis_durée source="depuis ?environ plus de dix heures ?environ" french="depuis plus de dix heures"
TrLex $$depuis_durée source="depuis aujourd'hui" french="depuis aujourd'hui"
TrLex $$depuis_durée source="depuis ?environ (plusieurs | des | quelques) jours ?environ" french="depuis plusieurs jours"

TrLex $$un_médic_contre_sympt source="((des | ces| les) laxatifs | (un | ce|le) laxatif | laxatif | des probiotiques | des médicaments (facilitant | pour) le transit ?intestinal|des médicaments (pour|qui va) vous aider à aller à selles|un médicament (pour|qui va) vous aider à allar à selles)" french="des médicaments facilitant le transit intestinal"
TrLex $$un_médic_contre_sympt source="(des aspirines | une aspirine|de l'aspirine|aspirine)" french="de l'aspirine"
TrLex $$un_médic_contre_sympt source="(?de la morphine | un dérivé de morphine|de la morphine ou un dérivé)" french="de la morphine ou un dérivé"

Utterance
Source ?$$examen_de_organe
Source $avez_vous ?(déjà) (eu|fait|subi) un examen ?$$examen_de_organe
Source vous a-t-on ?(déjà) fait un examen ?$$examen_de_organe
Source vousaton ?(déjà) fait un examen ?$$examen_de_organe
Source est-ce (qu'on|con) vous a ?(déjà) fait un examen ?$$examen_de_organe
Source on vous a ?(déjà) fait un examen ?$$examen_de_organe
Target/french avez-vous eu un examen ?$$examen_de_organe ?
EndUtterance

Utterance
Source ?$$examen_de_organe
Source $avez_vous ?(déjà) (eu|fait) un contrôle médical ?$$examen_de_organe
Source vous a-t-on ?(déjà) fait un contrôle médical ?$$examen_de_organe
Source vousaton ?(déjà) fait un contrôle médical ?$$examen_de_organe
Source est-ce (qu'on|con) vous a ?(déjà) fait un contrôle médical ?$$examen_de_organe
Source on vous a ?(déjà) fait un contrôle médical ?$$examen_de_organe
Target/french avez-vous eu un contrôle médical ?$$examen_de_organe ?
EndUtterance

TrLex $$examen_de_organe source="(de la|de votre) vésicule biliaire" french="de la vésicule biliaire"
TrLex $$examen_de_organe source="des canaux biliaires" french="des canaux biliaires"
TrLex $$examen_de_organe source="((du|de votre) (côlon|gros intestin) |colorectal)" french="du côlon"

# Encoding: UTF-8

RewriteRobustInput "œ" -> "oe"

Phrase
PhraseId $avez_vous
Source avez-vous
Source (est-ce que|èceque|esque) vous avez
Source vous avez
EndPhrase

Phrase
PhraseId $mal_au_ventre
Source ?( la | votre | cette | une) douleur ?(au ventre | dans l'abdomen | à l'abdomen | abdominale | de ventre | dans le ventre)
Source ?( les | vos | ces | des) (douleurs | maux) ?(au ventre | dans l'abdomen | à l'abdomen | abdominales | de ventre | dans le ventre)
Source ?( le | votre | ce | un) mal ?(au ventre | dans l'abdomen | à l'abdomen | abdominale | de ventre | dans le ventre)
EndPhrase

Phrase
PhraseId $ça_fait
Source (ça | cela) ?(vous) fait
Source cela ?(vous) fait-il
Source est-ce que (ça | cela) ?(vous) fait
EndPhrase

Phrase
PhraseId $ressentez_vous
Source ?(est-ce que) vous ressentez
Source ?(est-ce que) vous sentez
Source $éprouvez_vous
Source ressentez-vous
Source sentez-vous
Source $avez_vous ressenti
Source $avez_vous senti
Source $avez_vous noté
EndPhrase

Phrase
PhraseId $souffrez_vous
Source est-ce que vous souffrez
Source souffrez-vous
Source vous souffrez
Source $avez_vous souffert
Source ?(est-ce que) vous avez souffert
EndPhrase

Phrase
PhraseId $au_ventre
Source (au ?(niveau du) ventre | dans l'abdomen | dans le ventre | à l'abdomen|abdominales)
EndPhrase

Phrase
PhraseId $c_est_douloureux
Source (c'|cela) (est | était) douloureux
Source est-ce douloureux
Source est-ce ce que c'est douloureux
Source était-ce douloureux
Source est-ce que (c'|cela) (est | était) douloureux
EndPhrase

Phrase
PhraseId $sont
Source sont
Source étaient
EndPhrase

Phrase
PhraseId $à_un_endroit
Source à un (endroit|point) ?très précis 
Source au même endroit
Source à un même endroit
Source à un seul endroit
Source en un seul point
EndPhrase


Phrase
PhraseId $êtes_vous
Source ?(est-ce que|esque) vous êtes
Source êtes-vous
Source ètevous
Source avez-vous été
Source ?(est-ce que) vous avez été
EndPhrase

Phrase
PhraseId $suivez_vous
Source est-ce que vous suivez
Source suivez-vous
Source vous suivez
EndPhrase

Phrase
PhraseId $faites_vous
Source est-ce que vous faites
Source vous faites
Source faites-vous 
Source est-ce que vous avez fait
Source avez-vous fait
EndPhrase

Phrase
PhraseId $prenez_vous
Source est-ce que vous prenez
Source prenez-vous
Source vous prenez
Source $avez_vous ?pris
EndPhrase

Phrase
PhraseId $pouvez_vous
Source arrivez-vous à
Source est-ce que vous arrivez à
Source parvenez-vous à
Source est-ce que vous parvenez à
Source est-ce que vous pourriez
Source est-ce que vous pouvez
Source pourriez-vous
Source pouvez-vous
Source vous arrivez à
Source vous pourriez
Source vous pouvez
Source $avez_vous réussi 
EndPhrase

Phrase
PhraseId $c_est_prem
Source (c'est|cela (est | était)|c'était) la première fois
Source est-ce la première fois
Source était-ce la première fois
Source (est-ce que|èceque|esque|estceque) (c'est|c'était) la première fois
EndPhrase

Phrase
PhraseId $est_elle
Source (est-elle | est-il)
Source (était-elle | était-il)
EndPhrase

Phrase
PhraseId $est
Source est
Source était
EndPhrase

Phrase
PhraseId $sont_elles
Source (étaient-elles | étaient-ils)
Source (sont-elles | sont-ils)
EndPhrase

Phrase
PhraseId $c_est
Source cela est
Source (c'est | ces)
Source est-ce
Source (est-ce-que | èceque) (c'est | ces)
EndPhrase

Phrase
PhraseId $éprouvez_vous
Source ?(est-ce que) vous éprouvez
Source ?(est-ce que) vous avez éprouvé
Source éprouvez-vous
Source $avez_vous
Source $avez_vous ?dèjà (eu |  éprouvé) 
Source vous est-il arrivé (d'éprouver | d'avoir)
Source ?(est-ce qu') il vous est arrivé (d'éprouver | d'avoir)
Source vous arrive-t-il (d'éprouver | d'avoir)
Source ?(est-ce que) ça vous arrive (d'éprouver | d'avoir)
EndPhrase

Phrase
PhraseId $irm
Source (un|une) (i air mem | ièrem|i r m)
Source une (image|imagerie) par résonance ?magnétique
Source une résonance ?magnétique ?nucléaire
EndPhrase

Phrase
PhraseId $lirm
Source de l'i air m
Source de (l'image|l'imagerie) ?(par résonance ?magnétique)
Source de la résonance
Source de la résonance magnétique ?nucléaire
Source de la radio
Source de la radiographie
Source de la radiologie
Source de l'examen ?radiologique
Source du scanner
Source de l'encéphalogramme
EndPhrase


Phrase
PhraseId $radio
Source une radio
Source une image
Source une imagerie
Source une radiographie
Source un examen radiologique
EndPhrase

Phrase
PhraseId $svp
Source s'il vous plaît
EndPhrase

Phrase
PhraseId $suivez
Source ?(s'il vous plaît) suivez ?(s'il vous plaît)
Source suivez ?(s'il vous plaît)
Source veuillez ?(s'il vous plaît) suivre ?(s'il vous plaît)
Source vous devez suivre
Source vous allez devoir suivre
Source nous vous demandons de suivre
Source je vais vous demander de suivre
Source nous allons vous demander de suivre
Source $pouvez_vous suivre
EndPhrase

Phrase
PhraseId $quand
Source (quand|lorsque|pendant que|alors que|si)
EndPhrase

Phrase
PhraseId $prière_de
Source je vous prie (de | d')
Source nous vous prions (de | d')
Source prière de
Source veuillez ?$svp
Source je vais vous demander (de ?(bien vouloir) | d')
Source vous allez 
EndPhrase

# Encoding: UTF-8

Utterance
Source (je voudrais|j'aimerais) savoir si vous avez un traitement ?régulier
Source ($avez_vous|$suivez_vous|$faites_vous|$prenez_vous) un traitement ?régulier
Target/french avez-vous un traitement régulier ?
EndUtterance

Utterance
Source $prenez_vous (régulièrement | au quotidien|tous les jours|quotidiennement|d'habitude) (un|des) (médicament|médicaments)
Source $prenez_vous (un|des) (médicament|médicaments) (régulièrement | au quotidien|tous les jours|quotidiennement|d'habitude)
Target/french prenez-vous régulièrement des médicaments ?
EndUtterance

Utterance
Source $$un_médic_contre_sympt
Source vous avez pris $$un_médic_contre_sympt pendant  (combien de (temps | jours|mois))
Source vous avez été sous $$un_médic_contre_sympt pendant (combien de (temps | jours|mois))
Source pendant (combien de (temps | jours)) avez-vous pris $$un_médic_contre_sympt
Target/french pendant combien de jours avez-vous pris $$un_médic_contre_sympt ?
EndUtterance

Utterance
Source $avez_vous ?déjà pris $$un_médic_contre_sympt $$durée_médic
Target/french avez-vous pris $$un_médic_contre_sympt $$durée_médic ?
EndUtterance

TrLex $$durée_médic source="(?pendant longtemps|pendant une période prolongée|pendant de nombreuses années|pendant une longue période|pendant une longue durée)" french="longtemps"
TrLex $$durée_médic source="?(pendant | durant) (quelques |  plusieurs| des) jours" french="pendant plusieurs jours"
TrLex $$durée_médic source="?(pendant | durant) deux jours" french="pendant deux jours"


# Encoding: UTF-8

##suivi

Utterance
Source vous allez être (vu | examiné | dirigé|vue|examinée|dirigée) ?(dans (une ?autre zone | un ?autre secteur | un autre service) ?(de soin))
Target/french vous allez être vu dans une zone de soins
EndUtterance

Utterance
Source ?(pour cela) $suivez la ligne orange
Target/french suivez la ligne orange
EndUtterance


Utterance
Source (vous (devez |devrez)|il faudra|il va falloir|il faut) prendre $$comprimé $$temps_médic
Source vous prendrez $$comprimé $$temps_médic  
Source prenez $$comprimé $$temps_médic 
Source vous allez (recevoir|?devoir prendre) $$comprimé  $$temps_médic 
Target/french vous devez prendre $$comprimé $$temps_médic
EndUtterance

TrLex $$comprimé source="(un comprimé|une pillule)" french="un comprimé"
TrLex $$comprimé source="deux (comprimés|pillules)" french="deux comprimés"
TrLex $$comprimé source="trois (comprimés|pillules)" french="trois comprimés"

TrLex $$temps_médic source="(le matin|au réveil|$quand vous vous réveillez ?(le matin))" french="le matin"
TrLex $$temps_médic source="?(le matin|au réveil|$quand vous vous réveillez|tous les matins|chaque matin) à jeun" french="à jeun"
TrLex $$temps_médic source="le matin et le soir" french="le matin et le soir"

Utterance
Source (je vais | on va |  nous allons) ?vous (donner | prescrire) $$un_médic_contre_sympt
Source prenez $$un_médic_contre_sympt
Source vous allez (recevoir|?devoir prendre) $$un_médic_contre_sympt
Source vous (devez |devrez) prendre $$un_médic_contre_sympt
Source vous prendrez $$un_médic_contre_sympt
Target/french je vais vous prescrire $$un_médic_contre_sympt
EndUtterance


Utterance
Source (vous allez devoir | il va falloir | il faut | vous devez | il faudra) retourner en salle d'attente ?$$pour
Source ?$$pour (vous allez devoir | il va falloir | il faut | vous devez | il faudra) (patienter | attendre) ?(un moment) ?((en | dans la) salle d'attente) ?$svp 
Source (vous allez devoir | il va falloir | il faut | vous devez | il faudra|vous pouvez) (patienter | attendre) ?(un moment) ?((en | dans la) salle d'attente) ?$svp ?$$pour
Source (il va falloir | il faut | il faudra) que vous (patientiez | attendiez) ?(un moment) ?((en | dans la) salle d'attente) ?$svp ?$$pour
Source ?$$pour (il va falloir | il faut | il faudra) que vous (patientiez | attendiez) ?(un moment) ?((en | dans la) salle d'attente) ?$svp ?$$pour
Source (attendez | prenez place) ?(un moment) ?((en | dans la) salle d'attente) ?$svp ?$$pour
Source ?$$pour (attendez | prenez place) ?(un moment) ?((en | dans la) salle d'attente) ?$svp 
Source $prière_de (attendre | patienter | prendre place) ?(un moment) ?((en | dans la) salle d'attente) ?$svp ?$$pour
Source ?$$pour $prière_de (attendre | patienter | prendre place) ?(un moment) ?((en | dans la) salle d'attente) ?$svp 
Target/french vous devez attendre en salle d'attente ?$$pour
EndUtterance

Utterance
Source vous devez prendre l'insuline ?$$fréquence ?$$temps_médic 
Source vous devez vous injecter ?(l'insuline) ?$$fréquence ?$$temps_médic 
Source vous (devez |devrez) faire une ?seule injection ?$$fréquence ?$$temps_médic 
Source vous devez vous injecter ?(l'insuline)  ?$$temps_médic ?$$fréquence
Source vous (devez |devrez) faire une ?seule injection ?$$temps_médic ?$$fréquence
Source vous allez devoir faire une ?seule injection ?$$temps_médic ?$$fréquence
Target/french vous devez faire une injection ?$$fréquence ?$$temps_médic
EndUtterance

TrLex $$fréquence source="une ?seule fois par jour" french="une fois par jour"
TrLex $$fréquence source="deux fois par jour" french="deux fois par jour"
TrLex $$fréquence source="trois fois par jour" french="trois fois par jour"
# Encoding: UTF-8
###urine
##pluriel
Utterance
Source $avez_vous (uriné | fait pipi) ?(avant de venir|maintenant|aujourd'hui)
Source $avez_vous pu (uriner | faire pipi) ?(avant de venir|maintenant|aujourd'hui)
Source $avez_vous réussi (à uriner | à faire pipi) ?(avant de venir|maintenant|aujourd'hui)
Source ($êtes_vous (arrivé|parvenu) | arrivez-vous| ?(est-ce que) vous (arrivez |parvenez)) à (uriner | faire pipi)
Target/french avez-vous pu uriner ?
EndUtterance



Utterance
Source  $avez_vous  des (problèmes | symptômes|troubles|soucis) (urinaires | avec les urines|avec le pipi|avec les voies urinaires) $$depuis_durée
Target/french avez-vous des problèmes urinaires $$depuis_durée ?
EndUtterance


