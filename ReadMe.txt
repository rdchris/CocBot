The following is a personal project I did over the course of two weeks my family was out of town. It's basically
a completely automated bot that plays a top 3 iOS game, clash of clans, impersonating an active player.
The bot clicks on randomly locations within the range of acceptable areas, collects resources, makes human-like pauses and breaks after it's been
"playing too long", search for opponents to fight, execute attacks mimicking my attack styles, and provides me updates on how it's doing. 

The code base is currently not where I would like it to be from a clean-code perspective, but I'm slowly
re-factoring it when time permits. Functionality however it's extremely effective, I had to tune-down it's
effectiveness as I started landing in the world top 10 in resources gained per day. 

Some of the challenges I faced when writing this were, an extremely tight time-line (2 weeks), using groups
of technologies I had never played with before, and overcoming some clever game developers who designed their game to makes
this task much more difficult. For example, the loot numbers used to see how much a base has uses pixel layout randomization,
which means the pixels change slightly in color and position, making it impossible to hard-code a solution
to see how much loot a base has. It was a non-trivial problem that I eventually solved by taking a 
screenshot of these numbers and running them through google's tesseract OCR engine with a few minor tweaks. This provides me 
a 99% accurate read of the numbers on the screen.



