# Heart of Ice (Virtual Reality Adventures)

This is a ZIL Implementation of Heart of Ice game book (Virtual Reality Adventures) by Dave Morris.

| **Cover art** | **Back cover blurb**|
|:-:|:-:|
|![Cover Art](/images/heart-of-ice.jpg)|Legend says that the one who possesses the Heart of Volent shall wield ultimate power. Created in the searing fires of the Big Bang, this fabulous gemstone focuses the cosmic forces which shape the universe itself. As cahos grows and a new Ice Age closes its grip on the world, you and handful of desperate adventurers compete in your search for the gem. Are you ruthless and resourceful enough to win its power for yourself?|
| |Not luck but judgement!|
| |*Virtual Reality Adventure Books are a new generation of interactive fiction. This unique non-random game system makes the choices all yours. There are no dice to roll, no lengthy rules to learn. All you need is the spark of your own imagination!*|
| |*Cover illustration by Mike Posen|
| | |
| |**Map of Zone 18347 (North Africa and Europe)**|
| |![Map](/images/map-of-zone-18347.jpg)<br>**From: [Museum of Computer Adventure Game History](https://mocagh.org/loadpage.php?getcompany=otherbook)|

## Additional Copyright Information 

```
Published 1994 by Mammoth an imprint of Reed Consumer Books Limited
Michelin Home, 81 Fulham Road, London SW3 6RB and Auckland, Melbourne, Singapore and Toronto

Text copyright (c) 1994 Dave Morris
Illustrations copyright (c) 1994 Russ Nicholson
Map copyright (c) 1994 Leo Hartas

ISBN 0 7497 1674 6
```

## Notes about ZIL version

- No in-game illustrations or graphics (also excludes map from the book)
- Character selection and inventory of items and codewords are implemented
- Some changes to the text were made: spelling errors/consistency, some were rephrased to fit the "digital" format or the implemented mechanisms 
- Select an action by pressing the number keys that correspond to the option (**1** - **9**).
- In some situations, if there are more than 9 options, items 10-15 map to the keys **A** (or **a**) - **F** (or **f**)
- Press **q** or **Q** to quit or terminate the program
- Press **c** or **C** to view character (items, skills, codewords)
- Press **i** or **I** to view inventory (items)
- Press **g** or **G** to view skills glossary
- Press **r** or **R** to restore progress from a save file
- Press **s** or **S** to save current progress to a file
- Press **h** or **H** or **?** lists the commands **G**/**C**/**I**/**S**/**R**/**Q** and what each does 

## Additional Notes

- In this version, it is not possible to carry more than one barysal pistol. *No doubt, this is because I am still figuring out a lot of things about ZIL*.
- The barysol pistol is limited to 6 charges. Additonal charges are "lost".
- When given the option of picking up one (or more), if you already have an existing pistol, you will be presented with an opportunity to transfer the remaining charge to your existing pistol.
- If you pick up a battery unit during the course of your adventure, pressing **B** or **b** will charge a barysal pistol, if you are carrying one. If you do so, the battery unit will be lost.
- *Let me know if the above barysal pistol limitations makes completing the adventure difficult and/or impossible. I'll figure out another way to implement this. Thanks in advance!*

## Bugs

Feel free to report bugs or any issues with this adaptation. Thanks!
