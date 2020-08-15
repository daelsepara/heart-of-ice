; "Objects for Heart of Ice"

; Weapons

<OBJECT BARYSAL-GUN
    (DESC "barysal gun")
    (SYNONYM GUN)
    (ADJECTIVE BARYSAL)
    (REQUIRES SKILL-SHOOTING)
    (CHARGES 6)
    (FLAGS TAKEBIT)>

<OBJECT CROSSBOW
    (DESC "crossbow")
    (SYNONYM CROSSBOW)
    (FLAGS TAKEBIT)>

<OBJECT PSIONIC-FOCUS
    (DESC "psionic focus")
    (SYNONYM FOCUS)
    (ADJECTIVE PSIONIC)
    (REQUIRES SKILL-ESP)
    (FLAGS TAKEBIT)>

; Objects

<OBJECT ANTIDOTE-PILLS
    (DESC "antidote pills")
    (SYNONYM PILLS)
    (ADJECTIVE ANTIDOTE)
    (FLAGS TAKEBIT)>

<OBJECT BATTERY-UNIT
    (DESC "battery unit")
    (SYNONYM UNIT)
    (ADJECTIVE BATTERY-UNIT)
    (CHARGES 0)
    (FLAGS TAKEBIT)>

<OBJECT BINOCULARS
    (DESC "pair of binoculars")
    (SYNONYM BINOCULARS)
    (ADJECTIVE PAIR)
    (FLAGS TAKEBIT)>

<OBJECT COLD-WEATHER-SUIT
    (DESC "cold weather suit")
    (SYNONYM SUIT)
    (ADJECTIVE COLD WEATHER)
    (FLAGS TAKEBIT)>

<OBJECT FLASHLIGHT
    (DESC "flashlight")
    (SYNONYM FLASHLIGHT)
    (FLAGS TAKEBIT)>

<OBJECT FOOD-PACK
    (DESC "food pack")
    (SYNONYM PACK)
    (ADJECTIVE FOOD)
    (QUANTITY 1)
    (FLAGS TAKEBIT)>

<OBJECT FUR-COAT
    (DESC "fur coat")
    (SYNONYM COAT)
    (ADJECTIVE FUR)
    (FLAGS TAKEBIT)>

<OBJECT GAS-MASK
    (DESC "gas mask")
    (SYNONYM MASK)
    (ADJECTIVE GAS)
    (FLAGS TAKEBIT)>

<OBJECT ID-CARD
    (DESC "ID card")
    (SYNONYM CARD)
    (ADJECTIVE ID)
    (FLAGS TAKEBIT)>

<OBJECT KNIFE
    (DESC "knife")
    (SYNONYM KNIFE)
    (QUANTITY 1)
    (FLAGS TAKEBIT)>

<OBJECT LANTERN
    (DESC "lantern")
    (SYNONYM LANTERN)
    (FLAGS TAKEBIT)>

<OBJECT LITTLE-GAIA
    (DESC "Little Gaia")
    (SYNONYM GAIA)
    (ADJECTIVE LITTLE)
    (FLAGS TAKEBIT)>

<OBJECT MEDICAL-KIT
    (DESC "medical kit")
    (SYNONYM MEDICAL)
    (ADJECTIVE KIT)
    (FLAGS TAKEBIT)>

<OBJECT POLARIZED-GOGGLES
    (DESC "polarized goggles")
    (SYNONYM GOGGLES)
    (ADJECTIVE POLARIZED)
    (FLAGS TAKEBIT)>

<OBJECT ROPE
    (DESC "rope")
    (SYNONYM ROPE)
    (FLAGS TAKEBIT)>

<OBJECT SHORTSWORD
    (DESC "shortsword")
    (SYNONYM SHORTSWORD)
    (FLAGS TAKEBIT)>

<OBJECT SPECULUM-JACKET
    (DESC "speculum jacket")
    (SYNONYM JACKET)
    (ADJECTIVE SPECULUM)
    (FLAGS TAKEBIT)>

<OBJECT STASIS-BOMB
    (DESC "stasis bomb")
    (SYNONYM BOMB)
    (ADJECTIVE STASIS)
    (FLAGS TAKEBIT)>

<OBJECT STUN-GRENADE
    (DESC "stun grenade")
    (SYNONYM GRENADE)
    (ADJECTIVE STUN)
    (FLAGS TAKEBIT)>

<OBJECT VADE-MECUM
    (DESC "vade-mecum")
    (SYNONYM VADE-MECUM)
    (FLAGS TAKEBIT)>

<OBJECT VINE-KILLER
    (DESC "vade-mecum")
    (SYNONYM KILLER)
    (ADJECTIVE VINE)
    (FLAGS TAKEBIT)>

; Vehicles

<OBJECT MANTA-SKY-CAR
    (DESC "Manta sky-car")
    (SYNONYM CAR)
    (ADJECTIVE MANTA SKY)
    (FLAGS VEHICLEBIT)>

<OBJECT BURREK
    (DESC "burrek")
    (SYNONYM BURREK)
    (FLAGS VEHICLEBIT)>

;Retroviruses

<OBJECT VIRID-MYSTERY
    (DESC "Virid Mystery")
    (SYNONYM MYSTERY)
    (ADJECTIVE VIRID)
    (ACTION VIRID-MYSTERY-F)
    (STORY STORY330)
    (PRICE 7)
    (PURCHASED F)>

<OBJECT EXALTED-ENHANCER
    (DESC "Exalted Enhancer")
    (SYNONYM ENHANCER)
    (ADJECTIVE EXALTED)
    (ACTION EXALTED-ENHANCER-F)
    (STORY STORY308)
    (PRICE 7)
    (PURCHASED F)>

<OBJECT MASK-OF-OCCULTATION
    (DESC "Mask of Occultation")
    (SYNONYM MASK)
    (ADJECTIVE OCCULTATION)
    (ACTION MASK-OF-OCCULTATION-F)
    (STORY STORY449)
    (PRICE 6)
    (PURCHASED F)>

<OBJECT PEERLESS-PERCEPTIVATE
    (DESC "Peerless Perceptivate")
    (SYNONYM PERCEPTIVATE)
    (ADJECTIVE PEERLESS)
    (ACTION PEERLESS-PERCEPTIVATE-F)
    (STORY STORY287)
    (PRICE 4)
    (PURCHASED F)>

<ROUTINE VIRID-MYSTERY-F ()
    <COND (
        <OR
            <GETP ,EXALTED-ENHANCER ,P?PURCHASED>
            <GETP ,MASK-OF-OCCULTATION ,P?PURCHASED>
            <GETP ,PEERLESS-PERCEPTIVATE ,P?PURCHASED>
        >
        <APPLY ,EXALTED-ENHANCER-F T>
        <APPLY ,MASK-OF-OCCULTATION-F T>
        <APPLY ,PEERLESS-PERCEPTIVATE-F T>
    )(ELSE
        <EMPHASIZE "There are no prior genetic effects to be reversed!">
    )>>

<ROUTINE EXALTED-ENHANCER-F ("OPT" (REVERSE F))
    <COND (<NOT .REVERSE>
        <SETG MAX-LIFE-POINTS <+ ,MAX-LIFE-POINTS 5>>
        <EMPHASIZE "Your Maximum Life Points has increased">
        <GAIN-LIFE 5>
        <LOSE-SKILL ,SKILL-AGILITY>
    )(ELSE
        <COND (<GETP ,EXALTED-ENHANCER ,P?PURCHASED>
            <SETG MAX-LIFE-POINTS <- ,MAX-LIFE-POINTS 5>>
            <COND (<G? ,LIFE-POINTS ,MAX-LIFE-POINTS> <SET LIFE-POINTS ,MAX-LIFE-POINTS>)>
            <COND (<IN? ,SKILL-AGILITY ,LOST-SKILLS> <MOVE ,SKILL-AGILITY ,SKILLS>)>
            <REVERSE ,EXALTED-ENHANCER>
        )>
    )>>

<ROUTINE MASK-OF-OCCULTATION-F ("OPT" (REVERSE F))
    <COND (<NOT .REVERSE>
        <GAIN-CODEWORD ,CODEWORD-CAMOUFLAGE>
    )(ELSE
        <COND (<GETP ,MASK-OF-OCCULTATION ,P?PURCHASED>
            <DELETE-CODEWORD ,CODEWORD-CAMOUFLAGE>
            <REVERSE ,MASK-OF-OCCULTATION>
        )>
    )>>

<ROUTINE PEERLESS-PERCEPTIVATE-F ("OPT" (REVERSE F))
    <COND (<NOT .REVERSE>
        <GAIN-CODEWORD ,CODEWORD-SCOTOPIC>
    )(ELSE
        <COND (<GETP ,PEERLESS-PERCEPTIVATE ,P?PURCHASED>
            <DELETE-CODEWORD ,CODEWORD-SCOTOPIC>
            <REVERSE ,PEERLESS-PERCEPTIVATE>
        )>
    )>>

<ROUTINE REVERSE (EFFECT)
    <COND (.EFFECT
        <CRLF>
        <HLIGHT ,H-BOLD>
        <TELL "The genetic effects of " T .EFFECT " has been reversed" ,PERIOD-CR>
        <HLIGHT 0>
    )>>