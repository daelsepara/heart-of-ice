<CONSTANT SKILL-GLOSSARY <LTABLE SKILL-AGILITY SKILL-CLOSE-COMBAT SKILL-CUNNING SKILL-CYBERNETICS SKILL-ESP SKILL-LORE SKILL-PARADOXING SKILL-PILOTING SKILL-ROGUERY SKILL-SHOOTING SKILL-STREETWISE SKILL-SURVIVAL>>
<CONSTANT CHARACTERS <LTABLE CHARACTER-EXPLORER CHARACTER-BOUNTY-HUNTER CHARACTER-SPY CHARACTER-TRADER CHARACTER-VISIONARY CHARACTER-SCIENTIST CHARACTER-MUTANT>>

<OBJECT SKILL-AGILITY
    (DESC "AGILITY")
    (LDESC "The ability to perform acrobatic feats, run, climb, balance and leap. A character with this skills is nimble and dexterous")>

<OBJECT SKILL-CLOSE-COMBAT
    (DESC "CLOSE COMBAT")
    (LDESC "The use of a range of martial arts incorporating elements of karate, ju-jitsu and t'ai-chi")>

<OBJECT SKILL-CUNNING
    (DESC "CUNNING")
    (LDESC "The ability to think on your feet and devise celver ploys for getting out of trouble. Useful in countless situations")>

<OBJECT SKILL-CYBERNETICS
    (DESC "CYBERNETICS")
    (LDESC "The ability to program and operate computers -- almost a forgotten science in the apocalyptic world of the 23rd century")>

<OBJECT SKILL-ESP
    (DESC "ESP")
    (LDESC "The ability to sense danger and read other people's minds. You must possess a psionic focus to use this skill")
    (REQUIRES <LTABLE PSIONIC-FOCUS>)>

<OBJECT SKILL-LORE
    (DESC "LORE")
    (LDESC "A combination of history, legend and general knowledge which gives you a good basis for dealing with the unknown")>

<OBJECT SKILL-PARADOXING
    (DESC "PARADOXING")
    (LDESC "The ability to mentally affect the normal laws of nature. A slower and less reliable technique than ESP, but with sometimes miraculous effects. You must possess a psionic focus to use this skill")
    (REQUIRES <LTABLE PSIONIC-FOCUS>)>

<OBJECT SKILL-PILOTING
    (DESC "PILOTING")
    (LDESC "The ability to handle virtually any vehicle from an air-sled up to a space shuttle")>

<OBJECT SKILL-ROGUERY
    (DESC "ROGUERY")
    (LDESC "Stealth and espionage skills: picking pockets, opening locks, and skulking unseen in the shadows")>

<OBJECT SKILL-SHOOTING
    (DESC "SHOOTING")
    (LDESC "Expertise with long-range weaponry. You must possess a charged barysal gun to use this skill")
    (REQUIRES <LTABLE BARYSAL-GUN>)>

<OBJECT SKILL-STREETWISE
    (DESC "STREETWISE")
    (LDESC "With this skill you are never at a loss in cities. What others see as the squalor and meance of narrow neon-lit streets is opportunity to you")>

<OBJECT SKILL-SURVIVAL
    (DESC "SURVIVAL")
    (LDESC "A talent which enables you to cope in desolate and uninhabited regions: forests, deserts, swamps and mountain peaks")>

<OBJECT CHARACTER-EXPLORER
    (DESC "Explorer")
    (LDESC "Others might mourn the collapse of civilization, but for you it only opens up new areas of mystery in the world")
    (SYNONYM EXPLORER)
    (SKILLS <LTABLE SKILL-CLOSE-COMBAT SKILL-LORE SKILL-STREETWISE SKILL-SURVIVAL>)
    (POSSESSIONS NONE)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-BOUNTY-HUNTER
    (DESC "Bounty Hunter")
    (LDESC "Times are hard and the strong prey upon the weak. It is left to the likes of you to enforce the law")
    (SYNONYM HUNTER)
    (ADJECTIVE BOUNTY)
    (SKILLS <LTABLE SKILL-CUNNING SKILL-PILOTING SKILL-SHOOTING SKILL-STREETWISE>)
    (POSSESSIONS <LTABLE BARYSAL-GUN>)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-SPY
    (DESC "Spy")
    (LDESC "Even as the world dies a slow death, governments vie with one another for the wealth and power that remain. You steal secrets and trade them to the highest bidder")
    (SYNONYM SPY)
    (SKILLS <LTABLE SKILL-AGILITY SKILL-CYBERNETICS SKILL-ROGUERY SKILL-STREETWISE>)
    (POSSESSIONS NONE)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-TRADER
    (DESC "Trader")
    (LDESC "Few dare cross the icy wastes between cities, so a daring adventurer can make a tidy profit")
    (SYNONYM TRADER)
    (SKILLS <LTABLE SKILL-ESP SKILL-LORE SKILL-SHOOTING SKILL-STREETWISE>)
    (POSSESSIONS <LTABLE BARYSAL-GUN PSIONIC-FOCUS>)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-VISIONARY
    (DESC "Visionary")
    (LDESC "Cursed with second sight, you know that mankind has no future unless something is done to save the world")
    (SYNONYM VISIONARY)
    (SKILLS <LTABLE SKILL-CLOSE-COMBAT SKILL-CUNNING SKILL-ESP SKILL-PARADOXING>)
    (POSSESSIONS <LTABLE PSIONIC-FOCUS>)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-SCIENTIST
    (DESC "Scientist")
    (LDESC "Most people understand nothing of the machines created by their ancestors, but you've learned that knowledge is power")
    (SYNONYM SCIENTIST)
    (SKILLS <LTABLE SKILL-CYBERNETICS SKILL-LORE SKILL-PILOTING SKILL-SURVIVAL>)
    (POSSESSIONS NONE)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-MUTANT
    (DESC "Mutant")
    (LDESC "Born with strange powers, you are more than human. Others would kill you if they knew your secret")
    (SYNONYM MUTANT)
    (SKILLS <LTABLE SKILL-AGILITY SKILL-CUNNING SKILL-PARADOXING SKILL-ROGUERY>)
    (POSSESSIONS <LTABLE PSIONIC-FOCUS>)
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT)>

<OBJECT CHARACTER-CUSTOM
    (DESC "Custom Character")
    (SYNONYM CHARACTER)
    (ADJECTIVE CUSTOM)
    (LDESC "Custom character with user selected skills")
    (LIFE-POINTS 10)
    (MONEY 30)
    (FLAGS PERSONBIT NARTICLEBIT)>
