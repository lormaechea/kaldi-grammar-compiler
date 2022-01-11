# Encoding: UTF-8

Utterance
Source $key
EndUtterance

Utterance
Source ?$key $emergency_command
EndUtterance

Utterance
Source ?$key $stop_command
EndUtterance

Utterance 
Source ?$key $initiate_command ?($theme|$property)
Source ?$key $stop_command ?($theme|$property)
EndUtterance

PhraseId $theme
Phrase $entity ?$property
Phrase ?$entity ?$property
EndPhrase

PhraseId $entity
Phrase ( $person | $organisation | $object )
EndPhrase

PhraseId $property
Phrase ( $reglable | $levable | $on_off | $fermable | $appelable )
EndPhrase

PhraseId $reglable
Phrase (augmenter | augmente | diminuer | diminue | baisser | baisse )
Phrase ?la ( lumière | température )
Phrase ?le chauffage
EndPhrase

PhraseId $levable
Phrase ( monter | monte | baisser | baisse | descendre | descends | descendez )
Phrase ( arrêter | arrête | stopper | stoppe | redescendre | redescendez | redescends )
Phrase store
EndPhrase

PhraseId $on_off
Phrase (éteindre | éteins | éteignez | allumer | allume | arrêter | arrête | stopper | stoppe )
Phrase ?la ( télé | télévision | radio )
Phrase ( ordinateur | l'ordinateur )
EndPhrase

PhraseId $fermable
Phrase ( ouvrir | ouvre | fermer | ferme )
Phrase ( porte | rideau | store | fenêtre )
EndPhrase

PhraseId $appelable
Phrase ( appeler | appelle ) $person
Phrase ( appeler | appelle ) ?$organisation
EndPhrase

PhraseId $key
Phrase ( maison | nestor )
EndPhrase

PhraseId $stop_command
Phrase ( stopper | stoppe | arrêter | arrête )
EndPhrase

PhraseId $emergency_command
Phrase ( au secours | à l'aide )
Phrase ( aider moi | aide-moi )
EndPhrase

PhraseId $initiate_command
Phrase ( ouvrir | ouvre | fermer | ferme )
Phrase ( baisser | baisse | augmenter | augmente )
Phrase ( diminuer | diminue | éteindre | éteins | éteignez | monter | monte )
Phrase ( allumer | allume | descendre | descends | descendez )
Phrase ( appeler | appelle | appeler | appelle )
EndPhrase

PhraseId $organisation
Phrase ( ?le samu | secours | ?les pompiers )
Phrase ( ?la supérette | ?le supermarché )
EndPhrase

PhraseId $person
Phrase ?ma ( fille | femme )
Phrase ?mon ( fils | mari )
Phrase ?( une|l' ) infirmière 
Phrase ?( un|le ) ( médecin | docteur | ami )
EndPhrase

PhraseId $object
Phrase ?la ( lumière | température | fenêtre | porte | télé | télévision ) 
Phrase ( ordinateur | l'ordinateur )
Phrase ?le ( chauffage | pc | rideau | store )
EndPhrase
