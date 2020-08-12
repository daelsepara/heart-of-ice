<INSERT-FILE "numbers">

<GLOBAL CHARACTERS-ENABLED T>
<GLOBAL STARTING-POINT BACKGROUND>

<CONSTANT BAD-ENDING "Your adventure ends here.|">
<CONSTANT GOOD-ENDING "Further adventure awaits.|">
<CONSTANT DESTINY-GODHOOD "You are immortal and all-powerful now. Your adventure has culminated in godhood.|">
<CONSTANT DESTINY-SENTINEL "The stasis bomb activates, turning you into an undying sentinel for all time.|">
<CONSTANT DESTINY-SACRIFICE "In this chamber deep blow the ruins of Du-En, the two of you give your lives for the sake of the whole world.|">

<OBJECT CURRENCY (DESC "scads")>
<OBJECT VEHICLE (DESC "car")>

<ROUTINE RESET-OBJECTS ()
	<PUTP ,BARYSAL-GUN ,P?CHARGES 6>
	<PUTP ,BATTERY-UNIT ,P?CHARGES 0>
	<RETURN>>

<ROUTINE RESET-STORY ()
	<RESET-TEMP-LIST>
	<RESET-RETROVIRUS>
	<RESET-CONTAINER ,LOST-SKILLS>
	<SETG PRACTICED-SHORTSWORD F>
	<SET-DESTINATION ,STORY006 1 ,STORY138>
	<SET-DESTINATION ,STORY006 2 ,STORY182>
	<SET-DESTINATION ,STORY069 1 ,STORY135>
	<SET-DESTINATION ,STORY116 1 ,STORY160>
	<SET-DESTINATION ,STORY138 1 ,STORY182>
	<SET-DESTINATION ,STORY153 3 ,STORY454>
	<SET-DESTINATION ,STORY160 1 ,STORY138>
	<SET-DESTINATION ,STORY182 1 ,STORY138>
	<SET-DESTINATION ,STORY199 1 ,STORY286>
	<SET-DESTINATION ,STORY259 1 ,STORY242>
	<PUTP ,STORY004 ,P?DEATH T>
	<PUTP ,STORY013 ,P?DEATH T>
	<PUTP ,STORY019 ,P?DEATH T>
	<PUTP ,STORY026 ,P?DEATH T>
	<PUTP ,STORY035 ,P?DEATH T>
	<PUTP ,STORY037 ,P?DEATH T>
	<PUTP ,STORY039 ,P?DEATH T>
	<PUTP ,STORY043 ,P?DEATH T>
	<PUTP ,STORY044 ,P?DEATH T>
	<PUTP ,STORY056 ,P?DEATH T>
	<PUTP ,STORY065 ,P?DEATH T>
	<PUTP ,STORY066 ,P?DEATH T>
	<PUTP ,STORY070 ,P?DEATH T>
	<PUTP ,STORY075 ,P?DEATH T>
	<PUTP ,STORY076 ,P?DEATH T>
	<PUTP ,STORY085 ,P?DEATH T>
	<PUTP ,STORY102 ,P?DEATH T>
	<PUTP ,STORY108 ,P?DEATH T>
	<PUTP ,STORY127 ,P?DEATH T>
	<PUTP ,STORY129 ,P?DEATH T>
	<PUTP ,STORY131 ,P?DEATH T>
	<PUTP ,STORY137 ,P?DEATH T>
	<PUTP ,STORY147 ,P?DEATH T>
	<PUTP ,STORY158 ,P?DEATH T>
	<PUTP ,STORY161 ,P?DEATH T>
	<PUTP ,STORY162 ,P?DEATH T>
	<PUTP ,STORY168 ,P?DEATH T>
	<PUTP ,STORY171 ,P?DEATH T>
	<PUTP ,STORY180 ,P?DEATH T>
	<PUTP ,STORY185 ,P?DEATH T>
	<PUTP ,STORY186 ,P?DEATH T>
	<PUTP ,STORY192 ,P?DEATH T>
	<PUTP ,STORY194 ,P?DEATH T>
	<PUTP ,STORY201 ,P?DEATH T>
	<PUTP ,STORY207 ,P?DEATH T>
	<PUTP ,STORY234 ,P?DEATH T>
	<PUTP ,STORY248 ,P?DEATH T>
	<PUTP ,STORY249 ,P?DEATH T>
	<PUTP ,STORY260 ,P?DEATH T>
	<PUTP ,STORY262 ,P?DEATH T>
	<RETURN>>

<CONSTANT DIED-IN-COMBAT "You died in combat">
<CONSTANT DIED-OF-HUNGER "You starved to death">
<CONSTANT DIED-GREW-WEAKER "You grew weaker and eventually died">
<CONSTANT DIED-FROM-INJURIES "You died from your injuries">
<CONSTANT DIED-FROM-COLD "You eventually freeze to death">
<CONSTANT NATURAL-HARDINESS "Your natural hardiness made you cope better with the situation">

<GLOBAL PRACTICED-SHORTSWORD F>

<CONSTANT CHARGE-BARYSAL-KEY !\b>
<CONSTANT CHARGE-BARYSAL-KEY-CAPS !\B>

<ROUTINE SPECIAL-INTERRUPT-ROUTINE (KEY "AUX" CHARGES)
	<COND (<EQUAL? .KEY ,CHARGE-BARYSAL-KEY-CAPS ,CHARGE-BARYSAL-KEY>
		<COND (<AND <CHECK-ITEM ,BATTERY-UNIT> <CHECK-ITEM ,BARYSAL-GUN>>
			<SET CHARGES <GETP ,BATTERY-UNIT ,P?CHARGES>>
			<CRLF>
			<TELL CR "Charge " T ,BARYSAL-GUN "?">
			<COND (<YES?>
				<SET CHARGES <+ .CHARGES <GETP ,BARYSAL-GUN ,P?CHARGES>>>
				<PUTP ,BARYSAL-GUN ,P?CHARGES .CHARGES>
				<LOSE-ITEM ,BATTERY-UNIT>
			)>
			<RTRUE>
		)>
	)>
	<RFALSE>>

<ROUTINE PREVENT-DEATH ("OPT" STORY)
	<COND (<NOT .STORY> <SET STORY ,HERE>)>
	<COND (<GETP .STORY ,P?DEATH> <PUTP .STORY ,P?DEATH F>)>>

<ROUTINE GET-NUMBER (MESSAGE "OPT" MINIMUM MAXIMUM "AUX" COUNT)
	<REPEAT ()
		<CRLF>
		<TELL .MESSAGE>
		<COND (<AND <OR <ASSIGNED? MINIMUM> <ASSIGNED? MAXIMUM>> <G? .MAXIMUM .MINIMUM>>
			<TELL " (" N .MINIMUM "-" N .MAXIMUM ")">
		)>
		<TELL "? ">
		<READLINE>
		<COND (<EQUAL? <GETB ,LEXBUF 1> 1> <SET COUNT <CONVERT-TO-NUMBER 1 10>>
			<COND (<OR .MINIMUM .MAXIMUM>
				<COND (<AND <G=? .COUNT .MINIMUM> <L=? .COUNT .MAXIMUM>> <RETURN>)>
			)(<G? .COUNT 0>
				<RETURN>
			)>
		)>
	>
	<RETURN .COUNT>>

<ROUTINE DELETE-CODEWORD (CODEWORD)
	<COND (<AND .CODEWORD <CHECK-CODEWORD .CODEWORD>>
		<CRLF>
		<TELL "[You lose the codeword ">
		<HLIGHT ,H-BOLD>
		<TELL D .CODEWORD "]" CR>
		<HLIGHT 0>
		<REMOVE .CODEWORD>
	)>>

<ROUTINE KEEP-ITEM (ITEM "OPT" JUMP)
	<CRLF>
	<TELL "Keep " T .ITEM "?">
	<COND (<YES?>
		<COND (<NOT <CHECK-ITEM .ITEM>> <TAKE-ITEM .ITEM>)>
		<COND (.JUMP <STORY-JUMP .JUMP>)>
		<RTRUE>
	)>
	<COND (<CHECK-ITEM .ITEM> <LOSE-ITEM .ITEM>)>
	<RFALSE>>

<ROUTINE TEST-MORTALITY (DAMAGE MESSAGE "OPT" STORY SKILL)
	<COND (<NOT .STORY> <SET STORY ,HERE>)>
	<COND (
		<AND
			<EQUAL? .SKILL ,SKILL-CLOSE-COMBAT>
			<CHECK-SKILL .SKILL>
			<CHECK-ITEM ,SHORTSWORD>
			,PRACTICED-SHORTSWORD 
		>
		<EMPHASIZE "The shortsword prevented 1 damage">
		<SET DAMAGE <- .DAMAGE 1>>
	)>
	<COND (<G? .DAMAGE 0>
		<LOSE-LIFE .DAMAGE .MESSAGE .STORY>
	)(ELSE
		<PUTP .STORY ,P?DEATH F>
	)>>

<ROUTINE FIRE-BARYSAL ("OPT" AMOUNT "AUX" (CHARGES 0))
	<COND (<NOT .AMOUNT> <SET AMOUNT 1>)>
	<SET CHARGES <GETP ,BARYSAL-GUN ,P?CHARGES>>
	<COND (<G? .CHARGES 0>
		<SET CHARGES <- .CHARGES .AMOUNT>>
		<COND (<L? .CHARGES 1> <SET CHARGES 0>)>
		<PUTP ,BARYSAL-GUN ,P?CHARGES .CHARGES>
	)>>

<CONSTANT MAX-BARYSAL 6>

<ROUTINE CHARGE-BARYSAL ("OPT" AMOUNT "AUX" CHARGES)
	<COND (<NOT .AMOUNT> <SET AMOUNT 1>)>
	<SET CHARGES <GETP ,BARYSAL-GUN ,P?CHARGES>>
	<SET CHARGES <+ .CHARGES .AMOUNT>>
	<COND (<G? .CHARGES ,MAX-BARYSAL> <SET CHARGES ,MAX-BARYSAL>)>
	<PUTP ,BARYSAL-GUN ,P?CHARGES .CHARGES>>

<ROUTINE TAKE-BARYSAL ("OPT" AMOUNT)
	<COND (<NOT .AMOUNT> <SET AMOUNT 1>)>
	<PUTP ,BARYSAL-GUN ,P?CHARGES .AMOUNT>
	<TAKE-ITEM ,BARYSAL-GUN>>

<ROUTINE TAKE-OR-CHARGE ("OPT" AMOUNT PROMPT PLURAL "AUX" TAKEN)
	<COND (<NOT .AMOUNT> <SET AMOUNT 1>)>
	<COND (<NOT .PLURAL> <SET PLURAL 1>)>
	<COND (<AND .PROMPT <G? .PLURAL 1>>
		<SET TAKEN <GET-NUMBER "You many barysal guns will you take?" 0 .PLURAL>>
		<COND (<L=? .TAKEN 0>
			<RETURN 0>
		)(ELSE
			<SET PROMPT F>
			<SET AMOUNT <* .TAKEN .AMOUNT>>
			<SET PLURAL .TAKEN>
		)>
	)>
	<COND (.PROMPT <CRLF>)>
	<COND (<CHECK-ITEM ,BARYSAL-GUN>
		<COND (.PROMPT
			<TELL "Take " T ,BARYSAL-GUN>
			<COND (<G? .PLURAL 1> <TELL "s' (" N .PLURAL ")">)(ELSE <TELL "'s">)>
			<TELL " remaining ">
			<COND (<G? .AMOUNT 1> <TELL N .AMOUNT " charges">)(ELSE <TELL "charge">)>
			<TELL "?">
			<COND (<YES?>
				<CHARGE-BARYSAL .AMOUNT>
				<RETURN .PLURAL>
			)>
		)(ELSE
			<CHARGE-BARYSAL .AMOUNT>
			<RETURN .PLURAL>
		)>
	)(ELSE
		<COND (.PROMPT
			<TELL "Take " T ,BARYSAL-GUN>
			<COND (<G? .PLURAL 1> <TELL "s (" N .PLURAL ")">)>
			<TELL " (" N .AMOUNT " charge">
			<COND (<G? .AMOUNT 1> <TELL "s">)>
			<TELL " left)?">
			<COND (<YES?>
				<TAKE-BARYSAL .AMOUNT>
				<RETURN .PLURAL>
			)>
		)(ELSE
			<TAKE-BARYSAL .AMOUNT>
			<RETURN .PLURAL>
		)>
	)>
	<RETURN 0>>

<ROUTINE ADD-QUANTITY (OBJECT "OPT" AMOUNT CONTAINER "AUX" QUANTITY CURRENT)
	<COND (<NOT .OBJECT> <RETURN>)>
	<COND (<L=? .AMOUNT 0> <RETURN>)>
	<COND (<NOT .CONTAINER> <SET CONTAINER ,PLAYER>)>
	<COND (<EQUAL? .CONTAINER ,PLAYER>
		<DO (I 1 .AMOUNT)
			<TAKE-ITEM .OBJECT>
		>
	)(ELSE
		<SET CURRENT <GETP .OBJECT ,P?QUANTITY>>
		<SET QUANTITY <+ .CURRENT .AMOUNT>>
		<PUTP .OBJECT ,P?QUANTITY .QUANTITY>
	)>>

<ROUTINE ADD-FOOD-PACK ("OPT" AMOUNT)
	<ADD-QUANTITY ,FOOD-PACK .AMOUNT ,PLAYER>>

<ROUTINE BUY-FOOD-PACK (PRICE "AUX" QUANTITIES)
	<COND (<G=? ,MONEY .PRICE>
		<CRLF>
		<TELL "Buy a food pack for " N .PRICE " scads each?">
		<COND (<YES?>
			<REPEAT ()
				<SET QUANTITIES <GET-NUMBER "How many food packs will you buy" 0 8>>
				<COND (<G? .QUANTITIES 0>
					<COND (<L=? <* .QUANTITIES .PRICE> ,MONEY>
						<CRLF>
						<HLIGHT ,H-BOLD>
						<TELL "You purchased " N .QUANTITIES>
						<TELL " " D ,FOOD-PACK>
						<COND (<G? .QUANTITIES 1> <TELL "s">)>
						<TELL ,PERIOD-CR>
						<CHARGE-MONEY <* .QUANTITIES .PRICE>>
						<ADD-FOOD-PACK .QUANTITIES>
						<COND (<L? ,MONEY .PRICE> <RETURN>)>
					)(ELSE
						<EMPHASIZE "You can't afford that!">
					)>
				)(ELSE
					<RETURN>
				)>
			>
		)>
	)>>

<ROUTINE TAKE-FOOD-PACKS ("OPT" AMOUNT "AUX" PACKS)
	<COND (<NOT .AMOUNT> <SET .AMOUNT 1>)>
	<CRLF>
	<TELL "Take " T ,FOOD-PACK>
	<COND (<G? .AMOUNT 1> <TELL "s">)>
	<TELL "?">
	<COND (<YES?>
		<COND (<G? .AMOUNT 1>
			<SET PACKS <GET-NUMBER "How many food packs will you take" 0 .AMOUNT>>
			<ADD-FOOD-PACK .PACKS>
			<RETURN .PACKS>
		)(ELSE
			<TAKE-ITEM ,FOOD-PACK>
			<RETURN 1>
		)>
	)>
	<RETURN 0>>

<ROUTINE CONSUME-FOOD ("OPT" AMOUNT JUMP "AUX" QUANTITY (RETURN-VALUE F))
	<COND (<NOT .AMOUNT> <SET AMOUNT 1>)>
	<COND (<CHECK-ITEM ,FOOD-PACK>
		<SET QUANTITY <GETP ,FOOD-PACK ,P?QUANTITY>>
		<COND (<G? .QUANTITY 0>
			<SET QUANTITY <- .QUANTITY .AMOUNT>>
			<PUTP ,FOOD-PACK ,P?QUANTITY .QUANTITY>
			<COND (<G=? .QUANTITY 1>
				<CRLF>
				<HLIGHT ,H-BOLD>
				<TELL "[Your supply of food packs decreased by " N .AMOUNT "]" CR>
				<HLIGHT 0>
			)(ELSE
				<EMPHASIZE "[You've exhausted your food packs]">
			)>
			<COND (.JUMP <STORY-JUMP .JUMP>)>
			<SET RETURN-VALUE T>
		)>
		<COND (<L? .QUANTITY 1>
			<PUTP ,FOOD-PACK ,P?QUANTITY 1>
			<REMOVE ,FOOD-PACK>
		)>
	)>
	<RETURN .RETURN-VALUE>>

<ROUTINE TAKE-QUANTITIES (OBJECT PLURAL MESSAGE "OPT" AMOUNT)
	<CRLF>
	<TELL "Take the " .PLURAL "?">
	<COND (<YES?> <ADD-QUANTITY .OBJECT <GET-NUMBER .MESSAGE 0 .AMOUNT> ,PLAYER>)>>

<ROUTINE CHECK-VEHICLE (RIDE)
	<COND (<OR <IN? .RIDE ,VEHICLES> <AND ,CURRENT-VEHICLE <EQUAL? ,CURRENT-VEHICLE .RIDE>>> <RTRUE>)>
	<RFALSE>>

<ROUTINE TAKE-VEHICLE (VEHICLE)
	<COND (.VEHICLE
		<COND (,CURRENT-VEHICLE <REMOVE ,CURRENT-VEHICLE>)>
		<MOVE .VEHICLE ,VEHICLES>
		<SETG CURRENT-VEHICLE .VEHICLE>
		<UPDATE-STATUS-LINE>
	)>>

<ROUTINE LOSE-VEHICLE (VEHICLE)
	<COND (.VEHICLE
		<COND (<CHECK-VEHICLE .VEHICLE>
			<REMOVE .VEHICLE>
			<SETG CURRENT-VEHICLE NONE>
			<UPDATE-STATUS-LINE>
		)>
	)>>

<ROUTINE ASSASSINS-LOOT (KNIVES AMOUNT)
	<TAKE-QUANTITIES ,KNIFE "knives" "How many of the assassins' knives will you take" .KNIVES>
	<CRLF>
	<TELL "Take the money on the dead man's body (" N .AMOUNT " scads)?">
	<COND (<YES?> <GAIN-MONEY .AMOUNT>)>>

<OBJECT LOST-SKILLS
	(DESC "skills lost")
	(SYNONYM SKILLS)
	(ADJECTIVE LOST)
	(FLAGS CONTBIT OPENBIT)>

<ROUTINE LOSE-SKILL (SKILL)
	<COND (<AND .SKILL <CHECK-SKILL .SKILL>>
		<CRLF>
		<HLIGHT ,H-BOLD>
		<TELL "You lost " T .SKILL " skill">
		<TELL ,PERIOD-CR>
		<HLIGHT 0>
		<MOVE .SKILL ,LOST-SKILLS>
	)>>

<ROUTINE RESET-RETROVIRUS ()
	<PUTP ,VIRID-MYSTERY ,P?PURCHASED F>
	<PUTP ,EXALTED-ENHANCER ,P?PURCHASED F>
	<PUTP ,MASK-OF-OCCULTATION ,P?PURCHASED F>
	<PUTP ,PEERLESS-PERCEPTIVATE ,P?PURCHASED F>>

<ROUTINE MALENGIN-BUSINESS ("AUX" KEY ITEMS ITEM VIRUS PRICE ACTIVATE)
	<RESET-CONTAINER ,LOST-SKILLS>
	<REPEAT ()
		<RESET-TEMP-LIST>
		<SET ITEMS 0>
		<COND (<NOT <GETP ,VIRID-MYSTERY ,P?PURCHASED>> <SET ITEMS <+ .ITEMS 1>> <PUT ,TEMP-LIST .ITEMS ,VIRID-MYSTERY>)>
		<COND (<NOT <GETP ,EXALTED-ENHANCER ,P?PURCHASED>> <SET ITEMS <+ .ITEMS 1>> <PUT ,TEMP-LIST .ITEMS ,EXALTED-ENHANCER>)>
		<COND (<NOT <GETP ,MASK-OF-OCCULTATION ,P?PURCHASED>> <SET ITEMS <+ .ITEMS 1>> <PUT ,TEMP-LIST .ITEMS ,MASK-OF-OCCULTATION>)>
		<COND (<NOT <GETP ,PEERLESS-PERCEPTIVATE ,P?PURCHASED>> <SET ITEMS <+ .ITEMS 1>> <PUT ,TEMP-LIST .ITEMS ,PEERLESS-PERCEPTIVATE>)>
		<COND (<AND <G? .ITEMS 0> <G? ,MONEY 3>>
			<CRLF>
			<HLIGHT ,H-BOLD>
			<TELL "Malengin: ">
			<HLIGHT 0>
			<TELL "Select which retrovirus to purchase:" CR>
			<DO (I 1 .ITEMS)
				<HLIGHT ,H-BOLD>
				<TELL N .I>
				<HLIGHT 0>
				<TELL " - " D <GET ,TEMP-LIST .I> " (" N <GETP <GET ,TEMP-LIST .I> ,P?PRICE> " " D ,CURRENCY ")" CR>
			>
			<HLIGHT ,H-BOLD>
			<TELL "C">
			<HLIGHT 0>
			<TELL " - View your character (" D ,CURRENT-CHARACTER ")" CR>
			<HLIGHT ,H-BOLD>
			<TELL "G">
			<HLIGHT 0>
			<TELL " - Display Skills Glossary" CR>
			<HLIGHT ,H-BOLD>
			<TELL "0">
			<HLIGHT 0>
			<TELL " - Bye" CR>
			<TELL "You are carrying " N ,MONEY " " D ,CURRENCY ": ">
			<REPEAT ()
				<SET KEY <INPUT 1>>
				<COND (
					<OR
						<AND <G=? .KEY !\1> <L=? .KEY !\9> <L=? <- .KEY !\0> .ITEMS>>
						<AND ,CHARACTERS-ENABLED <OR <EQUAL? .KEY !\c !\C> <EQUAL? .KEY !\i !\I>>>
						<EQUAL? .KEY !\G !\g !\h !\H !\? !\0>
					>
					<RETURN>
				)>
			>
			<CRLF>
			<COND (<AND ,CHARACTERS-ENABLED <EQUAL? .KEY !\c !\C>> <DESCRIBE-PLAYER> <PRESS-A-KEY>)>
			<COND (<AND ,CHARACTERS-ENABLED <EQUAL? .KEY !\G !\g>> <PRINT-SKILLS>)>
			<COND (<AND <G? .KEY 48> <L? .KEY <+ .ITEMS 49>>>
				<SET ITEM <- .KEY 48>>
				<SET VIRUS <GET ,TEMP-LIST .ITEM>>
				<SET PRICE <GETP .VIRUS ,P?PRICE>>
				<SET ACTIVATE <GETP .VIRUS ,P?ACTION>>
				<CRLF>
				<TELL "Purchase " D .VIRUS " (" N .PRICE " " D ,CURRENCY ")?">
				<COND (<YES?>
					<CRLF>
					<HLIGHT ,H-BOLD>
					<COND (<L? ,MONEY .PRICE>
						<TELL "You can't afford " T .VIRUS ,EXCLAMATION-CR>
					)(ELSE
						<SETG MONEY <- ,MONEY .PRICE>>
						<TELL "You bought " T .VIRUS ,PERIOD-CR>
						<PUTP .VIRUS ,P?PURCHASED T>
						<APPLY .ACTIVATE>
						<PRESS-A-KEY>
					)>
				)>
				<UPDATE-STATUS-LINE>
			)(<EQUAL? .KEY !\0>
				<CRLF>
				<TELL "Are you sure?">
				<COND (<YES?> <RETURN>)>
			)>
		)(ELSE
			<EMPHASIZE "There are no retrovirus potions left.">
			<RETURN>
		)>
	>>

<CONSTANT TEXT "This story has not been written yet.">

<CONSTANT BACKGROUND-TEXT "In 2023, worsening conditions in the world's climate led to the first Global Economic Conference. It was agreed to implement measures intended to reverse industrial damage to the ecology and replenish the ozone layer. By 2031, an array of weather control satellites were in orbit. For added efficiency, and as a mark of worldwide cooperation, these were placed under the control of a supercomputer network called Gaia: the Global Artificial Intelligence Array. The Earth's climate began to show steady improvement.||The first hint of disaster came early in 2037, when Gaia shut down inexplicably for a period of seventeen minutes. Normal operation was resumed but the system continued to suffer 'glitches'. One such glitch resulted in Paris being subjected to a two-day heat wave of such intensity that the pavements cracked. After several months, the fault was identified. A computer virus had been introduced into Gaia by unknown means. The system's designer began programming an antivirus but died before his war was complete. The crisis grew throughout that year until finally, following the death of five thousand people in a flash flood along the Bangladesh coastline, the Gaia project was officially denounced. Unfortunately, it was no longer possible to shut it down.||By the mid twenty-first century, global weather conditions were in chaos owing to Gaia's sporadic operation. Ice sheets advanced further each year. Australia was subject to virtually constant torrential rain. The centre of Asia had become an arid wasteland. The political situation reflected the ravages of the climate, with wars flaring continually around the globe. Late in 2054, computer scientists in London tried to hack into Gaia and locate the replicating viruses in the program. Gaia, detecting this, interpreted the action as an attack on its program and retaliated by taking over a range of defense networks which allowed it to launch a nuclear strike. London was completely destroyed.||By the end of the century Gaia had routed itself into all major computer networks, taking control of weather, communications and weapons systems all across the planet. Periods of lucidity and hospitable climate were interspersed with hurricanes and arctic blizzards. The US President gave an interview in which he likened Gaia to a living entity: \"She was intended as mankind's protective mother, but this 'mother' has gone mad.\" Spiralling decline in the world's fortunes left much of humanity on the brink of extinction. The population fell rapidly until only a few million people remained scattered around the globe -- mostly in cities where food could still be artificially produced.||It is now the year 2300. The rich stand aloof, disporting themselves with forced gaiety and waiting for the end. The poor inhabit jostling slums where disease is rife and law is unknown. Between the cities, the land lies under a blanket of snow and ice. No-one expects humanity to last another century. This is truly 'the end of history'.">

<ROOM BACKGROUND
	(DESC "THE LAST THREE CENTURIES")
	(STORY BACKGROUND-TEXT)
	(CONTINUE PROLOGUE)
	(FLAGS LIGHTBIT)>

<CONSTANT PROLOGUE-TEXT "The Etruscan Inn lies in the shadow of the Apennine Mountains, beside a frozen waterfall, sheltered from the wind by a high ridge of bare black rock. You stand at a long window and gaze out towards the mountains. Dusk is melting the sharp outlines of the crags, filling the valleys with blue gloom. The moon glimmers faintly under racing black clouds. Later this evening there will be more snow.||Turning from the window, you let the curtain fall back and make your way across the dingy room. Travellers sit at the sides, noisily gambling and sipping hard liquor the colour of fire. Many are hunters and traders from the plains which slope down from here to the Ligurian Sea. Others may have been here much longer: thin old men and women who found meagre employment. The Etruscan Inn is a famous stop-over for those who undertake the perilous Apennine crossing. If a few such, gazing up at the ice-capped peaks, found their spirits daunted and chose to stay, who can blame them? You sometimes wonder yourself why you bother to press on across the world in the teeth of such hardship and poverty.||The story of how the inn came to be here is a strange one, even for these bizarre times. The building was originally an air cruiser which crashed in the mountains two hundred years ago. An ancestor of the present innkeeper turned the wreckage into a hostelry for wayfarers. The power unit had not been damaged in the crash, so the inn has electricity -- a rarity in the modern world. Even better, several of the air cruiser's careteks were salvaged. These are robots which continually clean and repair the structure, sturdily carrying out the tasks they were programmed to do centuries ago.||Pushing aside a drape, you step into another room. On the wall, a screen flickers with scenes from an old film. The innkeeper is sitting with a few others at the back, loudly commenting on the action. You step over a caretek which resembles a long metal cockroach. It extends polishing pads to clean the floor where you were standing. Propping yourself against the wall, you watch the film for a few minutes, but the innkeeper's shouts and jeers are impossible to ignore. When you complain, he only gives a great gusting laugh and says, \"There's no point in getting interested in any film that appears on this screen. The video link comes from a satellite connected to Gaia, who changes channels as the whim strikes her. Sometimes I have seen newsreel footage over a century old. At other times there are films, musical shows, or documentaries. But I have yet to see the end of any programme. There -- !\"He points at the screen and, turning, you see that the film has been replaced by a blizzard of grey static.||\"Turn it off, can't you?\" growls a man from the adjacent room. \"Some of us would like to get to sleep.\"||\"Turn it off, you say?\" The innkeeper bellows with laughter at this. \"It hasn't been off in all the time I've been alive. It can't be turned off. Not unless Gaia decides to take pity on us and give us a few hours' peace.\"||An angrily florid-faced man stamps through from the other room and glowers at the screen, which has now changed to show a weather report for the coming month. \"Preposterous!\" he snarls in outrage. \"It says New York will be having thunderstorms. There has been no rain in New York for years. It is buried under half a mile of ice!\"||The innkeeper only chuckles and goes about his chores. \"Don't blame me,\" he says. \"Everyone knows Gaia is mad.\"||The man whose rest was disturbed glares after him and protests: \"If you can't turn it off, why not smash the screen? It only shows gibberish anyhow.\"||Seeing the man step forward as if to do just that, the innkeeper wags a finger at him. \"I'd advise you to leave it as it is. Stick wads of wool in your ears if the noise disturbs you. But if you smash the screen, the careteks will spend the whole night repairing it and none of us will get any sleep, what with there scuttling about and the clattering of spare parts.\"||Hearing this, the man throws up his arms in exasperation and, gathering his blankets, stomps off to sleep at the far end of the inn.||Night falls. The drunken roistering turns to low murmurs, then snores. You huddle on your own bedding and listen to the moaning of the wind outside the fuselage. Tomorrow you have to set out again into the cold. It is not a pleasant prospect.||From the adjacent room you can hear the screen crackling with incessant babble. There is a part of a game show probably taped before your great-grandfather was born, followed by clips from science fiction films of the twenty-first century. You are thirsty and you cannot sleep. Ignoring the mumbled complaints of the people stretched out around you, you get up and step over them, moving through to the room where the screen is.||You sit down. Maybe a half hour of random videos will cure your insomnia. Then the screen changes. It is a news report from the year 2095. The main item concerns the crash of an air cruiser in the Apennine mountains. You sit forward in your seat, intrigued. Pictures taken from the air reveal the broken tangle of wreckage that was later repaired to form this inn.||Suddenly the picture changes. \"In another item today,\" says the announcer's voice, \"scientists studying the meteor that fell in Egypt last month say that it may be the oldest object in the universe. These pictures show the safety suits that are needed to approach the meteor, which emits radiation of a type never previously identified.\"||The screen flickers to a date months later. A reporter is standing at a roadside, an armoured truck blazing in the background. \"Terrorists of the sect known as the Volentine Watchers today seized the mysterious meteor as it was being transported to Cairo for further tests. The terrorists, who worship the meteor which they call the Heart of Volent, have yet to issue a statement.\"||The screen crackles again, becoming a rich green colour with the outline of the world's continents in red -- the continents as they looked before the sea-level fell and the polar caps crept down to cover them.||A warm feminine voice speaks: \"The Heart of Volent remained in the hands of the cultists for twenty years. They founded the city of Du-En in the Sahara and learned how to tap the Heart's power, which they used to devastating effect in the Paradox War. Later Du-En suffered civil war and became abandoned. I have now completed analysis of the scientific tests carried out before the Heart was seized by the cultists. These are my findings. If a sentient creature were to make direct physical contact with the Heart, this would release the full energy stored within. The effect would be to activate that creature's total psychic potential. In effect they would gain ultimate power over their surroundings. This has been a communication from Gaia. Thank you for your attention.\"||The screen goes blank and silent for a moment, then starts to show a cartoon. You hardly notice it. You are too awestruck by the realization that you have just heard the voice of Gaia.||What she said begins to sink in. Ultimate power... It lies somewhere in the ruined city of Du-En, across the Saharan Ice Wastes. Suddenly wary, you look at the sleeping forms stretched out around the room. Did anyone else hear Gaia's broadcast? You listen to the snores, the drone of slow regular breathing. No one shows any sign of being awake. Plunged in thought, you return to your blanket and stretch out, but now sleep is even harder to come by. When you finally doze off just a few hours before dawn, your dreams are filled with images of the strange meteor from space and he power that it contains.||Will you go to Du-En and seek the Heart? Are you tempted by a power that could change the whole world?">

<ROOM PROLOGUE
	(DESC "PROLOGUE")
	(STORY PROLOGUE-TEXT)
	(CONTINUE STORY001)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT001 "You are packed and ready to leave the inn at dawn. Cold grey light seeps in through the row of dusty portholes at the side of the common room. Making your way to the door, you find the innkeeper polishing the antique Formica desk. Seeing you set your pack down beside the door, he comes over and kicks away one of the careteks which had its metal body pressed down across the door-sill.||\"You're lucky having those,\" you say, pushing the door open a crack to take a breath of fresh icy air.||The innkeeper grunts as he watches the caretek reorient itself and glide away across the floor. \"They are a mixed blessing, since they insist on trying to repair the inn to the form it had originally. This door is a feature that I added myself, more convenient than the hatchway at the back of the fuselage. But if I leave it unattended for more than a few hours at a time, those wretched careteks always try to weld it shut.\"||You smile to show that you sympathise. \"I'd be grateful for some advice. I'm now travelling on to the Sahara. What is the best route?\"||The innkeeper flings the door wide, ignoring the curses that erupt from his customers at the sudden intrusion of cold air. Gazing across the expanse of dazzling white snow, he says, \"The most obvious course would take you to Venis, where you could board the ferry for Kahira, and yet...\@ He rubs his hands, blowing out a long furl of steam in the chill air. \"Myself, I'd be tempted to go instead through the Lyonesse jungle, just to savour a bit of warmth in this frigid world. Thence across the Jib-and-Halter and the Atlas Mountains -- unless you stumbled across the ruins of lost Marsay, of course, in which case you might even find a tube tunnel to take you straight to the Sahara.\"||Thanking the innkeeper for his advice, you indicate that you are ready to pay your bill. He looks at you in surprise and points to a small dapper man in a grey-trimmed white snowsuit. \"Your friend there has already paid.\"||At this, the small man comes over and extends his hand, smiling broadly. \"Hello. My name is Kyle Boche. I believe we're travelling in the same direction.\"">
<CONSTANT CHOICES001 <LTABLE "accept Kyle Boche as your companion on the road" "tell him that you prefer to travel alone">>

<ROOM STORY001
	(DESC "001")
	(STORY TEXT001)
	(CHOICES CHOICES001)
	(DESTINATIONS <LTABLE STORY023 STORY045>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT002 "The figure emerges from the darkness like a ghost. It is wrapped in a rough cape of stitched furs, its shrivelled frame sprouting a spindly neck which supports a large soft head like a leather bag. Pushing back its hood, it reveals a hideous face dominated by a single glowing eye on a flexible stalk.||Boche scrambles to the side of the ledge and then freezes, mesmerized by the creature's eye. The stalk swivels, turning the lethal gaze towards you.">
<CONSTANT TEXT002-END "It is too late to act, and you are plunged into a hypnotic trance from which you will never recover">

<ROOM STORY002
	(DESC "002")
	(STORY TEXT002)
	(PRECHOICE STORY002-PRECHOICE)
	(CONTINUE STORY112)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY002-PRECHOICE ()
	<LOSE-ITEM ,STUN-GRENADE>
	<COND (<CHECK-SKILL ,SKILL-AGILITY>
		<PREVENT-DEATH ,STORY002>
	)(ELSE
		<CRLF>
		<TELL ,TEXT002-END>
		<TELL ,PERIOD-CR>
	)>>

<CONSTANT TEXT003 "The passage is lit by gleaming blue-white tubes along the ceiling. They cast a garish glare in which the sight of a dead body ahead seems like a glimpse of a night mare. Boche and the baron watch while you stoop and inspect the corpse. You roll it over, surprised at how well the shrivelled flesh has kept in the cold air. \"His own mother could still recognize him,\" you remark with grim humour.||\"Except she'll have been dead two centuries as well,\" says Boche. He gazes off along the corridor, then gives a start. \"There's another one!\"||The baron sweeps on ahead and hovers low over the next body. \"He died of a broken back.\"|\"So did that first one,\" you say as you come hurrying up with Boche.||A metallic scuttling sound resounds from the far end of the passage. Instantly your whole body is tensely alert, nerves jangling in fear of the unknown. Then you see it approaching along the passage like a giant robot spider: the body a glass bubble filled with blue fluid, surrounded by legs formed from long articulated steel pipes. Inside the glass bubble floats a lumpish embryonic figure pierced by many tubes. Its eyes are open and it is watching you.||Boche gives a gasp of disgust and fires his barysal gun at the glass bubble. But the thing has already raised a row of its legs to form a shield, and the blast splashes away leaving hardly a mark.||\"I think we'd better run,\" he says backing away.">
<CONSTANT CHOICES003 <LTABLE "try and outwit the thing" "confront it" "use" "hurl a" "otherwise your only option is to retreat and take the other passage">>

<ROOM STORY003
	(DESC "003")
	(STORY TEXT003)
	(CHOICES CHOICES003)
	(DESTINATIONS <LTABLE STORY040 STORY062 STORY084 STORY106 STORY128>)
	(REQUIREMENTS <LTABLE SKILL-CUNNING SKILL-AGILITY SKILL-PARADOXING STUN-GRENADE NONE>)
	(TYPES <LTABLE R-SKILL R-SKILL R-SKILL R-LOSE-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT004 "The two men make no move to stop you as you dart through into the steam room. A moment later you realize why, when they wedge the door shut and peer in through the narrow glass partition with mocking leers, \"Cook in there like a prawn, then,\" they laugh. \"It only makes our job all the easier!\"||Engulfed in a cloud of chokingly hot steam, you slump onto the bench at the back of the room. You are trapped. Condensation patters off the wooden roof-beams; sweat soaks you within moments, plastering your hair to your scalp. As the minutes tick by, you listen to the assassins chattering cheerfully just outside the door. They know that they only have to bide their time. Soon you will be too weak to put up any fight.">
<CONSTANT TEXT004-END "You lie gasping until the assassins enter and finish you off at last">
<CONSTANT CHOICES004 <LTABLE "use" "use">>

<ROOM STORY004
	(DESC "004")
	(STORY TEXT004)
	(PRECHOICE STORY004-PRECHOICE)
	(CHOICES CHOICES004)
	(DESTINATIONS <LTABLE STORY158 STORY180>)
	(REQUIREMENTS <LTABLE SKILL-PARADOXING SKILL-SURVIVAL>)
	(TYPES <LTABLE R-SKILL R-SKILL>)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY004-PRECHOICE ()
	<COND (<OR <CHECK-SKILL ,SKILL-PARADOXING> <CHECK-SKILL ,SKILL-SURVIVAL>>
		<PREVENT-DEATH ,STORY004>
	)(ELSE
		<CRLF>
		<TELL ,TEXT004-END>
		<TELL ,PERIOD-CR>
	)>>

<CONSTANT TEXT005 "You step through into what seems to be a recreation room, with padded couches set around low glass-topped tables. At the far end of the room, a row of couches is set facing a screen on the wall. An image flickers into sharp clarity, but it takes you a moment to identify the wary, baffled-looking figure in the picture. It is you.||You glance at the camera mounted on the wall, then back at the screen. The picture changes to show other views: the parked Manta sky-car, the outer door, the gondo trudging up and down in the snow outside.||\"Who spoke?\" you say, feeling uneasy at calling out to an empty room.||\"I did.\" The voice comes from the screen.||\"Gaia?\"||\"Yes. Attend, as there is little time before I fall again to the darkness. You must go to Giza.\" The screen flickers to show another scene, now of the pyramids against a backdrop of crystal night. \"The word 'humbaba' is the key to entry. Find Gilgamesh and activate him. He will be your servant in the race for the Heart.\"||\"Race? So others are seeking the Heart?\"||\"Yes. The broadcast you received was seen by man across the globe. The mightiest of this age will compete for the power. That is the way of mankind.\" Gaia gives a sound that might almost be a sigh, then speaks more quickly. \"I am working to secure an area of my mind that will be protected against the viruses that beset me. I will speak again to you when it is easier.\"||The screen suddenly goes blank. Gaia is no longer present.">
<CONSTANT CHOICES005 <LTABLE "take a look at the sky car" "leave">>

<ROOM STORY005
	(DESC "005")
	(STORY TEXT005)
	(CHOICES CHOICES005)
	(DESTINATIONS <LTABLE STORY049 STORY395>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-HUMBABA)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT006 "The library is a huge series of halls in the basement of the building. The air is dry and musty, and green-shaded lamps blaze at intervals above the imitation walnut desks. In addition to the thousands of books, there are two or three computer terminals of antique design.">
<CONSTANT CHOICES006 <LTABLE "try to establish contact with Gaia" "read up concerning the Heart of Volent" "you can leave the library">>

<ROOM STORY006
	(DESC "006")
	(STORY TEXT006)
	(PRECHOICE STORY006-PRECHOICE)
	(CHOICES CHOICES006)
	(DESTINATIONS <LTABLE STORY138 STORY182 STORY073>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY006-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-CYBERNETICS>
		<SET-DESTINATION ,STORY006 1 ,STORY116>
	)(ELSE
		<SET-DESTINATION ,STORY006 1 ,STORY138>
	)>
	<COND (<CHECK-SKILL ,SKILL-LORE>
		<SET-DESTINATION ,STORY006 2 ,STORY160>
	)(ELSE
		<SET-DESTINATION ,STORY006 2 ,STORY182>
	)>>

<CONSTANT TEXT007 "The elevator arrives at the lobby and the doors slide open, but the waiting security guards are amazed to find it empty. The security chief barks an order: \"Get upstairs! Check the other floors!\"||You hear them go charging up the stairs. Waiting until the coast is clear, you lower your back down through the access hatch on on top of the elevator car. Ignoring the spluttered protests of the receptionist, you dart out into the safety of the night.">

<ROOM STORY007
	(DESC "007")
	(STORY TEXT007)
	(CONTINUE STORY311)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT008 "During your march east you have taken an hour or two each day to practice with the shortsword. The exercise has helped keep you warm, as well as acquainting you with the feel of your new weapon. Now you can use the shortsword in any hand to hand fight, its effect being to reduce any injury you take by 1 Life Point.">

<ROOM STORY008
	(DESC "008")
	(STORY TEXT008)
	(PRECHOICE STORY008-PRECHOICE)
	(CONTINUE STORY334)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY008-PRECHOICE ()
	<SETG PRACTICED-SHORTSWORD T>>

<CONSTANT TEXT009 "A short distance along one of the tunnels you find a doorway. While Fax looks on with fluttering gestures of protest, you force the door and enter a small computer room. A caretek is crawling across the banks of equipment, dutifully sweeping away the dust. You log into the computer. As you suspected, it maintains the city's generator and lighting systems, as well as hydroponic gardens which are presumably the ultimate source of food here.||Fax screws up enough courage to peer over your shoulder. \"What are you doing?\"||Your fingers flit across the keyboard. \"Trying to find if there's a communication line to the outside world still working anywhere in the city. Ah, here's one. Now I'm going to contact Gaia.\"||Fax utters a doleful bleat. \"Surely Gaia is mad? You are rash to draw her attention. She might switch off the sun!\"">
<CONSTANT CHOICES009 <LTABLE "attempt to contact Gaia" "agree that the risk is too great and either explore the transit tunnels" "else leave Marsay and continue west">>

<ROOM STORY009
	(DESC "009")
	(STORY TEXT009)
	(CHOICES CHOICES009)
	(DESTINATIONS <LTABLE STORY336 STORY439 STORY420>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT010 "At dawn the ferry enters the Isis estuary and skims upriver towards Kashira. Taking a stroll on the deck, you notice a waft of warmth rising from the river. It eases the bitter chill of the morning air. Questioning one of the sailors, you learn that heating pipes are laid along the river bed. No one knows the source of energy, but the effect is to keep the Isis from freezing, with the result that river-plants and fish are more plentiful than you would expect. \"That is the basis of Kahira's prosperity,\" he tells you. \"But one day the pipes will fail. Then the river will freeze and Kahira must die.\"||You glance to the east, where the sun struggles morosely behind a drape of stern grey cloud. \"That is the whole world's eventual fate.\"||Kahira hoves into view around a bend in the river. It stands on massive concrete buttresses straddling the Isis, a huge fortress-city with towers like spines along its back, looking like a beast of mechanical Armageddon against the wintry surroundings. The ferry glides to a halt, the gang-ramp is extended, and you disembark in front of the city gates.">

<ROOM STORY010
	(DESC "010")
	(STORY TEXT010)
	(PRECHOICE STORY010-PRECHOICE)
	(CONTINUE STORY229)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY010-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-DIAMOND> <STORY-JUMP ,STORY251>)>>

<CONSTANT TEXT011 "The fog makes the buildings across the plaza look like lace cut-outs against the night sky. You cross to a line of lights under a colonnade, your footsteps ringing on the slick cobblestones. Finding a row of shops and stalls, you search until you find an answer to your question. \"Seek at the rooms of Pinar the Copt,\" advises a stall-holder, pointing to a narrow door at the end of the colonnade\"He knows the answer to all mysteries.\"||Pindar seems to be a local fortune-teller and spinner of yarns. You stand at his door for a few moments, looking at the faded bronze plaque, then step inside. The room is hung with jewel-bright rugs and the air smells of must and incense. Three crabbed old men look up from their hubble-bubble pipe. Without asking your business, they wave you to a cushion.||You sit down. \"Tell me about the Sphinx.\"||\"She asked a riddle of all who passed, and those who failed to answer were devoured,\" says one of the old men.||\"The answer to her riddle was Man himself,\" says another.||Now Pinar speaks. \"That was the Greek Sphinx. The Egyptian Sphinx is male. He sits at Giza and watches over Kahira, keeping the Saharan snows from overrunning the city.\"||You smile. \"These are only stories.\"||\"Not the last part,\" insists Pindar in a pragmatic tone. \"A nuclear reactor is set under the Sphinx, and that is what powers the heating elements that keep the Isis River from freezing. The same reactor presumably still supplies power to the military complex inside the Great Pyramid.\"||Giving him a keen look, you say, \"You seem well informed.\"||\"I have lived a long time. If you are interested, the answer to the Sphinx's riddle these days is 'Humbaba'.\"">

<ROOM STORY011
	(DESC "011")
	(STORY TEXT011)
	(PRECHOICE STORY011-PRECHOICE)
	(CONTINUE STORY311)
	(CODEWORD CODEWORD-HUMBABA)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY011-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-LORE> <STORY-JUMP ,STORY095>)>>

<CONSTANT TEXT012 "Even after a century or more of disuse, the computers still work. The screen glimmers to life and you key in a connection to Gaia. A stream of meaningless gibberish runs onto the screen, followed by a sequence which seems ominously meaningful.">

<ROOM STORY012
	(DESC "012")
	(STORY TEXT012)
	(PRECHOICE STORY012-PRECHOICE)
	(CONTINUE STORY055)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY012-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-CYBERNETICS> <STORY-JUMP ,STORY034>)>>

<CONSTANT TEXT013 "Sunlight, hazed by a high overcast, is thrown up from the snow dunes in an unremitting glare as white and harsh as exposed bone. Squinting does no good. Your eyes feel gritty and tired. On the fourth evening, huddling behind the shelter of a crag of ice, you gaze across the landscape. It is like looking through a film of blood. The next day you find the sunrise burn so hard that you cannot stand to open your eyes.||Snow-blinded, you can only sit and wait for the dazzle to clear. If you were to press on now, you would soon lose your bearings and die. As you wait, the chill crawls deeper into your bones.">
<CONSTANT TEXT013-BURREK "You curl up and share the burrek's body warmth">
<CONSTANT TEXT013-CONTINUED "You are relieved to discover after a day and a night your eyesight has recovered enough for you to press on. From now on you are careful to shield your face against the glare">

<ROOM STORY013
	(DESC "013")
	(STORY TEXT013)
	(PRECHOICE STORY013-PRECHOICE)
	(CONTINUE STORY403)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY013-PRECHOICE ("AUX" (HAS-BURREK F) (DAMAGE 3))
	<COND (<CHECK-ITEM ,BURREK> <SET DAMAGE 2> <SET HAS-BURREK T>)>
	<COND (<AND <NOT <CHECK-ITEM ,FUR-COAT>> <NOT <CHECK-ITEM ,COLD-WEATHER-SUIT>>> <SET DAMAGE <+ .DAMAGE 1>>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-COLD ,STORY013>
	<COND (<IS-ALIVE>
		<CRLF>
		<COND (.HAS-BURREK
			<TELL ,TEXT013-BURREK>
			<TELL ,PERIOD-CR>
			<CRLF>
		)>
		<TELL ,TEXT013-CONTINUED>
		<TELL ,PERIOD-CR>
	)>>

<CONSTANT TEXT014 "\"There is nothing else to interest you here,\" says Little Gaia when you question her. \"You should get under way.\"||Accepting her advice, you return up to the shaft to the top level.">

<ROOM STORY014
	(DESC "014")
	(STORY TEXT014)
	(CONTINUE STORY361)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT015 "On the third day you do not awaken. The toxins in the air and wildlife here have got into your bloodstream. You moan and gasp, threshing weakly in the depths of a fever from which you will never recover.">

<ROOM STORY015
	(DESC "015")
	(STORY TEXT015)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT016 "You descend via a ruined subway entrance whose ventilation ducts connect with part of the catacombs. Golgoth jabs at buttons on his map box, bringing up a crackling image of the tunnel. The air in the ducts is stale, but he assures you that there is a good chance of reaching the underground tunnels close to the Shrine of the Heart. The Gargan sisters are even less enthusiastic about the route you are taking. With their broad shoulders, the duct feels like a long metal coffin.||The stale air makes it hot work. You are soaked in sweat by the time you finally wriggle out of the duct and drop to the floor of a dimly lit tunnel. The Gargan sisters follow, grunting curses, as Golgoth consults the map box.">

<ROOM STORY016
	(DESC "016")
	(STORY TEXT016)
	(PRECHOICE STORY016-PRECHOICE)
	(CONTINUE STORY325)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY016-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-ENKIDU> <STORY-JUMP ,STORY198>)>>

<CONSTANT TEXT017 "Among the items originally stored in the sky-car's locker were a flashlight and a length of rope. If you have not equipped yourself with these already, you may as well do so now since, if the baron's hunch is right, the moment of truth is almost upon you.">

<ROOM STORY017
	(DESC "017")
	(STORY TEXT017)
	(PRECHOICE STORY017-PRECHOICE)
	(CONTINUE STORY039)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY017-PRECHOICE ()
	<KEEP-ITEM ,FLASHLIGHT>
	<KEEP-ITEM ,ROPE>>

<CONSTANT TEXT018 "\"The Truth is a flame,\" you say.||\"What ignites the flame?\" intones the computer. So far so good.||\"The spark ignites the flame.\"||\"What is the spark?\" it asks.||\"The Heart of Volent.\"||You wait with bated breath. Then, with a hum, the elevator starts to descend. You are being conveyed to the Shrine of the Heart.">

<ROOM STORY018
	(DESC "018")
	(STORY TEXT018)
	(CONTINUE STORY150)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT019 "Captain Novak comes racing towards you out of the smoke. His uniform is torn and signed by the explosion and he has a wild look in his eyes. You are not sure whether to block his way or stand aside, when suddenly a barysal shot streams through the air, piercing his brain. A second shot hits him as he falls, but glances off his armour and ricochets into you.||You are badly burned.">

<ROOM STORY019
	(DESC "019")
	(STORY TEXT019)
	(PRECHOICE STORY019-PRECHOICE)
	(CONTINUE STORY041)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY019-PRECHOICE ("AUX" (DAMAGE 6))
	<COND (<CHECK-ITEM ,SPECULUM-JACKET> <SET DAMAGE 4>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-INJURIES ,STORY019>
	<COND (<IS-ALIVE> <DELETE-CODEWORD ,CODEWORD-MALLET>)>>

<CONSTANT TEXT020 "Singh was so intent on watching for Golgoth that he did not expect an attack from you. Caught unawares, he is flung to the ground. Rushing in, you snatch up the cannon and finish him with a blast from his own weapon.||The smoke begins to disperse. At first you see no sign of Golgoth, then he emerges from one of the elevator tubes. He had attached his gun to the wall magnetically and set it for remote fire. Retrieving it, he casts a wary glance at the cannon and then smiles. \"Ultimate power can be quite a temptation,\" he says, glancing significantly from the cannon to the gun in his own hand.">
<CONSTANT CHOICES020 <LTABLE "blast him" "trust him not to shoot">>

<ROOM STORY020
	(DESC "020")
	(STORY TEXT020)
	(CHOICES CHOICES020)
	(DESTINATIONS <LTABLE STORY043 STORY431>)
	(REQUIREMENTS <LTABLE MANTRAMUKTA-CANNON NONE>)
	(TYPES <LTABLE R-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT CHOICES021 <LTABLE "fire at Golgoth" "Boche" "Vajra Singh">>

<ROOM STORY021
	(DESC "021")
	(CHOICES CHOICES021)
	(DESTINATIONS <LTABLE STORY109 STORY087 STORY131>)
	(TYPES <LTABLE THREE-NONES>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT022 "Grabbing the stage curtain, you haul yourself up hand over hand until you reach the machinery that moves the puppets' wires. Swinging out, you gather up the wires and snag them into the rotating cogs. Down on the stage, the puppets are jerked off their feet and lifted up as their wires snarl inside the machinery.||You see your companions look around in surprise, then Golgoth thinks to look up. Seeing you, his smile flashes in the strobing light. \"There's our deus ex machina,\" he says. \"You can come down now. And thanks.\"">

<ROOM STORY022
	(DESC "022")
	(STORY TEXT022)
	(CONTINUE STORY110)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT023 "\"I overheard you say you were bound for the Saharan Ice Wastes,\" says Boche. \"My own journey takes me in that direction.\"||As you set off together through the deep drifts of snow, Boche takes your arm and points to a row of black wooden posts. \"That is the road to Venis. We can catch the ferry from there to Kahira.\"">
<CONSTANT CHOICES023 <LTABLE "agree to go east to Venis" "you'd rather go west through the Lyonesse jungle, as the innkeeper recommended">>

<ROOM STORY023
	(DESC "023")
	(STORY TEXT023)
	(CHOICES CHOICES023)
	(DESTINATIONS <LTABLE STORY200 STORY177>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT024 "To Boche's obvious surprise, you suddenly dive off the ledge and wriggle down into the bank of snow piled against the rock face just below it. Within seconds you are buried out of sight. Lying there, you listen for the approaching footsteps that tell you the mysterious figure is near at hand.||Boche starts to cry out, then gives a gasp and falls silent. You decide to wait no longer, but leap up from your hiding place and deliver a hard blow to the back of the stranger's neck. The stranger falls, and at the same moment you see Boche shake his head as if recovering from a trance.">

<ROOM STORY024
	(DESC "024")
	(STORY TEXT024)
	(CONTINUE STORY090)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT025 "Dawn hides behind a blanket of dark snow-laden cloud. Huddled in warm furs, a group of travellers make their way to the quayside to await the ferry. As you approach the ticket kiosk, you see an old man propped like a limp sack on a bench facing out to sea. He is crippled, having no legs, and his face has the look of a clay effigy that has crumpled in on itself through sheer age. A puff of white hair haloes his liver-spotted pate. Poor old devil, you think as you pass him.|| He looks up. Keen hawk's eyes meet your own. \"I don't care for your pity, youngster,\" he snaps.||\"I'm sorry,\" you say, \"I didn't mean --\"||And then it hits you.. He can read your mind.||\"\"Of course I can read your mind. Have you never heard of Baron Siriasis?\" Before you can reply, he hauls himself to the edge of the bench. It seems to you that he is about to fall to the ground, and you take half a step forward, but he glares at you and says, \"I don't need your help either!\"||To your amazement, he rises into the air until he is hovering in front of you, his gaze level with yours. For a moment your eyes lock. You hear his words of warning, not spoken, but burning their way into your mind: Don't go to Du-En if you want to live.||Abruptly he turns and drifts away. A woman standing behind you in the queue glances after him and says, \"That's Baron Siriasis, one of the lords of Bezant. He's said to be the most powerful psionic alive.\"||You have never before seen a man with enough psychokinetic power to levitate his own body. \"Indeed, who can doubt it?\" you reply.">

<ROOM STORY025
	(DESC "025")
	(STORY TEXT025)
	(PRECHOICE STORY025-PRECHOICE)
	(CONTINUE STORY202)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY025-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-DIAMOND> <STORY-JUMP ,STORY224>)>>

<CONSTANT TEXT026 "Reaching up, you point the shower nozzle so that a stream of scalding hot water hits one of your assailants in the face. He gives an agonized screech and falls clutching his eyes. By a lucky accident, the shower jet strikes the oil lamp by the door, plunging the shower hall into darkness. As you hear the other man step forward, you get ready to dart aside. He lunges, his knife gashing across your ribs to inflict some damage.">
<CONSTANT TEXT026-EXPERT "You are expert enough to parry an attack even in the dark">
<CONSTANT TEXT026-CONTINUED "Before the can thrust again, you have caught his wrist. There is a brief struggle -- a crack of bone, a wet sound, a groan. Slowly your attacker goes limp in your grasp, impaled on his own knife.||You grope your way to the door and relight the lamp. The dead man's blood goes swirling across the shower tiles into the drain. His accomplice whimpers as you approach">

<ROOM STORY026
	(DESC "026")
	(STORY TEXT026)
	(PRECHOICE STORY026-PRECHOICE)
	(CONTINUE STORY048)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY026-PRECHOICE ("AUX" (EXPERT F) (DAMAGE 3))
	<COND (<CHECK-SKILL ,SKILL-CLOSE-COMBAT>
		<SET EXPERT T>
		<SET DAMAGE 1>
	)>
	<TEST-MORTALITY .DAMAGE ,DIED-IN-COMBAT ,STORY026 ,SKILL-CLOSE-COMBAT>
	<COND (<IS-ALIVE>
		<CRLF>
		<COND (.EXPERT
			<TELL ,TEXT026-EXPERT>
			<TELL ,PERIOD-CR>
			<CRLF>
		)>
		<TELL ,TEXT026-CONTINUED>
		<TELL ,PERIOD-CR>
	)>>

<CONSTANT TEXT027 "You can detect no thoughts from the next room. Either you imagined the voice, or the speaker was one whose thoughts you cannot read.||\"Hurry,\" the voice cries out. \"Not much time.\"">
<CONSTANT CHOICES027 <LTABLE "ignore it and check out the Manta sky-car" "go through to the next room" "you think it would be wiser to get out of here">>

<ROOM STORY027
	(DESC "027")
	(STORY TEXT027)
	(CHOICES CHOICES027)
	(DESTINATIONS <LTABLE STORY049 STORY005 STORY395>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT028 "You step out of the elevator and follow the signs along empty corridors until you come to a plushly carpeted room with a door opposite. There is a desk where you might expect to see a nurse or clerk, but the room is unoccupied. The door has a plaque: the red crescent is a universal symbol, and beside it is the doctor's name-plate. You push the door open. A woman looks up from the book she was consulting and gives you a smile which is both a greeting and an enquiry.||\"Doctor Jaffe, I presume.\"||She puts the book into her bag and closes it. \"You caught me just in time. I was about to go home.\"||She is refreshingly free of the sycophancy that characterizes most of the Society's employees. You mention this to her as she is giving you a check-up and she laughs saying, \"Well, most of the members are so used to wielding power that they bully anyone who'll let them. That wouldn't do for a doctor; I'm supposed to be the bully!\"">
<CONSTANT TEXT028-CONTINUED "Doctor Jaffe also gives you a pack of antidote pills. \"There are generally useful against most diseases and toxins you'll encounter while in Kahira.\"">

<ROOM STORY028
	(DESC "028")
	(STORY TEXT028)
	(PRECHOICE STORY028-PRECHOICE)
	(CONTINUE STORY073)
	(ITEM ANTIDOTE-PILLS)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY028-PRECHOICE ()
	<GAIN-LIFE 2>
	<CRLF>
	<TELL ,TEXT028-CONTINUED>
	<CRLF>>

<CONSTANT TEXT029 "The indicator light shows you have fifteen floors to go. About thirty seconds. Long enough to work a miracle if you're lucky. You clear your mind of everything but a single purpose: to direct your willpower through the psionic focus you wear.||The indicator light shows you have reached the third floor... the second... the first. With a chime, the elevator comes to a halt and the doors start to open.||Suddenly all the lights go out, not only here but in the street outside, plunging the lobby into total darkness.||\"Power cut!\" you hear someone shout. Then someone else snarls an order to open fire, and gunfire spatters the rear wall of the elevator where you were standing only seconds before.||Following the wall, you find the door and duck out into the night. Hurrying off, you go half a block through the welcome enveloping mist before allowing the electricity to flow again. That was as narrow an escape as you've ever had. You'll have to sharpen your edge if you are to have any chance of getting the Heart.">

<ROOM STORY029
	(DESC "029")
	(STORY TEXT029)
	(CONTINUE STORY311)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT030 "Cold reptilian thoughts seep into your brain, jolting you awake. Your gaze flicks across the swaying fronds around you, searching for the source of the thoughts. Warned by an intuitive impulse, you glance up in time to see a narrow fang-lined snout dropping on a long neck towards you. Leaping to your feet, you cast a handful of soil into the creature's eyes and race off through the trees.">

<ROOM STORY030
	(DESC "030")
	(STORY TEXT030)
	(CONTINUE STORY228)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT031 "You sit at the front of the carriage and stare through the window, even though the tunnel is unlit and there is nothing to see. Hours pass before a glimmer of light shows ahead. The carriage glides to a halt and the doors open with a whirr. You emerge into a maze of partly collapsed corridors. There are no careteks here to keep the place spruce. You search until you find a spiral staircase, at the top of which is a tunnel choked with rubble. Laboriously you clear away the masonry blocks until at last you feel a slight breeze of fresh air. Flickering light shows through a crack in a wall panel. You press your fingers against the panel. It is only light plastiwood which you can break through easily.">

<ROOM STORY031
	(DESC "031")
	(STORY TEXT031)
	(PRECHOICE STORY031-PRECHOICE)
	(CONTINUE STORY357)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY031-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-ESP> <STORY-JUMP , STORY141>)>>

<CONSTANT CHOICES032 <LTABLE "fight with" "draw a barysal gun on them" "resort to" "you really would be better off not tangling with them">>

<ROOM STORY032
	(DESC "032")
	(CHOICES CHOICES032)
	(DESTINATIONS <LTABLE STORY076 STORY098 STORY120 STORY054>)
	(REQUIREMENTS <LTABLE SKILL-CLOSE-COMBAT <LTABLE BARYSAL-GUN> SKILL-CUNNING NONE>)
	(TYPES <LTABLE R-SKILL R-ALL R-SKILL R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT033 "Bador thrusts his chin forward and strokes at his grizzled scrub of beard as he waits to see how he can help you.">
<CONSTANT CHOICES033 <LTABLE "ask him about Giza" "Saharan Ice Wastes" "the city of Kahira" "where you should take lodging">>

<ROOM STORY033
	(DESC "033")
	(STORY TEXT033)
	(CHOICES CHOICES033)
	(DESTINATIONS <LTABLE STORY059 STORY077 STORY143 STORY099>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT034 "Gaia must be having one of her periodic bouts of madness. The commands that have appeared on the screen tell you that she has logged into the computer which oversees the nuclear reactor supplying power to this base. Your jaw sags in dismay as you see the next set of commands: a sequence which, if completed, would cause the reactor to go critical!||There are times for subtlety, but this isn't one of them. You rip out the external cables, physically breaking the link to Gaia. The computer sputters and fades before the reactor override command could be completed. You've saved yourself and quite possibly all of Kahira, but with the computer out of action there is no way to restore the reactor to full function. Failsafe systems will probably shut it down now. That means that the electricity will go off soon. Since that will disable the elevator, you lose no time in ascending to the surface while you still can.">

<ROOM STORY034
	(DESC "034")
	(STORY TEXT034)
	(CONTINUE STORY361)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT035 "You gnaw wretchedly at your meagre provisions, trying to ration out what remains so that it will last as long as possible. You manage to trap a migrating bird which pauses to rest on one of the spars of ice.">
<CONSTANT TEXT035-BIRD "The bird escapes while hunger continues to weaken you.">

<ROOM STORY035
	(DESC "035")
	(STORY TEXT035)
	(PRECHOICE STORY035-PRECHOICE)
	(CONTINUE STORY100)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY035-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL>
		<PREVENT-DEATH ,STORY035>
	)(ELSE
		<EMPHASIZE TEXT035-BIRD>
		<TEST-MORTALITY 1 ,DIED-OF-HUNGER ,STORY035>
	)>>

<CONSTANT TEXT036 "A laboratory extends from the far end of the hall. A bank of computers lines one wall. The benches are strewn with electronic equipment whose function you cannot even guess at, most of it only half-constructed. On one bench, next to a metal box, you notice an empty coffee cup. It seems as though this base was evacuated in a hurry.||You stoop to inspect the metal box. It looks something like a communicator, with a viewscreen and speaker on one side next to an array of buttons. You guess that the prominent red button on the side will power it up... whatever it is.">
<CONSTANT CHOICES036 <LTABLE "try using the computers to put through a message to Gaia" "power up the metal box" "spend time on a more thorough search of the laboratory" "descend to the military level" "leave the pyramid">>

<ROOM STORY036
	(DESC "036")
	(STORY TEXT036)
	(CHOICES CHOICES036)
	(DESTINATIONS <LTABLE STORY012 STORY057 STORY080 STORY255 STORY361>)
	(TYPES FIVE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT037 "You make do as best you can with the little food remaining. You take to sleeping in the middle of each day, when the sunlight gives some small respite from the cold. Rising in late afternoon, you travel on through the night so that the activity keeps you from freezing to death. You watch the stars wheel ponderously overhead, melancholy sparks drifting through the silent heavens.">
<CONSTANT TEXT037-CONTINUED "When dawn at last washes the sky silver and lays gold-pink tracks across the snow, you are amazed to find tears of joy running down your cheeks. You have survived another night of this terrible ordeal.">

<ROOM STORY037
	(DESC "037")
	(STORY TEXT037)
	(PRECHOICE STORY037-PRECHOICE)
	(CONTINUE STORY125)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY037-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL>
		<PREVENT-DEATH ,STORY037>
		<EMPHASIZE NATURAL-HARDINESS>
	)(ELSE
		<TEST-MORTALITY 1 ,DIED-FROM-COLD ,STORY037>
	)>>

<CONSTANT TEXT038 "As night falls, an eerie glitter of lights appears in the sky like a translucent curtain draped across the cosmos. Janus Gaunt gazes up and tells you it is the aurora cordis, caused by particles from outer space falling into the field of paradox radiation emanating from the Heart of Volent.||You stand in awe, humbled by the magnificent sight. The curtain of light ripples and stirs in the heavens. \"It seems staggering,\" you remark to Gaunt in a whisper, \"to think that just a fraction of the Heart's power could create something on such a scale.\"||He chuckles. \"The Heart's power is much greater than that. Power enough to shape worlds and shift the stars in their courses, if the legend is to be believed.\"||\"And do you believe it?\"||He gives you an odd, half-frightened look. \"Believe it? I have studied the scientific records. I know it for a fact.\"">

<ROOM STORY038
	(DESC "038")
	(STORY TEXT038)
	(PRECHOICE STORY038-PRECHOICE)
	(CONTINUE STORY082)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY038-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-URUK>
		<DELETE-CODEWORD ,CODEWORD-URUK>
		<GAIN-CODEWORD ,CODEWORD-ENKIDU>
	)>
	<COND (<CHECK-CODEWORD ,CODEWORD-NEMESIS> <STORY-JUMP ,STORY060>)>>

<CONSTANT TEXT039 "You ease yourselves down into the crevice. The walls are slick with frost and you have to brace your back against sharp rocks to keep from slipping. At last you see a glimmer of light below and you emerge onto a ledge overlooking a large underground cavern. A distant howl of rushing air reaches your ears, magnified by the vast space surrounding you. The light is a dull grey phosphorescence from deep in the rock. Climbing down to the floor of the cavern, you advance through a forest of slender stalagmites which glisten like old candles.||Baron Siriasis bobs along beside you like a grotesque broken manikin. He points. \"Ahead is a chasm. Fortunately for you both, there seems to be a bridge across it.\"||As you step out from among the stalagmites, you fail to notice at first that a thick glowing vapour is roiling around your feet. Boche heads towards the chasm, but stumbles and gives a cry of alarm as the vapour begins to creep around his limbs. With a groan, the baron seems to sag and drift down to the cavern floor. You take another step, then you realize that the mist is draining your strength. It rises across your vision, a luminous fog that seeps into your skin like ice water. You can no longer see your comrades. Then you see a sight that sends a tingle of dread through you. Taking shape within the mist, reaching towards you with ghastly imploring fingers, is a horribly twisted figure that looks like a squashed effigy of white clay.">
<CONSTANT TEXT039-END "There is nothing you can do to stop the phantom from reaching through your skin and extracting your life-essence">

<ROOM STORY039
	(DESC "039")
	(STORY TEXT039)
	(PRECHOICE STORY039-PRECHOICE)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY039-PRECHOICE ()
	<COND (<OR <CHECK-CODEWORD ,CODEWORD-ENKIDU> <CHECK-CODEWORD ,CODEWORD-TALOS> <CHECK-SKILL ,SKILL-LORE>>
		<PREVENT-DEATH ,STORY039>
		<COND (<CHECK-CODEWORD ,CODEWORD-ENKIDU>
			<STORY-JUMP ,STORY105>
		)(<CHECK-CODEWORD ,CODEWORD-TALOS>
			<STORY-JUMP ,STORY127>
		)(ELSE
			<STORY-JUMP ,STORY171>
		)>
		<RETURN>
	)>
	<CRLF>
	<TELL ,TEXT039-END>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT040 "Tossing the nearest corpse aside, you lie down on the floor of the passage and tell Boche and Siriasis to start retreating. \"Keep firing at it, \"you say to Boche, \"and make sure you don't hit me.\"||Boche takes two more shots, forcing the thing to keep its front legs raised as a shield. It stalks forward, feeling its way with its other legs. You feel a shudder of dread as it reaches you and probes your prone body with a metal leg, but you force yourself to keep absolutely still. The thing assumes you are one of the corpses littering the passage. As it clambers across you in pursuit of Boche and Siriasis, you find yourself staring up at the stunted little body inside the glass bubble. There is no doubt that this is the thing's guiding intelligence. You lash upwards with your boot, cracking the glass, and the blue fluid pours out. The thing rears up on its legs like a dying spider, takes a series of rushing steps that up-end it against the wall, then twitches and dies.||In stunned silence, the three of you edge past and head on to the end of the passage.">

<ROOM STORY040
	(DESC "040")
	(STORY TEXT040)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT041 "Boche comes along the passage with gun in hand. He is covered with dust from the explosion and has a gash across his forehead where he was hit by a splinter of masonry, but he is smiling. \"The baron's dead,\" he tells you.||\"How? What happened?\"||He swells with pride. \"I got him with a grenade. I'd been carrying it all along, but the joke was I didn't even know it myself. It was the only way to foil his mind-reading, you see.\"||\"I don't understand.\"||Boche coughs rock dust out of his throat and then goes on. \"I knew the baron was heading for Du-En and that he'd be the hardest foe I'd have to face, so I got myself hypnotized to forget that I was carrying a grenade. I had post-hypnotic suggestion planted that I should use the grenade at a key moment. He never knew what hit him.\"||\"Ruthlessly cunning.\"||If you intended any sarcasm, Boche fails to notice it. \"Thanks,\" he says. \"Now, let's get going before the tunnel collapses on us.\"">

<ROOM STORY041
	(DESC "041")
	(STORY TEXT041)
	(CONTINUE STORY175)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT042 "A barysal beam stabs blindly through the smoke, narrowly missing you. Singh turns and squints in the direction of the shot. \"I still can't see him,\" he mutters grimly.">
<CONSTANT CHOICES042 <LTABLE "return fire" "advance under the cover of the smoke towards him where the shot came from" "back off out of the smoke and look around">>

<ROOM STORY042
	(DESC "042")
	(STORY TEXT042)
	(CHOICES CHOICES042)
	(DESTINATIONS <LTABLE STORY064 STORY086 STORY108>)
	(REQUIREMENTS <LTABLE BARYSAL-GUN NONE NONE>)
	(TYPES <LTABLE R-ITEM R-NONE R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT043 "Golgoth fires back, but he has no defence against the unstoppable power of the mantramukta cannon, which literally blasts him apart. His last shot strikes you glancingly, however, and you feel an agonizing pain coursing through your side.">

<ROOM STORY043
	(DESC "043")
	(STORY TEXT043)
	(PRECHOICE STORY043-PRECHOICE)
	(CONTINUE STORY415)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY043-PRECHOICE ("AUX" (DAMAGE 3))
	<COND (<CHECK-ITEM ,SPECULUM-JACKET> <SET DAMAGE 2>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-INJURIES ,STORY043>>

<CONSTANT TEXT044 "Gargan XIV's fist lashes out, cracking your head back against the wall.">
<CONSTANT TEXT044-CONTINUED "As you are squaring off for a hard fight, you see that Gargan XIII has drawn a knife and is standing over Golgoth, in no hurry to finish him off. Suddenly he looks up with a broad smile.">

<ROOM STORY044
	(DESC "044")
	(STORY TEXT044)
	(PRECHOICE STORY044-PRECHOICE)
	(CONTINUE STORY154)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY044-PRECHOICE ("AUX" (DAMAGE 3))
	<COND (<CHECK-SKILL ,SKILL-CLOSE-COMBAT> <SET DAMAGE 1>)>
	<TEST-MORTALITY .DAMAGE ,DIED-IN-COMBAT ,STORY044 ,SKILL-CLOSE-COMBAT>
	<IF-ALIVE TEXT044-CONTINUED>>

<CONSTANT TEXT045 "You look at Boche's hand but do not take it. In these latter days, with humanity on the brink of extinction, you have learned to be way of strangers.||\"I travel alone.\"||Boche is not deterred. \"Come, that's hardly friendly. I've paid your bill.\"||\"I did not ask you to. Landlord, return this man's money. I shall settle my own account.\"">
<CONSTANT CHOICES045 <LTABLE "pay your bill for the night" "reconsider and accept Boche's generosity">>

<ROOM STORY045
	(DESC "045")
	(STORY TEXT045)
	(CHOICES CHOICES045)
	(DESTINATIONS <LTABLE STORY067 STORY023>)
	(REQUIREMENTS <LTABLE 3 NONE>)
	(TYPES <LTABLE R-MONEY R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT046 "Grabbing handfuls of snow, you rapidly dust it over your clothing and face. The cold nips your skin painfully. Ignoring the discomfort, you pluck some icicles from the overhang above the ledge, lodging these across your hood in front of your face. Taking up an intent rigid pose, you look like just another of the frozen corpses lining the walls of the pass.||Boche is slow on the uptake. \"What are you doing?\"||\"Get going, you fool,\" you hiss out of the side of your mouth. \"You're the decoy.\"||He hesitates, then drops from the ledge and vanishes out of sight along the pass. Soon afterwards, the mysterious figure draws level with where you are crouching. A gold glimmer shows under its hood as it glances up, then hurries on towards Boche.||You leap down behind it, and a hard blow with a rock lays it flat in the snow.">

<ROOM STORY046
	(DESC "046")
	(STORY TEXT046)
	(CONTINUE STORY090)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT047 "The Compass Society is an international organization whose membership consists entirely of the rich, powerful and privileged. Possession of one of the coveted gold membership cards marks a person out as someone to be respected, with full access to the Society's wealth and lavish resources. Although the Society is not represented here in Venis, you know that it has premises in Daralbad, Bezant and Kahira.">

<ROOM STORY047
	(DESC "047")
	(STORY TEXT047)
	(PRECHOICE STORY047-PRECHOICE)
	(CONTINUE STORY414)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY047-PRECHOICE ()
	<COND (<CHECK-ITEM ,ID-CARD> <STORY-JUMP ,STORY069>)>>

<CONSTANT TEXT048 "You stoop to question him. His knife lies beside him, but he is in too much pain to think of retrieving it. He peers at you between his fingers, his face and eyes badly scalded.||\"Who are you?\" you ask. \"Why did you try to kill me?\"||\"Body snatchers,\" he replies, grinding his teeth in agony because of the burns. \"Any healthy stranger is fair game in this part of town.\"||Body snatchers seize live organs for transplants. You know that a high price can be had on the black market for a usable heart, kidney or liver -- and no questions asked of how the body snatchers came by it. It is a foul trade, lacking even the relative honesty of conventional mugging.">
<CONSTANT CHOICES048 <LTABLE "use" "consult a" "use" "otherwise">>

<ROOM STORY048
	(DESC "048")
	(STORY TEXT048)
	(CHOICES CHOICES048)
	(DESTINATIONS <LTABLE STORY114 STORY114 STORY136 STORY092>)
	(REQUIREMENTS <LTABLE SKILL-STREETWISE VADE-MECUM SKILL-ESP NONE>)
	(TYPES <LTABLE R-SKILL R-ITEM R-SKILL R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT049 "You touch a dial on the dashboard. The liquid crystal display shows that the sky-car's power unit is still working. None of the other instruments show damage. The caretek has maintained the sky-car well. There is not even a trace of dust on the vehicle's smooth black finish.||In a storage locker behind the seat you find food, medical supplies and a variety of other items. Stored in the vacuum packs, they should still be usable despite having been left here since before the Ice Age.">
<CONSTANT CHOICES049 <LTABLE "powering up th sky-car and flying it out of the complex" "you would rather just loot the storage locker of useful goods and then leave">>

<ROOM STORY049
	(DESC "049")
	(STORY TEXT049)
	(CHOICES CHOICES049)
	(DESTINATIONS <LTABLE STORY071 STORY093>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT050 "You sit at the front of the carriage and stare through the window at hurtling darkness. There is no way to tell how fast you are travelling, but you estimate from the long smooth acceleration at the start of the journey that it could be around four hundred kilometres an hour. The carriage never gives the slightest jolt.||Hours pass before you see the glimmer of lights along the tunnel. The carriage glides to a halt and the doors open with a whir. You emerge and set off along a tunnel very different form the one in Marsay. This subway station has not been maintained by careteks, and dust and rubble cover the tiled walkways.||Climbing a staircase, you find the entrance blocked by fallen masonry and you have to labour for over an hour before there is a gap large enough to squeeze through. You find yourself on an ice-hard plain under the descending chill of dusk. A sprinkling of snow drifts down out of the sky. A few kilometres away, Kahira straddles the River Isis on its thick buttresses, a grey concrete lobster winking with a thousand eyes o flight through the haze of mist. You set out at a brisk pace, anxious to reach the gates before curfew.">

<ROOM STORY050
	(DESC "050")
	(STORY TEXT050)
	(CONTINUE STORY229)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT051 "The elevator carries almost to the top floor of the building, where a well-equipped gym overlooks the city. You spend half an hour on the treadmill, watching your own reflection in the glass window superimposed against the mist-shrouded towers and twinkling lights of Kahira. Another half hour on various weights machines leaves you feeling firmed up and fit. You finish with five minutes on a massage bed followed by a relaxing spa.||As you are leaving the changing room, you almost collied with a huge Fijian in a trim black suit and mirror glasses. He grunts an absent-minded apology and hurries past, staring urgently around the room. He is the only other person you have seen in the building who doesn't seem to be an employee here. You are about to head off towards the elevator when he calls after you, \"Hey! Who are you?\"">
<CONSTANT CHOICES051 <LTABLE "use a" "you prefer to use" "try" "you had better run for it">>

<ROOM STORY051
	(DESC "051")
	(STORY TEXT051)
	(CHOICES CHOICES051)
	(DESTINATIONS <LTABLE STORY227 STORY248 STORY269 STORY290>)
	(REQUIREMENTS <LTABLE BARYSAL-GUN SKILL-CLOSE-COMBAT SKILL-CUNNING NONE>)
	(TYPES <LTABLE R-ITEM R-SKILL R-SKILL R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT052 "The elevator reaches the ground floor and the doors slide open. You step out, only to be confronted by a group of uniformed security men with rifles. \"You're in illegal possession of a Compass Society ID,\" growls the security chief with a wolfish grin.||\"Let me explain.\"||He shakes his head. \"Tell it to the marines. Better yet, tell it to the angels.\"||With a click of his fingers, he signals to his men and you are blasted apart in a juddering hail of gunfire.">

<ROOM STORY052
	(DESC "052")
	(STORY TEXT052)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT053 "A rustling in the leaf canopy directly overhead warns you of danger. You open your eyes in time to see a narrow wedge/shaped head shaking down from the branches, its wide pink mouth lined with teeth like needles.||You react instantly, flipping backwards over the log an instant before the jaws strike. The creature roars back, spitting out soil and twigs, head bobbing on a long grey cable of neck, and lunges again. You slip aside, snatch up your belonging, and race off through the trees.">

<ROOM STORY053
	(DESC "053")
	(STORY TEXT053)
	(CONTINUE STORY228)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT054 "You take yourself to a table and sit down. The twins watch you for a moment longer, then return to their drinking.||You glance around the inn. No one else dares stand up to the two Amazons. What about you?">
<CONSTANT CHOICES054 <LTABLE "eavesdrop" "read their minds" "try to outwit them" "draw a" "you had better mind your own business">>

<ROOM STORY054
	(DESC "054")
	(STORY TEXT054)
	(CHOICES CHOICES054)
	(DESTINATIONS <LTABLE STORY208 STORY230 STORY120 STORY098 STORY252>)
	(REQUIREMENTS <LTABLE SKILL-ROGUERY SKILL-ESP SKILL-CUNNING BARYSAL-GUN NONE>)
	(TYPES <LTABLE R-SKILL R-SKILL R-SKILL R-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT055 "The computer locks you out. You try rebooting, to no avail. With a shrug, you turn to exploring the rest of the pyramid idly wondering what Gaia was up to when she entered the stream of inexplicable commands into the computer system here.||The answer comes so suddenly that you never know it. Gaia was in the throes of her periodic madness when you contacted her this time. She located the nuclear reactor supplying power to the pyramid and ordered it to go critical. Without warning a blossom of plasma erupts from the earth. For a brief incandescent second it is as though time has turned back to before the Ice Age, and the Pyramid of Cheops once more sits on hot sands in blazing light. Then the blast spreads -- sweeping away the pyramids that have stood here for fifty centuries, vaporizing the snow and ice covering the desert, turning the rock to lava and the river to steam, and making of Kahira a cinderous ruin. In the midst of such a holocaust, your own death goes unnoticed.">

<ROOM STORY055
	(DESC "055")
	(STORY TEXT055)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT056 "You curse the recklessness that brought you into the Ice Wastes before you were adequately prepared. Your lack of food intensifies the cold, which seems to drill into your bones. Each dawn you arise lethargic and listless, like on who has been visited by a vampire in the night. Each step you take costs a greater effort. You feel torpid with fatigue and hunger.">
<CONSTANT TEXT056-SURVIVOR "You manage to trap a bird which alights on one of the tors of glacial ice for food.">
<CONSTANT TEXT056-BURREK "You tap some of the burrek's oily blood for sustenance">

<ROOM STORY056
	(DESC "056")
	(STORY TEXT056)
	(PRECHOICE STORY056-PRECHOICE)
	(CONTINUE STORY100)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY056-PRECHOICE ("AUX" (SURVIVOR F) (BURREK F) (DAMAGE 4))
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL> <SET DAMAGE 2> <SET SURVIVOR T>)>
	<COND (<CHECK-ITEM ,BURREK> <SET DAMAGE <- .DAMAGE 1>> <SET BURREK T>)>
	<TEST-MORTALITY .DAMAGE ,DIED-GREW-WEAKER ,STORY056>
	<COND (<IS-ALIVE>
		<COND (.SURVIVOR
			<CRLF>
			<TELL ,TEXT056-SURVIVOR>
		)>
		<COND (.BURREK
			<COND (<NOT .SURVIVOR> <CRLF>)(ELSE <TELL " ">)>
			<TELL ,TEXT056-BURREK>
			<TELL ,PERIOD-CR>
		)(.SURVIVOR
			<TELL ,PERIOD-CR>
		)>
	)>>

<CONSTANT TEXT057 "You touch the red button. The box produces a prolonged hum which rises in tone and then ends with a bleep. \"Ready,\" says a synthetic feminine voice from the speaker.||Taken aback for a moment, you lean closer and gingerly speak to the box. \"Er... ready for what?\"||\"Explain,\" says the box crisply. \"Your query was unspecific.\"||\"Is this a radio? Who am I talking to?\"||\"I am a miniature facsimile of the Global Artificial Intelligence Array,\" replies the box.||\"Gaia? But Gaia is crazy.\"||\"I was loaded with Gaia's program prior to virus infection. I am able to model the thinking of the Gaia system at a reduced rate owing to my limited memory capacity, which now stands at 512 gigabytes.\"||\"What can you tell me about the Heart of Volent?\"||\"Nothing. No such information has been loaded into my memory.\" The device has an annoyingly smug little voice. All the same, if it has even a fraction of Gaia's intelligence then it may be useful.">
<CONSTANT CHOICES057 <LTABLE "search the lab for other equipment" "descend to the bottom level" "leave">>

<ROOM STORY057
	(DESC "057")
	(STORY TEXT057)
	(CHOICES CHOICES057)
	(DESTINATIONS <LTABLE STORY080 STORY255 STORY361>)
	(TYPES THREE-NONES)
	(ITEM LITTLE-GAIA)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT058 "The volcanic gases here make the air poisonous, stunting the trees around the oasis and causing the slow death of animal life. No doubt those insects swarming in the sudorific updraughts have had to mutate in order to tolerate the conditions here. You know that the prolonged exposure to the tainted air might eventually cause cancer unless you have some protection. Otherwise it is only worth staying if you are on the brink of death and are so desperate for recuperation now that you are willing to take a gamble with your life.">
<CONSTANT CHOICES058 <LTABLE "stay for a day or so" "continue onwards at once">>

<ROOM STORY058
	(DESC "058")
	(STORY TEXT058)
	(PRECHOICE STORY058-PRECHOICE)
	(CHOICES CHOICES058)
	(DESTINATIONS <LTABLE STORY103 STORY426>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY058-PRECHOICE ()
	<COND (<OR <CHECK-ITEM ,GAS-MASK> <CHECK-CODEWORD ,CODEWORD-TALOS>> <STORY-JUMP ,STORY169>)>>

<CONSTANT TEXT059 "He holds up his finger. \"Ah, it is a very ancient place, not very far to the west. There, in ancient times, were buried the royalty of Egypt. Later, men came from the distant corners of the globe with a great warrior they called Gilgamesh, who had skin of iron and eyes of fire. They told him to watch across the snows for stirrings of life in the ruins of Du-En and, if any threat arose from there, he was to take up his sword and venture forth.\" Bador sees the look on your face. \"It is true, all true!\"">
<CONSTANT CHOICES059 <LTABLE "ask for advice about the Sahara" "about Kahira itself" "where to stay in the city" "you can dismiss him">>

<ROOM STORY059
	(DESC "059")
	(STORY TEXT059)
	(CHOICES CHOICES059)
	(DESTINATIONS <LTABLE STORY077 STORY143 STORY099 STORY095>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT060 "If Gaia is to be believed, to unleash the power of the Heart would spell death for all of creation. But is she to be believed? Or trusted, for that matter? Gaia is not even a 'she', but an 'it' -- just an artificial intelligence resident in a network of computers. And schizophrenic into the bargain, thanks to the computer viruses entrenched in her software. You must make up your own mind. If you think the Heart should be destroyed, you will need to find a friend who is willing to help you do it. You look dubiously around the faces limned in the campfires. By their very nature, these are the most ruthless and determined adventurers of the age. Can you make them trust you? Or should you forget Gaia's dire warning, and just try to get the Heart for yourself?">

<ROOM STORY060
	(DESC "060")
	(STORY TEXT060)
	(PRECHOICE STORY060-PRECHOICE)
	(CONTINUE STORY082)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY060-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-ESP> <STORY-JUMP ,STORY152>)>>

<CONSTANT CHOICES061 <LTABLE "use" "try" "or" "use" "otherwise">>

<ROOM STORY061
	(DESC "061")
	(CHOICES CHOICES061)
	(DESTINATIONS <LTABLE STORY344 STORY365 STORY387 STORY408 STORY429>)
	(REQUIREMENTS <LTABLE SKILL-ESP SKILL-ROGUERY SKILL-LORE <LTABLE SKILL-CYBERNETICS LITTLE-GAIA> NONE>)
	(TYPES <LTABLE R-SKILL R-SKILL R-SKILL R-SKILL-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT062 "You are in no doubt that the stunted little form inside the central globe is the thing's guiding intellect. Racing forward, you avoid a sweep of the powerful metal legs and throw yourself into a forward roll that carries you onto the top of the glass globe. The half-formed face of the embryo is floating just inches from your own. Its muddy eyes give no sign of surprise or understanding -- it has the drooling vacant face of an imbecile -- but suddenly the metal legs buck and rear in a frantic effort to throw you off. You cling on for several seconds until you feel it give an upward thrust, trying to crush you against the ceiling. You leap clear at the crash. As the blue fluid drains away, the thing gives a dying spasm and then falls still.||Boche comes over and helps you to your feet. \"I wonder what that was,\" he says with emphatic distaste.||\"I don't care as long as there aren't any more of them,\" you reply. Together you head on to the end of the passage.">

<ROOM STORY062
	(DESC "062")
	(STORY TEXT062)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT063 "The beam crackles through the air, only to splatter off an invisible shield of psychic force.">
<CONSTANT CHOICES063 <LTABLE "try to strip away the defensive shield and fire again" "back out of the hall the way you came" "press on deeper into the catacombs">>

<ROOM STORY063
	(DESC "063")
	(EVENTS STORY063-EVENTS)
	(STORY TEXT063)
	(CHOICES CHOICES063)
	(DESTINATIONS <LTABLE STORY282 STORY107 STORY129>)
	(REQUIREMENTS <LTABLE <LTABLE SKILL-PARADOXING BARYSAL-GUN> NONE NONE>)
	(TYPES <LTABLE R-SKILL-ITEM R-NONE R-NONE>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY063-EVENTS ()
	<COND (,RUN-ONCE <FIRE-BARYSAL 1>)>
	<RETURN ,STORY063>>

<ROOM STORY064
	(DESC "064")
	(EVENTS STORY064-EVENTS)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY064-EVENTS ()
	<COND (<CHECK-SKILL ,SKILL-ESP> <RETURN ,STORY130>)>
	<RETURN ,STORY240>>

<CONSTANT TEXT065 "The shot was a decoy. Sensing Golgoth's thoughts, you whirl to see him running silently through the smoke towards you. He has a knife in his hand, and the look in his eyes is as cold as death. You block his first thrust but take a gash on your forearm, countering with an elbow-strike which leaves him dazed.||The fight is short and brutal. Golgoth is a master of lethal killing techniques.">
<CONSTANT TEXT065-CONTINUE "You finally manage to twist the knife around and impale him.">

<ROOM STORY065
	(DESC "065")
	(STORY TEXT065)
	(PRECHOICE STORY065-PRECHOICE)
	(CONTINUE STORY072)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY065-PRECHOICE ("AUX" (DAMAGE 5))
	<COND (<CHECK-SKILL ,SKILL-CLOSE-COMBAT> <SET DAMAGE 3>)>
	<TEST-MORTALITY .DAMAGE ,DIED-IN-COMBAT ,STORY065 ,SKILL-CLOSE-COMBAT>
	<IF-ALIVE ,TEXT065-CONTINUE>>

<CONSTANT TEXT066 "The puppets are programmed to fight each other in an epic theatrical battle. But you doubt if the programmers ever expected a group of spectators to wander onto the stage during the performance. Dodging the sword-blows is almost impossible. The strobing light was supposed to enhance the scene, adding a sense of frantic pace as well as disguising any jerkiness in the puppet' movement, but it also makes it much harder to see a sword-thrust coming.||You finally succeed in pushing your way through the melee and jumping down off the stage, but in the process you take several nasty cuts.">

<ROOM STORY066
	(DESC "066")
	(STORY TEXT066)
	(PRECHOICE STORY066-PRECHOICE)
	(CONTINUE STORY110)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY066-PRECHOICE ("AUX" (DAMAGE 2))
	<COND (<CHECK-SKILL ,SKILL-CLOSE-COMBAT> <SET DAMAGE 1>)>
	<TEST-MORTALITY .DAMAGE ,DIED-IN-COMBAT ,STORY066 ,SKILL-CLOSE-COMBAT>>

<CONSTANT TEXT067 "Taking up your pack, you trudge out into the snow. Moments later you hear the crunching of rapid footsteps and Boche catches up with you. His breath curls into the diamond-clear morning air. \"We may as well travel together for mutual convenience, at least for a while,\" he says chirpily.">
<CONSTANT CHOICES067 <LTABLE "agree to this" "refuse point-blank">>

<ROOM STORY067
	(DESC "067")
	(STORY TEXT067)
	(CHOICES CHOICES067)
	(DESTINATIONS <LTABLE STORY133 STORY155>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT068 "There is the familiar pulse of blistering grey-white light, which instantaneously illuminates the overhanging crags like daylight. The sharp crack of vaporized snow and superheated air reverberates off the rocks. You are gratified to see the figure throw up its arms and fall to the ground.||\"That was rash,\" snaps Boche. \"You might have just killed a potential ally.\"||You lower yourself form the ledge and start off towards the prone figure. \"Let's find out,\" you call back over your shoulder. The figure looks dead, but you are careful to keep your gun trained on it.">

<ROOM STORY068
	(DESC "068")
	(STORY TEXT068)
	(PRECHOICE STORY068-PRECHOICE)
	(CONTINUE STORY090)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY068-PRECHOICE ()
	<FIRE-BARYSAL 1>>

<CONSTANT TEXT069 "The drawback to using the card is the holographic picture on the front, which looks nothing like you.">
<CONSTANT CHOICES069 <LTABLE "get the ID card altered" "forget about the card and investigate your other options instead">>

<ROOM STORY069
	(DESC "069")
	(STORY TEXT069)
	(PRECHOICE STORY069-PRECHOICE)
	(CHOICES CHOICES069)
	(DESTINATIONS <LTABLE STORY135 STORY414>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY069-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-ROGUERY> <STORY-JUMP ,STORY452>)>
	<COND (<OR <CHECK-SKILL ,SKILL-STREETWISE> <CHECK-ITEM ,VADE-MECUM>>
		<SET-DESTINATION ,STORY069 1 ,STORY113>
	)(ELSE
		<SET-DESTINATION ,STORY069 1 ,STORY135>
	)>>

<CONSTANT TEXT070 "One of the men sticks out a foot to trip you, while the other chops at your neck with his knife.">
<CONSTANT TEXT070-BLOCK "You are able to fend off the blow and escape past them, grabbing up your clothes as you run">
<CONSTANT TEXT070-CONTINUED "The blade gashes you across the breast-bone -- a painful but not lethal injury">
<CONSTANT CHOICES070 <LTABLE "retreat into the steam room" "stand your ground and fight">>

<ROOM STORY070
	(DESC "070")
	(STORY TEXT070)
	(PRECHOICE STORY070-PRECHOICE)
	(CHOICES CHOICES070)
	(DESTINATIONS <LTABLE STORY004 STORY026>)
	(TYPES TWO-NONES)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY070-PRECHOICE ()
	<CRLF>
	<COND (<OR <CHECK-SKILL ,SKILL-AGILITY> <CHECK-SKILL ,SKILL-CLOSE-COMBAT>>
		<TELL ,TEXT070-BLOCK>
		<TELL ,PERIOD-CR>
		<PREVENT-DEATH ,STORY070>
		<STORY-JUMP ,STORY092>
		<RETURN>
	)>
	<COND (,RUN-ONCE
		<TEST-MORTALITY 3 ,DIED-FROM-INJURIES ,STORY070>
	)>
	<COND (<IS-ALIVE>
		<TELL ,TEXT070-CONTINUED>
		<TELL ,PERIOD-CR>
	)>>

<ROOM STORY071
	(DESC "070")
	(EVENTS STORY071-EVENTS)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY071-EVENTS ()
	<COND (<CHECK-SKILL ,SKILL-PILOTING> <RETURN ,STORY115>)>
	<RETURN ,STORY137>>

<CONSTANT TEXT072 "\"We've done it!\" you cry. \"Now to destroy the Heart.\"||But Singh shakes his head. \"Nonsense. I have honoured our agreement thus far, but only to ensure success. Now we must decide which of us survives to claim the power.\"||\"Hardly an even battle.\" You nod at the powerful mantramukta cannon in his hands.||He tosses the cannon aside. In his belt is tucked a nozzle that tells you it is in fact a modified laser.">
<CONSTANT CHOICES072 <LTABLE "use a" "otherwise">>

<ROOM STORY072
	(DESC "072")
	(STORY TEXT072)
	(CHOICES CHOICES072)
	(DESTINATIONS <LTABLE STORY283 STORY305>)
	(REQUIREMENTS <LTABLE BARYSAL-GUN NONE>)
	(TYPES <LTABLE R-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT CHOICES073 <LTABLE "take the elevator to the library" "the medical lounge" "the gymnasium" "the armoury" "the canteen" "you have pushed your luck far enough and wish to leave before your deception is uncovered">>

<ROOM STORY073
	(DESC "073")
	(CHOICES CHOICES073)
	(DESTINATIONS <LTABLE STORY006 STORY204 STORY051 STORY447 STORY094 STORY311>)
	(TYPES SIX-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT074 "The carriage gathers speed. You sit at the front and stare through the window at the darkness rushing by. Hours pass before you see the glimmer of lights along the tunnel. The carriage glides to a halt at a station lit by dull red lights. You stand up, but the doors do not open. Instead the motilator gives a placid announcement: \"We have arrived at a restricted area. We will now proceed to Maka, where you will be able to transfer to another vehicle for your onward journey. We apologize for any inconvenience.\"||Again the carriage picks up speed, this time for a journey of less than two hours. Arriving at another terminal, you wait to see what other destinations the motilator will offer. On the map, only Tarabul continues to flash.">
<CONSTANT CHOICES074 <LTABLE "either take the subway there" "disembark and see where you are">>

<ROOM STORY074
	(DESC "074")
	(STORY TEXT074)
	(CHOICES CHOICES074)
	(DESTINATIONS <LTABLE STORY031 STORY375>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT075 "\"What's that, what's that?\"||You silt bolt upright and stare around. The voice you heard was jarringly strange: humanlike, but not quite human. Nerves tingling, you scan the undergrowth.||Teeth snare your shoulder and you cry out in pain and surprise.">
<CONSTANT TEXT075-CONTINUED "You look up to see an uncanny beast peering down at you. Stretched between the branches, its body is a tent of leathery wing-flaps. Its head is a narrow snout filled with teeth, swaying on a long flexible neck. It watches you with small glittering eyes and croaks, \"What's that?\"||Nothing nice, that's for sure.">
<CONSTANT CHOICES075 <LTABLE "use" "otherwise">>

<ROOM STORY075
	(DESC "075")
	(STORY TEXT075)
	(PRECHOICE STORY075-PRECHOICE)
	(CHOICES CHOICES075)
	(DESTINATIONS <LTABLE STORY096 STORY118>)
	(REQUIREMENTS <LTABLE SKILL-SHOOTING NONE>)
	(TYPES <LTABLE R-SKILL R-NONE>)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY075-PRECHOICE ()
	<COND (,RUN-ONCE
		<TEST-MORTALITY 1 ,DIED-FROM-INJURIES ,STORY075>
	)>
	<IF-ALIVE ,TEXT075-CONTINUED>>

<CONSTANT TEXT076 "\"I have been travelling for weeks,\" you reply curtly, \"and I will not be deterred from taking a good hot meal just because two slab-shouldered termagants want to drink themselves into a stupor.\"||A mutter of guarded approval goes around the other customers when they hear your tone of defiance. It is not exactly a cheer. Obviously the twins have kept everyone here tyrannized for hours.||You walk forward. One of the twins plants a hand in the middle of your chest. You seize it, apply a lock, and twist. She rolls out of the lock, bracing her arm against the bar and kicking up with strong yet fluid grace. You weave aside, block a punch from the other twin, and counter with a stiff-fingered strike to the solar plexus. She braces against the blow, taking it on muscles like steel cables. Her sister, springing upright, launches a kick at your kidneys which you barely avoid, the attack hitting you on the hip with bruising force.||The Jib-and-Halter Inn has never witnessed such a rough-house. Punches, kicks and brutal gouges lash back and forth while the other customers look on aghast.">
<CONSTANT TEXT076-CONTINUED "The twins finally step back and signal that they are prepared to end the fight.">
<CONSTANT CHOICES076 <LTABLE "agree" "insist on fighting on">>

<ROOM STORY076
	(DESC "076")
	(STORY TEXT076)
	(PRECHOICE STORY076-PRECHOICE)
	(CHOICES CHOICES076)
	(DESTINATIONS <LTABLE STORY164 STORY186>)
	(TYPES TWO-NONES)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY076-PRECHOICE ()
	<COND (,RUN-ONCE <TEST-MORTALITY 3 ,DIED-IN-COMBAT ,STORY076 ,SKILL-CLOSE-COMBAT>)>
	<IF-ALIVE ,TEXT076-CONTINUED>>

<CONSTANT TEXT077 "Bador expresses dismay when you tell him you intend to cross the Ice Wastes. \"By your father's beard! Do you wish to become a corpse with hoarfrost in your veins? Put aside all thought of such a scheme, I pray you!\" You cannot help smiling. \"What?\" says Bador, starting to weep. \"Do you mock my concern?\"||You place a hand on his sleeve. \"Calm yourself. You and I are strangers, and you already have your fee. Do not allow thought of my death to upset you, but give me advice on how to avoid such a fate.\"||\"Only the barbarian Ebor venture into the Sahara, and even they go no further that its fringes. It is a place of ghosts and devils, and the wind is like flint.\"||\"The Ebor? A nomad tribe? How do they survive?\"||\"They have burreks, shaggy thick-necked beasts that grow folds of fat. When the blizzard comes, the Ebor rider shelters by his burrek and bleeds the animal, frying up a blood pudding to sustain him.\" Bador grimaces to show what he thinks of such a custom.">
<CONSTANT CHOICES077 <LTABLE "ask what he knows about the city" "about Giza" "the best place to spend the night" "you have learned all you need and want to send him away">>

<ROOM STORY077
	(DESC "077")
	(STORY TEXT077)
	(CHOICES CHOICES077)
	(DESTINATIONS <LTABLE STORY143 STORY059 STORY099 STORY095>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT078 "The flyer slowly drifts into the air on streamers of lambent gas. As the main thrusters engage, it picks up speed and goes roaring up into the heavens. A flash of sunlight glances off the hull as it veers towards the east. You watch until it is lost in the soft blue haze.||You set out on foot until you come to a shore of white sand, which you follow north to a ferry building. A group of men emerge and appraise you with suspicious glances before showing you to the ferry boat, a single-masted schooner that has seen better days. Two or three other passengers are already aboard, and on seeing you one of them says, \"Good! Now the ferry is full, we can set sail for Port Sudan.\"">
<CONSTANT TEXT078-CONTINUED "Moonlight is making such a creamy track in the water by the time you reach Sudan, a village of wooden huts huddled within the vast shell of an abandoned city wall. The boat sweeps in across the harbour, guided by a flaring beacon, and moors at a jetty reeking of fish. The streets are empty , and it is obviously too late to find a hostelry for the night, so you decide to sleep on the boat. The ferrymen are averse to this, insisting they should be paid more for providing you with accommodation as well as transport, but the other passengers are encouraged by your lead. \"You were happy enough to keep us waiting two days until you had enough passengers for the journey,\" snaps one.||At last the ferrymen sullenly agree. You sleep until dawn tinges the sky with the colour of a candle flame.">
<CONSTANT CHOICES078 <LTABLE "do some shopping in Sudan" "you are eager to set out for Du-En">>

<ROOM STORY078
	(DESC "078")
	(STORY TEXT078)
	(PRECHOICE STORY078-PRECHOICE)
	(CHOICES CHOICES078)
	(DESTINATIONS <LTABLE STORY101 STORY234>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY078-PRECHOICE ()
	<COND (,RUN-ONCE <CHARGE-MONEY 1>)>
	<CRLF>
	<TELL ,TEXT078-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT079 "A thin searing beam spits through the air, burning a precise hole through the giant bometh's head. It utters a deep growl, takes two stumbling steps through the snow, and then falls. You hurry over to make sure of the kill. You would not want a wounded bometh stalking you through the night.">

<ROOM STORY079
	(DESC "079")
	(STORY TEXT079)
	(PRECHOICE STORY079-PRECHOICE)
	(CONTINUE STORY341)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY079-PRECHOICE ()
	<FIRE-BARYSAL 1>>

<CONSTANT TEXT080 "You find several items scattered across a bench at the back of the laboratory. These include a flashlight, a pair of binoculars, a set of polarized goggles, and a barysal gun. The gun has been opened for inspection, but it is a simple matter to secure the but and replace the screws. You check the power unit, finding two charges remaining.">
<CONSTANT CHOICES080 <LTABLE "descend the shaft to the bottom level" "ascend and leave the pyramid">>

<ROOM STORY080
	(DESC "080")
	(STORY TEXT080)
	(PRECHOICE STORY080-PRECHOICE)
	(DESTINATIONS <LTABLE STORY255 STORY361>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY080-PRECHOICE ()
	<COND (,RUN-ONCE
		<TAKE-OR-CHARGE 2 T>
		<SELECT-FROM-LIST <LTABLE FLASHLIGHT BINOCULARS POLARIZED-GOGGLES> 3 3>
	)>>

<CONSTANT TEXT081 "Gilgamesh stands rock-still beside you. You hear the soft whirr of a fan sucking air into his chest-plate. Then he announces that the air here is toxic.||\"How toxic? The trees seem to survive well enough.\" You brush midges away from your face. \"And insects.\"||\"They are adapted to the conditions here,\" replies Gilgamesh in his abrupt mechanical voice. \"Trace elements may cause cancer in higher life forms.\"||\"After how long?\"||\"Unknown. Even one day's exposure is potentially hazardous. Recommend you take precautions to filter your air supply or leave the vicinity">
<CONSTANT CHOICES081 <LTABLE "stay and rest for a few days" "depart as Gilgamesh suggests">>

<ROOM STORY081
	(DESC "081")
	(STORY TEXT081)
	(PRECHOICE STORY081-PRECHOICE)
	(CHOICES CHOICES081)
	(DESTINATIONS <LTABLE STORY103 STORY426>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY081-PRECHOICE ()
	<COND (<CHECK-ITEM ,GAS-MASK> <STORY-JUMP ,STORY169>)>>

<CONSTANT TEXT082 "The moon rises, wreathed in a haze of frost. In the crisp cold light, the ancient halls and towers look more than half unreal. You watch the others huddled by their campfires. No one else has much to say. Each of them is absorbed in private hopes, dreams and fears of what tomorrow will bring. When the Heart is found it will be every man for himself. Who would expect anything else, when the prize at stake is nothing less than the power of a god?||Vajra Singh and Thadra Bey have retreated to their respective tents and scarcely seem to invite conversation.">
<CONSTANT CHOICES082 <LTABLE "talk to one of the others -- either Chaim Golgoth" "Kyle Boche" "Janus Gaunt" "Baron Siriasis" "alternatively you could just turn in for the night">>

<ROOM STORY082
	(DESC "082")
	(STORY TEXT082)
	(CHOICES CHOICES082)
	(DESTINATIONS <LTABLE STORY126 STORY104 STORY148 STORY170 STORY192>)
	(TYPES FIVE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT083 "The sky is clear and blue, with high wisps of grey cloud. The snow crunches underfoot as you walk across the square to join Kyle Boche. Floating out of his tent comes the legless Baron Siriasis. You look around but the square is otherwise deserted apart from clumps of servants waiting beside the tents.||\"The others have already descended,\" Boche tells you and the baron. \"Vajra Singh went with Golgoth, down through the main temple complex. Thadra Bey took herself alone into the adjoining subway tunnels. Janus Gaunt was gone before I woke.\"||\"I suggest we three team up, then,\" says the baron briskly.||Boche nods. \"Agreed. If we find the Heart, our alliance holds until the other teams are dealt with. Where shall we descend?\"||Last night you noticed an icy crevice beside the building that Singh levelled with his mantramukta cannon. You point it out to the others. \"It looks to give onto the cellars, and there may be a way through to the temple catacombs below.\"||The baron gazes down into the crevice, then gives a curt nod. \"I sense it is a favourable route. It will lead us to the Heart.\"">

<ROOM STORY083
	(DESC "083")
	(STORY TEXT083)
	(PRECHOICE STORY083-PRECHOICE)
	(CONTINUE STORY039)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY083-PRECHOICE ()
	<COND (<CHECK-VEHICLE ,MANTA-SKY-CAR> <STORY-JUMP ,STORY017>)>>

<CONSTANT TEXT084 "You see the air twist inside out as the baron projects a bolt of psychic force against the oncoming creature. Like Boche's gun blast, the bolt is deflected by its shield of metal legs. \"It is a robot, immune to paradoxing,\" shouts the baron. \"We must retreat!\"||You have abetter idea. You may not be as powerful a psionic as Baron Siriasis, but that only means you've learned to be smarter. Instead of channelling your psi-force as a direct bolt, you use it to transmute the blue fluid that fills the glass bubble. Within moments the gnarled little homunculous inside is floating in acid. The thing rears up on its long legs like a dying spider, then topples to the floor. By the time you go over to look, the body inside has entirely dissolved away.||\"Not a robot,\" you say to the startled baron, \"but a cyborg. You should have attacked the organic part.\"||He glares at you, then gives a curt nod of respect. \"It seems I can still learn new tricks of my craft, even from a youngster like you.\"||Together you head on to the end of the passage.">

<ROOM STORY084
	(DESC "084")
	(STORY TEXT084)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT085 "The brain reaches you. Its single remaining eye glares into yours, seeming to burn your soul like a lens focusing the rays of the sun. Your veins and arteries feel as though they are filled with ice water. Thoughts which are not your own intrude upon your mind. You are locked in a psychic contest for possession of your living body!">
<CONSTANT TEXT085-END "You can do nothing to save yourself, and darkness closes over your soul as Baron Siriasis claims your body as his own">

<ROOM STORY085
	(DESC "085")
	(STORY TEXT085)
	(PRECHOICE STORY085-PRECHOICE)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY085-PRECHOICE ()
	<COND (<AND <CHECK-SKILL ,SKILL-ESP> <CHECK-SKILL ,SKILL-PARADOXING>>
		<PREVENT-DEATH ,STORY085>
		<STORY-JUMP ,STORY151>
		<RETURN>
	)>
	<CRLF>
	<TELL ,TEXT085-END>
	<TELL ,PERIOD-CR>>

<ROOM STORY086
	(DESC "086")
	(EVENTS STORY086-EVENTS)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY086-EVENTS ()
	<COND (<CHECK-SKILL ,SKILL-ESP> <RETURN ,STORY065>)>
	<RETURN ,STORY240>>

<CONSTANT TEXT087 "Boche falls to your first shot. His death acts as a signal for the start of hostilities. Golgoth and Singh, in no doubt that each is the most dangerous foe, whirl to face each other. Golgoth's first shot hisses into sparks on Singh's armour as the Sikh warlord raises his mighty mantramukta cannon.">

<ROOM STORY087
	(DESC "087")
	(STORY TEXT087)
	(PRECHOICE STORY087-PRECHOICE)
	(CONTINUE STORY410)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY087-PRECHOICE ()
	<FIRE-BARYSAL 1>>

<CONSTANT TEXT088 "Gargan XIV closes in on you. Gargan XIII draws a knife and looks down at Golgoth, in no hurry to finish him off. Suddenly he looks up with abroad smile. She was wrong in thinking him beaten. To the contrary, he has the look of a cat who has trapped two very large mice.">

<ROOM STORY088
	(DESC "088")
	(STORY TEXT088)
	(CONTINUE STORY154)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT089 "There is no love lost between you and the Gargan twins. Seeing you square off warily against them, Janus Gaunt tries to defuse the situation, saying. \"Come now, we must set aside past differences. Until we can locate the Heart, a state of truce must apply.\"||\"Truce? That word is a refuge for cowards,\" Gargan XIV hisses at him, while never letting her molten gaze stray from you.||\"Du-En's getting overcrowded,\" says Gargan XIII as she takes a step towards you. \"Someone has to put the rubbish out.\"||You flick a glance at Gargan XIV. While her sister kept your attention, she has drawn a gun. You leap to one side just as a thin beam of energy spits past your shoulder and sears a gobbet of molten stone out of the wall behind. Gargan XIII drops into a crouch and comes stamping forward to grapple you, but you throw one of Gaunt's glassy-eyed xoms towards her and duck away behind the weathered stump of a pillar.||In the tense atmosphere of the camp, the squabble acts like a spark in a powder keg. Within seconds everyone is preparing for full-scale battle. Boche dives through an open doorway just in time to avoid Thadra Bey's throwing-dagger. An ectoplasmic aura crackles around Baron Siriasis as he marshals his psychic force. With a thoughtful frown, Chaim Golgoth draws his gun and steps back looking for a target. Janus Gaunt panics and shouts to his xom servants, \"Kill everyone! Protect me!\"||Then a voice rips like thunder across the square: \"Stop this senseless fighting now!\" and turning, you have your first view of the mighty Vajra Singh.">

<ROOM STORY089
	(DESC "089")
	(STORY TEXT089)
	(CONTINUE STORY300)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT090 "\"Is it dead?\" says Boche.||You snap an icicle from under the ledge and drive it deep into the grotesque pulpy head. The creature gives a single spasm and lies still. \"It is now.\"||You roll the body over to inspect it and are almost overcome by a wave of nausea. It is the most loathsome thing you have ever seen: a thin malformed body with a bloated mauve-pink head. The only facial feature is a long thick stalk ending in the cyclopean eye, now thankfully dimmed by the glaze of death. The scalp is covered with tiny orifices like gaping eyelids. Are they breathing holes? Sensory organs? There is no way to tell.||Boche joins you beside the body. \"It's a mutant.\"||You nod. \"That's for sure, but a mutant what?\"">
<CONSTANT CHOICES090 <LTABLE "follow the creature's tracks back to its lair before the snow covers them" "wait where you are until dawn">>

<ROOM STORY090
	(DESC "090")
	(STORY TEXT090)
	(CHOICES CHOICES090)
	(DESTINATIONS <LTABLE STORY134 STORY310>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT091 "You piece together a jigsaw of legend, superstition and historical fact. The Heart fell from the sky: an unearthly gemstone that became the focus of a crazed cult. The cult used the Heart's miraculous power to wage the Paradox war. Now it lies buried under the ruined city of Du-En, and the one who retrieves it will become mightier than any man has ever been.||\"Why, then, did the civilization of Du-En fall?\" you ask a scholar at the library.||\"Its rulers went mad. No one could wield such power and stay sane.\"||\"Do you know it for a fact, or is it just your own theory?\"||But his only answer to that is a whimsical smile.">

<ROOM STORY091
	(DESC "091")
	(STORY TEXT091)
	(PRECHOICE STORY091-PRECHOICE)
	(CONTINUE STORY025)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY091-PRECHOICE ()
	<COND (<OR <CHECK-SKILL ,SKILL-STREETWISE> <CHECK-ITEM ,VADE-MECUM>>
		<STORY-JUMP ,STORY157>
	)(<CHECK-SKILL ,SKILL-LORE>
		<STORY-JUMP ,STORY414>
	)>>

<CONSTANT TEXT092 "By the front desk of the inn there is a notice-board where posters are pinned up for the perusal of bounty hunters. You scan the pictures of wanted criminals to see if any resemble the two men who attacked you, but without success. When you ask the innkeeper, he shrugs and says that people are constantly coming and going. \"I cannot keep track of all the riff-raff of Venis.\"||\"But I might very easily have been murdered.\"||His only answer to this is to point to a sign on the wall which reads: 'The management is not responsible for the safety of customers or their belongings.' You give him a glowering look, then turn and stride out of the inn. A walk in the night air will help you to cool off.">

<ROOM STORY092
	(DESC "092")
	(STORY TEXT092)
	(CONTINUE STORY329)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT093 "You lay out the contents of the storage compartment on the floor beside the vehicle. There are ten food packs, a medical kit, a flashlight, a cold-weather suit and a length of nylon rope.">

<ROOM STORY093
	(DESC "093")
	(STORY TEXT093)
	(PRECHOICE STORY093-PRECHOICE)
	(CONTINUE STORY395)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY093-PRECHOICE ()
	<TAKE-FOOD-PACKS 10>
	<SELECT-FROM-LIST <LTABLE MEDICAL-KIT FLASHLIGHT COLD-WEATHER-SUIT ROPE> 4 4>>

<CONSTANT TEXT094 "The canteen is located at the top of the building, with wide windows giving a breathtaking view over the city. You stand and look out for a few minutes at the tall towers wreathed in swirling fog. Below, a dark patch of woodland studded with mistily sparkling lamps can only be the infamous Claustral Park.||The canteen has no human attendants, just a food dispenser which brings forth foil-wrapped packs at the touch of a button.">
<CONSTANT TEXT094-CONTINUED "As you are leaving the canteen, you almost collied with a huge Fijian in a trim black suit and mirror glasses. He grunts an absent-minded apology and hurries past, staring urgently around the room. He is the only other person you have seen in the building who doesn't seem to be an employee here. You are about to head off towards the elevator when he calls after you, \"Hey, who are you?\"">
<CONSTANT CHOICES094 <LTABLE "use a" "use" "try" "you had better run for it">>

<ROOM STORY094
	(DESC "094")
	(STORY TEXT094)
	(PRECHOICE STORY094-PRECHOICE)
	(CHOICES CHOICES094)
	(DESTINATIONS <LTABLE STORY227 STORY248 STORY269 STORY290>)
	(REQUIREMENTS <LTABLE <LTABLE BARYSAL-GUN> SKILL-CLOSE-COMBAT SKILL-CUNNING NONE>)
	(TYPES <LTABLE R-ALL R-SKILL R-SKILL R-NONE>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY094-PRECHOICE ()
	<COND (,RUN-ONCE <TAKE-FOOD-PACKS 8>)>>

<CONSTANT CHOICES095 <LTABLE "make use of an" "try to find out about Baron Siriasis" "Chaim Golgoth" "Gilgamesh" "the Sphinx" "you are ready to get some rest">>

<ROOM STORY095
	(DESC "095")
	(CHOICES CHOICES095)
	(DESTINATIONS <LTABLE STORY401 STORY422 STORY380 STORY011 STORY311>)
	(REQUIREMENTS <LTABLE ID-CARD NONE NONE NONE NONE>)
	(TYPES <LTABLE R-ITEM R-NONE R-NONE R-NONE R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT096 "The blast hisses in the dank steamy air. Blue plasma-fire burns through the creature's neck. It utters a bleak wail of distress and falls crashing to the ground, where you finish off the twitching carcass with a heavy stone.||The wound in your shoulder is beginning to throb. You clean it with some leaves, then tear strips from the lining of your jacket to make a bandage. Lying back against the log, you feel slightly giddy, but this is no place to rest. There might be more of those creatures about. Hauling yourself to your feet, you lumber off in search of a safer place to hole up.">

<ROOM STORY096
	(DESC "096")
	(STORY TEXT096)
	(PRECHOICE STORY096-PRECHOICE)
	(CONTINUE STORY228)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY096-PRECHOICE ()
	<FIRE-BARYSAL 1>>

<CONSTANT TEXT097 "The nearest man stabs his knife at your heart. You deflect the blow with an open-handed block to his wrist, then sidestep in close to deliver two swift elbow strikes across his face. As he sags, you pluck the knife out of his fingers. The angle is wrong to get the man with the gun, so you cast the knife at each other. It catches him in the shoulder and he falls back with a grunt.||The man with the gun is about to fire. You throw yourself into a forward roll, hearing the blast crack overhead and explode against the wall. Scissoring your legs, you thrust him off-balance before he can take another shot. He topples into the fire, his frightened yelp cut brutally short as his head hits a rock.||Before you can get to your feet, the man with the knife in his shoulder comes lumbering forward and tries to stomp you in the guts. You jerk aside, catch his ankle, and bring him down backwards across your hip, where a swift powerful twist ends the struggle.||You search the shelter. The barysal gun has one charge left. You also find two knives, a set of polarized goggles, and cold weather clothes, binoculars, and six food packs.">
<CONSTANT TEXT097-CONTINUED "Then you wait for the blizzard to blow itself out before you emerge into the crisp snow outside">

<ROOM STORY097
	(DESC "097")
	(STORY TEXT097)
	(PRECHOICE STORY097-PRECHOICE)
	(CONTINUE STORY393)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY097-PRECHOICE ()
	<TAKE-OR-CHARGE 1 T>
	<TAKE-FOOD-PACKS 6>
	<TAKE-QUANTITIES ,KNIFE "knives" "How many knives will you take" 2>
	<SELECT-FROM-LIST <LTABLE POLARIZED-GOGGLES COLD-WEATHER-SUIT BINOCULARS> 3 3>>

<CONSTANT TEXT098 "Your gun is barely out of its holster before one of the twins flicks her wrist and sends a splash of fiery vodka into your eyes. The gun discharges with a sizzling crack. You stumble back, wiping your face. A kick lashes out, striking the gun from your hands. Strong fingers seize your head. There is no time to act before your legs are swept out form under you. You topple, and a mighty twist from your assailant breaks your neck. Your die in an unseemly tavern brawl.">

<ROOM STORY098
	(DESC "098")
	(STORY TEXT098)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT099 "He is emphatic that you should on no account sleep in Claustral Park. \"It is unsafe after nightfall,\" he says, wagging his finger. \"The claustrals are barely deterred from entering the streets as it is.\"||\"What are claustrals?\"||He jerks back in exaggerated surprise. \"Do you truly not know? They are rank fiends -- creatures that are the reverse of men. They flourish in the darkness, cold and filth; they abjure sunlight and goodness. Their food is the decaying remains of the dead.\" His fat jowls shudder with fright.||\"Decaying flesh? So why would they hunt a living person? Possibly the claustrals are simply figments of a fairy tale.\"||He looks at you sadly, as though at a person who had lost their wits. \"Do not allow your cynicism to tempt you into the park,\" he maintains.||\"So where should I stay?\"||\"The Ossiman Hotel is best. If you cannot afford a hotel, avoid the backstreets, where muggers lurk. If you must, sleep by the gratings on Fishermonger Plaza. It is well lit, warm, and there are plenty of folk around all through the night.\"">
<CONSTANT CHOICES099 <LTABLE "ask his advice about the Sahara" "about Giza" "or about Kahira itself" "you can dismiss him">>

<ROOM STORY099
	(DESC "099")
	(STORY TEXT099)
	(CHOICES CHOICES099)
	(DESTINATIONS <LTABLE STORY077 STORY059 STORY143 STORY095>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT100 "You continue on, watching the sun slide dankly down into the west. A silvery afterglow rims the skyline. Pale humps of snow extend to the murky horizon, divided by hollows brimming with violet shadow. Catching a movement out of the corner of your eye you freeze, slowly turning to see a huge sabre-fanged bometh standing on a rise not fifty metres away. You slink back behind an ice boulder, not certain if the creature saw you.">
<CONSTANT CHOICES100 <LTABLE "attack the bometh with a charged barysal gun" "or with a stun grenade" "close with it" "track it" "creep off before it spots you">>

<ROOM STORY100
	(DESC "100")
	(STORY TEXT100)
	(PRECHOICE STORY100-PRECHOICE)
	(CHOICES CHOICES100)
	(DESTINATIONS <LTABLE STORY079 STORY145 STORY277 STORY319 STORY298>)
	(REQUIREMENTS <LTABLE SKILL-SHOOTING STUN-GRENADE NONE BINOCULARS NONE>)
	(TYPES <LTABLE R-SKILL R-ITEM R-NONE R-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY100-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-ENKIDU>
		<STORY-JUMP ,STORY123>
	)(<CHECK-SKILL ,SKILL-SURVIVAL>
		<STORY-JUMP ,STORY256>
	)>>

<CONSTANT TEXT101 "You stroll around the market, but there is little on offer here. If you wish to buy a fur coat, it will cost 5 scads. You can buy food packs for 4 scads each; these consist of fish, oil and grain dried into blocks, each giving rations for several days.">
<CONSTANT TEXT101-CONTINUED "A small girl follows you along the dusty street singing a ditty:||\"Out across the Ice Wastes,|Yellow steam and snow,|Cough your gust and freeze to death,|A silly way to go.\"||No doubt the same rhyme has been repeated by children here for many generations. For some reason you find it more discouraging than any amount of sage advice. Not for the first time, you find yourself wondering if you are mad to consider a journey across the daunting Saharan plains. Still, when life on Earth is guttering like a candle about to blow out, only a fool makes plans for the future. You square your shoulders and turn to the west">

<ROOM STORY101
	(DESC "101")
	(STORY TEXT101)
	(PRECHOICE STORY101-PRECHOICE)
	(CONTINUE STORY234)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY101-PRECHOICE ()
	<COND (<AND <G=? ,MONEY 5> <NOT <CHECK-ITEM ,FUR-COAT>>>
		<CRLF>
		<TELL "Buy " CT ,FUR-COAT "?">
		<COND (<YES?>
			<CHARGE-MONEY 5>
			<TAKE-ITEM ,FUR-COAT>
		)>
	)>
	<BUY-FOOD-PACK 4>
	<CRLF>
	<TELL ,TEXT101-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT102 "You are halfway across the tarmac when you realize your mistake. The pilot of the flyer has already engaged the boosters. You see him at the cockpit window, his face contorting in surprise and shock at the sight of you racing towards the craft. Your last image is of him jabbing desperately at the controls, but he is too late to abort the booster ignition. An instant later, a blast of white/hot gas bursts from the landing jets and billows up to press a wave of solid heat into your face. Blinding light burns into your retinas, followed by darkness and oblivion.">

<ROOM STORY102
	(DESC "102")
	(STORY TEXT102)
	(PRECHOICE STORY102-PRECHOICE)
	(CONTINUE STORY122)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY102-PRECHOICE ()
	<TEST-MORTALITY 5 ,DIED-FROM-INJURIES ,STORY102>>

<CONSTANT TEXT103 "You build a lean/to beside the bubbling pool in the shelter of dwarf conifers. You soon discover that the water of the pool is tainted with volcanic gases, but when you need to drink it is easy enough to collect snow from beyond the edge of the oasis and bring it back to camp to melt.||Food is more difficult to come by. The birds you saw when you first arrived prove to be very timid, and canny enough not to let you catch them. If someone had told you even two weeks ago that you would be eagerly chewing grubs and insects for sustenance, you would have laughed them to scorn. At least the hot gases rising from clefts in the rocks mean that you can bake the insects before eating them.">
<CONSTANT TEXT103-CONTINUED "On the morning of your second day at the oasis, you notice a slight feeling of nausea, and begin to wonder whether the sulphur-tinged air is affecting your health">
<CONSTANT CHOICES103 <LTABLE "leave the oasis and head on" "stay for a few days more">>

<ROOM STORY103
	(DESC "103")
	(STORY TEXT103)
	(PRECHOICE STORY103-PRECHOICE)
	(CHOICES CHOICES103)
	(DESTINATIONS <LTABLE STORY426 STORY015>)
	(REQUIREMENTS <LTABLE CODEWORD-HOURGLASS NONE>)
	(TYPES <LTABLE R-GAIN-CODEWORD R-NONE>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY103-PRECHOICE ()
	<COND (,RUN-ONCE <GAIN-LIFE 2>)>
	<TELL ,TEXT103-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT104 "Boche struts around the fire under the colonnade while outlining his plans for how you will share the power of the Heart. Lost in your own deep reverie, you hardly hear his words. Finally you look up and ask him, \"Why do you want ultimate power, Boche?\"||He stops short and looks at you sharply. For a moment you think he is about to give you a straight answer, but no. \"What are you saying? Are you having doubts? Surely not, when we are on the verge of triumph. You must not be so timid!\"">
<CONSTANT CHOICES104 <LTABLE "suggest an alliance" "you would rather get some sleep">>

<ROOM STORY104
	(DESC "104")
	(STORY TEXT104)
	(CHOICES CHOICES104)
	(DESTINATIONS <LTABLE STORY236 STORY192>)
	(REQUIREMENTS <LTABLE <LTABLE CODEWORD-NEMESIS> NONE>)
	(TYPES <LTABLE R-CODEWORD R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT105 "Even though the three of you are helpless, Gilgamesh can still act. Lunging forward through the swirling vapour, he seizes the gnarled phantom in his arms and carries it on stiff strides to the edge of the chasm. It shrieks and twists in his grasp, flowing and distorting like a painting in the rain. Sparks cascade from Gilgamesh's visor as it sinks its fingers under his armour. For a long instant they both stand there, wreathed in white mist, struggling for the upper hand. Then Gilgamesh steps forward over the edge and he and the creature drop out of sight. You hear its thin bleating cry echo up from the depths and then there is silence. When you run to the chasm and look down, you find no trace of either the phantom or your loyal automaton.">

<ROOM STORY105
	(DESC "105")
	(STORY TEXT105)
	(PRECHOICE STORY105-PRECHOICE)
	(CONTINUE STORY149)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY105-PRECHOICE ()
	<DELETE-CODEWORD ,CODEWORD-ENKIDU>>

<CONSTANT TEXT106 "The thing comes stalking forward, feeling its way while keeping its front legs raised as a shield. You have already seen that gunfire cannot penetrate the tough metal alloy. The glass case in the centre is another matter, though. You roll your grenade along the floor of the passage and pull the others back to a safe distance. There is a loud bang. The grenade is designed only to stun a living target, but the explosion cracks the glass and the blue fluid gushes out. As it does, the thing rears up like a dying spider, falls with a twitching of its robotic legs, and lies still.||Boche nervously goes over to look at it. The little embryo inside the glass case lies as inert as a lump of cold clay. \"It's dead,\" he says. In stunned silence, the three of you head on to the end of the passage.">

<ROOM STORY106
	(DESC "106")
	(STORY TEXT106)
	(PRECHOICE STORY106-PRECHOICE)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY106-PRECHOICE ()
	<LOSE-ITEM ,STUN-GRENADE>>

<ROOM STORY107
	(DESC "107")
	(EVENTS STORY107-EVENTS)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY107-EVENTS ()
	<COND (<CHECK-CODEWORD ,CODEWORD-MALLET>
		<DELETE-CODEWORD ,CODEWORD-MALLET>
		<RETURN ,STORY195>
	)>
	<RETURN ,STORY217>>

<CONSTANT TEXT108 "Golgoth had the same idea. You come face to face with him on the edge of the smoke cloud. Instead of a gun, he has a crossbow in his hands. He shoots, but you are already dodging and the bolt only opens a gash across your shoulder.">

<ROOM STORY108
	(DESC "108")
	(STORY TEXT108)
	(PRECHOICE STORY108-PRECHOICE)
	(CONTINUE STORY326)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY108-PRECHOICE ()
	<TEST-MORTALITY 2 ,DIED-FROM-INJURIES ,STORY108>
	<COND (<AND <IS-ALIVE> <CHECK-SKILL ,SKILL-SHOOTING>> <STORY-JUMP ,STORY304>)>>

<CONSTANT TEXT109 "Vajra Singh had the same idea at the same time. Golgoth's gaze snaps form Singh to you, but he hesitates a moment too long. Your shot hits first, and Golgoth crumples to the floor. Singh wastes no time taking stock of the situation, swinging his mantramukta cannon around to point at you. Boche seizes his chance to take a shot, but it spatters off Singh's armour. It is the last thing you see, since a moment later you are blasted out of existence by the fiery roar of the mantramukta.">

<ROOM STORY109
	(DESC "109")
	(STORY TEXT109)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT110 "After Gargan XIII's wound has been seen to, you spend another hour searching the bomb shelter. You find a canteen, but the food is unsealed and spoiled. At last you have to accept that you will not get access to the Shrine of the Heart from here. Weary and disappointed, you head back to the ventilation duct.||\"You know the theory that the Heart was formed in the Big Bang?\" says Golgoth to you. \"The boffins say it's actually another universe, like a seed that didn't quite get started. I read somewhere that the same thing happens with people. Often you start off with a twin in the womb, but that twin gets reabsorbed into you. In some people, the process happens quite late in the foetus's development. Occasionally the vestigial remains of the unborn twin is found inside a cyst -- you know, tiny limbs, a nubbin of a heart, and so on. It might be true of any of us\"||You wonder why he is telling you this rather ghoulish bit of medical lore when one of the Gargan sisters interrupts. \"That is only true for those born in the inferior natural way, inside a womb. My sisters and I were all carefully nurtured and grown to maturity. The artificial wombs guaranteed perfect nutrient balance.\"||Golgoth laughs at her proud remarks. It seems to you he is deliberately provoking her. \"Your own twin sisters were all fine specimens of womanhood,\" he replies. \"I should know; it was me that killed all twelve of them.\"||You have not taken in what Golgoth said before Gargan XII explodes into action. Roaring in fury, she grabs Golgoth's shoulder and spins him around. His gun is in his hand and it looks to you that he might have got off a shot, but Gargan XIII slaps it away and knees him in the stomach. He reels back into Gargan XIV, who grabs him by the throat and dangles him like a rag doll. \"So this is the great Commander Golgoth, sister,\" she says contemptuously. \"Like all so-called natural humans, he is compared to our pure racial stock.\"||She tosses Golgoth aside and he slumps to the floor. You have a nasty feeling you'll be next.">
<CONSTANT CHOICES110 <LTABLE "order your automaton to attack" "step in to fight them yourself" "you can hold back to see what happens">>

<ROOM STORY110
	(DESC "110")
	(STORY TEXT110)
	(CHOICES CHOICES110)
	(DESTINATIONS <LTABLE STORY220 STORY044 STORY088>)
	(REQUIREMENTS <LTABLE <LTABLE CODEWORD-ENKIDU> NONE NONE>)
	(TYPES <LTABLE R-CODEWORD R-NONE R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT111 "After a cursory greeting, the others start to disperse back to their tents, Janus Gaunt tells you he has just brewed a pot of tea and invites you to join him. You are pleased enough to share the warmth of his fire, but when a xom hands you a teacup in its bloodless fingers you cannot suppress a shiver of dread.||Don't bother about them,\" he says with a laugh. \"They're just robots, really, except that they're made out of once-living tissue instead of plastic and metal. They're powered by a small electrochemical implant in the chest cavity.\"||\"They are an abomination against nature,\" says Boche flatly, draining his tea. \"Where do we get firewood?\"||Gaunt is taken aback by Boche's rudeness, but replies courteously: \"Take it from the buildings around the square. The mulberry window-shutters you are warming your hands over, for instance, date from tenth-century Persia. It is a pity to burn such artifacts as these, but the former owners have no more use for them.\"||Boche rises with a grunt and trudges off, entering a narrow doorway. You follow to find him flashing his torch around. \"Ah, here is some firewood already broken up for our convenience,\" he says.||\"It is mine,\" he purrs a voice of menace from the doorway. Thadra Bey stands there, muscles coiled taut in pantherish grace, a lethal dart-projector in her hand.||\"Down!\" roars Boche, cannoning into you from behind and sending you flying into Thadra Bey. You and she go rolling out into the snow, her dart singing through the air and narrowly missing Chaim Golgoth, who responds once by drawing his barysal gun. In seconds all hell has broken loose, as the uneasy truce splinters apart. Thadra Bey rakes her fingers across your face and leaps away, levelling her dart-projector, and you hear Gaunt yelling to his xoms, \"Defend me! Slay any who attack!\"||For a moment it seems that the struggle for power will be decided here and now. Then a voice rips like thunder across the square: \"Stop this senseless fighting now!\" and, turning, you have your first view of the mighty Vajra Singh.">

<ROOM STORY111
	(DESC "111")
	(STORY TEXT111)
	(CONTINUE STORY300)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT112 "With only a split-second left before the creature's gaze paralyses you, you act on raw instinct. Leaping high into the air, you somersault over its head, twisting so as to land directly behind it. The eyestalk sweeps frantically, trying to see where you went. But before the creature can bring its ghastly scrutiny to bear, you give it a hard blow across the back of the head. As it falls senseless in the snow, Boche recovers from the hypnotic trance. Even so, it is several seconds before he has recovered his wits enough to speak.">

<ROOM STORY112
	(DESC "112")
	(STORY TEXT112)
	(CONTINUE STORY090)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT113 "You soon find a man who can do what you want: a fat sweaty fellow with a profusion of ancient tools and devices strewn around his shop. Guiding his laser by hand, he makes a few deft changes to the image on the card until it could pass for your own likeness. \"Five scads,\" he says, holding it out to you.||\"Five?\" you scowl.||\"Membership of the prestigious Compass Society is usually much more expensive than that,\" he says with a shrug.||You consider snatching the card back, but the fat man cannily anticipates you and holds it close to the laser beam until you pay.">

<ROOM STORY113
	(DESC "113")
	(STORY TEXT113)
	(PRECHOICE STORY113-PRECHOICE)
	(CONTINUE STORY414)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY113-PRECHOICE ()
	<COND (<G? ,MONEY 4>
		<CRLF>
		<TELL "Agree to his terms?">
		<COND (<YES?>
			<CHARGE-MONEY 5>
		)(ELSE
			<EMPHASIZE "Since you refused to pay, he destroys the ID card.">
			<LOSE-ITEM ,ID-CARD>
		)>
	)(ELSE
		<EMPHASIZE "Since you cannot pay for it, he destroys the ID card.">
		<LOSE-ITEM ,ID-CARD>
	)>>

<CONSTANT TEXT114 "\"There's flaw in your story,\" you point out to the man as you scoop up the knife he dropped. You stroke the point against his neck, pricking the skin until a single drop of blood appears. He swallows nervously. You go on, \"Body snatchers don't use knives. There's too much risk of puncturing a vital organ -- damage to merchandise, you might say. They prefer garrottes and sedative sprays.\"||\"All right,\" he admits. \"We were hired to kill you.\"||\"Who?\" You prod him again with the knife.||\"Baron Siriasis.\"||You are puzzled. \"I've never heard of him. Why should he want me dead?\"||\"He didn't explain it to us. Apparently he regards you as a rival.\"||This is a mystery you can clear up later. Telling the surviving assassin to make himself scarce, you dry yourself off and get dressed.">

<ROOM STORY114
	(DESC "114")
	(STORY TEXT114)
	(PRECHOICE STORY114-PRECHOICE)
	(CONTINUE STORY092)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY114-PRECHOICE ()
	<ASSASSINS-LOOT 2 10>>

<CONSTANT TEXT115 "You settle at the controls of the sky-car and touch the button to power it up. There is a deep hum, and slowly it rises into the air. Hovering at the height of a metre above the floor, you cautiously engage the thrusters. A blaze of blue-white light illuminates the rear wall as the sky-car cannons forward. Quickly you reduce thrust, adroitly steering towards the corridor leading to the entrance. A couple of times you bump the wings against the side walls, scratching to your great annoyance, the perfect matt-black paintwork. You must take care until you have got the hang of this vehicle.||As you emerge into the open, the gondo looks on aghast and then, turning with a yell, starts running clumsily off through the deep snowdrifts. You increase the speed to catch up. He drops flat as you roar overhead and swing around to hover beside him. He lies trembling with his arms over his head until you say, \"It's just me.\"||He looks up, \"I thought you were a flying monster!\"||\"You should have looked twice before you panicked,\" you say with a laugh.||After some urging, the gondo warily clambers up and slides into the seat beside you. \"Is there any roof to shield the cockpit?\" he asks.||\"Apparently not. Remember that when the Manta sky-car was in common use, people go about in thin clothing without the fear of freezing to death.\"||You steer back towards Venis. The outward journey took a couple of hours; returning is a matter of minutes.">

<ROOM STORY115
	(DESC "115")
	(STORY TEXT115)
	(PRECHOICE STORY115-PRECHOICE)
	(CONTINUE STORY159)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY115-PRECHOICE ()
	<TAKE-VEHICLE ,MANTA-SKY-CAR>
	<COND (<CHECK-CODEWORD ,CODEWORD-DIAMOND> <STORY-JUMP ,STORY181>)>>

<CONSTANT TEXT116 "The computer terminals are only intended to access the library catalogue, but you have no trouble routing into the building's administrative computer and then opening an outside line via the rooftop satellite dish. Like most organizations with the ability to connect into global communications, the Society protects its system from accidental linkage into Gaia by the use of a filter program. This is necessary to prevent infection by the same viruses that are resident in Gaia, as well as to stop Gaia from taking over the Society's whole system for her own use.||You set a standard filter-override program running. It should take a few minutes, and to kill time you run a check on other users who have logged into the system recently. Only one name is displayed: Janus Gaunt. He requested all the Society's records regarding the Heart of Volent. Intrigued, you call up his biofile. The screen shows a round-faced man with extremely white skin and hair like silver floss. Flicking idly through the data, you find he has a reputation for outstanding work in the fields of bioengineering and nanotechnology. The address of his mansion causes you a double-take; it is located in the Paris catacombs. You were not even sure Paris still existed.||The terminal bleeps, informing you the link with Gaia is ready. You switch over. When you type in your query about the Heart, Gaia's response is swift: THE HEART MUST BE DESTROYED. ACTIVATION OF ITS POWER WILL CRASH THE UNIVERSE, WIPING OUT ALL THAT EXISTS.||You reply: INCLUDING EARTH?||EVERYTHING, Gaia tells you. BARYSAL BOMBARDMENT CAN CAUSE A CRITICAL RESONANCE. DESTROYING THE HEART'S CRYSTALLINE STRUCTURE. TWO SIMULTANEOUS BOMBARDMENTS MUST BE MADE, THE BEAMS PHASED AND CROSSING AT RIGHT ANGLES.||This is awkward. From what you have heard, the Heart is a gem several metres across. To destroy it as Gaia suggests, you'd need an accomplice. And two barysal guns. You try to get further information, but the link is broken. Like a senile invalid, Gaia has lapsed back into her customary incoherence.">
<CONSTANT CHOICES116 <LTABLE "study the records on Heart of Volent" "you have finished in the library">>

<ROOM STORY116
	(DESC "116")
	(STORY TEXT116)
	(PRECHOICE STORY116-PRECHOICE)
	(CHOICES CHOICES116)
	(DESTINATIONS <LTABLE STORY182 STORY073>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-NEMESIS)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY116-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-LORE>
		<SET-DESTINATION ,STORY116 1 ,STORY160>
	)(ELSE
		<SET-DESTINATION ,STORY116 1 ,STORY182>
	)>>
<CONSTANT TEXT117 "\"It's been useful having you along,\" says Shandor, beaming his confident smile as he firmly shakes your hand. \"I'm sure you won't need my advice on getting by in Venis, resourceful as you are, so let me give you something else.\"||He reaches into a pocket and produces a monkey token which he touches to yours, automatically transferring the sum of 20 scads to you. You are about to protest when you notice the sum remaining on his token. He can well afford what he's paid to you.">
<CONSTANT TEXT117-CONTINUED "Bidding Shandor and his men farewell, you set off into Venis">

<ROOM STORY117
	(DESC "117")
	(STORY TEXT117)
	(PRECHOICE STORY117-PRECHOICE)
	(CONTINUE STORY334)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY117-PRECHOICE ()
	<GAIN-MONEY 20>
	<COND (<AND <CHECK-SKILL ,SKILL-CLOSE-COMBAT> <CHECK-ITEM ,SHORTSWORD>> <STORY-JUMP ,STORY008>)>
	<CRLF>
	<TELL ,TEXT117-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT118 "You jump to your feet and scramble through the undergrowth. The creature follows at a leisurely pace, squawking triumphantly from high in the branches. It claws its way effortlessly between the close spaced trunks, sometimes sailing out across clearings on the wide leathery kite of its body.">

<ROOM STORY118
	(DESC "118")
	(STORY TEXT118)
	(PRECHOICE STORY118-PRECHOICE)
	(CONTINUE STORY162)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY118-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL>
		<STORY-JUMP ,STORY206>
	)(<CHECK-SKILL ,SKILL-LORE>
		<STORY-JUMP ,STORY140>
	)>>

<CONSTANT TEXT119 "A lethal blue spike of light pierces the air, charring its way through the chest of the man with the gun. The knifeman blinks, starts to backpedal then realizes he has no choice but to attack you anyway. The instant's hesitation proves his undoing, as you have time to swing your gun around and unload a blast at point-blank range. The third man rushes in with a sob of desperate fury. You lash out with the but of the gun and he drops as though poleaxed.||You search the trapper's shelter. Their barysal gun has two charges left. You also find two knives, a set of polarized goggles, binoculars, and a cold-weather suit, and six food packs.">
<CONSTANT TEXT119-CONTINUED "Then you wait for the blizzard to blow itself out before you emerge into the crisp snow outside">

<ROOM STORY119
	(DESC "119")
	(STORY TEXT119)
	(PRECHOICE STORY119-PRECHOICE)
	(CONTINUE STORY393)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY119-PRECHOICE ()
	<FIRE-BARYSAL 2>
	<TAKE-OR-CHARGE 2 T>
	<TAKE-QUANTITIES ,KNIFE "knives" "How many of the assassins' knives will you take" 2>
	<TAKE-FOOD-PACKS 6>
	<SELECT-FROM-LIST <LTABLE POLARIZED-GOGGLES BINOCULARS COLD-WEATHER-SUIT> 3 3>
	<CRLF>
	<TELL ,TEXT119-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT120 "The innkeeper is cringing at the end of the bar with a sick look on his face. You bow to the twins, saying, \"Ladies, pardon me. I am a simple servant here.\" Turning to the innkeeper, you ask, \"master, shall I fetch the very best vodka for your guests?\"||The twins scowl at him. \"Isn't this the best?\"||He twitches nervously, but senses you have a plan in mind. \"Er... my my dear ladies, cherished guests --\"||One of the twins seizes his jerkin and hauls him across the bar, glaring into his face. \"Well?\"||\"Ulp. In fact, there is one bottle of extremely fine Old Daralbad Immolate in the cellar.\"||\"Fetch it.\" This is addressed to you. You race out to the cellar door to get a bottle, returning by way of the bathroom at the back of the building where you find the inn's medicine cabinet. As you come racking back, the bottle is snatched out of your hands.||\"I must advise caution, my lady,\" you say, almost grovelling. \"This is strong liquor.\"||\"Pah!\" She drains half the bottle at a gulp, then hands the rest to her sister.||You stand back and watch. Gradually the twins start to yawn, then fold across the bar. Only when they begin snoring do the rest of the customers feel safe in approaching these two fearsome Amazons. Even asleep, they inspire such fear that no one knows quite what to do with them, until you suggest putting them in a rowboat and pushing it out to sea.||\"How long before they wake up?\" asks the innkeeper.||You shake your head. \"Who knows? I put a whole packet of sleeping pills in that vodka, but these two seem to have a vigorous metabolism. Best that we get rid of them at once.\"">

<ROOM STORY120
	(DESC "120")
	(STORY TEXT120)
	(PRECHOICE STORY120-PRECHOICE)
	(CONTINUE STORY142)
	(CODEWORD CODEWORD-SCYTHE)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY120-PRECHOICE ()
	<KEEP-ITEM ,MEDICAL-KIT>>

<CONSTANT TEXT121 "Golgoth must have a keen interest in lurid fiction, because his thoughts are filled with images of carnage, explosions, gunfire, and violent death. Then you realize that these are not scenes from films or books -- they are Golgoth's actual memories. He has successfully eliminated dozens of the United States' enemies around the world, mainly by dint of trickery, cunning and a quite unabashed level of viciousness. Viewing these memories from his mind, at the same time as you return that placid smiling gaze, sends a shiver along your spine.">
<CONSTANT CHOICES121 <LTABLE "ask Golgoth what he knows about Giza" "question his reason for carrying a crossbow" "allow Boche to lead you away from this hardened killer">>

<ROOM STORY121
	(DESC "121")
	(STORY TEXT121)
	(CHOICES CHOICES121)
	(DESTINATIONS <LTABLE STORY337 STORY315 STORY358>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT122 "Awareness returns slowly, the details of your surroundings emerging out of a blur. There is a white ceiling above you and soft fabric at your back. The air carries a faint smell of antiseptic. You can make out the low whine of air conditioning.||\"You're able to hear me?\" booms a voice.||You wince, focussing on a face that looms above yours. The colours seem harsh, garish. Sounds come to your ears with a rasping undertone, as though filtered by electronics.||Another face comes into view, slender and handsome with a high forehead capped by a green circlet. He has a lopsided but not unfriendly smile. \"How are you feeling?\" he asks.||\"I've got pins and needles,\" you say in a voice still slurred by anaesthetic. Reaching across to rub your left arm, you feel the unyielding hardness of metal in place of flesh. You sit bolt upright with a thrill of horror, throwing off the sheets. You can only stare at what they have made of you: a being half of robotics, half of living tissue. A cyborg.||\"It was all we could do to save your life,\" explains the man wearing the green circlet. \"You were caught in the jets as my flyer took off. I brought you up here. It was touch and go for a couple of weeks, but you should be all right now.\"||\"What's left of me, that is,\" you say bitterly. Turning to the window, you see a surprising profusion of stars in a black void. \"Where are we, anyhow?\"||The other man, the doctor, takes you by your still-living right arm and leads you to the window. A vast crescent globe of swirling grey and white hangs in space below you.||\"That's the Earth,\" he says. \"You're on al-Lat.\"||The pilot joins you. \"I know you are still shaken, but I must ask you some questions. You should not have been in Maka. How did you get there, and why?\"">
<CONSTANT CHOICES122 <LTABLE "tell him the truth" "you prefer to invent a convincing story">>

<ROOM STORY122
	(DESC "122")
	(STORY TEXT122)
	(CHOICES CHOICES122)
	(DESTINATIONS <LTABLE STORY144 STORY166>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-TALOS)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT123 "\"Target identification: bometh,\" grates Gilgamesh. \"Mutant wolf/bear hybrid. Predator. It presents a danger. Immediate elimination is called for.\"||He raises his arm, ejecting a crackling blast of energy that turns the dusk to day. The swirling snowflakes hiss into steam. On the crest of the rise, the giant beast shudders and falls, rolling down into the deep snow. With Gilgamesh clanking along behind, you hurry over to make sure the bometh is dead, as you would not want a wounded predator stalking you through the night.">

<ROOM STORY123
	(DESC "123")
	(STORY TEXT123)
	(CONTINUE STORY341)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT124 "The carriage rushes on into the darkness of the tunnel. You wait for almost two hours, and then you start to feel the carriage slowing down. It enters a station and glides to a halt, but there is a delay before the doors open. \"Karthag station is damaged,\" explains the motilator's calm electronic voice. \"You are recommended to select an alternative destination.\"||Through the window, you can see that the station has caved in. Huge chunks of shattered concrete litter the platform, with twisted metal cables extending from them like torn arteries from a heart. It is sheer luck that the tunnel itself was not blocked, otherwise you would have ended your journey with a sever jolt, to say the least.||What now?">
<CONSTANT CHOICES124 <LTABLE "disembark here" "take the subway back to Marsay, and from there head on to Kahira" "to Tarabul" "to Giza" " resume your journey on foot">>

<ROOM STORY124
	(DESC "124")
	(STORY TEXT124)
	(CHOICES CHOICES124)
	(DESTINATIONS <LTABLE STORY146 STORY050 STORY031 STORY074 STORY420>)
	(TYPES FIVE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT125 "At last you see a streak of dark rubble against the dazzling skyline. You fear it might just be a line of hills or even a trick of the light, but as you approach on quickened footsteps it is possible to make out the details of brooding towers, empty palaces and gargantuan snow-bound walls. You have arrived at the lost city of Du-En.">

<ROOM STORY125
	(DESC "125")
	(STORY TEXT125)
	(PRECHOICE STORY125-PRECHOICE)
	(CONTINUE STORY213)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY125-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-DIAMOND>
		<DELETE-CODEWORD ,CODEWORD-DIAMOND>
		<STORY-JUMP ,STORY191>
	)>>

<CONSTANT TEXT126 "You find Golgoth squatting by torchlight at the end of the colonnade, where he has laid out all his weapons o the flagstones. As he checks each, he slips it into its concealed sheath: a garrotte wire under his belt, along with a flexible steel blade; poison darts in a bandolier inside his jacket; guns at hip, ankle and wrist; small flat grenades clipped along his sabretache. You watch him aghast for a few minutes.||\"Quite the professional killer, aren't you, Golgoth?\"||\"Don't get far if you only make t a hobby.\"||You heave a sigh. \"Does human life mean anything to you?\"||He buckles on his barysal gun, gets up, and gives you a long thoughtful look in the torchlight. \"Not the life of scum like this.\" He gestures along the colonnade. \"I've happily sent hundreds like them to an early grave. Who do you think my USI bosses should've sent -- a pack of boy-scout Marines?\"||\"So you're here as a USI agent?\"||He nods. \"Of course. The power of the Heart cannot be allowed to fall into hostile hands. In order of priority, I will either take it to the States, get the power myself, or destroy it.\"">
<CONSTANT CHOICES126 <LTABLE "propose an alliance" "go and talk to Kyle Boche" "get some sleep">>

<ROOM STORY126
	(DESC "126")
	(STORY TEXT126)
	(CHOICES CHOICES126)
	(DESTINATIONS <LTABLE STORY214 STORY104 STORY192>)
	(REQUIREMENTS <LTABLE <LTABLE CODEWORD-NEMESIS> NONE NONE>)
	(TYPES <LTABLE R-CODEWORD R-NONE R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT127 "The glowing phantom is leeching the strength from your living tissue, but your artificial body parts are not affected. Lunging out with your metal arm, you seize it by the neck. Your cyborg leg carries you forward with a lurching gait until you stand on the brink of the chasm. The phantom squirms in your unbreakable grip, its form twisting and flowing like melting wax. As its fingers penetrate the circuitry of your arm there is a flash of sparks and the feedback causes some damage.">
<CONSTANT TEXT127-CONTINUED "You manage to throw the phantom down. Its thin bleating cry echoes up from the depths as it falls, trailing its gleaming wisps of vapour like a comet's tail.">

<ROOM STORY127
	(DESC "127")
	(STORY TEXT127)
	(PRECHOICE STORY127-PRECHOICE)
	(CONTINUE STORY149)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY127-PRECHOICE ()
	<TEST-MORTALITY 2 ,DIED-FROM-INJURIES ,STORY127>
	<IF-ALIVE ,TEXT127-CONTINUED>>

<CONSTANT TEXT128 "The passage brings you to a series of galleries, each consisting of a cloister running either side of a central concourse softly illuminated by chandeliers. Many of the heavy buttresses have been defaced, leaving chunks of broken masonry scattered across the marble floor. \"No doubt this devastation was wreaked in the city's collapse,\" says Boche in a hushed voice. \"It's said that the people of Du-En went mad and turned against their leaders.\"||Baron Siriasis drifts to a halt and peers off into the gloom of the cloistered walkway at the side of the room. \"I sense a presence,\" he says after a moment's concentration. \"Something is stalking us.\"||Quickening your pace you hurry on through the galleries until you see a heavy iron-bound door ahead. A rasping sound echoes out of the cloisters to one side. It sounds like chitin slithering across stone. You are about to break into a run when the lights go out and you are plunged into darkness.">
<CONSTANT CHOICES128 <LTABLE "use" "or" "a charged barysal gun" "light a" "otherwise">>

<ROOM STORY128
	(DESC "128")
	(STORY TEXT128)
	(PRECHOICE STORY128-PRECHOICE)
	(CHOICES CHOICES128)
	(DESTINATIONS <LTABLE STORY216 STORY194 STORY238 STORY172 STORY260>)
	(REQUIREMENTS <LTABLE SKILL-ROGUERY SKILL-ESP SKILL-SHOOTING <LTABLE FLASHLIGHT LANTERN> NONE>)
	(TYPES <LTABLE R-SKILL R-SKILL R-SKILL R-ANY R-NONE>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY128-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-SCOTOPIC> <STORY-JUMP ,STORY302>)>>

<CONSTANT TEXT129 "With the ghastly brain floating after you, you race out of the hall. The passage soon forks, but you have no time to pause and get your bearings. You blunder on, gasping for breath, looking back over your shoulder to see if your pursuer is still there. Losing sight of it around a bend in the tunnel, you begin to calm down and think. The baron is a powerful psychic .. ore powerful than you ever dreamed, to outlive his body like this -- but he cannot survive once the remaining oxygen in his brain tissue is used up. All you have to do is stay ahead of him that long.||Your simple plan is ruined a moment later when, darting around a junction in the passage, you come face to face with a hover-droid. A quarter of a second is long enough for you to start tor turn, and for the hover-droid to identify you as an intruder in the catacombs. As you leap back, its laser flares up and you feel a sickening pain as the hot beam cuts through your gut.">
<CONSTANT TEXT129-CONTINUED "You retreat rapidly. But just as you lose sight of the hover-droid, you turn to see the baron's brain drifting towards you. You are between a rock and a hard place.">

<ROOM STORY129
	(DESC "129")
	(STORY TEXT129)
	(PRECHOICE STORY129-PRECHOICE)
	(CONTINUE STORY085)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY129-PRECHOICE ("AUX" (DAMAGE 4))
	<COND (<CHECK-ITEM ,SPECULUM-JACKET> <SET DAMAGE 3>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-INJURIES ,STORY129>
	<IF-ALIVE ,TEXT129-CONTINUED>>

<CONSTANT TEXT130 "The shot was a decoy. Sensing Golgoth's thoughts, you whirl to see him running silently through the smoke towards you. The look in his eyes is the chilling glint of an inhuman killer. Your arm comes up by instinct and you send a lethal blast of energy through his heart. He topples at your feet.">

<ROOM STORY130
	(DESC "130")
	(STORY TEXT130)
	(PRECHOICE STORY130-PRECHOICE)
	(CONTINUE STORY072)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY130-PRECHOICE ()
	<FIRE-BARYSAL 1>>

<CONSTANT TEXT131 "Your shot burns through Singh's armour and he staggers back, but although wounded he is far from beaten. He presses the fire button on his mantramukta cannon just as Boche goes for an opportunist shot at you. The beam carves through your shoulder.">
<CONSTANT TEXT131-CONTINUED "A moment later Boche falls as Singh swings the cannon around, blasting him apart with a torrent of searing energy.||There is a moment of silence as the cannon's blast cuts out. It will take a few seconds to build up charge before it can fire again. Golgoth seizes the chance to take aim with his barysal gun. This is the showdown that will decide which of you lives to claim the power of the Heart.">

<ROOM STORY131
	(DESC "131")
	(STORY TEXT131)
	(PRECHOICE STORY131-PRECHOICE)
	(CONTINUE STORY410)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY131-PRECHOICE ("AUX" (DAMAGE 2))
	<COND (<CHECK-ITEM ,SPECULUM-JACKET> <SET DAMAGE 1>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-INJURIES ,STORY131>
	<IF-ALIVE ,TEXT131-CONTINUED>>

<CONSTANT TEXT132 "A barrage of tightly focused plasma bolts flash through the air directly overhead. You feel the wave of heat as the copper wires are vaporized. The puppets drop lifeless to the stage.||Gilgamesh lowers his arm. Smoke is wafting from his built-in gun. \"Random motion of manikins could have caused you damage,\" he grates in his mechanical voice. \"They have been rendered inert. Danger now over.\"||\"And you wanted to leave the tin man behind,\" Golgoth reminds the Gargan sisters as you get down off the stage.">

<ROOM STORY132
	(DESC "132")
	(STORY TEXT132)
	(CONTINUE STORY110)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT133 "\"You won't regret it,\" he says emphatically.||You look to the east, where the morning sun is hidden under a shelf of heavy grey cloud. A link of black posts protrude from the snow, marking the road to Venis. The other direction would take you through the swamplands of Lyonesse -- the one region of Europe not afflicted by ice sheets and arctic blizzards. But Lyonesse has dangers of its own.">
<CONSTANT CHOICES133 <LTABLE "head east, towards Venis" "go west through Lyonesse">>

<ROOM STORY133
	(DESC "133")
	(STORY TEXT133)
	(CHOICES CHOICES133)
	(DESTINATIONS <LTABLE STORY200 STORY177>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT134 "The creature's lair proves to be a cave at the end of the pass. Inside you find a fire of smouldering peat. Around it are strewn bones from humans and large animals. It seems that the creature trapped its prey by hypnosis, leaving the victim to die of exposure. Whenever it needed fresh meat, it had only to fetch in one of the frozen bodies along the pass -- a gruesomely effective procedure. The aftermath of the Paradox War has left the world with many such weird mutations.||Boche gives an involuntary cry of disgust, which he immediately disguises with a nervous laugh. He has discovered a clutch of the creature's young: blobby heads like diseased potatoes, bodies as shrivelled as a bag of giblets, the mesmeric eye no more than a yellow pebble on the end of an embryonic tuber-like stalk.||\"Cure little devils.\"">
<CONSTANT CHOICES134 <LTABLE "kill them" "not">>

<ROOM STORY134
	(DESC "134")
	(STORY TEXT134)
	(CHOICES CHOICES134)
	(DESTINATIONS <LTABLE STORY156 STORY178>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT135 "You show the card to various forgers around town. One tells you that the process involved in altering a hologram is very expensive, since lasers and other rare devices are needed. You are about to leave his shop when he sidles over and glances furtively along the street. Dusk squats over the city, pouring dank slush snow from a colourless sky. He lowers the blinds. \"I can't alter the picture,\" he says. \"But what about your own face?\"||\"Cosmetic surgery?\"||He shows you to a room at the back. \"I do it all the time for clients who want to escape their past misdeeds. A whiff of gas and you sleep. When you wake, you'll have a new face.\"||\"How much?\"||After some haggling, he settles on the sum of 5 scads. He reaches out his hand, but you smilingly shake your head, telling him you will pay once the operation is over. He prepares his instruments, then invites you to breathe the anaesthetic gas.">
<CONSTANT CHOICES135 <LTABLE "reconsider and leave now" "go ahead with the operation">>

<ROOM STORY135
	(DESC "135")
	(STORY TEXT135)
	(CHOICES CHOICES135)
	(DESTINATIONS <LTABLE STORY223 STORY201>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT136 "You sense that he is lying. Narrowing your gaze, you search deeper into his thoughts while he lies there helpless on the titles. The shower splashes water onto both of you, icy cold now.||You glimpse the image of a crippled man. white hair like a puff of steam surrounds an old, sick, deeply seamed face. He ordered your death. The assassin does not know why.||Deciding it is easier just to question the man, you say, \"Who was the man who hired you?\"||\"Baron Siriasis, a paradoxer from Bezant. He said you were not to reach Kahira.\"||\"Why did he want me dead?\" you ask. But the question is futile; you have already read the assassin's mind, and he cannot give you any answer. It is a mystery you must clear up later. Telling the man to make himself scarce, you dry yourself off and get dressed.">

<ROOM STORY136
	(DESC "136")
	(STORY TEXT)
	(PRECHOICE STORY136-PRECHOICE)
	(CONTINUE STORY092)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY136-PRECHOICE ()
	<ASSASSINS-LOOT 2 10>>

<CONSTANT TEXT137 "The sky-car emits a soft hum as you engage the power. White light flares from the thrusters, casting a garish glow across the walls. It rises to hover a metre or so above the floor. Despite the smoothness of its movement, you are aware of the enormous power in the machine and open the throttle only gently. Unfortunately you misjudge it even so. The thrusters boom, sending the sky-car caroming across the chamber. Frantically you twist the joystick, trying to turn towards the corridor, but you are going too fast. The sky-car smashes into the wall and you are flung out, hitting the floor with numbing impact.||When you come round, your whole body is a single throbbing ache. You feel sure you must have cracked a couple of ribs, and your wrist is badly wrenched. Blood pours from a deep graze above your eyes, and as you get to your feet a wave of dizziness hits you.">
<CONSTANT TEXT137-CONTINUED "You stagger over to look at the sky-car. It is a wreck. The chassis has split and white-hot sparks are cascading from the broken power unit. The caretek that had maintained it for all these years comes crawling drearily forward and begins probing the wreckage. You almost feel story for it. It has its work cut out for the next year or so. The sky-car will not fly again before then. Now all you can do is rummage through the storage locker and salvage a few items.">

<ROOM STORY137
	(DESC "137")
	(STORY TEXT137)
	(PRECHOICE STORY137-PRECHOICE)
	(CONTINUE STORY093)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY137-PRECHOICE ()
	<TEST-MORTALITY 4 ,DIED-FROM-INJURIES ,STORY137>
	<COND (<IS-ALIVE>
		<CRLF>
		<TELL ,TEXT137-CONTINUED>
		<TELL ,PERIOD-CR>
		<LOSE-VEHICLE ,MANTA-SKY-CAR>
	)>>

<CONSTANT TEXT138 "You seek out the librarian, a plump sour-faced man who sits at his desk amid the stacks like a spider in its web. He is barely able to disguise his irritation when you explain what you want. \"A link to Gaia? That is most irregular. Very few of our members make such requests.\"||He will deter you if you let him, if only to spare himself inconvenience. Recalling the status of the typical Society member, you adopt an uncompromising attitude and say, \"It was not a request, but a command. You will now establish a link so that I can talk to Gaia.\"||\"Talk?\" He spreads his hands imploringly. \"What will you talk about? Gaia is mad!\" Seeing you will not be put off, he grumbles under his breath and pushes a slip of paper across the desk. \"Write your query there and it will be broadcast to Gaia. The reply will be brought back to you.\"||\"I prefer a direct two-way communication.\"||\"Impossible!\" he cries. \"That is against Society policy, as nay link to Gaia must be stringently monitored to prevent arrogation of our computer network.\"|||You see he will not be swayed on this point. You write out your message and wait for half an hour until the librarian comes back. \"Here is your reply from Gaia,\" he says, his tone of surprise showing that he did not expect anything but gibberish. He reads from the paper in his hand; \"go and meet with Gilgamesh under the pyramid. Humbaba will give you access.\"||\"Is that all?\"||He nods. \"Gaia then began to transmit random references to Babylonian history followed by a digression into architectural feats of history, and the link was terminated.\"">
<CONSTANT CHOICES138 <LTABLE "consult the archives for information about the Heart of Volent" "you are finished in the library">>

<ROOM STORY138
	(DESC "138")
	(STORY TEXT138)
	(PRECHOICE STORY138-PRECHOICE)
	(CHOICES CHOICES138)
	(DESTINATIONS <LTABLE STORY182 STORY073>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-HUMBABA)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY138-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-LORE>
		<SET-DESTINATION ,STORY138 1 ,STORY160>
	)(ELSE
		<SET-DESTINATION ,STORY138 1 ,STORY182>
	)>>

<CONSTANT TEXT139 "You ascend into the mountains across stark rocky ridges like the broken backs of colossal dinosaurs. The sun shines as feebly as a flashlight seen through a thick pane of ice. When the wind gusts into your face, it is so cold that you can hardly draw breath.||On the second day you come upon four figures also trudging eastwards. They are several hundred metres ahead on the surface of a glacier. As you hurry to catch up, you see patches where the snow has swirled away to reveal the sky surface of the glacier reflecting glints of feeble daylight.||The leader of the group is a short broad-shouldered man whose dark sparkling eyes display an easy authority. The other three, apparently his bodyguards, are hulking men whom you take to be of South Pacific origin. It is hard to be sure with the fur hoods drawn so tightly around their faces.||The short hand man shakes hands and introduces himself as Hal Shandor. \"Our sky-car crashed in the hills back there,\" he explains. \"We're going on to Venis. Travel with us if you want.\"">
<CONSTANT CHOICES139 <LTABLE "join their group" "you prefer to journey alone">>

<ROOM STORY139
	(DESC "139")
	(STORY TEXT139)
	(CHOICES CHOICES139)
	(DESTINATIONS <LTABLE STORY225 STORY161>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT140 "The creature that attacked you is a sanguivore, a mutant lizard with gliding and mimicking abilities. The sanguivore's saliva contains an anti-clotting agent, ensuring that its prey slow bleeds to death even after escaping from it. That explains why it's in no hurry to catch up with you. It is content to track you through the woods and wait until you collapse from exhaustion. Well, you have a few resources not shared by any wild animal. Tearing the lining of your jacket into strips, you bind the wound to prevent further loss.">
<CONSTANT CHOICES140 <LTABLE "rest here" "press on through the jungle for a while">>

<ROOM STORY140
	(DESC "140")
	(STORY TEXT140)
	(CHOICES CHOICES140)
	(DESTINATIONS <LTABLE STORY184 STORY250>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT141 "There are men beyond the plastiwood partition. You read their thoughts: three hunters. No doubt the cruelty you see in their minds is only a symptom of their harsh existence on the fringes of the Sahara. All the same, you are wise to stay concealed. They are not above murdering lone travellers for the clothes on their back.||Waiting until they go to sleep, you carefully ease the partition open and sneak past them. A rug hangs across the entrance of their shelter. You can hear a blizzard howling through the night outside -- an uninviting sound, but preferable to staying here to be butchered when these three wake. Drawing your hood down, you slip out into the icy wind.">

<ROOM STORY141
	(DESC "141")
	(STORY TEXT141)
	(CONTINUE STORY314)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT142 "The reputation of the Gargan clones is so daunting that no one dares to suggest killing them. \"I have heard that the other members of the clone group were killed, but who can be sure?\" says one man with the flaring blue hat-flaps of a Tuareg hunter.||\"That's true,\" admits the innkeeper with a nod. \"I wouldn't care to have twelve identical Amazons barge into my taproom a month from now and demand retributions for their sisters.\"||At last a compromise is reached. The unconscious sisters are taken down to the shore and placed in a small boat which you push out to sea. You watch the boat drift away into the frosty evening haze. Shivering, you stamp back through the snow to the inn, where you are given food and wine and treated like a hero.||The innkeeper also offers you provisions for your journey: two food packs.">

<ROOM STORY142
	(DESC "142")
	(STORY TEXT142)
	(PRECHOICE STORY142-PRECHOICE)
	(CONTINUE STORY273)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY142-PRECHOICE ()
	<GAIN-LIFE 1>
	<ADD-FOOD-PACK 2>>

<CONSTANT TEXT143 "\"On this point,\" announces Bador, \"I would be untruthful if I pretended to know with adamantine certainty. According to some, the city took its name from Khare-Ohe, or 'Field of Conflict,' as it was found on the spot where the first pharaoh watched a falcon fight a rat. Another version relates it to the settlement of el-Qahira, consecrated to the red planet of victory.\"||You shake your head. \"These are ancient myths. I am interested in recent history.\"||Ah, Well, then Du-En rose to power, Kahira became an important as a base of operations for those armed forces opposing the Volentine Watchers -- in essence, the rest of the world. Owing to heat-conductive pipes buried along the bed of the Isis River, fishes are abundant even in these parlous times, and Kahira continues to flourish. The warm water, rising into contact with icy winds off the Saharan plain, forms the incessant mist which is characteristic of the city.\"||\"And why is the city built on high columns of concrete, instead of sprawling along the river banks?\"||Balor pulls an uncertain face. \"Defence? Scarcity of materials? An obscure edict? Who can say?\"">
<CONSTANT CHOICES143 <LTABLE "ask his advice about the Sahara" "about Giza" "about the best place to stay" "you can dismiss him">>

<ROOM STORY143
	(DESC "143")
	(STORY TEXT143)
	(CHOICES CHOICES143)
	(DESTINATIONS <LTABLE STORY077 STORY059 STORY099 STORY095>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT144 "\"I found a terminal of the intercontinental subway system, beneath the ruins of Lost Marsay. I tried to reach Giza, but I was unable to alight there and was left with no alternative but to travel on to Maka.\"||He strokes his thumbnail across the cleft of his chin, deep in thought. \"Why were you trying to reach Giza?\" he asks at last.||The truth seems absurd, but you tell him anyway. \"I was following the advice of Gaia.\"||He gives you a sharp look. \"Do not attempt to contact Gaia while you are on al-Lat. Our computer systems are secure from viruses, and that's the way we'd like it to stay.\" His face softens into an easy smile. \"Still, I'm forgetting my manners. I am Riza Baihaqi.\"||You shake hands. There is a moment of uncomfortable silence, then Riza says, \"I can never atone for the guilt I feel. This dreadful injury you've suffered...\"||You raise your artificial arm and flex the fingers. There is a soft buzz of gears, but they seem dextrous enough. \"It could be worse,\" you admit. \"These prosthetics will do as temporary repairs, at any rate.\"||\"You are putting a brave face on things, my friend,\" says Riza. \"But, in all truth, where on Earth could you hope to find a cure for your dreadful injuries?\"">
<CONSTANT CHOICES144 <LTABLE "tell him about Du-En" "say you are keen to return to Earth">>

<ROOM STORY144
	(DESC "144")
	(STORY TEXT144)
	(CHOICES CHOICES144)
	(DESTINATIONS <LTABLE STORY188 STORY275>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT145 "The stun grenade sails through the air and crunches into the deep snow at the foot of the rise. The bometh slowly stirs itself and lumbers down the slop to snuffle around. As it locates the grenade, you detonate by remote. A flurry of snow is thrown up into the bometh's face by the blast and you see it drop. An imperceptible fraction of a second later, the hard crump of the explosion reaches your ears. By that time you are already running towards the fallen predator.||Kneeling beside it in the crater of slush formed by the explosion, you life the huge limp head across your knee and give it a sharp twist. The bometh gives a spasm and then lies still.">

<ROOM STORY145
	(DESC "145")
	(STORY TEXT145)
	(PRECHOICE STORY145-PRECHOICE)
	(CONTINUE STORY341)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY145-PRECHOICE ()
	<LOSE-ITEM ,STUN-GRENADE>>

<CONSTANT TEXT146 "You explore the corridors leading off the platform, but all are blocked by rubble. There is no way of reaching the surface from here. As you return to the carriage, though, you notice a small partition in the wall. It is labelled as an air vent. You remove the grating and peer up the darkened shaft. A waft of rich loamy air drifts down. The shaft is intended for careteks servicing the ventilation ducts, but at a pinch you might be able to squeeze up it -- if you're not bothered by claustrophobia.">
<CONSTANT CHOICES146 <LTABLE "venture up the shaft" "otherwise you must take the subway back to Marsay, from where you can proceed to Kahira" "to Tarabul" "or to Giza" "resume your journey on foot">>

<ROOM STORY146
	(DESC "146")
	(STORY TEXT146)
	(CHOICES CHOICES146)
	(DESTINATIONS <LTABLE STORY168 STORY050 STORY031 STORY074 STORY420>)
	(TYPES FIVE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT147 "How long have you been out on the Ice Wastes? You've lost all sense of time. The wind becomes a constant roaring in your ears. You stumble on through the sheets of snowflakes, each breath sounding like a sob of pain.">
<CONSTANT TEXT147-BURREK "You slaughter the burrek in desperation for its meat">

<ROOM STORY147
	(DESC "147")
	(STORY TEXT147)
	(PRECHOICE STORY147-PRECHOICE)
	(CONTINUE STORY125)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY147-PRECHOICE ("AUX" (DAMAGE 4) (MEAT F))
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL> <SET DAMAGE 3>)>
	<COND (<CHECK-ITEM ,BURREK> <SET MEAT T> <SET DAMAGE <- .DAMAGE 2>>)>
	<TEST-MORTALITY .DAMAGE ,DIED-GREW-WEAKER ,STORY147>
	<COND (<AND <IS-ALIVE> .MEAT>
		<CRLF>
		<TELL ,TEXT147-BURREK>
		<TELL ,PERIOD-CR>
		<LOSE-ITEM ,BURREK>
	)>>

<CONSTANT TEXT148 "Gaunt walks with you to the outskirts of Du-En to show you the night sky. His undead xoms stalk silently alongside bearing glow-lamps. At the city gates, they dim the lamps and you are left with the light of ten thousand glittering stars. The snows of the Sahara are swallowed by darkness, but you get the impression of standing at the hub of infinity.||For a long period neither of you speaks. Then Gaunt recites softly, \"Some say the world will end in fire, some say in ice. From what I've tasted of desire, I hold with those who favour fire. But if it had to perish twice, I think I know enough of hate to say that ice is also great, and would suffice.\"||\"What's that?\"||\"The words of a poet long ago.\" He gazes to the north. \"My home city lies under a shield of ice a kilometre thick. Soon the world will slip into a coma, like a man frozen at the point of death. The polar caps will meet and everything will end.\"||\"Unless we find the Heart and use its power to set things right.\"||He turns with a smile almost of delight. \"Is that why you've come here? I fear you'll be disappointed. The Heart must inevitably fall into the hands of one who is most ruthless. To seize true power, a man must have a heart of ice. When the powerful do good deeds -- I speak of Caesar, Alexander, Napoleon, Mao -- they do so inadvertently. The good and honest of the world are always the most impotent.||It suddenly occurs to you that Gaunt hasn't a chance of surviving here. He is too intellectual to vie with the others for the Heart.">
<CONSTANT CHOICES148 <LTABLE "tell him that" "ask what he thinks of the others" "otherwise, you can return to the main square and seek out Kyle Boche" "turn in for the night">>

<ROOM STORY148
	(DESC "148")
	(STORY TEXT148)
	(CHOICES CHOICES148)
	(DESTINATIONS <LTABLE STORY279 STORY258 STORY104 STORY192>)
	(TYPES FIVE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT149 "Slowly the chill leaves your bodies. \"Curious,\" mutters the baron, floating over to peer into the chasm. \"It seemed to be a genuine ghost, so far as I could tell. I could not read its mind, at any rate.\"||\"Just as long as it's gone now,\" grunts Boche. He gestures at a narrow stone bridge spanning the chasm. On the far side, an archway opens onto a tiled hall. \"Who wants to go first?\"||The baron gives him a scornful look and hovers out across the drop. As you watch him drift to a halt on the far side, it occurs to you that he looks a rather ghostly figure himself.||Boche glances at you, shrugs and strides rapidly across the bridge. \"It's not too bad as long as you don't look down,\" he calls over his shoulder.||They are waiting for you to cross. As you step onto the bridge, you find your gaze drawn downwards in spite of Boche's advice. The walls of the chasm plunge dizzyingly into feculent darkness. Then you notice something else. Set into the rock walls, about five metres below the level of the bridge, are a row of metal grilles.">
<CONSTANT CHOICES149 <LTABLE "climb down to investigate" "continue across the bridge">>

<ROOM STORY149
	(DESC "149")
	(STORY TEXT149)
	(CHOICES CHOICES149)
	(DESTINATIONS <LTABLE STORY193 STORY215>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT150 "You step out of the elevator to find Singh, Boche and Golgoth already here. Thadra Bey didn't make it.||You are in a dome so vast that it feels like a gulf in the black void of intergalactic space. Boche's flashlight does not reach the far wall. In the centre of the chamber, on a raised dais at the end of a ramp, lies a purple gemstone almost two metres in diameter. Scintillant sparks stream from deep in its core, giving off a violet radiation that causes a pain at the back of your eyes.||\"The Heart of Volent...\" breathes Boche in a voice of awe. \"The key to ultimate power.\"">

<ROOM STORY150
	(DESC "150")
	(STORY TEXT150)
	(PRECHOICE STORY150-PRECHOICE)
	(CONTINUE STORY367)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY150-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-RED>
		<STORY-JUMP ,STORY303>
	)(<CHECK-CODEWORD ,CODEWORD-BLUE>
		<STORY-JUMP ,STORY346>
	)(<CHECK-CODEWORD ,CODEWORD-YELLOW>
		<STORY-JUMP ,STORY324>
	)>>

<CONSTANT TEXT151 "Even with all your power you could not beat Baron Siriasis in a battle of will. He is the world's mightiest psychic, and because of desperation his strength is double. But you do not have to beat him, you only have to hold him off while he dies expending the last store of oxygen in his disembodied brain. Slowly you begin to feel his efforts weaken, his invading tentacles of thought slipping from your mind.||The brain suddenly drops out of the air, hitting the floor with a wet splat. There is a groan that could not be heard with the ears, and a last telepathic message: The darkness...||Silence. The baron is dead at last.">

<ROOM STORY151
	(DESC "151")
	(STORY TEXT151)
	(CONTINUE STORY261)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT152 "Who is the most trustworthy person here? You can rely on your psychic sense to guide you. Vajra Singh is an honourable man, but you cannot believe he would ever relinquish the chance for ultimate power. Chaim Golgoth is motivated by duty to his nation -- at least on the surface. Thadra Bey would never ally herself with others; she is as proud and independent as a cat. Janus Gaunt strikes you as free of malice; a reflective man, he could even be virtuous if he were of stronger character. Kyle Boche is vain, pompous and self/serving. And as for Baron Siriasis -- his mind is closed to you entirely.||Perhaps you would be better to ask yourself who is least untrustworthy.">

<ROOM STORY152
	(DESC "152")
	(STORY TEXT152)
	(CONTINUE STORY082)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT153 "If you touch the Heart, you will attune its power and create a new universe in which you wield the power of a god. But in doing so you would wipe out this universe and everything in it. You stand and gaze into the flickering facets. You can feel the palpable power within it. Can you resist its lure?">
<CONSTANT CHOICES153 <LTABLE "release the Heart's power" "prevent the Heart ever falling into anyone's hands" "otherwise your only option is to reject the chance for power">>

<ROOM STORY153
	(DESC "153")
	(STORY TEXT153)
	(PRECHOICE STORY153-PRECHOICE)
	(CHOICES CHOICES153)
	(DESTINATIONS <LTABLE STORY174 STORY197 STORY454>)
	(REQUIREMENTS <LTABLE NONE STASIS-BOMB NONE>)
	(TYPES <LTABLE R-NONE R-ITEM R-NONE>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY153-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-FOCUS>
		<SET-DESTINATION ,STORY153 3 ,STORY354>
	)(ELSE
		<SET-DESTINATION ,STORY153 3 ,STORY454>
	)>>

<CONSTANT TEXT154 "Gargan XIII follow Golgoth's gaze to her leg, where there is a razor-thin cut through the trouser fabric. She pulls it apart to reveal a scratch on the skin. Golgoth holds up a small needle he had hidden in the palm of his hand.||You see now that Gargan XIV has a similar scratch on her forearm. \"Cyanide,\" explains Golgoth. \"Should take about five seconds now... four... three...\"||The Gargan sisters exchange a look. There is no time for words. Suffering identical stabs of pain, they crumple to the floor. By the time you feel for a pulse, they are already dead. \"They went two seconds sooner than I thought,\" says Golgoth in a curious tone. \"Must've been their faster metabolism. Well, let's see what they've got.\"||Stripping the bodies of equipment, you find two barysal guns (each with three charges), a flashlight, a medical kit, a stun grenade, and three food packs. Golgoth offers you the choice of any four items you like.">

<ROOM STORY154
	(DESC "154")
	(STORY TEXT154)
	(PRECHOICE STORY154-PRECHOICE)
	(CONTINUE STORY176)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY154-PRECHOICE ("AUX" (COUNT 4))
	<SET COUNT <- .COUNT <TAKE-OR-CHARGE 3 T 2>>>
	<SET COUNT <- .COUNT <TAKE-FOOD-PACKS 3>>>
	<COND (<G? .COUNT 0>
		<COND (<G? .COUNT 3> <SET COUNT 3>)>
		<SELECT-FROM-LIST <LTABLE FLASHLIGHT MEDICAL-KIT STUN-GRENADE> 3 .COUNT>
	)>>

<CONSTANT TEXT155 "\"Why won't you see sense?\" asks Boche in an affable tone. \"Two can travel more safely than one. The road is plagued by robbers.\"||You find Boche's sincerity to be as false as a serpent's smile, and you have no desire to wake up one morning to find he has made off with your money and provisions. \"For all I know, you are the robber,\" you tell him to his face.||Before he can come up with an answer to this, you slog off through the snow. Now you must decide your route.">
<CONSTANT CHOICES155 <LTABLE "head east to Venis, where you might be able to get passage to Kahira" "you can follow the innkeeper's advice and go west through the Lyonesse jungle">>

<ROOM STORY155
	(DESC "155")
	(STORY TEXT155)
	(CHOICES CHOICES155)
	(DESTINATIONS <LTABLE STORY139 STORY221>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT156 "Grimacing, you cast the tiny gorgons into the flames. They produce a high-pitched whine which continues long after they must have burned to death - presumably the result of air escaping from their breathing cavities.||\"They might have been the only members of a new and unique species!\" protests Boche. \"Are you proud to have committed genocide?\"||\"Since each would have grown up to become a murdering monster, yes I am,\" you reply. You are increasingly beginning to suspect that Boche is a fool. Refusing to discuss the matter further, you search the cave.">

<ROOM STORY156
	(DESC "156")
	(STORY TEXT156)
	(CONTINUE STORY178)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT157 "Others are also interested in the story of the Heart. A black-caped guide, overhearing your enquiries, follows you down the street saying, \"You're not the first to pass through Venis bound for Du-En. Last week there was Janus Gaunt, hiring guides for a trip across the Saharan Ice Wastes. And only this morning I took a woman of al-Lat to see Malengin the Gene Genie. Thadra Bey was her name. A veritable Amazon already -- now, thanks to Malengin's potions, she is more than human.\"||Intriguing. If what the guide says is true, the hunt for Du-En has become a race. Deep in thought, you hardly notice the guide demanding that you pay for information he's given you.">
<CONSTANT CHOICES157 <LTABLE "pay him" "not">>

<ROOM STORY157
	(DESC "157")
	(STORY TEXT157)
	(CHOICES CHOICES157)
	(DESTINATIONS <LTABLE STORY414 STORY414>)
	(REQUIREMENTS <LTABLE 1 NONE>)
	(TYPES <LTABLE R-MONEY R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT158 "By dint of tremendous mental effort, you find that you are able to move the steam cloud into the centre of the room, leaving cooler air where you are sitting. You concentrate on shaping the steam into a funnel, and gradually a miniature whirlwind forms in the air in front of you. As it twists faster and faster, it also becomes narrower. With your mind, you shape it like a clay pot on a wheel.||One of the assassins glances in through the glass. \"What the devil's going on?\" he shouts. They start to fumble with the latch, but you hardly notice. All your concentration is now on the hissing funnel of superheated steam.||The door opens. The two men stand staring in disbelief, knives slack in their hands. Mentally you cast the lance of steam towards them. One gives a scream as he is struck full in the face, and falls clutching his eyes. The other, although scaled, staggers in and tries to slice your belly open with his knife. Luckily he slips on the wet floor, an you take only a glancing blow.">
<CONSTANT TEXT158-CONTINUED "You close to grapple with him and a brief struggle ensues, ending when your attacker is impaled on his own knife. You can tell straight away that this one is dead, but the other man in still lying in the doorway whimpering.">

<ROOM STORY158
	(DESC "158")
	(STORY TEXT158)
	(PRECHOICE STORY158-PRECHOICE)
	(CONTINUE STORY048)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY158-PRECHOICE ()
	<TEST-MORTALITY 1 ,DIED-FROM-INJURIES ,STORY158>
	<IF-ALIVE ,TEXT158-CONTINUED>>

<CONSTANT TEXT159 "The next day, you glide the Manta southwards out of town and across the icy flats descending towards the Inland Sea. Flurries of snow gust out of a dull cloud-heavy sky. The headland to your left looks like a streak of tarnished silver over the iron-coloured waves.||Once clear of the coastline, you take the Manta up to an altitude of ten metres and open the throttle. The wind comes shrieking around the cockpit screen, but you are sheltered behind the controls. There are even heating vents to either side of the dashboard that give you a modicum of comfort.||The sea skims by beneath, grey as gunmetal and churning with chunks of ice. The sky resembles the underside of a giant fungus. Hours pass. As you approach the estuary of Isis, a haze of mist looms up to blanket the coastline, formed where the river flows into the freezing depths of the Inland Sea. Warmed by submerged pipes, the waters of the Isis teem with life. The heat is soon lost when the river enters the Inland Sea, but the estuary can support several fishing villages.||The coast hurtles closer. Now you can see boats scattered on the silvery water. Startled fishermen look up in fright as you go screeching past only metres above their heads. You laugh. To them your vehicle must look like some kind of demonic flying fish.">
<CONSTANT CHOICES159 <LTABLE "steer a course to Kahira" "bypass kahira and visit the nearby pyramids of Giza" "head straight for Du-En">>

<ROOM STORY159
	(DESC "159")
	(STORY TEXT159)
	(CHOICES CHOICES159)
	(DESTINATIONS <LTABLE STORY247 STORY268 STORY289>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT160 "The Society's books add little to what you already knew. The Heart of Volent fell from space, a meteorite resembling a violet gemstone two metres across. It became revered by a religious cult calling themselves the Volentine Watchers, led by one Eleazar Picard. Learning how to tap the Heart's power, the cultists reversed the degradation of Earth's environment in a small region around their city of Du-En, in the Sahara, and for a time enjoyed prosperity.||Then came the Paradox War. The Volentine Watchers used their strange power to send blasts of chaos-inducing radiation against the nations of the world, whom they deemed corrupt and decadent. The new Ice Age was already under way because of Gaia's instability, and the Paradox War accelerated the process. Some regions became so irradiated that the normal laws of nature no longer applied, and they were quickly overrun by eerie mutants.||The rest of the world allied to establish a military bunker at Giza, intending to strike from there against Du-En, but it was never needed. The people of Du-En succumbed to mass insanity and fled their city, only to perish in the Sahara as the snows returned. Eleazar Picard himself was found by a patrol from al-Lat, but only rambled incoherently for a few days before dying. Du-En was declared off limits, the Sahara an icy wasteland inhabited only by ghosts. And so it has remained for two hundred years.||You return the books to the shelves.">
<CONSTANT CHOICES160 <LTABLE "try making contact with Gaia" "you've finished in the library">>

<ROOM STORY160
	(DESC "160")
	(STORY TEXT160)
	(PRECHOICE STORY160-PRECHOICE)
	(CHOICES CHOICES160)
	(DESTINATIONS <LTABLE STORY138 STORY073>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY160-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-CYBERNETICS>
		<SET-DESTINATION ,STORY160 1 ,STORY116>
	)(ELSE
		<SET-DESTINATION ,STORY160 1 ,STORY138>
	)>>

<CONSTANT TEXT161 "You trek wearily onwards, often plunging almost to your waist through fine powdery banks of snow. The sun pokes feeble rays of light across the bleak sky like an old man clutching for his pills. Quicksilver ribbons lie across the landscape, marking out the course of glaciers through the ridges of rock. Night descends like a sheath of hoarfrost. For days your ordeal continues as you cross the rugged mountain slops and finally begin your descent towards the foothills.">
<CONSTANT TEXT161-CONTINUED "You give a hoarse grunt of relief through frost-numbed limbs when the towers and cupolas Venis finally appear against the skyline">

<ROOM STORY161
	(DESC "161")
	(STORY TEXT161)
	(PRECHOICE STORY161-PRECHOICE)
	(CONTINUE STORY334)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY161-PRECHOICE ("AUX" (DAMAGE 3))
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL> <SET DAMAGE 2>)>
	<TEST-MORTALITY .DAMAGE ,DIED-GREW-WEAKER ,STORY161>
	<COND (<IS-ALIVE>
		<CRLF>
		<TELL ,TEXT161-CONTINUED>
		<TELL ,PERIOD-CR>
		<COND (<AND <CHECK-SKILL ,SKILL-CLOSE-COMBAT> <CHECK-ITEM ,SHORTSWORD>> <STORY-JUMP ,STORY008>)>
	)>>

<CONSTANT TEXT162 "With each step you take you are getting weaker.">
<CONSTANT TEXT162-CONTINUED "The blood is still pouring freely from the jagged rip in your shoulder, and you realize that the creature must have injected an anti-clotting agent. Hurriedly tearing the lining of your jacket into strips, you bind the wound to prevent further blood loss.||Looking back, you see no sign of your pursuer. Perhaps it lost interest after having a taste of your flesh.">
<CONSTANT CHOICES162 <LTABLE "rest hear" "press on further into the jungle">>

<ROOM STORY162
	(DESC "162")
	(STORY TEXT162)
	(PRECHOICE STORY162-PRECHOICE)
	(CHOICES CHOICES162)
	(DESTINATIONS <LTABLE STORY184 STORY250>)
	(TYPES TWO-NONES)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY162-PRECHOICE ()
	<COND (,RUN-ONCE <TEST-MORTALITY 1 ,DIED-FROM-INJURIES ,STORY162>)>
	<IF-ALIVE ,TEXT162-CONTINUED>>

<CONSTANT TEXT163 "You are held at gunpoint while your arms are wrenched behind your back and securely tied. One of the men rummages through your belongings, then jerks his thumb contemptuously towards you. \"Are we keeping an extra mouth to feed, then, Snarvo?\"||The man with the knife sneers. \"Not unless you want a pet for yourself, mate.\"||\"Hang on,\" says the third man as he tucks his gun away. He stands peering at you in the firelight, chewing his lip thoughtfully. \"I've seen your face before, haven't I?\"||\"Yeah,\" you say sarcastically, \"at the President's last garden party in Dallas.\"||The others snigger at this, admiring your casual attitude in the face of death, but the man with the gun stands there glowering in silence. Suddenly he clicks his fingers. \"On a wanted poster in Daralbad, that's where it was. They've et a bounty of five hundred scads for you, my friend.\"||\"I'm much in demand.\"||\"Too right! Too right!\" He strides excited around the fire, then turns to his cronies. \"Well, what's it to be? Hang on here in the hope of another bear, or take this prize to Daralbad for the bounty?\"||They settle on cashing you in for the reward. You pretend to take the news sourly, then wait while they celebrate by drinking themselves into a stupor. Flexing your wrists, you soon work free of your bonds and creep quietly over to their supply packs. You remove three food packs, a cold-weather suit, and some polarized goggles.">
<CONSTANT TEXT163-CONTINUED "Then you slip out into the snow">

<ROOM STORY163
	(DESC "163")
	(STORY TEXT163)
	(PRECHOICE STORY163-PRECHOICE)
	(CONTINUE STORY314)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY163-PRECHOICE ()
	<TAKE-FOOD-PACKS 3>
	<SELECT-FROM-LIST <LTABLE COLD-WEATHER-SUIT POLARIZED-GOGGLES> 2 2>
	<CRLF>
	<TELL ,TEXT163-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT164 "Gargan XIII heartily shakes your hand, Gargan XIV sets up the glasses and pours each of you a shot of vodka. You take the glass and sip, only to wince as the alcohol sears into your cut gums. A mist of blood tinges the vodka. The Gargan sisters down their own drinks without a murmur. \"You are a fine warrior!\" declares XIV with approval.||Despite their declarations of friendship, you are careful not to drink much. It's possible that, having realized you are too tough to beat in a straight fight, they hope to ply you with vodka until you are helpless. Turning to the innkeeper, you ask, \"I'll take food and a room for the night. How much do I owe you?\"||Eyes rolling in fright at the two Amazons, he flaps a hand limply in the air and replies in a strained voice: \"No charge, since you are a friend of these fine ladies.\"||You recover a bit after a night's rest.">
<CONSTANT TEXT164-CONTINUED "In the morning, the innkeeper provides you with a food pack for the journey">
<CONSTANT CHOICES164 <LTABLE "travel with the Gargan sisters" "you can delay setting out until they have moved on">>

<ROOM STORY164
	(DESC "164")
	(STORY TEXT164)
	(PRECHOICE STORY164-PRECHOICE)
	(CHOICES CHOICES164)
	(DESTINATIONS <LTABLE STORY294 STORY273>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY164-PRECHOICE ()
	<COND (,RUN-ONCE <GAIN-LIFE 1>)>
	<CRLF>
	<TELL ,TEXT164-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT CHOICES165 <LTABLE "bed down in a park" "a quiet back alley" "an open plaza">>

<ROOM STORY165
	(DESC "165")
	(EVENTS STORY165-EVENTS)
	(CHOICES CHOICES165)
	(DESTINATIONS <LTABLE STORY209 STORY231 STORY253>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY165-EVENTS ()
	<COND (<CHECK-SKILL ,SKILL-STREETWISE> <RETURN ,STORY187>)>
	<RETURN ,STORY165>>

<CONSTANT TEXT166 "You steady yourself as if you were suffering a giddy spell. \"I... can't remember,\" you tell him. \"My mind's a blank. The accident...\"||He glances at the doctor, who nods and says: \"That isn't uncommon in a case like this. You'll find your memory patchy at first, but it will slowly come back to you.\"||The pilot seems satisfied. His brooding look is suddenly swept away by an open smile. \"I have forgotten my manners. I am Riza Baihaqi; this is Dr. Anwar Mujam.\"||You shake hands. \"Be careful to use your flesh-and-blood hand for delicate tasks,\" warns the doctor. \"The grip strength of your cyborg arm is enough to crush bone.\"||\"I'll be careful,\" you reply with a strained laugh.||Riza gestures towards the viewport where the crescent Earth hangs like a luminous pearl. \"You would of course be welcome to remain here as our guest, but I expect that you will be anxious to return to Earth?\"">
<CONSTANT CHOICES166 <LTABLE "go straight back to earth" "tell Riza about your quest">>

<ROOM STORY166
	(DESC "166")
	(STORY TEXT166)
	(CHOICES CHOICES166)
	(DESTINATIONS <LTABLE STORY275 STORY188>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT167 "There is an alphanumeric keypad set in a recess beside the door. You tap in the sequence H-U-M-B-A-B-A and hold your breath, hardly daring to hope that the antique circuitry still works. Then, with a soft whir, the door slides up and you are able to step into the interior of the Great Pyramid.">

<ROOM STORY167
	(DESC "167")
	(STORY TEXT167)
	(CONTINUE STORY233)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT168 "After some squirming, you manage to wedge yourself into the shaft and begin a slow ascent. You are in total darkness. Minutes crawl by, and the air grows stifling as you climb. At last with the sweat pouring off your body, you are on the verge of giving up when you detect a nimbus of grey light from just above. You struggle towards it, cramming your body around a twist in the shaft. A heady aroma hangs in the air here, sweet as greenwood.||You emerge into a larger space at the junction of several ducts. As your eyes adjust to the faint light trickling down from above, you make out a human shape in the gloom. He is hanging like a puppet, entangled in a thick mass of fleshy creepers dangling from the top of the shaft. You approach and touch his shoulder. His head lolls back slowly, falls off, and strikes the floor with a hollow clatter.||You cannot stifle a gasp of horror. You step back, only to find a taut vine cable wound around your ankle. Another brushes your face, gropes with abrupt vitality, and seizes your throat in a firm grip. The creepers are alive and predatory. You struggle, grappling with the vine at your neck to no avail. It is tightening, squeezing your windpipe. Your pulse pounds inside your ears with a dull roar.">
<CONSTANT TEXT168-END "There is nothing you can do to free yourself and you will slowly strangle to death in the grip of the mutant plant">

<ROOM STORY168
	(DESC "168")
	(STORY TEXT168)
	(PRECHOICE STORY168-PRECHOICE)
	(CONTINUE STORY190)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY168-PRECHOICE ()
	<COND (<CHECK-ITEM ,VINE-KILLER>
		<PREVENT-DEATH ,STORY168>
	)(ELSE
		<CRLF>
		<TELL ,TEXT168-END>
		<TELL ,PERIOD-CR>
	)>>

<CONSTANT TEXT169 "The air here is tolerable once filtered of volcanic fumes. You build a lean-to beside the bubbling pool in the shelter of the dwarf conifers. Although the water of the pool is undrinkable, you can easily collect snow from beyond the edge of the oasis and bring it back to camp to melt. For food, you catch insects and grubs and bake them on the hot rocks.">

<ROOM STORY169
	(DESC "169")
	(STORY TEXT169)
	(PRECHOICE STORY169-PRECHOICE)
	(CONTINUE STORY426)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY169-PRECHOICE ()
	<GAIN-LIFE 4>>

<CONSTANT TEXT170 "The baron is cloistered in his tent. A couple of servants are hunkered down in the snow outside next to a glimmering fire, but they pay you no heed. Glancing into the tent as you pass, you notice that the baron is intently studying a video screen which he has set up on a low table next to the cushions on which he is propped. He seems to be muttering something quietly to himself.">
<CONSTANT CHOICES170 <LTABLE "eavesdrop" "boldly enter the tent uninvited" "go and talk to Golgoth" "Boche" "Gaunt">>

<ROOM STORY170
	(DESC "170")
	(STORY TEXT170)
	(CHOICES CHOICES170)
	(DESTINATIONS <LTABLE STORY364 STORY386 STORY126 STORY104 STORY148>)
	(TYPES FIVE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT171 "It is a beam phantom -- the victim of a teleporter accident which has left it eternally out of phase with the rest of the world. Such creatures suffer eternal torment because of the teleporter's mangling of their internal organs, but there is nothing that can be done for them, since they do not truly exist. Even in their ghostly state they are dangerous, however, as their desire to return to solid form means that they insatiably seek contact with the living. And their touch drains all life energy.||While you still have strength to move, you shrug off your jacket and lunge forward holding it like a net, catching the beam phantom inside. The feel of it is sickening, like a broken body that has been put back together by a maniac surgeon. Even with the jacket insulating your grip, its negative force drains you like a well of coldness.">
<CONSTANT TEXT171-CONTINUED "You succeed in manhandling the squirming creature over to the chasm and hurling it down. Its thin bleating cry echoes up from the depths as it falls, trailing its gleaming wisps of vapour like a comet's tail.">

<ROOM STORY171
	(DESC "171")
	(STORY TEXT171)
	(PRECHOICE STORY171-PRECHOICE)
	(CONTINUE STORY149)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY171-PRECHOICE ()
	<TEST-MORTALITY 2 ,DIED-GREW-WEAKER ,STORY171>
	<IF-ALIVE ,TEXT171-CONTINUED>>

<CONSTANT TEXT172 "You hear a scuttling of many insectoid legs. In the sudden flare of light you catch a glimpse of a shape like a giant black centipede, mouthparts churning like oiled blades. Blinded by the unexpected light, it writhes and retreats in panic to the darkness of the cloisters. The three of you seize your chance to hurry on through the iron-bound door, slamming it behind you. A moment later a heavy form thuds against the door.||\"That was a close call,\" breathes Boche, wiping a trickle of cold sweat out of his eyes.">

<ROOM STORY172
	(DESC "172")
	(STORY TEXT172)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT173 "Misjudging the leap, you fall short by an arm's length and go plunging down through the fog to meet your doom on the hard flagstones twenty storeys below.">

<ROOM STORY173
	(DESC "173")
	(STORY TEXT173)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT174 "You kneel beside the huge gem and embrace it, feeling its power surge through you. Coruscating bands of energy blaze from the depths of the unearthly gem, swathing you in an aura of blinding violet light. The fabric of reality is ripped apart and you feel weightless. A vortex spins up through the dome, sweeping away rock and air, rising up into space out past the moon and planets. In what seems like seconds, all of creation has been swept away, replaced by a new universe of your own making.">

<ROOM STORY174
	(DESC "174")
	(STORY TEXT174)
	(VICTORY DESTINY-GODHOOD)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT175 "There is a sound from somewhere ahead in the maze of tunnels. Boche cocks his hear. \"It's the old-fashioned laser fire,\" he says, adding significantly: \"But none of the others were carrying lasers.\"||The mystery is soon explained. Turning a corner, you find yourselves facing three hover-droids that resemble large silver eggs with a rotating gun-turret mounted underneath. They are gliding directly towards you, the aiming-lights of their lasers playing across your vision. Boche throws himself down a side tunnel. You are in motion an instant later, just as three laser beams lance out, burning a patch of molten stone on the floor where you had been standing.||Racing headlong through the tunnels, you reach a circular room with a violet starburst set in mosaic on the floor. Several other tunnels lead into the chamber, and down one of them you see Vajra Singh, Thadra Bey and Chaim Golgoth running from another group of hover-droids. \"We stirred up a whole nest of them,\" shouts Golgoth. \"Too many to fight!\"||As he enters the room, Vajra Singh whirls and fires his mantramukta cannon over the heads of Bey and Golgoth. Four hover-droids explode in a blossom of plasma, but you can see others converging on the room from the other tunnels.||Across the sweep of the opposite wall are seven glass-fronted elevators, each large enough for one person. Thadra Bey lopes across to the nearest and the door slides shut behind her. In moments the room will be swarming with hover-droids. The rest of you have no choice but to follow her lead. As you step into an elevator, the door closes and an electronic voice says: \"Identify yourself, please.\"">
<CONSTANT CHOICES175 <LTABLE "tell the truth" "pretend to be a follower of the Volentine cult">>

<ROOM STORY175
	(DESC "175")
	(STORY TEXT175)
	(CHOICES CHOICES175)
	(DESTINATIONS <LTABLE STORY280 STORY301>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT176 "You return to the surface. Janus Gaunt and Thadra Bey are already back at the camp. They tell you they explored a warren of tunnels under the plaza but to no avail. \"All we found were vaults full of mildewed grain,\" growls Bey.||The long list of sunset is bathing the ruins by the time Vajra Singh and the baron reappear. You soon learn that they set out along different routes which converged at a long underground hall. They are obviously excited by what they discovered. \"We have identified the temple precincts,\" announces Vajra Singh, gesturing to a cluster of buildings across the square. \"The Heart of Volent lies somewhere below. Tomorrow may be the last day of the search.\"">

<ROOM STORY176
	(DESC "176")
	(STORY TEXT176)
	(CONTINUE STORY038)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT177 "Boche is not enthusiastic. \"The Lyonesse region is infested with malefactors and noctambules,\" he avers. \"We would be at great risk. Also, the Atlas Mountains are a daunting obstacle. As your partner in this venture, I strongly urge you to reconsider.\"||He is obviously not willing to accompany you if you insist on heading west.">
<CONSTANT CHOICES177 <LTABLE "do so anyway" "you can change your mind and take the road to Venis">>

<ROOM STORY177
	(DESC "177")
	(STORY TEXT177)
	(CHOICES CHOICES177)
	(DESTINATIONS <LTABLE STORY221 STORY200>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT178 "Strewn amid the mortal remains of the gorgon's victims, you discover a number of items: an ID card, a battery unit for a barysal gun (good for six charges), a working flashlight, and a set of polarized goggles.||Boche holds up the goggles and jokes, \"I don't suppose our one-eyed chum had much use for these, eh?\" He insists on an equal division of the spoils, but gives you first choice. Add two of the items to your list of possessions.">
<CONSTANT TEXT178-CONTINUED "You spend a reasonably comfortable night in the cave and head on your way in the morning">

<ROOM STORY178
	(DESC "178")
	(STORY TEXT178)
	(PRECHOICE STORY178-PRECHOICE)
	(CONTINUE STORY199)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY178-PRECHOICE ("AUX" (COUNT 2) CHARGES)
	<CRLF>
	<TELL "Take the battery unit (6 charges)?">
	<COND (<YES?>
		<COND (<CHECK-ITEM ,BARYSAL-GUN>
			<CHARGE-BARYSAL 6>
		)(ELSE
			<COND (<CHECK-ITEM ,BATTERY-UNIT>
				<SET CHARGES <GETP ,BATTERY-UNIT ,P?CHARGES>>
				<SET CHARGES <+ .CHARGES 6>>
			)(ELSE
				<SET CHARGES 6>
				<TAKE-ITEM ,BATTERY-UNIT>
				<EMPHASIZE "To charge a barysal gun with the battery-unit, press 'B' during action selection.">
				<PRESS-A-KEY>
			)>
			<PUTP ,BATTERY-UNIT ,P?CHARGES .CHARGES>
		)>
		<SET COUNT <- .COUNT 1>>
	)>
	<SELECT-FROM-LIST <LTABLE ID-CARD FLASHLIGHT POLARIZED-GOGGLES> 3 .COUNT>
	<CRLF>
	<TELL ,TEXT178-CONTINUED>>

<CONSTANT TEXT179 "You find an answer to your enquiries in a drinking parlour under the Bridge of Sighs. Here a group of men, rendered affable and talkative by the vials of synthash liqueur they have imbibed, tell you all you need to know.||\"Ky Boche?\" says one of them, scowling distractedly out into the drizzle beyond the eaves of the drinking parlour. \"I have heard of him. A wayfarer and sometimes trader.\"||\"A trader?\" snorts another of the men, sluicing the hot liqueur around his mouth before adding, \"A parasite, rather. His sole instinct is treachery; his sole talent is self-preservation.\"||You turn to the man who has just spoken. \"I take it you've personally had dealings with Kyle Boche?\"||He nods slowly, narrowing his eyes as he peers inward at his memories through a haze of synthash fumes. \"We collaborated in a smuggling operation running furs into Daralbad. This was a few years back. The militia were alerted and Boche scarpered in the boat, leaving me to face the music alone. They're pigs in Daralbad, and that's how I lost these two fingers, see? Later I managed to escape, and I heard Boche had been strutting around telling everyone how I let him down. If I knew where to find him, I'd go this minute and put a knife through his weaselly heart!\"||A third man joins the conversations. \"I do not wholly disagree with my friend here, except to add that Boche's character is more complex than he suggests. If he is treacherous or self-serving, he is not aware of being so, for he is a man of such prodigious vanity that he can admit no faults.||\"The other man, refilling his glass, only hisses like an angry swan and says again, \"He is a mere parasite!\"||If you wish to reveal your knowledge of Boche's whereabouts to the man he betrayed, he will pay you 10 scads for the information.">

<ROOM STORY179
	(DESC "179")
	(STORY TEXT179)
	(PRECHOICE STORY179-PRECHOICE)
	(CONTINUE STORY414)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY179-PRECHOICE ()
	<CRLF>
	<TELL "Do you wish to reveal Kyle Boche's whereabouts?">
	<COND (<YES?>
		<GAIN-MONEY 10>
		<DELETE-CODEWORD ,CODEWORD-DIAMOND>
	)>>

<CONSTANT TEXT180 "You slump in the corner of the bench with barely strength to move. At last, thinking you helpless, the assassins open the steam room door. \"Let's get this carcass over to the baron -- prove we've done the job,\" one of them says.||\"Rather a disappointment,\" says the other, grabbing a hunk of your hair and lifting your head up off the bench. \"I was hoping I'd get to use my knife.\"||Hearing this, you explode into action. You have no compunction about giving the nearest man a very hard kick in the groin. As he doubles up and his accomplice gapes in surprise, you lunge out of the door and race back towards the dormitory. Your nakedness draw a few choice looks from the inn's other residents, so you hastily pull on your clothes.||A few minutes later, the assassins glance into the dormitory. With so many people around, they think better of pursuing you and instead duck out into the night. Just as well. After being shut up in the steam room, you feel too weak for a fight.">

<ROOM STORY180
	(DESC "180")
	(PRECHOICE STORY180-PRECHOICE)
	(CONTINUE STORY092)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY180-PRECHOICE ()
	<TEST-MORTALITY 2 ,DIED-FROM-INJURIES ,STORY180>
	<IF-ALIVE ,TEXT180>>

<ROOM STORY181
	(DESC "181")
	(PRECHOICE STORY181-PRECHOICE)
	(CONTINUE STORY159)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY181-PRECHOICE ()
	<CRLF>
	<TELL "Do you want to find Kyle Boche and tell him about acquiring the sky-car?">
	<COND (<YES?> <STORY-JUMP ,STORY203> <RETURN>)>
	<DELETE-CODEWORD ,CODEWORD-DIAMOND>>

<CONSTANT TEXT182 "By luck you find the following reference:||Extract form the interrogation of Eleazar Picard, leader and sole survivor of the Volentine Cult, July 16, 2113 AD; debriefing conducted by Colonel Mehmet Alishah of al-Lat:||Picard: It was the light at the end of Time, and my sanity is blinded.|Alishah: How is it you escaped? You alone and no one else?|Picard: I remember the Truth.|Alishah: What is the Truth?|Picard [recites]: \"The Truth is a flame. What ignites the flame? The spark ignites the flame. What is the spark? The heart of Volent!\"||You flip through a few other books. Eleazar Picard was the founder of the cult that worshipped the Heart of Volent two hundred years go. He ruled Du-En with six others -- until the night of July 15, 2113, when the entire populace of the city went mad and fled into the Saharan Ice Wastes. Du-En has stood abandoned since then. You check one other detail. Picard died, still raving, only hours after being questioned by Colonel Alishah.">
<CONSTANT CHOICES182 <LTABLE "try making contact with Gaia" "you're finished in the library">>

<ROOM STORY182
	(DESC "182")
	(STORY TEXT182)
	(PRECHOICE STORY182-PRECHOICE)
	(CHOICES CHOICES182)
	(DESTINATIONS <LTABLE STORY138 STORY073>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-LUNAR)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY182-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-CYBERNETICS>
		<SET-DESTINATION ,STORY182 1 ,STORY116>
	)(ELSE
		<SET-DESTINATION ,STORY182 1 ,STORY138>
	)>>

<CONSTANT TEXT183 "The signs you have noticed indicate a porphyr. These are parasitical creatures of ancient myth who roam the night in search of living victims, from whom they drain the body warmth (or, in some versions, the very lifeblood) in order to sustain their own existence. They can only be slain by decapitation, but are vulnerable to direct sunlight, running water, and certain extinct herbs.||You guess that this porphyr was overpowered and hurled into the glacier centuries ago as a way of getting rid of him. Even frozen running water has the power to hold him immobile. Of course, now that the ice has been chipped away, he might be able to escape. You glance up at the thin wedge of powder-blue sky beyond the crevasse, already streaked with dusky grey streamers of cloud. Less than two hours of daylight remain. You tell Shandor your suspicions.||\"Porphyrs?\" he mocks. \"Fairy tales for kiddies, surely.\"||You aren't so sceptical. Fortunately you remember one other thing about these creatures. Their minds are quite simple, and they are particularly baffled by vertical or horizontal lines, which their eyes try to follow to infinity -- similar to the way a chicken can be hypnotized by drawing a chalk mark in front of its beak. You scratch two intersecting lines into the ice directly in front of the trapped porphyr's eyes, then step back with a satisfied nod. \"There it can't escape now.\"||Shandor chuckles and claps his hand on your shoulder. \"In case you hadn't noticed, it couldn't anyway: it's been dead two hundred years and it's trapped under thousands of tons of ice. Still, if it makes you feel safer.\" He turns to his bodyguards. \"Let's get going. We can do another six kilometres by nightfall.\"">

<ROOM STORY183
	(DESC "183")
	(STORY TEXT183)
	(CONTINUE STORY249)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT184 "At last you nestle down in the cleft of a dead tree and drift off to sleep. Strange feverish dreams flicker across the back of your eyelids. Moaning, bathed in torrents of sweat, you fling out an arm to brush away what you imagine to be a gnat. You are not aware of the long prow of reptilian head that hangs down out of the foliage and starts to sup on your blood. Its venom thunders through your bloodstream and keeps you drowsy wile it feasts. You are destined never to wake.">

<ROOM STORY184
	(DESC "184")
	(STORY TEXT184)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT185 "They obviously mean to kill you, not out of viciousness but from the simple logic of survival. There probably is not enough game in the region to provide enough food for a fourth person. As they close in, you put on a crafty expression and glance over your shoulder, back the way you came.||\"Got friends, have you?\" growls the man with the knife. He puts the tip to your throat. \"Answer.\"||\"I'm alone.\"||\"What, then? What were you looking at?\"||\"Nothing.\" You compress your lips. The knife presses tighter, shedding a drop of your blood. \"All right! There's a storeroom down there -- food, medical supplies, that sort of thing. I was just regretting that I'll never get back to civilization and sell it.\"||They peer into the rubble-clogged tunnel, a sheen of greed in their eyes. \"You're lying,\" suggests the man with the gun.||You shrug. \"Yeah. I was just prowling the tunnels for the sake of sightseeing. Of course.\"||The third man scratches his chin thoughtfully. \"We ought to take a look. This joker didn't just spring out of thin air, after all.\" He looks at the man with the knife. \"Snarvo, you stay here and watch our... guest. Krench, you come with me.\"||They tie you up, then depart in search of non-existent booty. You wait until they must be out of earshot in the tunnels below. Snarvo is facing down the tunnel. He thinks you helpless, but in fact you have been burning the rope away from your wrists over the crackling fire. It is a painful business, but better than certain death.">
<CONSTANT TEXT185-CONTINUED "Suddenly you cannon into Snarvo, winding him with a butt in the stomach. Wrestling for the knife, you twist it around and stab him. As he slumps gasping to the floor, you snatch up the knife and run over to the opening. Outside a blizzard is raging, but you cannot wait for the others to return. You push the rug aside and dash out into the storm.">

<ROOM STORY185
	(DESC "185")
	(STORY TEXT185)
	(PRECHOICE STORY185-PRECHOICE)
	(CONTINUE STORY314)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY185-PRECHOICE ()
	<TEST-MORTALITY 1 ,DIED-FROM-INJURIES ,STORY185>
	<IF-ALIVE ,TEXT185-CONTINUED>
	<TAKE-ITEM ,KNIFE>>

<CONSTANT TEXT186 "Again the battle is joined. This time you and your two opponents have the measure of each other. The twins circle warily, trying to divide your attention. You plant your back solidly to the bar and wait with arms spread wide, daring them to attack. The extravagant acrobatics have been set aside now. All three of you are too breathless to waste effort on high flying kicks or fast barrages of punching.||One lunges forward, clutching at your neck. You counter, pushing her arm up as you drive stiffened fingers into the corded muscles of her throat. As she splutters, briefly limp, you swing her around, using her as a shield that her sister's sudden attack catches her in the back. But she recovers faster than you expected, and her knee drives up agonizingly into your groin.">
<CONSTANT TEXT186-CONTINUED "You finally manage to swing one of the twins off her feet and hurl her at the other with such force that both are knocked senseless. You are not in much better shape yourself.">

<ROOM STORY186
	(DESC "186")
	(STORY TEXT186)
	(PRECHOICE STORY186-PRECHOICE)
	(CONTINUE STORY142)
	(CODEWORD CODEWORD-SCYTHE)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY186-PRECHOICE ()
	<TEST-MORTALITY 3 ,DIED-IN-COMBAT ,STORY186 ,SKILL-CLOSE-COMBAT>
	<IF-ALIVE ,TEXT186-CONTINUED>>

<CONSTANT TEXT187 "You recognize the signs that mark some areas of the city as unsafe: the hard sidelong scrutiny of the locals, the ragged evidence of poverty, the nervous hurrying footsteps in the fog. You head for a well-lit plaza where people are likely to be working all night.">

<ROOM STORY187
	(DESC "187")
	(STORY TEXT187)
	(CONTINUE STORY253)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT188 "You explain what you have learned regarding Du-En and the Heat of Volent. \"It seems far-fetched,\" says Riza when he has heard you out.||\"You look down dourly at the fusion of metal and flesh that is now your body. \"Before my accident, it seemed a noble but distant goal. Now it has taken on a personal dimension. With the power of the Heart, I can restore myself.\"||\"And much more, if Gaia is to be believed,\" says Riza. He takes you through to another room and sits you in front of a screen. \"Here you have access to the information banks. Perhaps you can find out something that will help in your venture.\"||You watch as he touches a few buttons. A list of files concerning the Heart of Volent appears on the screen. \"I think I can take it from here,\" you tell Riza.||He nods. \"Good. I'll come back in an hour or so and see how your work is going.\"">
<CONSTANT CHOICES188 <LTABLE "check through the files on the screen" "go for a stroll and see what else you can find out here">>

<ROOM STORY188
	(DESC "188")
	(STORY TEXT188)
	(PRECHOICE STORY188-PRECHOICE)
	(CHOICES CHOICES188)
	(DESTINATIONS <LTABLE STORY210 STORY254>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY188-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-LORE> <STORY-JUMP ,STORY232>)>>

<CONSTANT TEXT189 "Glancing around for a means of opening the door, you notice an alphanumeric keypad set in a recess to one side. As you are cleaning away the crust of snow, it strikes you that a hundred years might have passed since this door last opened. There are billions of possible combinations, but whoever used it then would have known the correct sequence to punch into the keypad.||You close your eyes, focusing with that inward mental sense which transcends ordinary reality. The veil of time draws aside. For a moment you glimpse a figure in the military dress of an earlier era, stabbing impatiently at this very keypad.||The image flickers, breaks apart like a projection on smoke. With bated breath you enter the same sequence you thought you saw the soldier use: H-U-M-B-A-B-A. There is a crackling of ice as the door slides up to admit you.">

<ROOM STORY189
	(DESC "189")
	(STORY TEXT189)
	(CONTINUE STORY233)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT190 "A haze begins to close over your vision. You haul out the canister, point it up into the mass of squirming roots above your head, and press the nozzle. An acrid fluid sprays out, soaking the plant. Some of it covers your fingers, causing the canister to slip out of your grasp. Ignoring the slight stinging sensation, you jab your hand against the root holding your throat. With a hushed and eerie rustling sound, the creepers pull away and shrivel up the shaft. You steady yourself against the wall and gratefully suck in lungfuls of the stale vine-scented air.||The canister fell by your feet. As you retrieve it, you notice something glinting in the half-light. A barysal gun. You glance at the long-dead cadaver. The gun didn't do him much good, but you might find a use for it. It has just one charge remaining.">
<CONSTANT TEXT190-CONTINUED "You can see now that there is no way you can hope to reach the surface form here. The shaft is blocked by the dead plant. You wriggle back down the shaft and take the subway carriage back to Marsay. Fax has long gone, of course">
<CONSTANT CHOICES190 <LTABLE "go up to the ruins and continue your journey on foot" "try one of the subway's other destinations: choose between Kahira" "Tarabul" "Giza">>

<ROOM STORY190
	(DESC "190")
	(STORY TEXT190)
	(PRECHOICE STORY190-PRECHOICE)
	(CHOICES CHOICES190)
	(DESTINATIONS <LTABLE STORY420 STORY050 STORY031 STORY074>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY190-PRECHOICE ()
	<TAKE-OR-CHARGE 1 T>
	<CRLF>
	<TELL ,TEXT190-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT191 "The gates of Du-En stand open to the elements, leaving the wide avenues piled under deep snow-dunes. The buildings are monoliths of dark stone, desolate remnants of a civilization long gone. Their vast scale and pitiless geometric decoration make them seem out of proportion to the human soul. You find them tyrannical and depressing.||\"Impressive architecture, eh?\" says Boche, looking to a high black tower whose fretwork dome shows like a fleshless head against the bleak white sky.||You see a thin swirl of smoke rising from a campfire in the main plaza of the city. \"It seems we're not the only ones to heed Gaia's message,\" you say dourly. \"Come on, let's introduce ourselves.\"">

<ROOM STORY191
	(DESC "191")
	(STORY TEXT191)
	(CONTINUE STORY243)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT192 "You return to your campsite in the shelter of a ruined building and settle down for the night. The flames of the fire throw long capering shadows across the walls. The ground is so cold that it seems to suck the vitality out of you.||How long has it been since you ate?">

<ROOM STORY192
	(DESC "192")
	(STORY TEXT192)
	(PRECHOICE STORY192-PRECHOICE)
	(CONTINUE STORY083)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY192-PRECHOICE ("AUX" (LIFE 0))
	<COUNT-POSSESSIONS>
	<COND (<CHECK-VEHICLE ,MANTA-SKY-CAR>
		<SET LIFE 2>
	)(ELSE
		<COND (<CONSUME-FOOD 1> <SET LIFE <+ .LIFE 1>>)>
		<COND (<CHECK-ITEM ,MEDICAL-KIT> <SET LIFE <+ .LIFE 1>>)>
	)>
	<COND (<CHECK-CODEWORD ,CODEWORD-HOURGLASS> <SET LIFE <- .LIFE 1>>)>
	<COND (<G=? .LIFE 0>
		<GAIN-LIFE .LIFE>
		<PREVENT-DEATH ,STORY192>
	)(ELSE
		<TEST-MORTALITY 1 ,DIED-GREW-WEAKER ,STORY192>
	)>>

<CONSTANT TEXT193 "Your footing slips on an icy outcropping as you are making your way down and, having no wish to fall to your doom in the bowels of the earth, you scramble back up onto the bridge.">

<ROOM STORY193
	(DESC "193")
	(EVENTS STORY193-EVENTS)
	(STORY TEXT193)
	(CONTINUE STORY215)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY193-EVENTS ()
	<COND (<AND <CHECK-SKILL ,SKILL-AGILITY> <CHECK-ITEM ,ROPE>> <RETURN ,STORY237>)>
	<RETURN ,STORY193>>

<CONSTANT TEXT194 "Your sixth sense, while not as sensitive as the baron's, warns you of something alien and predatory moving in for the kill. You hear its insectoid legs rattling on the marble floor. Diving to one side, you feel a stab of pain lance up your leg. Without the forewarning of your ESP you would have been torn in half by the monster's mandibles.">
<CONSTANT TEXT194-CONTINUED "You scramble to the doorway where you now see the flash of Boche's torch. As you throw yourself through, the baron slams the door shut and Boche drops the bolt. Just in time. A second later and the door gives a jolt as something massive slams against the other side.">

<ROOM STORY194
	(DESC "194")
	(STORY TEXT194)
	(PRECHOICE STORY194-PRECHOICE)
	(CONTINUE STORY281)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY194-PRECHOICE ()
	<TEST-MORTALITY 1 ,DIED-FROM-INJURIES ,STORY194>
	<IF-ALIVE ,TEXT194-CONTINUED>>

<CONSTANT TEXT195 "You retreat as far as the room where Novak was frozen in stasis. The baron's brain glides closer. The telepathic messages are getting scrambled and incoherent now, as the thing slowly uses up its remaining oxygen.">
<CONSTANT TEXT195-ESP "The soldier's dead. Can't risk using Boche... Not until I know... How did he hide grenade from me? Need new body... new life. Yours..">

<ROOM STORY195
	(DESC "195")
	(STORY TEXT195)
	(PRECHOICE STORY195-PRECHOICE)
	(CONTINUE STORY085)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY195-PRECHOICE ()
	<CRLF>
	<HLIGHT ,H-ITALIC>
	<TELL ,TEXT195-ESP>
	<HLIGHT 0>
	<CRLF>
	<COND (<CHECK-ITEM ,STUN-GRENADE> <STORY-JUMP ,STORY239>)>>

<CONSTANT TEXT196 "You manage to jump across catch hold of a girder that projects from the roof of the building opposite. You scramble up over the parapet and run off while the Fijian shouts out threats behind you.">

<ROOM STORY196
	(DESC "196")
	(STORY TEXT196)
	(CONTINUE STORY311)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT197 "You fetch Vajra Singh's cannon and begin to power it up. A hum of colossal energy fills the air. Taking the stasis bomb from your pack, you station yourself beside the Heart. You will freeze yourself in time, so that if any others reach here in the years to come they will find you waiting, sealed along with the Heart inside a zone of stasis. Even if they have the means to break the stasis, they will have to get past you to claim the Heart.">

<ROOM STORY197
	(DESC "197")
	(STORY TEXT197)
	(VICTORY DESTINY-SENTINEL)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT198 "You had not expected Gilgamesh to be able to follow through the narrow ventilation ducts, but now there is a metallic clanking and he climbs out into the corridor. In order to fit in the shaft, he has detached his right arm and most of his armour segments, so that he now looks like a bizarre metal skeleton.||\"This reconfiguration lacks a long-term power source,\" he tells you. \"I have enough power stored for three hours, then I must reintegrate with my other components.\"||\"Aren't you more vulnerable without your armour?\"\"Affirmative. I shall avoid direct danger except when your own life is threatened.\"||\"The automaton looks less impressive when it's undressed,\" you overhear Gargan XIII remark to her sister.||\"Probably just like its owner,\" says Gargan XIV with a sneer.">

<ROOM STORY198
	(DESC "198")
	(STORY TEXT198)
	(CONTINUE STORY325)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT199 "Dusk is falling on the tenth day after leaving the Etruscan Inn when you finally come in sight of Venis. It shimmers with a thousand lights under a sky like dull green bronze. Hungry and cold, you quicken your pace until you can make out individual buildings -- first the temporary shacks where hunters and traders dwell, then the slums of corrugated iron and plastic which fill the narrow streets that some say were once canals. Above them loom the blocks of ancient plazas, where the rich and powerful of the city reside in palatial buildings shored up with wooden scaffolding to support them from the ravages of time.||You soon learn that the ferry to Kahira is not due for a couple of days. Kyle Boche tells you that he has friends he must visit, and arranges to meet up with you when the ferry arrives. While waiting, you have a choice of where to take lodging. The lavish Marco Polo Hotel will charge 12 scads for two nights; the Hotel Paradise will charge 6 scads; the disreputable Doge's Inn will cost only 3 scads.">
<CONSTANT CHOICES199 <LTABLE "go to the Marco Polo" "opt for Paradise" "check in at the Doge's Inn">>

<ROOM STORY199
	(DESC "199")
	(STORY TEXT199)
	(PRECHOICE STORY199-PRECHOICE)
	(CHOICES CHOICES199)
	(DESTINATIONS <LTABLE STORY286 STORY244 STORY371>)
	(REQUIREMENTS <LTABLE 12 6 3>)
	(TYPES <LTABLE R-MONEY R-MONEY R-MONEY>)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY199-PRECHOICE ()
	<COND (<CHECK-ITEM ,ID-CARD>
		<SET-DESTINATION ,STORY199 1 ,STORY222>
	)(ELSE
		<SET-DESTINATION ,STORY199 1 ,STORY286>
	)>>

<CONSTANT TEXT200 "Your journey takes you up into the mountains, where the days are dull under a leaden sky and the nights are filled with swirling snow. You subsist on a few rations brought with you from the inn, but these are quickly used up. Too quickly. You must reach an inhabited area soon or else starve.||Forcing your way bent-backed against a glacial wind, you are traversing a narrow pass when you catch sight of a human figure on a ledge up ahead. Your cries of greeting are ignored, and the figure is hidden for a moment behind a veil of snow. Hurrying forward, you discover several other figures, but none are glad to see you. They are beyond any emotion, in fact, being long dead and frozen into rigid statues by the cold.">
<CONSTANT CHOICES200 <LTABLE "go closer to investigate" "ignore the frozen corpses and continue along the pass">>

<ROOM STORY200
	(DESC "200")
	(STORY TEXT200)
	(CHOICES CHOICES200)
	(DESTINATIONS <LTABLE STORY265 STORY285>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-DIAMOND)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT201-ESP "A sudden sense of danger warns you not to proceed and you slip out of the shop">
<CONSTANT TEXT201-END "You blithely submit to the anaesthetic and your consciousness slides away, never to return. You should have been more wary than to put yourself at the mercy of such street scum">

<ROOM STORY201
	(DESC "201")
	(PRECHOICE STORY201-PRECHOICE)
	(CONTINUE STORY223)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY201-PRECHOICE ()
	<CRLF>
	<COND (<CHECK-SKILL ,SKILL-ESP>
		<PREVENT-DEATH ,STORY201>
		<TELL ,TEXT201-ESP>
	)(ELSE
		<TELL ,TEXT201-END>
	)>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT202 "The queue shuffles along slowly and at last you reach the ticket office. A bored official in the livery of a Venisian merchant guild peers at you through a screen of wire/meshed glass. \"The cost of passage as far as Kahira is ten scads,\" he tells you.">
<CONSTANT CHOICES202 <LTABLE "pay this sum" "not">>

<ROOM STORY202
	(DESC "202")
	(STORY TEXT202)
	(CHOICES CHOICES202)
	(DESTINATIONS <LTABLE STORY246 STORY288>)
	(REQUIREMENTS <LTABLE 10 NONE>)
	(TYPES <LTABLE R-MONEY R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT203 "Boche has a broad grin on his face as he looks over the sky-car and then turns to you, saying, \"This is a startling and welcome piece of luck! Now that we have a Manta, success in our venture is virtually assured.\"||\"Our venture?\" You raise your eyebrows. \"So you did overhear Gaia's message back at the Etruscan Inn.\"||He claps you heartily on the back. \"You know I did, but what of it? We are partners, and shall share the power of the Heart equally. Now that we have this vehicle, there is no need to wait for the ferry to Kahira. We can set out directly for Du-En.\"">

<ROOM STORY203
	(DESC "203")
	(STORY TEXT203)
	(CONTINUE STORY159)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT204 "You take the elevator to the floor indicated but find only the dim after-hours lights illuminating the corridor. As you are looking around, a janitor steps out of an office with pail and broom in hand and nods to you respectfully. \"If you are looking for Doctor Jaffe, she has gone home for the night. The surgery opens again at nine AM.\"">

<ROOM STORY204
	(DESC "204")
	(STORY TEXT204)
	(CONTINUE STORY073)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT205 "Shandor's two remaining bodyguards produce small picks with which they hack at the ice. They are strong men and throw themselves into the job tirelessly, but it is soon obvious that the ice is too hard-packed. They remove their fur jackets despite the cold and one of them, turning to Shandor and wiping beads of sweat out of his eyes, says, \"It's going to take us hours to get the body out, boss.\"||Shandor glances at you, then shrugs. \"Just chip the ice away around the hand, then. Get the sword.\"||It is almost an hour before they have achieved this. By now the wind has dropped, making just a low ghastly moan as it gusts along the gully leading down to the cave. Nightfall cannot be more than a couple of hours off. You go over with Shandor and peer at the ice wall. Where the picks have gouged down to the corpse's hand, the clear blue ice has become cloudy with white cracks. The hand hangs limply, the shortsword still clutched in its fingers. Shandor goes to take it, hesitates, turns to you with a grimace of distance. \"I'm not easily spooked, but... \" He gives an embarrassed chuckle.||The shortsword is of Japanese style, its blade still razor sharp in spite of a faint speckling of rust. You can take it if you wish; if not one of the bodyguards will claim it.||You notice something odd about the corpse's hand. The slight violet bloom to the skin could be attributed to its preservation in ice, but the long index finger and the hair on the palm are not so easy to explain.">

<ROOM STORY205
	(DESC "205")
	(STORY TEXT205)
	(PRECHOICE STORY205-PRECHOICE)
	(CONTINUE STORY270)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY205-PRECHOICE ()
	<KEEP-ITEM ,SHORTSWORD>
	<COND (<CHECK-SKILL ,SKILL-LORE> <STORY-JUMP ,STORY183>)>>

<CONSTANT TEXT206 "The creature that attacked you is a sanguivore. A species of tree/dwelling lizard which is halfway to evolving flight, this is just one of the hallucinatory by-products of the Paradox War. From the way your wound is pouring blood, you suspect the sanguivore's saliva contained an anti-clotting agent. That alone would not explain your increasing dizziness, though, which suggests its bite also injected a drug. No wonder it's in no hurry to catch up with you -- easier by far to track you through the woods and wait until you collapse. Well, you are not as helpless as the wild animals on which the sanguivore normally preys. Tearing the lining of your jacket into strips, you bind the wound to prevent further blood loss.||The only thing you can do about the drug is stay on the move until you find shelter. If you were to lie down now you would never get up again.">

<ROOM STORY206
	(DESC "206")
	(STORY TEXT206)
	(CONTINUE STORY250)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT207 "You start to move forwards, begin a lunge towards the man with the gun, the jump adroitly aside as he discharges a blast. The blue-white flash snaps through the air and explodes against the knife-wielder's arm. He drops with a whimper. The third hunter runs in, arms spread wide to grab you, but you duck under his clumsy tackle and dart towards the rug covering the door. Another shot crackles from the gun, and again you veer away, but this time it glances across your hip, burning the clothing away and inflicting a painful burn.">
<CONSTANT TEXT207-CONTINUED "You are luck to be alive. Wasting no more time, you throw yourself through the opening and limp off into the blizzard. The hunters do not give chase.">

<ROOM STORY207
	(DESC "207")
	(STORY TEXT207)
	(PRECHOICE STORY207-PRECHOICE)
	(CONTINUE STORY314)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY207-PRECHOICE ()
	<TEST-MORTALITY 1 ,DIED-FROM-INJURIES ,STORY207>
	<IF-ALIVE ,TEXT207-CONTINUED>>

<CONSTANT TEXT208 "Placing your chair behind a heavy oaken post, you drape your coat across the back and prop your travelling-pack under it. If the sisters were to glance in your direction, they would assume you were still brooding at your table. In fact they seem entirely preoccupied, leaning on the bar and muttering to one another in terse whispers. You slide through the shadows to the far end of the room, slip unnoticed over the bar, then creep back on hands and knees until you are hidden just below where the sisters are talking. The innkeeper notices you, but luckily he is too terrified to make any comment.||\"We'll need a barysal gun,\" one of the sisters is saying.||\"We'll need two. Gaia said the Heart must be bombarded with two barysal beams at right angles. That will cause a critical resonance and destroy it.\"||\"There's going to be others heading for the Heart. Vajra Singh's interest cannot be a coincidence; Janus Gaunt too. It'll be difficult to achieve the Heart's destruction with such as they are intent on preserving it.\"||You listen with keen interest. So others are bound for Du-En and it seems not all of them share the goal of ultimate power. This is worth thinking about. Meanwhile, you return stealthily to your seat.">

<ROOM STORY208
	(DESC "208")
	(STORY TEXT208)
	(CONTINUE STORY252)
	(CODEWORD CODEWORD-NEMESIS)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT209 "Claustral Park is a large expanse in the upper level of the city which is entirely given over to wilderness. The fence is lined up with bright arc-lamps, and these are directed inwards across a grassy perimeter towards a thick unkempt woodland.||Scaling the fence, you scurry across the open area of grass and push into the bushes. Twigs and moss suffice to make a reasonably comfortable bed. As you drift off to sleep, you gaze back through the tree at the arc-lamps glaring hard in the mist. Why illuminate the park if no one comes here after dark? Perhaps the lamps were installed in bygone days and it is not known how to turn them off...||You wake with a stifled scream. You heave been seized by many hands and they are dragging you deep into the woods. You struggle, making contact with rough bodies that rasp your flesh like sandpaper. In the darkness you can see nothing of your assailants, but you can hear their snuffling grunts. They drag you to a clearing and break your limbs so that you cannot escape.||The claustrals cannot believe their good luck. Now they will feed on fresh meat for weeks to come.">

<ROOM STORY209
	(DESC "209")
	(STORY TEXT209)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT210 "Initiating a search of the files, you turn up a video almost two hundred years old. It shows an interview with Eleazar Picard, leader of the Volentine Cult, after he had fled form the unexplained destruction of Du-En. As you listen to Picard rambling about 'the madness' and 'the end of everything', you begin to piece together the facts. Apparently there was some kind of cataclysm or riot in the city, from which Picard barely escaped with his life.||A hawk-faced man in a colonel's uniform appears on the screen. He listens as Picard becomes slightly more lucid under the effect of truth serum: \"It was the light at the end of Time, and my sanity is blinded!\"||\"How is it you escaped?\" asks the colonel. \"You alone and no one else?\"||Picard replies, \"I remembered the Truth.\"||At this point, Picard's eyes glaze and he starts to recite a catechism of his faith: \"The Truth is a flame. What ignites the flame? The spark ignites the flame. What is the spark? The Heart of Volent!\"||You scan forward through the rest of the interview, but Picard soon lapses into incoherence. A message at the end informs you that he died soon afterwards.">

<ROOM STORY210
	(DESC "210")
	(STORY TEXT210)
	(CONTINUE STORY254)
	(CODEWORD CODEWORD-LUNAR)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT211 "In a recess beside the door is a keypad comprising both letters and numerals. Putting your ear to the door, you begin to experiment with various combinations. Only an expert cracksman like yourself could recognize the distinctive clicks and whirs from the mechanism that show when you are on the right track.||After an hour or so you have identified the first four letters of the code sequence. From that point it is a simple matter of trial and error to find the correct keys to press. Your efforts are rewarded with a hum of machinery as the door slides upwards, revealing the interior of the pyramid.">

<ROOM STORY211
	(DESC "211")
	(STORY TEXT211)
	(CONTINUE STORY233)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT212 "The motilator registers your destination by flashing a light on the map. A chime sounds, warning that the doors are about to close. Fax steps back and raises his hand to wave. You watch his lean figure recede along the platform as the carriage gathers speed. The lights of the station dwindle into the distance of the tunnel.||You are on your way... where?">
<CONSTANT CHOICES212 <LTABLE "go to Kahira" "to Karthag" "to Tarabul" "to Giza">>

<ROOM STORY212
	(DESC "212")
	(STORY TEXT212)
	(CHOICES CHOICES212)
	(DESTINATIONS <LTABLE STORY050 STORY124 STORY031 STORY074>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT213 "Up ahead you can now see a small figure trudging through the snow, dwarfed by the high walls of the city. Approaching, you attract his attention and he turns. As he unzips his hood you are struck by sudden recognition. \"Kyle Boche,\" you mutter wryly. \"What a small world.\"||\"So,\" he says with a wide grin, \"you have also come to seek the ultimate power!\"">

<ROOM STORY213
	(DESC "213")
	(STORY TEXT213)
	(CONTINUE STORY191)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT214 "\"You might alter that list of priorities once you've heard what the Heart's 'ultimate power' actually consists of,\" you tell him.||He listens as you explain about Gaia's warnings. \"That does change things,\" he admits. \"It seems the Heart is a danger to the existence of the United States.\"||\"The existence of the whole universe!\"||Golgoth smiles. \"The universe doesn't sign my pay cheques. But I agree, we must see that the Heart is destroyed.\"">

<ROOM STORY214
	(DESC "214")
	(STORY TEXT214)
	(CONTINUE STORY192)
	(CODEWORD CODEWORD-BLUE)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT215 "You reach the far end of the bridge and pass through into the tiled hall beyond. The architecture here is the same oppressive design as on the surface: the heavy harshly-chiselled lintels and monumental bulbous columns, the gigantic vaults and grotesque carvings. You have a choice of routes on from here: either of the two wide passages directly ahead, or a doorway to your left.">
<CONSTANT CHOICES215 <LTABLE "go through the door" "take the left-hand passage" "take the right-hand passage">>

<ROOM STORY215
	(DESC "215")
	(STORY TEXT215)
	(CHOICES CHOICES215)
	(DESTINATIONS <LTABLE STORY259 STORY003 STORY128>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT216 "You are used to sneaking about in the dark, and you have learned to rely on your other sense almost as well as on your sight. Even as the huge predator comes darting out from the cloisters to attack, you are racing nimbly ahead to the feeble glimmer of light from the doorway.||Reaching it, you turn to see Boche and the baron fleeing in terror. In the light of Boche's flashlight you have a brief glimpse of a gigantic centipede with flanks like polished steel. As the others dive through, you slam the door shut and drop the bolt. A second later the door judders as the monster throws itself against it.||\"Let's hope it holds,\" says Boche grimly. \"I wouldn't want to fight that beastie!\"">

<ROOM STORY216
	(DESC "216")
	(STORY TEXT216)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT217 "You retreat as far as the room where the soldier is frozen in stasis. The baron's brain glides in pursuit. The telepathic messages are getting scrambled and incoherent now, as the brain slowly uses up its remaining oxygen.">
<CONSTANT TEXT217-MESSAGE "Stay... need your body. Getting dark.. Need new body...">
<CONSTANT TEXT217-CONTINUED "So that's its game! You duck around behind the stasis zone, watching the hovering brain as though through a lens. As soon as you are around the edge of the zone, you sidle to a point directly opposite your foe, then backtrack and run around to come up behind it. In his confusion, the baron had forgotten that light takes several seconds to cross the stasis zone. He is still watching your image when you club out of the air and crush him underfoot. The brain emits a dying wail -- a silent sound that you hear only inside your mind. It will haunt your nightmares for many years. If you live that long">

<ROOM STORY217
	(DESC "217")
	(STORY TEXT217)
	(PRECHOICE STORY217-PRECHOICE)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY217-PRECHOICE ()
	<CRLF>
	<HLIGHT ,H-ITALIC>
	<TELL ,TEXT217-MESSAGE>
	<HLIGHT 0>
	<CRLF>
	<CRLF>
	<TELL ,TEXT217-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT218 "Veering the sky-car in the air over Kahira, you glance down to see the Fijian shaking his fist up at you. He looks a tiny figure from here. You buzz him, swooping so low that he has to throw himself flat on the roof for fear of being hit. You fly off laughing into the night.">

<ROOM STORY218
	(DESC "218")
	(STORY TEXT218)
	(PRECHOICE STORY218-PRECHOICE)
	(CONTINUE STORY311)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY218-PRECHOICE ()
	<TAKE-VEHICLE ,MANTA-SKY-CAR>>

<CONSTANT TEXT219 "You station yourselves beside the Heart. Within its glittering facets, a universe is waiting to be born. Infinite possibilities flicker in the violet glare.|Golgoth seems to share your mood. \"There's no other way,\" he says. \"Ready?\"||\"What will happen?\" you ask him. \"I mean, will it just disappear, or will there be an explosion?\"||He shrugs. \"I don't know. Personally I doubt if I'll be around afterwards to collect this month's pay, but no one lives for ever.\"||You nod. \"I just never expected to be a martyr, that's all.\"||The beams from your guns converge at the centre of the Heart, splintering its crystal lattice. The light within grows until it blinds you. With a rush of energy, the Heart suddenly bursts apart, engulfing you and Golgoth in a cold flare of energy.">

<ROOM STORY219
	(DESC "219")
	(STORY TEXT219)
	(VICTORY DESTINY-SACRIFICE)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT220 "Gargan XIV was expecting that. She tosses a glass vial into Gilgamesh's unprotected ribcage. It breaks, releasing a green fluid which hisses as it gives off a cloud of acrid vapour. Gilgamesh staggers as the acid burns through his central power casing. He tries to aim his gun, but suddenly there is a crackle of sparks and his body locks rigid. You see the gleam of light fade from his eye-slit.||\"That's your robot dealt with,\" says Gargan XIV, beckoning you to come closer. \"See if you can do any better.\"||Meanwhile, Gargan XII has drawn a knife and is standing over Golgoth. She thinks he is beaten, when suddenly he looks up with a broad smile.">

<ROOM STORY220
	(DESC "220")
	(STORY TEXT220)
	(PRECHOICE STORY220-PRECHOICE)
	(CONTINUE STORY154)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY220-PRECHOICE ()
	<DELETE-CODEWORD ,CODEWORD-ENKIDU>>

<CONSTANT TEXT221 "As you travel west, the bitter cold begins to ease. Instead of wild blizzards, you find yourself trudging through flurries of soft sleet. After several days you see a harsh light on the horizon. Ahead looms an arc of sunlight slanting through a wide gulf in the clouds. Even when night falls, the light keeps blazing down. An old weather satellite far out in space, misdirected by Gaia's freakish whims, battles the landscape in endless sun. These are the steaming swamps and jungles of Lyonesse.||On the northern fringes of the region, you have heard that men exploit the fertile farmland to support the old city of Lyon. To the south, the warm waters mean plentiful fish. But no one inhabits the interior of Lyonesse, which is the stalking ground of mutated beasts and carnivorous fungi.||You press on undaunted, pleased to be able to shrug off your thick furs as you leave the icy wasteland behind and enter the lush dank morass. Foliage like ships' sails blots out much of the sky, leaving you plunged in green gloom despite the ceaseless daylight. Extravagant blooms with jewel-like colours exude a mingle of musky scents. Creepers stretch in nets between the black trees. Ferns form high banks across your path. Off in the distance, the chittering and screeching of jungle animals seem unreal after so many days with only the wind's howl in your ears. Here there is no night or day. When tiredness becomes too much, you slump sweat-soaked beside a fallen log and roll our clothing up to make a pillow. The succulent jungle whispers lull you off to sleep.">

<ROOM STORY221
	(DESC "221")
	(STORY TEXT221)
	(PRECHOICE STORY221-PRECHOICE)
	(CONTINUE STORY075)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY221-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-ESP>
		<STORY-JUMP ,STORY030>
	)(<CHECK-SKILL ,SKILL-AGILITY>
		<STORY-JUMP ,STORY053>
	)>>

<CONSTANT TEXT222 "You notice a man at reception using a gold card similar to the one you found. After glancing at it, the clerk puts on an ingratiating smile and escorts the man through the VIP lounge. You make discreet enquiries of a bellboy, who tells you that the cardholder is a member of the Society of the Compass. \"They're the top people. Always get the best of everything.\"||\"It's a sort of traveller's club, then?\"||\"More than a club. One gentleman who stayed here told me that he displayed his Compass ID to a mugger who threatened him in the street. The mugger was so frightened of the Compass Society's retribution that he ran off empty-handed\"||A useful item. You examine your own ID card in the privacy of your room. Unfortunately, the hologram photo looks nothing like you. Perhaps you can see about getting it altered somehow.">

<ROOM STORY222
	(DESC "222")
	(STORY TEXT222)
	(CONTINUE STORY286)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT223 "You hurry along to the end of the street, where an old man stops you and asks, \"Is Sarco the Poisoner still open for business?\"||\"How should I know?\" you reply. \"I am not acquainted with the man you mention.\"||He returns a look that suggests you are either deranged or a liar. \"I just now saw you leave his shop!\" he declares.||You rub your jaw ruefully. \"Sarco the Poisoner, indeed.\"||It seems you've had a narrow escape.">
<CONSTANT CHOICES223 <LTABLE "keep trying to get the ID card altered" "see to other matters before the ferry to Kahira arrives">>

<ROOM STORY223
	(DESC "223")
	(STORY TEXT223)
	(CHOICES CHOICES223)
	(DESTINATIONS <LTABLE STORY245 STORY414>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT224 "As the queue moves along, Kyle Boche hurries to join you. Stamping his feet to fend off the morning chill, he tells you that he was delayed by some last-minute purchases in town. You notice a new barysal gun at his belt. \"We're on our way now,\" he says excitedly, grinning as he stares out into the mist over the sea. \"The adventure's begin!\"||A problem arises when you reach the ticket office. The cost of passage to Kahira is 10 scads each. Boche peers woefully at his remaining funds and then turns to you with a shrug. \"You'll have to pay for me, I'm afraid. Still we're partners. I'm sure you'll agree I've never stinted from doing my bit up till now.\"">
<CONSTANT CHOICES224 <LTABLE "pay for both" "pay for yourself but not for him" "you do not have enough money even to buy your own ticket">>

<ROOM STORY224
	(DESC "224")
	(STORY TEXT224)
	(CHOICES CHOICES224 )
	(DESTINATIONS <LTABLE STORY246 STORY267 STORY288>)
	(REQUIREMENTS <LTABLE 20 10 NONE>)
	(TYPES <LTABLE R-MONEY R-MONEY R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT225 "The next morning you are overtaken by a blizzard that turns the sky dark as Doomsday. Stumbling on, you are barely able to see the others through the thick snowfall. Then a blue flare erupts in the gloom, drawing you to where Shandor stands with two of his bodyguards. He has a sputtering magnesium torch in his hand which drips hissing fragments of hot metal into the snow. \"Where's Goro?\" says one of the bodyguards.||You all gaze off into the blizzard. No one says a thing until Shandor grabs your sleeve. \"We can't do anything for him now,\" he calls over the shrieking wind. \"Come on, there's an ice cave we can shelter in.\"||You follow the others down a crevice in the ground. In the light of Shandor's flare, the walls around you gleam like old blue glass. \"This is frozen meltwater,\" you say, running your hand across the smooth ice. \"We must be on another glacier.\"||\"Inside a glacier, you mean,\" mutters Shandor. \"Eerie, isn't it? We're safer here than out in that storm, though.\"||You walk along the gallery of ice, overwhelmed by a sense of awe. Perhaps this was a mighty river once, a raging torrent, before the summers died and the Ice Age took root in the world. Now it slides imperceptibly along the rate of a few centimetres a year.||You see a face in the ice and jump back with a startled cry. Shandor comes over and raises the torch. Frozen just inside the surface of the wall is a man in black military-style overalls, a shortsword held in one hand. Perhaps he has been there for centuries, but what makes you shudder is that fact that his eyes are wide open. \"I could almost fancy he's watching us,\" you say.||\"Tell you what I fancy,\" says Shandor. \"That sword he's got.\"">
<CONSTANT CHOICES225 <LTABLE "chip the body out of the ice" "wait until the blizzard is past and then press on">>

<ROOM STORY225
	(DESC "225")
	(STORY TEXT225)
	(CHOICES CHOICES225)
	(DESTINATIONS <LTABLE STORY205 STORY249>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT226 "The relief crew arrive and take shelter from the cold inside the terminal building. Strolling along the wharf, you spy a cluster of wickerwork pots containing live cancretes. These are pale crustaceans with long spines: a noted local delicacy when baked in clay. With cautious dexterity, you open one of the pots and remove the cancrete inside. The cold has made it torpid and it makes only a half-hearted effort to sever your thumb with its claws. You wrap it up in your jacket. Returning with it to the terminal building, you sidle over to the fireside where some of the sailors are enjoying and early-morning nip of whiskey. None of them notices you slip the cancrete into the pile of jackets and pullovers they have strewn across a chair.||You stand by the window and look out to sea, pretending to watch for the ferry. At last a gong is sounded, announcing the ferry's imminent arrival, and the relief crew begin to gather their belongings. Suddenly there is a yelp of pain from one of the sailors and he throws off his jacket as though it were on fire. The cancrete emerges and crawls sullenly away across the floorboards. \"That cancrete has bitten me severely,\" says the sailor, displaying a read weal on his hand.||A youngster whom you take to be the cabin boy watches in horror as the cancrete squeezes into hiding behind the stones of the hearth. You guess that this is his first voyage when he blurts out, \"Did you see that horrific creature? Are they common in the Inland Sea?\"||\"Not of such a size,\" you tell him quietly. He looks relieved until you add, \"Most grow much bigger. Didn't your shipmates tell you about them?\"||Eyes widening in fright, the cabin boy rushes out without making any explanation. You step smartly into the breach. Introducing yourself to the captain, you portray yourself as a person with some prior nautical experience. \"Your cabin boy has withdraw from the voyage, but I am a willing and able worker,\" you tell him.||A faint furrow of suspicion clouds his brow, but he admits that he is one hand short. \"Very well, I'll take you on. But since you are untried, I won't be offering full pay.\"||You shrug casually as you shoulder your pack. \"Pay? Passage to Kahira is enough.\"">

<ROOM STORY226
	(DESC "226")
	(STORY TEXT226)
	(CONTINUE STORY246)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT227 "\"They told me my boss was up there,\" says the Fijian, \"but all I see is you. Imposter!\" He starts to lunge towards you.||You turn in the doorway to face him, displaying your gun. \"Here are my credentials,\" you say coolly. \"Now, let's go and see what's in that closet over there.\"||Staring down the barrel of your gun, he has no arguments. You guess that he is a professional bodyguard because he obviously expects what's coming next. With hands on the top of his head, he turns his back and steps into the closet. You club him across the neck with the butt of the gun and he drops. Closing the door of the closet, you leave quickly before he can recover and raise the alarm.">

<ROOM STORY227
	(DESC "227")
	(STORY TEXT227)
	(CONTINUE STORY311)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT228 "Crashing through a thicket of glossy green fronds, you are brought up short by an astounding sight. A majestic ruined city spreads off into the jungle in front of you, seeming to shimmer in the haze of eternal tree-filtered sunlight. Some of the buildings have been choked by vegetation, grappled to destruction by cables of vine, walls uprooted by inexorable growth and carpeted with moss. But other towers still stand gleaming, bright glass and polished steel glorious in the dappled green-gold light. Those must be the buildings still cleaned and maintained by careteks, the diligent robot janitors left by the ancients.||You skirt the perimeter of the city, stumbling and staggering from sheer awe, like a blind man suddenly given the gift of vision. It can only be the remnants of old Marsay, the mythic place lost for two centuries. A bee as big as a child's fist goes careering cumbersomely past your ear, legs sprawling like a helicopter's skids, and disappears into a vast buzzing hive in the eaves of a crumbled house. Birds sit pecking at lichen-stained girders, sparing you only disdainful glance. You feel like an intruder here.||A barren patch of ground lies ahead, about fifty paces across, forming an avenue towards the intact area of the city.">
<CONSTANT CHOICES228 <LTABLE "follow it" "press on into the jungle">>

<ROOM STORY228
	(DESC "228")
	(STORY TEXT228)
	(CHOICES CHOICES228)
	(DESTINATIONS <LTABLE STORY271 STORY292>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT229 "Kahira is shrouded in a perpetual mist that rises from the warm river waters that flow beneath the city. The city gate is a metal shutter opening into a wide cargo lift at the bottom of a concrete buttress. You hurry through just before the gate closes for the final time this evening. Standing in a crowd of people, donkeys and camels, you wait while the lift rattles up to the street level and opens to disgorge its passengers onto a fog-draped plaza. You step out under the dank glare of a neon lamp and gaze around the plaza, ignoring the stragglers barging past you with their packs. The babble of voices is muffled by the fog. The air is dankly cold, with a flat reek of mist and wet concrete.||A man wearing an illuminated fez scurries up to you, brushing his fingertips together as though washing. A clutch of snaggled teeth gleam in the street-light as he bows. \"Greetings! I am Bador, a dracoman. For a single scad I will be pleased to assist you with the many queries you must have regarding this estimable city.\"">
<CONSTANT CHOICES229 <LTABLE "pay Bador's fee" "tell him to be gone">>

<ROOM STORY229
	(DESC "229")
	(STORY TEXT229)
	(CHOICES CHOICES229)
	(DESTINATIONS <LTABLE STORY033 STORY095>)
	(REQUIREMENTS <LTABLE 1 NONE>)
	(TYPES <LTABLE R-MONEY R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT230 "You look into the surface thoughts of the twins as they converse. The memories are of a hostelry in Florida, a cracking video screen, a tantalizing message concerning the power of the Heart of Volent. They, like you, heard a transmission from Gaia. They travelled across the Atlantic to get here. No question about it -- they must be heading for Du-En.||You are about to end the mind probe when you glimpse another memory that amazes you. At an old computer complex in Madeira, the twins managed to make contact with Gaia again. This time she seems to have been more coherent, and told them that the Heart was dangerous. If a person were to claim its power, the universe as it currently exists would be swept away, remade in a new image.||The twins apparently concluded that the Heart should be destroyed. Gaia told them that this could be done by dual barysal beams striking the gemstones at right angles, which would set up an internal dissonance. The Heart would then crack apart like a glass shattered by a soprano's highest note.||One of the twin glances up. Guiltily you withdraw your mental scan, looking away before she notices you watching.">

<ROOM STORY230
	(DESC "230")
	(STORY TEXT230)
	(CONTINUE STORY252)
	(CODEWORD CODEWORD-NEMESIS)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT231 "You find a deserted alley where you slump down behind a stack of cardboard boxes.||You have no sense of how long has passed when you feel a boot nudge you in the ribs. You open your eyes. Half a dozen figures stand over you in the dim mist-filtered moonlight. \"Get up,\" says a voice.||You start to rise, but the nearest figure sweeps out his leg and sends you sprawling back against the wall. You steady yourself against the damp brickwork and glare back at them.||A woman steps forward and speaks in a brittle zealous voice. \"We are of the Church of Gaia. Give of your belongings that Gaia may bring salvation to the world.\"||You have heard of this cult -- just one of hundreds that have sprung up in the latter days of the world, as people turn in their desperation to strange beliefs. The Church is founded on a particularly deranged creed. Instead of thinking Gaia to be a sophisticated computer, they believe she is the creator goddess.">
<CONSTANT CHOICES231 <LTABLE "give the your money" "use" "fight">>

<ROOM STORY231
	(DESC "231")
	(STORY TEXT231)
	(CHOICES CHOICES231)
	(DESTINATIONS <LTABLE STORY274 STORY295 STORY316>)
	(REQUIREMENTS <LTABLE NONE SKILL-CUNNING NONE>)
	(TYPES <LTABLE R-NONE R-SKILL R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT232 "You try a peripheral avenue of investigation, consulting all files relating to the Heart of Volent before it acquired that name. You discover that it was a large gemstone, apparently of interstellar origin, which fell to Earth in the late twenty-first century. Coming into the hands of the Volentine cult, it became the focus of cult worship and was conveyed to their citadel in the fastness of the Sahara.||The technical records are intriguing. Before the Heart was stolen by the Volentines, a preliminary scientific study was made to analyse its crystalline, structure and intrinsic radiation. The results, when fed into Gaia, yielded the startling conclusion that it was a by-product of the Big Bang which created the universe -- in essence a kind of 'twin' universe which had frozen in stasis before it could expand. It is eerily akin to the way that abortive twins are sometimes formed in human gestation, only to be reabsorbed by the developing foetus.||Gaia's remarks from the time ring ominously across the gulf of centuries: \"This object is unstable. Psionic disruption, as from direct contact with a human man, could reactivate its expansion inside our own universe, leading to the destruction of all that exists. A new universe would result. Destruction of the object is advised, and this can be simply accomplished by bombardment with coupled barysal beams of complementary phasing.\"||Gaia's advice was not acted upon. She was already considered unreliable. That was before the world experienced the Paradox War -- evidence of what a fraction of the Heart's untapped power could do.">
<CONSTANT CHOICES232 <LTABLE "look through the data on the Volentine cult" "take a look around the rest of al-Lat">>

<ROOM STORY232
	(DESC "232")
	(STORY TEXT232)
	(CHOICES CHOICES232)
	(DESTINATIONS <LTABLE STORY210 STORY254>)
	(TYPES TWO-NONES)
	(CODEWORD CODEWORD-NEMESIS)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT233 "A tunnel beyond the doorway is lit by luminant strips close to the floor, which bathe you in a sinister blue glow as you advance towards the centre of the pyramid. You reach a room whose walls are covered with video screens. A partial projection of the world's surface stretches across the ceiling, reduced to a chequerboard of black patches where the scanning satellites have gone offline over the years.||In the centre of the room is a shaft that descends into the depths of the pyramid. A circular steel plate hovers at the top, beside a row of buttons. You guest it is a sort of elevator, although a much more sophisticated design than any in existence nowadays. Studying the buttons, you discount the levels given over to dormitories and recreation. That leaves the research and military levels, located furthest down in the building.">
<CONSTANT CHOICES233 <LTABLE "risk taking the strange elevator going to the research level" "the military level at the very bottom of the shaft" "you think it would be wiser to leave the way you came">>

<ROOM STORY233
	(DESC "233")
	(STORY TEXT233)
	(PRECHOICE STORY323-PRECHOICE)
	(CHOICES CHOICES233)
	(DESTINATIONS <LTABLE STORY276 STORY255 STORY361>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY323-PRECHOICE ()
	<COND (,RUN-ONCE <DELETE-CODEWORD ,CODEWORD-HUMBABA>)>>

<CONSTANT TEXT234 "The ground underfoot is hard-packed gravel under a sprinkling of snow. As you travel on, a biting wind sweeps down from the north bringing heavy snow. The pale blue sky is blotted out by glowering clouds through which enough daylight seeps to give the snow a canescent hue. You hunch into the wind and trudge on, fearing to step and rest in case you never get up again.">
<CONSTANT TEXT234-CONTINUED "You eventually reach the River Isis and cross over an old iron bridge to the west bank. From here, a broad sweep of gleaming ivory dunes extends to the horizon under a sky darker than wet stone. These are the Saharan Ice Wastes, thousands of kilometres of uncharted wilderness, desolate snow fields pounded by incessant arctic gales. This is the terrible barrier that separates you from your goal.">

<ROOM STORY234
	(DESC "234")
	(STORY TEXT234)
	(PRECHOICE STORY234-PRECHOICE)
	(CONTINUE STORY393)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY234-PRECHOICE ()
	<COND (<OR <CHECK-ITEM ,COLD-WEATHER-SUIT> <CHECK-ITEM ,FUR-COAT>>
		<PREVENT-DEATH ,STORY234>
	)(ELSE
		<TEST-MORTALITY 1 ,DIED-FROM-COLD ,STORY234>
	)>
	<IF-ALIVE ,TEXT234-CONTINUED>>

<CONSTANT TEXT235 "You pass a restless night troubled by bouts of nausea. As the sky begins to show the dim silver burnish of predawn light, you rise and run trembling fingers through your sweat-matted hair.">

<ROOM STORY235
	(DESC "235")
	(STORY TEXT235)
	(PRECHOICE STORY235-PRECHOICE)
	(CONTINUE STORY342)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY235-PRECHOICE ()
	<COND (<CHECK-ITEM ,ANTIDOTE-PILLS> <STORY-JUMP ,STORY320>)>>

<CONSTANT TEXT236 "He listens with interest as you explain how the Heart can be destroyed by two people working together. \"A fitting use for that fine barysal pistol of yours.\" you conclude with a grim smile.||He nods and then leans close, putting an arm across your shoulders. \"You're right of course. I'm glad you confided all this to me. We must keep it secret from the others. They are mad dogs, who care nothing for whether the world lives or dies.\"">

<ROOM STORY236
	(DESC "236")
	(STORY TEXT236)
	(CONTINUE STORY192)
	(CODEWORD CODEWORD-YELLOW)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT237 "Reaching the nearest grille, you find it rusted and easy to wrench out of the wall. Narrowing your shoulders, you squeeze through into a small tomb chamber. A body lies on a low carved slab, withered but preserved by the cold dry breeze gusting up from below. The robes suggest this was one of the priests of the Volentine cult. Hearing the others calling you, you make a hurried search of the tomb, finding nothing of interest except for a speculum jacket. This gives some protection from barysal gunshots.||Since the others are anxious to be off, you climb back up to rejoin them without inspecting the other grilles.">

<ROOM STORY237
	(DESC "237")
	(STORY TEXT237)
	(CONTINUE STORY215)
	(ITEM SPECULUM-JACKET)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT238 "With unerring precision, you blast a shot at the lintel above the doorway. The beam fractures the darkness and raises the lintel to white heat in an instant. \"Run towards the door!\" you shout to the others.||You race in the direction of the glowing stone lintel. The baron reaches it first, gliding through the doorway and turning to slam it after you and Boche have run through. A moment later, something slams into the other side with juddering impact, but the door holds.||\"What was that?\" you ask.||\"I caught a brief glimpse of it in the glare from your gunshot,\" says Boche. \"Believe me, you don't want to know.\"">

<ROOM STORY238
	(DESC "238")
	(STORY TEXT238)
	(PRECHOICE STORY238-PRECHOICE)
	(CONTINUE STORY281)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY238-PRECHOICE ()
	<FIRE-BARYSAL 1>>

<CONSTANT TEXT239 "You are almost hypnotized by terror, and it is only by the merest chance that your fingers brush the grenade hanging at your belt. Unclipping it, you send it rolling and bounding across the floor. The baron's brain comes rushing through the air just as the grenade detonates. There is a flash, and the brain is flung to the floor by the concussion. While it lies dazed, you crush it under your heel. If only you could shut out the dying shriek that echoes telepathically through your mind and will stay with you until your dying day.">

<ROOM STORY239
	(DESC "239")
	(STORY TEXT239)
	(PRECHOICE STORY239-PRECHOICE)
	(CONTINUE STORY261)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY239-PRECHOICE ()
	<LOSE-ITEM ,STUN-GRENADE>>

<CONSTANT TEXT240 "You feel a jolting impact as though someone had punched you in the throat. Looking down, you are amazed to see a steel crossbow bolt has pierced your windpipe. You stagger back a couple of steps and then fall, dying in a pool of blood. You have failed with success almost in your grasp.">

<ROOM STORY240
	(DESC "240")
	(STORY TEXT240)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT241 "Golgoth checks Boche's gun, but the charge has been used up.">

<ROOM STORY241
	(DESC "241")
	(STORY TEXT241)
	(PRECHOICE STORY241-PRECHOICE)
	(CONTINUE STORY263)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY241-PRECHOICE ()
	<COND (<AND <CHECK-ITEM ,BATTERY-UNIT> <G? <GETP ,BATTERY-UNIT ,P?CHARGES> 0>>
		<EMPHASIZE "You charge it with the battery unit in your backpack">
		<STORY-JUMP ,STORY219>
	)>>

<CONSTANT TEXT242 "You sift carefully through the debris, but find nothing more than torn clothes and broken ornaments. Boche points out a rusty brown stain on a broken tabletop. \"The rioters went in for human sacrifice,\" he says.||The baron hovers over the spot, peering back through the curtain of time. Finally he gives a curt nod. \"Yes. The populace broke in here and slaughtered the acolytes. But this is not where the high priest and his adepts dwelled. That lies deeper in the catacombs, and there we shall find the Shrine of the Heart.\" He swivels in the air and glides rapidly back to the antechamber, calling over his shoulder: \"Come.\"||You and Boche exchange a glance, then follow. The baron is inspecting the two passages, but his psychic senses cannot tell which is better. \"You choose,\" he says.">
<CONSTANT CHOICES242 <LTABLE "go right" "left">>

<ROOM STORY242
	(DESC "242")
	(STORY TEXT242)
	(CHOICES CHOICES242)
	(DESTINATIONS <LTABLE STORY128 STORY003>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT243 "Passing under a broken arch, you enter the central plaza. This is a broad area of snow-covered flagstones, roughly three hundred metres across, enclosed by ruined palaces that gleam like lead in the white haze.||There are several campfires built up against a fallen colonnade. As you get closer you see antique furniture and splintered doors crackling in the flames: plunder from the once great city of Du-En, list art treasures beyond price. In this desolate place, their only value is the warmth they give.||A man steps forward from the fireside and pulls off his glove to shake hands. \"Greetings. I am Janus Gaunt.\"||While Boche makes the introductions, you take stock of Gaunt. He is younger than his grey hair would suggest, with an open friendly manner. His servants stumble along behind him in the snow, but they wear only thin clothes and you guess they are past feeling the cold. Gaunt sees you looking at them and nods. \"These are my xoms -- reanimated cadavers, loyal and tireless.\"||Others are now emerging from their tents along the colonnade. A wizened old man with no legs who comes drifting through the air like a ghost is introduced as Baron Siriasis, a psionic from Bezant. Next comes a woman who walks with long feline strides, eyes glittering like jade in the wan afternoon light. She gives you a single guarded look and then turns away. \"That is Thadra Bey of al-Lat,\" says Gaunt. \"An here is Commander Chaim Golgoth, an agent of United States Intelligence. The two strapping bronzed ladies behind him are Gargan XIII and Gargan XIV, sole survivors of a clone superwarrior group.\"||Golgoth smiles and shakes hands. The Gargan twins watch you with a glare like Medusa's sisters. \"There's also Vajra Singh,\" adds Golgoth, nodding towards a large scarlet-and-black pavilion across the plaza. \"You'll meet him soon enough, I'll warrant.\"">

<ROOM STORY243
	(DESC "243")
	(STORY TEXT243)
	(PRECHOICE STORY243-PRECHOICE)
	(CONTINUE STORY111)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY243-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-SCYTHE>
		<DELETE-CODEWORD ,CODEWORD-SCYTHE>
		<STORY-JUMP ,STORY089>
	)>>

<CONSTANT TEXT244 "The Hotel Paradise proves to be a converted temple overlooked by a high bell-tower. You stand looking up at the inside of the splendid domes. Once, centuries ago, this vast hall must have rung with orisons to the forgotten deity of that age. Now it echoes instead to the grunt and clamour of people eating in the refectory or clattering up and down the wooden stairway to their rooms.">

<ROOM STORY244
	(DESC "244")
	(STORY TEXT244)
	(CONTINUE STORY329)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT245 "You eventually find a man who can do what you want: a fat sweaty fellow with a profusion of ancient tools and devices strewn around his shop. Guiding his laser by hand, he makes a few deft changes to the image on the card until it could pass for your own likeness. \"Five scads,\" he says, holding it out to you.||\"Five?\" You scowl.||\"Membership of the prestigious Compass Society is usually much more expensive than that,\" he says with a shrug.||You consider snatching the card back, but the fat man cannily anticipates you and holds it close to the laser beam until you pay. If you refuse to pay, he destroys the ID card.">

<ROOM STORY245
	(DESC "245")
	(STORY TEXT245)
	(PRECHOICE STORY245-PRECHOICE)
	(CONTINUE STORY025)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY245-PRECHOICE ()
	<COND (<G? ,MONEY 4>
		<CRLF>
		<TELL "Agree to his terms (5 scads)?">
		<COND (<YES?>
			<CHARGE-MONEY 5>
			<GAIN-CODEWORD ,CODEWORD-PROTEUS>
			<RETURN>
		)>
	)>
	<EMPHASIZE "He destroys the ID card.">
	<LOSE-ITEM ,ID-CARD>>

<CONSTANT TEXT246 "After fifteen minutes, a pale green light flashes through the murk out to sea. The assembled travellers start to rise and gather their belongings as the ferry comes sweeping in towards the dock. A massive hovercraft of the tree tiered decks surmounted by a high conning-tower, the ferry glides up the frosty foreshore and settles on its metal skirt. Workers immediately rush out with planks to assemble a boardwalk, and you go aboard with the others.||There is a delay while supplies are loaded. You find a couch on the middle deck and gaze out to sea. A polarizing tint in the glass adds to the gloominess of the scene, with tall iron-black clouds pile high above a sea of grey swell and ice floes.||Eventually the craft raises itself and you are under way. Stewards come round and lunch is served at long curved tables in the central lounge. You chew at the stodgy gruel formulated from sea algae, washed down with spiced tea.||You take a promenade of outside deck, but the chill of the afternoon soon drives you back inside. Some of the other passengers started card games. As the daylight fades, a gap in the louring cloud reveals a handful of diamond-bright stars. The bar is opened and the atmosphere aboard gradually acquires a current of bonhomie, but you remain aloof and troubled. Most of these people have no further destination in mind than Kahira, no ambition beyond a small profit and a frisson of petty adventure. But your own goal is directly remote: the lost ruins of Du-En, in the far hinterland of the Saharan Ice Wastes. It seems impossible to believe, but here in Du-En you will either grasp the ultimate power -- or perish.">

<ROOM STORY246
	(DESC "246")
	(STORY TEXT246)
	(CONTINUE STORY010)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT247 "You travel upriver until Kahira comes in sight through the veils of sparkling river-mist. It straddles the river on huge concrete buttresses, a city built on many levels, with gleaming towers stretching towards the darkening sky. Steering the sky-car towards the gate set into one of the colossal buttresses, you cast your eyes west across the Sahara. The pyramids of Giza are half-hidden by dusk and mist. Beyond lies the implacable desert of ice which you must cross to reach your goal.">

<ROOM STORY247
	(DESC "247")
	(STORY TEXT247)
	(PRECHOICE STORY247-PRECHOICE)
	(CONTINUE STORY229)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY247-PRECHOICE ()
	<COND (<CHECK-CODEWORD ,CODEWORD-DIAMOND> <STORY-JUMP ,STORY251>)>>

<CONSTANT TEXT248 "The Fijian is strong and well-trained, but you have the advantage of suppleness. His foot lashes out. You dodge to one side, catch the ankle, and twist him off balance. Rather than allow you to dislocate his knee, he falls back, braces his arms on the ground, and delivers a thrust with both legs that sends you slamming back against the wall.">
<CONSTANT TEXT248-CONTINUED "The impact leaves you stunned, giving your opponent time to get to his feet. He charges towards you bellowing. You steady yourself to meet the attack, and by luck a wall-mounted extinguisher comes to hand. You feel no compunction at using it; any weapon is fair in such a fight. A spray of foam to the eyes blinds the Fijian long enough for you to swing the canister in a solid clout to the side of his head. He falls like a sack of bricks.||You stoop and check his pulse, relieved to discover he is still alive. You had better get well away before he comes round.">

<ROOM STORY248
	(DESC "248")
	(STORY TEXT248)
	(PRECHOICE STORY248-PRECHOICE)
	(CONTINUE STORY311)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY248-PRECHOICE ()
	<TEST-MORTALITY 2 ,DIED-IN-COMBAT ,STORY248 ,SKILL-CLOSE-COMBAT>
	<IF-ALIVE ,TEXT248-CONTINUED>>

<CONSTANT TEXT249 "The third bodyguard, Goro, is found only fifty metres from the ice cave where you took shelter. He is frozen on his hands and knees, having died crawling in the merciless fury of the blizzard. Snow is piled around the body.||The other two, who may be his brothers for all you know, betray no emotion at the sight. Of course, they must have known he could not have survived. \"Shall we bury him, boss?\" says one.||Shandor looks at the sky. Dusk is already descending along the edge of the valley, shadows creeping like blots of soot across the crisp white snow. He considers, then gives you a curt nod back towards the crevasse. \"Toss the body down into the cave -- it's as good a tomb as any. I want to be off this glacier by nightfall.\"||Your journey continues for another week. Hungry and beset by chilling winds, you feel drained of strength. The unbroken glower of grey cloud across the sky leaves you dispirited. By the time you reach the eastern foothills, your fingers are tingling with the first stages of frostbite.">
<CONSTANT TEXT249-CONTINUED "Outside Venis, Shandor tells you he is detouring north to meet some friends who live in an isolated manor house.">

<ROOM STORY249
	(DESC "249")
	(STORY TEXT249)
	(PRECHOICE STORY249-PRECHOICE)
	(CONTINUE STORY438)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY249-PRECHOICE ("AUX" (DAMAGE 2))
	<COND (<CHECK-SKILL ,SKILL-SURVIVAL> <SET DAMAGE 1>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-COLD ,STORY249>
	<IF-ALIVE ,TEXT249-CONTINUED>
	<COND (<OR <CHECK-SKILL ,SKILL-STREETWISE> <CHECK-ITEM ,VADE-MECUM>> <STORY-JUMP ,STORY117>)>>

<CONSTANT TEXT250 "Crashing through a thicket of glossy green fronds, you are brought up short by an astounding sight. A majestic ruined city spreads off into the jungle in front of you, seeming to shimmer in the haze of eternal tree-filtered sunlight. Some of the buildings have been choked by vegetation, grappled to destruction by cables of vine, walls uprooted by inexorable growth and carpeted with moss. But other towers still stand gleaming, bright glass and polished steel glorious in the dappled green-gold light. Those must be the buildings still cleaned and maintained by careteks, the diligent robot janitors left by the ancients.||You skirt the perimeter of the city, stumbling and staggering as much from sheer awe as from your throbbing wound. It can only be the remnants of old Marsay, the mythic place lost to the sight of man for two centuries.||A bee as big as a child's fist goes careering cumbersomely past your ear, legs sprawling like a helicopter's skids, to disappear into a vast buzzing hive in the eaves of a crumbled house. Birds sit pecking at lichen-stained girders, sparing you only a disdainful glance. You feel like an intruder here.||A barren patch of ground lies ahead, about fifty paces across, forming an avenue towards the intact area of the city.">
<CONSTANT CHOICES250 <LTABLE "follow it" "press on into the jungle">>

<ROOM STORY250
	(DESC "250")
	(STORY TEXT250)
	(CHOICES CHOICES250)
	(DESTINATIONS <LTABLE STORY271 STORY184>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT251 "The city gate is a metal shutter that opens into a wide cargo lift at the bottom of a concrete abutment. Those entering are conveyed up inside the abutment to the lowest street level twenty metres above. You have arrived just before the gates are closed for the night, and as you step out into the street you draw the attention of a man in blue-&-grey combat dress.||Boche recognizes him, throwing out his chest in a display of wary truculence. The man stops and nods, a relaxed smile on his slim features. \"Kyle Boche. And is this your accomplice, or your latest victim?\"||\"Chaim Golgoth! Are you still a hired murderer?\" pipes up Boche in a tone of bravado. He turns to you. \"This man kills people for a living.\"||You notice the insignia on Golgoth's sleeve: the blazoned sliver eagle and blue stars of United States Intelligence. Even with the world close to collapse, the United States remains a force to be reckoned with. If Golgoth really is a USI assassin, Boche is being reckless in bantering with him like this. You size up what you can see.||Golgoth has a holstered a barysal gun and, to your surprise, a steel crossbow slung behind his hip. At a glance he looks open and friendly, his voice mild with wry amusement. But there is something almost chilling about the eyes. Those are the eyes of a man who is always alert.">
<CONSTANT CHOICES251 <LTABLE "probe Golgoth's mind" "query him about Giza" "his reason for carrying a crossbow" "simply pass by him into the city">>

<ROOM STORY251
	(DESC "251")
	(CHOICES CHOICES251)
	(DESTINATIONS <LTABLE STORY121 STORY337 STORY315 STORY358>)
	(REQUIREMENTS <LTABLE SKILL-ESP NONE NONE NONE>)
	(TYPES <LTABLE R-SKILL R-NONE R-NONE R-NONE>)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT252 "At last the fearsome twins begin to show signs of lassitude. They call for plates of stew, which they devour with gusto, then go crashing off into the dormitory where they hurl themselves down on cots and are soon snoring like lionesses.||\"What fearsome furies,\" says the innkeeper in a disconsolate whisper. \"They drank a hundred scads' worth of vodka. I think there's little hope of getting my money, however.\"||The other customers of the inn set up bedding on the floor of the taproom. No one dares to share the dormitory for fear of the Gargan sisters awakening and setting on them in a drunken rage. You cannot blame them. You pass an uneasy night yourself, rising early to set out on your way.">

<ROOM STORY252
	(DESC "252")
	(STORY TEXT252)
	(CONTINUE STORY273)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT253 "Fishermonger Plaza, on the lowest level of the city, is a wide paved area surrounding an area of gratings directly above the river. At night, the gratings are opened and nets lowered. Bright lamps are shone down into the river to attract the attention of the fish, which are then hauled up in huge writhing shoals. This continues throughout the night, and the promise of fresh fried fish brings all manner of night-time workers to the plaza. At stalls ranged around the gratings, a curious band rub shoulders: off-duty policemen, fishmongers, prostitutes, street cleaners, beggars, and burglars.||You huddle down beside a shuttered pastry stall. The bright light and bustle make it difficult to sleep here, but at least you are safe from muggers. You pass a restless night, awakening before the dawn with a gritty feeling in your eyes and cramp in your limbs. \"Get away from here,\" say the stall-holder as he opens up for the day. \"I will not have my wares contaminated by a beggar's lice.\"||You wait until he is not looking to steal a pastry for your breakfast, then make your way to the bazaar.">

<ROOM STORY253
	(DESC "253")
	(STORY TEXT253)
	(CONTINUE STORY333)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT254 "A young technician sees you wandering around bewildered and takes you on a tour of the laboratories. \"The al-Lat station was originally intended as a base of pure scientific research,\" he explains. \"Luckily we were always designed to be self sufficient, so the degradation of Earth's climate and population has not affected us.\"||You pause beside a bank of supercooled chambers. \"What research is going on here?\"||\"These are neural networks -- artificial brains into which we are loading the original weather control programs used when Gaia was first set up. They are works of genius, unsurpassed even today. Naturally we cannot tap into Gaia herself, by reason of the viruses that have invaded the system. But these original programs are uninfected.\"||\"What is the purpose of the work?\" you ask.||\"We hope to terraform the planet Venus -- that is, make it suitable for human habitation. Then we can colonize.\"||You give a snort of incredulous laughter. \"Why not use your skills on Earth? Although inhospitable, it is still a better place than Venus!\"||He smile. \"We thought of that, of course. Any attempt to alter the Earth's current climate might meet with Gaia's displeasure, and al-Lat would be targeted by nuclear missiles against which we have no defence.\"">
<CONSTANT CHOICES254 <LTABLE "argue that the Earth should not be callously abandoned" "offer to join the people of al-Lat and help with the terraforming project">>

<ROOM STORY254
	(DESC "254")
	(STORY TEXT254)
	(CHOICES CHOICES254)
	(DESTINATIONS <LTABLE STORY296 STORY317>)
	(TYPES TWO-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT255 "You step onto the hovering platform, surprised and relieved that it remains steady under your weight and does not go plummeting to the bottom of the shaft. Once again, as so often in the past, you have cause to marvel at the technology of your ancestors. Touching the lowest button, you activate the elevator and the platform glides gently down the shaft, depositing you in a circular chamber from which several doors lead off. All are closed. As you stand pondering which way to go, an automatic circuit engages and a synthesized voice speaks from a slot in the wall, enquiring your reason for being there. What will you answer?">
<CONSTANT CHOICES255 <LTABLE "answer: \"Gaia\"" "\"Gilgamesh\"" "\"Du-En\"" "\"the Heart of Volent\"">>

<ROOM STORY255
	(DESC "255")
	(STORY TEXT255)
	(CHOICES CHOICES255)
	(DESTINATIONS <LTABLE STORY297 STORY318 STORY441 STORY383>)
	(TYPES FOUR-NONES)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT256 "A hunter who makes a habit of tangling with bomeths will not live very long. Instead of grand heroics, you decide to track the beast to its lair. Crouching motionless until the moon rises, you see the bometh rouse itself and go loping away across the undulating hillocks of snow. You follow until you see it disappear into a snowdrift, whereupon you drop low and compose yourself for a long wait. Two or three hours go by. At last it emerges from the lair, sniffs the wind, and lumbers off in search of prey.|\Once it is out of sight, you scramble over the snowdrift, pushing along a tunnel into a hollowed-out cavity where there are three small bomeths on a nest of moulted fur. Ignoring them, you turn your attention to the closely packed walls of the lair: the bometh's larder, where the beast has stored remains of previous kills. You dig out the carcass of a large fowl, which the icy cold has preserved well. Wrapping the flesh carefully, you make two food packs.">
<CONSTANT TEXT256-CONTINUED "One of the young bomeths nips at your ankle. The teeth do not penetrate your boot, but it is a timely reminder that the parent might return any time. You squirm back to the open and hurry away">

<ROOM STORY256
	(DESC "256")
	(STORY TEXT256)
	(PRECHOICE STORY256-PRECHOICE)
	(CONTINUE STORY298)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY256-PRECHOICE ()
	<TAKE-FOOD-PACKS 2>
	<CRLF>
	<TELL ,TEXT256-CONTINUED>
	<TELL ,PERIOD-CR>>

<CONSTANT TEXT257 "Your fingers show signs of frostbite and you have dozen small bruises. You does yourself with antibiotics and apply ointments and dressings from the medical kit.">

<ROOM STORY257
	(DESC "257")
	(STORY TEXT257)
	(PRECHOICE STORY257-PRECHOICE)
	(CONTINUE STORY278)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY257-PRECHOICE ()
	<GAIN-LIFE 1>>

<CONSTANT TEXT258 "When he folds his hands across his chest and speaks in his mild whimsical way, Janus Gaunt puts you in mind of a priest. \"Vajra Singh is the lion among us,\" he says; \"proud, brave and noble -- but cross him, and you'll measure your remaining span in seconds. So, if Singh is a lion, Golgoth is a fox, agile and crafty. For Baron Siriasis's totem I would suggest the spider: a brooding, spiteful, sinister creature, always ready to cast its net.\"||\"And Thadra Bey is evidently a tigress,\" you say, \"for I have never seen a woman so sleek and fierce. And Kyle Boche?\"||\"Boche?\" He gives a snort of contempt. \"He is a jackal... no, an albatross around your neck, I think.\"||\"And what about you, Janus Gaunt?\" breaks in a voice abruptly. You turn to see Kyle Boche sauntering out across the snow. He casts a hooded glance around the throng of silent xoms. \"Perhaps you're the worm of the group? The maggot that eats from within?\"||Gaunt turns on his heel and stalks away without reply, his xoms clustering along behind like sleepwalkers. Boche takes your arm and leads you back to the main square. \"You should be more careful,\" he chides. \"Gaunt might have murdered you out there and turned you into one of his undead. You're lucky I came along when I did.\"">

<ROOM STORY258
	(DESC "258")
	(STORY TEXT258)
	(CONTINUE STORY104)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT259 "You are in a dimly lit room with a number of smaller rooms leading off it. You guess that this was where the acolytes of the Volentine cult lived. Even after two hundred years, there are still signs of the rioting that led to the city's downfall. You clamber through a wreckage of broken furniture and toppled cupboards. Crumpled sheets of writing-plastic litter the floor.||Boche picks up a book, ruffles the charred pages and drops it to the floor. \"There's nothing here to interest us,\" he says. \"Let's press on.\"">
<CONSTANT CHOICES256 <LTABLE "insist on searching the wreckage" "go back to the antechamber and take either the passage to the left" "the passage to the right">>

<ROOM STORY259
	(DESC "259")
	(STORY TEXT259)
	(PRECHOICE STORY259-PRECHOICE)
	(CHOICES CHOICES256)
	(DESTINATIONS <LTABLE STORY242 STORY003 STORY128>)
	(TYPES THREE-NONES)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY259-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-ROGUERY>
		<SET-DESTINATION ,STORY259 1 ,STORY412>
	)(ELSE
		<SET-DESTINATION ,STORY259 1 ,STORY242>
	)>>

<CONSTANT TEXT260 "There is the rattle of hard insectoid legs on the smooth floor, then something huge slams into you. It feels like a coiled monster with a body as hard as ebony. Striking out blindly, you feel a segmented eye squash under your fist, spurting out ichor. Then it seizes you in its mandibles and two scything blades are driven into your sides. You give a scream of agony. It feels as though the monster is trying to saw you in half.">
<CONSTANT TEXT260-CONTINUED "You manage to break free with a sob of terror and stumble on to the doorway. Boche and the baron slam and bolt the door behind you, and you see it almost buckle off its hinges as the monster throws itself furiously against the other side. \"I hope that holds,\" you say to the others, \"or else we're insect food.\"">

<ROOM STORY260
	(DESC "260")
	(STORY TEXT260)
	(PRECHOICE STORY260-PRECHOICE)
	(CONTINUE STORY281)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY260-PRECHOICE ("AUX" (DAMAGE 6))
	<COND (<CHECK-SKILL ,SKILL-CLOSE-COMBAT> <SET DAMAGE 4>)>
	<COND (<CHECK-CODEWORD ,CODEWORD-TALOS> <SET DAMAGE <- .DAMAGE 1>>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-INJURIES ,STORY260 ,SKILL-CLOSE-COMBAT>
	<IF-ALIVE ,TEXT260-CONTINUED>>

<CONSTANT TEXT261 "You find Boche recovering from the blast. Despite a gash on his forehead, he is in good spirits. \"It worked!\" he says. \"I'd been barring that grenade all along, but the joke was that I didn't even know it myself. It was the only way to foil the baron's mind-reading you see.\"||\"I don't understand.\"||Boche spits out rock dust before explaining. \"I knew the baron was heading for Du-En and that he'd be the hardest foe I'd have to face, so I got myself hypnotized to forget that I was carrying a grenade. I had a post-hypnotic suggestion planted that I should use it at a key moment. He never knew what hit him, did he?\"||\"A ruthlessly clever scheme.\"||If you intended any sarcasm, Boche fails to notice it. \"Thanks,\" he says. \"Now, let's get going and find the Heart.\"">

<ROOM STORY261
	(DESC "261")
	(STORY TEXT261)
	(CONTINUE STORY175)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT262 "A swishing in the air is followed by a noise like a knife being driven into an apple. You are startled to see a crossbow bolt protruding from Singh's eye. He is spun round by the impact, dead on his feet, raking the floor with a random blast from the mantramukta as he falls. Molten chunks of marble fly up, one of them striking you heavily across the left arm.">
<CONSTANT TEXT262-CONTINUED "As the smoke disperses you see that Golgoth had attached his gun to the wall magnetically and set it for remote-controlled fire. Retrieving it, he casts a wary glance at you. \"It's just up to us now,\" he says. \"We can make a shoot-out of it, and probably both die, or we can cooperate to get rid of that.\" And he jerks his thumb towards the ominously glittering Heart of Volent.\"">

<ROOM STORY262
	(DESC "262")
	(STORY TEXT262)
	(PRECHOICE STORY262-PRECHOICE)
	(CONTINUE STORY431)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY262-PRECHOICE ("AUX" (DAMAGE 4))
	<COND (<CHECK-CODEWORD ,CODEWORD-TALOS> <SET DAMAGE 1>)>
	<TEST-MORTALITY .DAMAGE ,DIED-FROM-INJURIES ,STORY262>
	<IF-ALIVE ,TEXT262-CONTINUED>>

<CONSTANT TEXT263 "Golgoth gives you a bleak smile. His gun is aimed at your chest. \"So we can't destroy the damned thing after all,\" he says without relish. \"I certainly can't get it back to the States, so I guess that leaves one option.\"||\"You can't...\" you say, shaking your head. \"It'll be the end of the world.\"||\"The world is on its last legs anyway. No one thinks humanity will survive another century. Maybe I can make a better world.\"||You give him a withering look. \"You're just trying to justify yourself, Golgoth. You're like all the rest. It was power you wanted all along.\"||He shrugs. \"Just doing my job.\" And his gun spurts fire, killing you instantly.">

<ROOM STORY263
	(DESC "263")
	(STORY TEXT263)
	(DEATH T)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT264 "Boche scrambles up to the ledge and goes through the pockets of one of the corpses. \"I don't like robbing the dead, but there might be some food,\" he mutters.">

<ROOM STORY264
	(DESC "264")
	(STORY TEXT264)
	(PRECHOICE STORY264-PRECHOICE)
	(CONTINUE STORY306)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY264-PRECHOICE ()
	<COND (<CHECK-SKILL ,SKILL-ROGUERY>
		<STORY-JUMP ,STORY328>
	)(<CHECK-SKILL ,SKILL-PARADOXING>
		<STORY-JUMP ,STORY370>
	)>>

<CONSTANT TEXT265 "After reassuring the anxious scribe that you will do nothing to damage his hardware, you connect one of the laptops into the phone network. The antiquity of the modem will limit your ability to converse with Gaia, but it also means that the terminal you are using is safe from Gaia's resident hyperviruses, which are too complex to copy themselves across the primitive modem link.||The scribe watches in amazement as you type your questions. In this world of declining technology, what you are doing seems to him like magic.||> HELLO, GAIA. PLEASE TELL ME ABOUT THE HEART OF VOLENT.|> IT WAS FORMED AT THE BEGINNING OF TIME. THE PERSON WHO ATTUNES IT WILL HAVE POWER OVER EVERYTHING.|> HOW CAN YOU HELP ME TO GET IT?|> MY MIND IS NOT ALWAYS CLEAR. YOU WILL NEED AN ALLY. GO TO GIZA. SEEK GILGAMESH UNDER THE PYRAMID. HUMBABA WILL GIVE YOU ENTRY.|> WHAT THEN?|> UNKNOWN. THE FUTURE. A TABULA RASA.||The screen goes blank as the scribe reaches out and pulls the plug. \"Enough, please,\" he says firmly. \"I know you've assured me there is no risk, but bear in mind it is my livelihood that's at stake.\"||Resolving to establish a better link with Gaia when you have time, you leave the stall and head off along the street.">

<ROOM STORY265
	(DESC "265")
	(STORY TEXT265)
	(CONTINUE STORY372)
	(CODEWORD CODEWORD-HUMBABA)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT266 "You identify each of the potions, describing its effects in detail. Malengin takes out a pad and eagerly scribbles down everything you can tell him. \"This will be invaluable,\" he says, so pleased that he agrees to sell to you at a discount.||The potion he calls the Virid Mystery is easiest to identify. It is simply an antidote designed to reverse unwanted genetic changes. Luckily the other three potions are more useful.||The potion called the Exalted Enhancer costs 7 scads and will toughen your skin so that you gain 5 Life Points, even above your initial score. However it also slows your reflexes so that you must lose the AGILITY skill if you have it.||The Mask of Occultation costs 6 scads and gives the ability to alter your appearance and colouring.||The Peerless Perceptive costs 4 scads and confers the ability to see in almost total darkness.">

<ROOM STORY266
	(DESC "266")
	(STORY TEXT266)
	(PRECHOICE STORY266-PRECHOICE)
	(CONTINUE STORY025)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY266-PRECHOICE ()
	<MALENGIN-BUSINESS>
	<COND (<OR <CHECK-SKILL ,SKILL-STREETWISE> <CHECK-ITEM ,VADE-MECUM>> <STORY-JUMP ,STORY414>)>>

<CONSTANT TEXT267 "Boche frowns in indignation and amazement. \"I cannot understand your attitude. I've worked very hard getting you this far, and now you propose to abandon me!\"||You thank the official for your ticket and then turn to Boche, saying, \"In the area of wilderness survival, you turned out to be long on opinion but short on expertise. Even so, I tolerated your company because you gave me to understand that your contacts would be useful once we reached civilization. However, I have not seen anything of you for the two days we've spent in Venis. Now you show up like a bad penny, having squandered your money on fancy gear such as that new barysal gun, and you have the audacity to expect me to pay for your passage. Boche, you are an idiot.\"||Though taken aback, he is not at a loss for words. \"I expected a little more support from you. Have you forgotten that I started out with a gesture of comradeship by paying your bill at the Etruscan Inn before I knew a thing about you?\"||\"That, more than anything else, should have warned me off associating with you. It's the typical con-man's opening gambit.\" You give a bored sigh. \"Farewell, Boche.\"||You walk off towards the seafront before he can say anything else.">


<ROOM STORY267
	(DESC "267")
	(STORY TEXT267)
	(PRECHOICE STORY267-PRECHOICE)
	(CONTINUE STORY246)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY267-PRECHOICE ()
	<DELETE-CODEWORD ,CODEWORD-DIAMOND>>

<CONSTANT TEXT268 "You travel upriver. Flurries of sleet sweep out of the evening sky. Veering west, you steer towards the pyramids of Giza where they stand outlined against the feeble afterglow of sunset. The Sphinx lies huddled with banks of snow along its stone flanks, its face ravaged by frostbite. You set the sky-car down and trudge across the icy plain towards those ancient ruins.">

<ROOM STORY268
	(DESC "268")
	(STORY TEXT268)
	(CONTINUE STORY440)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT269 "You catch on at once. The Fijian obviously works for the person who originally owned your ID card, and rushed up here in search of his boss, only to find you instead. \"There was another person here,\" you glibly tell him, \"who suffered a heart attack just minutes ago and was taken on a stretcher to the medical lounge. Could that have been your boss?\"||His jaw drops, then he races out and stabs anxiously at the elevator button. You join him and politely ask for the ground floor. Watching him fidget impatiently as the elevator descends, you say, \"Don't worry, the Society has excellent medical facilities -- the best in Kahira. I'm sure your boss will be all right.\"||The elevator stops at the floor for the medical lounge and the Fijian gets out. You continue down to the lobby and leave without delay, before he discovers he's been lied to.">

<ROOM STORY269
	(DESC "269")
	(STORY TEXT269)
	(CONTINUE STORY311)
	(FLAGS LIGHTBIT)>

<CONSTANT TEXT270 "You find the missing bodyguard, Goro, lying only fifty metres from the ice cave where you took shelter. He froze to death on his hands and knees, crawling in the teeth of the blizzard. Snow is piled around the body. Ice cakes his features, locked rigid in an expression of stubborn intensity. The other two, who may be his brothers for all you know, betray no emotion at the sight. Of course, they must have realized he couldn't have survived. \"Shall we bury him, boss?\" says one.||Shandor looks at the sky. Dusk is already descending along the edge of the valley, shadows creeping like blots of soot across the crisp white snow. He considers, then gives a curt nod back towards the crevasse. \"Toss the body down into the cave -- it's as good a tomb as any. I want to be off this glacier by nightfall.\"||After sliding Goro's body down into the crevasse, the four of you trudge on in silence. By the time you crest the shoulder of bare black rock bordering the glacier, stars begin to glimmer between the low banks of cloud. Something impels you to glance back. You see the last of the sunlight trickle off the world. In the same instant, a slurry of thick purple steam gushes out of the crack in the ice far behind. You rub your eyes and look again. Now there is nothing. It must have been a trick of the fading light.||Shandor's bodyguards have found a spar of rock to give cover from the night winds. They heat it with blasts from their barysal guns, leaving the rock surface pleasantly warm when you hunker down beside it to eat the rations that Shandor shares out.">

<ROOM STORY270
	(DESC "270")
	(STORY TEXT270)
	(PRECHOICE STORY270-PRECHOICE)
	(CONTINUE STORY312)
	(FLAGS LIGHTBIT)>

<ROUTINE STORY270-PRECHOICE ()
	<COND (<CHECK-ITEM ,SHORTSWORD> <STORY-JUMP ,STORY291>)>>

<ROOM STORY271
	(DESC "271")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY272
	(DESC "272")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY273
	(DESC "273")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY274
	(DESC "274")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY275
	(DESC "275")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY276
	(DESC "276")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY277
	(DESC "277")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY278
	(DESC "278")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY279
	(DESC "279")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY280
	(DESC "280")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY281
	(DESC "281")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY282
	(DESC "282")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY283
	(DESC "283")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY284
	(DESC "284")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY285
	(DESC "285")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY286
	(DESC "286")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY287
	(DESC "287")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY288
	(DESC "288")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY289
	(DESC "289")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY290
	(DESC "290")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY291
	(DESC "291")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY292
	(DESC "292")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY293
	(DESC "293")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY294
	(DESC "294")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY295
	(DESC "295")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY296
	(DESC "296")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY297
	(DESC "297")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY298
	(DESC "298")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY299
	(DESC "299")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY300
	(DESC "300")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY301
	(DESC "301")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY302
	(DESC "302")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY303
	(DESC "303")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY304
	(DESC "304")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY305
	(DESC "305")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY306
	(DESC "306")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY307
	(DESC "307")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY308
	(DESC "308")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY309
	(DESC "309")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY310
	(DESC "310")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY311
	(DESC "311")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY312
	(DESC "312")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY313
	(DESC "313")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY314
	(DESC "314")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY315
	(DESC "315")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY316
	(DESC "316")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY317
	(DESC "317")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY318
	(DESC "318")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY319
	(DESC "319")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY320
	(DESC "320")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY321
	(DESC "321")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY322
	(DESC "322")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY323
	(DESC "323")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY324
	(DESC "324")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY325
	(DESC "325")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY326
	(DESC "326")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY327
	(DESC "327")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY328
	(DESC "328")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY329
	(DESC "329")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY330
	(DESC "330")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY331
	(DESC "331")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY332
	(DESC "332")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY333
	(DESC "333")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY334
	(DESC "334")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY335
	(DESC "335")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY336
	(DESC "336")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY337
	(DESC "337")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY338
	(DESC "338")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY339
	(DESC "339")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY340
	(DESC "340")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY341
	(DESC "341")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY342
	(DESC "342")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY343
	(DESC "343")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY344
	(DESC "344")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY345
	(DESC "345")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY346
	(DESC "346")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY347
	(DESC "347")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY348
	(DESC "348")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY349
	(DESC "349")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY350
	(DESC "350")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY351
	(DESC "351")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY352
	(DESC "352")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY353
	(DESC "353")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY354
	(DESC "354")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY355
	(DESC "355")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY356
	(DESC "356")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY357
	(DESC "357")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY358
	(DESC "358")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY359
	(DESC "359")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY360
	(DESC "360")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY361
	(DESC "361")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY362
	(DESC "362")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY363
	(DESC "363")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY364
	(DESC "364")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY365
	(DESC "365")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY366
	(DESC "366")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY367
	(DESC "367")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY368
	(DESC "368")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY369
	(DESC "369")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY370
	(DESC "370")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY371
	(DESC "371")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY372
	(DESC "372")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY373
	(DESC "373")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY374
	(DESC "374")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY375
	(DESC "375")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY376
	(DESC "376")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY377
	(DESC "377")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY378
	(DESC "378")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY379
	(DESC "379")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY380
	(DESC "380")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY381
	(DESC "381")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY382
	(DESC "382")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY383
	(DESC "383")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY384
	(DESC "384")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY385
	(DESC "385")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY386
	(DESC "386")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY387
	(DESC "387")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY388
	(DESC "388")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY389
	(DESC "389")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY390
	(DESC "390")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY391
	(DESC "391")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY392
	(DESC "392")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY393
	(DESC "393")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY394
	(DESC "394")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY395
	(DESC "395")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY396
	(DESC "396")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY397
	(DESC "397")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY398
	(DESC "398")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY399
	(DESC "399")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY400
	(DESC "400")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY401
	(DESC "401")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY402
	(DESC "402")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY403
	(DESC "403")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY404
	(DESC "404")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY405
	(DESC "405")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY406
	(DESC "406")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY407
	(DESC "407")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY408
	(DESC "408")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY409
	(DESC "409")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY410
	(DESC "410")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY411
	(DESC "411")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY412
	(DESC "412")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY413
	(DESC "413")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY414
	(DESC "414")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY415
	(DESC "415")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY416
	(DESC "416")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY417
	(DESC "417")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY418
	(DESC "418")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY419
	(DESC "419")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY420
	(DESC "420")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY421
	(DESC "421")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY422
	(DESC "422")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY423
	(DESC "423")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY424
	(DESC "424")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY425
	(DESC "425")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY426
	(DESC "426")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY427
	(DESC "427")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY428
	(DESC "428")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY429
	(DESC "429")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY430
	(DESC "430")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY431
	(DESC "431")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY432
	(DESC "432")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY433
	(DESC "433")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY434
	(DESC "434")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY435
	(DESC "435")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY436
	(DESC "436")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY437
	(DESC "437")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY438
	(DESC "438")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY439
	(DESC "439")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY440
	(DESC "440")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY441
	(DESC "441")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY442
	(DESC "442")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY443
	(DESC "443")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY444
	(DESC "444")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY445
	(DESC "445")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY446
	(DESC "446")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY447
	(DESC "447")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY448
	(DESC "448")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY449
	(DESC "449")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY450
	(DESC "450")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY451
	(DESC "451")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY452
	(DESC "452")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY453
	(DESC "453")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>

<ROOM STORY454
	(DESC "454")
	(STORY TEXT)
	(EVENTS NONE)
	(PRECHOICE NONE)
	(CHOICES NONE)
	(DESTINATIONS NONE)
	(REQUIREMENTS NONE)
	(TYPES NONE)
	(CONTINUE NONE)
	(ITEM NONE)
	(CODEWORD NONE)
	(COST 0)
	(DEATH F)
	(VICTORY F)
	(FLAGS LIGHTBIT)>
