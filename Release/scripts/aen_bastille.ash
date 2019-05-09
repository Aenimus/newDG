script aen_bastille.ash

// Bastille automation stolen from Cheesecookie; bastilleBatallion(0, 0, 0, 0); in script
boolean bastilleBatallion(int stats, int it, int buff, int potion) {
	if(get_property("_bastilleGames").to_int() != 0) {
		return false;
	}

	if(stats == 0) {
		switch(my_primestat()) {
			case $stat[Muscle]:			stats = 2;			break;
			case $stat[Mysticality]:	stats = 1;			break;
			case $stat[Moxie]:			stats = 3;			break;
		}
	}

	if(it == 0) {
		switch(my_primestat()) {
			case $stat[Muscle]:			it = 1;			break;
			case $stat[Mysticality]:	it = 2;			break;
			case $stat[Moxie]:			it = 3;			break;
		}
	}

	if(buff == 0) {
		switch(my_primestat()) {
			case $stat[Muscle]:			buff = 1;			break;
			case $stat[Mysticality]:	buff = 2;			break;
			case $stat[Moxie]:			buff = 3;			break;
		}
	}

	if(potion == 0) {
		potion = 1 + random(3);
	}

	if((stats < 1) || (stats > 3)) {
		return false;
	}
	if((it < 1) || (it > 3)) {
		return false;
	}
	if((buff < 1) || (buff > 3)) {
		return false;
	}
	if((potion < 1) || (potion > 3)) {
		return false;
	}

	string page = visit_url("inv_use.php?pwd=" + my_hash() + "&which=3&whichitem=9928", false);

	matcher first = create_matcher("/bbatt/barb(\\d).png", page);
	if(first.find()) {
		int setting = first.group(1).to_int();
		while(setting != stats) {
			string temp = visit_url("choice.php?whichchoice=1313&option=1&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3) {
			setting = 1;
			}
		}
	}

	matcher second = create_matcher("/bbatt/bridge(\\d).png", page);
	if(second.find()) {
		int setting = second.group(1).to_int();
		while(setting != it) {
			string temp = visit_url("choice.php?whichchoice=1313&option=2&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3)	{
				setting = 1;
			}
		}
	}

	matcher third = create_matcher("/bbatt/holes(\\d).png", page);
	if(third.find()) {
		int setting = third.group(1).to_int();
		while(setting != buff) {
			string temp = visit_url("choice.php?whichchoice=1313&option=3&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3) {
				setting = 1;
			}
		}
	}

	matcher fourth = create_matcher("/bbatt/moat(\\d).png", page);
	if(fourth.find())	{
		int setting = fourth.group(1).to_int();
		while(setting != potion)	{
			string temp = visit_url("choice.php?whichchoice=1313&option=4&pwd=" + my_hash(), false);
			setting++;
			if(setting > 3)	{
				setting = 1;
			}
		}
	}

	string temp = visit_url("choice.php?whichchoice=1313&option=5&pwd=" + my_hash(), false);

	for(int i=0; i<5; i++){
		visit_url("choice.php?whichchoice=1314&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1319&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1314&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1319&option=3&pwd=" + my_hash());
		visit_url("choice.php?whichchoice=1315&option=3&pwd=" + my_hash());
			if(last_choice() == 1316) {
				break;
			}
	}

	visit_url("choice.php?whichchoice=1316&option=3&pwd=" + my_hash());
	return true;
}