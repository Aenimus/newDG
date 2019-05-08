script pantogram.ash

import utils.ash

// PANTOGRAM
boolean pantogram_have() {
	return pantogram.available_amount() > 0;
}

boolean pantogram_summoned() {
	return pantogram_pants.available_amount() > 0;
}

boolean pantogram_can_summon() {
	if(!pantogram_have() || pantogram_summoned()) {
		return false;
	}
		return true;
}

string pantogram_stat(stat m) {
	if (m == $stat[none]) {
		m = my_primestat();
	}

	switch (m) {
		case        mus:    return 1;
		case        mys:    return 2;
		case        mox:    return 3;
		default:            return pantogram_stat(ps);
	}
}

string pantogram_element(element e) {
	switch (e) {
		case		hot:		return 1;
		case		cold:		return 2;
		case		spooky:		return 3;
		case		sleaze:		return 4;
		case		stench:		return 5;
		default:				return 1;
	}
}

string pantogram_normalise(string text) {
	string [int] tokens = text.split_string(" ");
	string new_text = "";
	foreach i, token in tokens {
		if (i > 0) new_text += " ";
			switch(token) {
				case "mys":
				case "myst":		new_text += "mysticality";		continue;
				case "mox":			new_text += "moxie";			continue;
				case "mus":
				case "musc":		new_text += "muscle";			continue;
				case "wepdmg":		new_text += "weapon damage";	continue;
				case "speldmg":		new_text += "spell damage";		continue;
				case "fish":		new_text += "fishing";			continue;
				case "crit":		new_text += "critical hit";		continue;	
				case "+com":		new_text += "+combat";			continue;					
				case "-com":		new_text += "-combat";			continue;				
				case "dmg":			new_text += "damage";			continue;
				case "init":		new_text += "initiative";		continue;
				case "fam":			new_text += "familiar";			continue;
				default:			new_text += token;
			}
	}
	return new_text;
}

int [2] pantogram_s1(string s1) {
	s1 = pantogram_normalise(s1);
	int [2] output;
	switch (s1) {
		case "hp":
		case "drops of blood":	output = {-1, 0};	break;
		case "mp":
		case "nail clippings":	output = {-2, 0};	break;
		case "low hp regen":	output = {464, 1};	break;
		case "medium hp regen":	output = {830, 1};	break;
		case "high hp regen":	output = {2438, 1};	break;
		case "low mp regen":	output = {1658, 1};	break;
		case "medium mp regen":	output = {5789, 1};	break;
		case "high mp regen":	output = {8455, 1};	break;
		case "skill":			output = {705, 1};	break;
		default: abort("Do not recognise " + s1 + " for slot 1");
	}
	return output;
}

int [2] pantogram_s2(string s2) {
	s2 = pantogram_normalise(s2);
	int [2] output;
	switch (s2) {
		case "your hopes":
		case "weapon damage":		output = {-1, 0};	break;
		case "your dreams":
		case "spell damage":		output = {-2, 0};	break;
		case "low meat":			output = {173, 1};	break;
		case "high meat":			output = {706, 1};	break;
		case "low items":			output = {80, 1};	break;
		case "high items":			output = {7338, 1};	break;
		case "muscle stats":		output = {747, 1};	break;
		case "mysticality stats":	output = {559, 3};	break;		
		case "moxie stats":			output = {27, 3};	break;
		case "muscle gains":		output = {7327, 5};	break;
		case "mysticality gains":	output = {7324, 5};	break;		
		case "moxie gains": 		output = {7330, 5};	break;
		default: abort("Do not recognise " + s2 + " for slot 2");
	}
	return output;
}

int [2] pantogram_s3(string s3) {
	s3 = pantogram_normalise(s3);
	int [2] output;
	switch (s3) {
		case "self-respect":
		case "-combat":			output = {-1, 0};		break;
		case "self-control":
		case "+combat":			output = {-2, 0};		break;
		case "initiative":		output = {70, 1};		break;
		case "critical hit":	output = {704, 1};		break;
		case "familiar":
		case "familiar weight":	output = {865, 11};		break;
		case "candy":			output = {6891, 1};		break;
		case "diver":			output = {3495, 11};	break;
		case "fishing":			output = {9008, 1};		break;		
		case "pool":			output = {1907, 15};	break;
		case "purple":			output = {14, 99};		break;
		case "hilarity":
		case "clover":			output = {24, 1};		break;
		default: abort("Do not recognise " + s3 + " for slot 3");
	}
	return output;
}

string pantogram_check(int [2] sl, boolean can_buy) {
	if (sl[0] >= 0) {
		item it = sl[0].to_item();
		int quantity = sl[1];

		if (it.available_amount() < quantity && !can_buy) {
			abort("You do not have enough " + it.to_string());
		}

		if (it.item_amount() < quantity) {
			boolean r = retrieve_item(quantity, it);
			if (!r) abort("Could not retrieve " + it.plural(quantity));
		}
	}

	return sl[0] + "," + sl[1];
}

string pantogram_check(int [2] sl) {
	return pantogram_check(sl, true);
}

void pantogram_summon(stat m, element e, string s1, string s2, string s3, boolean can_buy) {
	if(!pantogram_can_summon()) {
		return;
	}
	string [string] choices;

	choices["m"] = pantogram_stat(m);
	choices["e"] = pantogram_element(e);
	choices["s1"] = pantogram_s1(s1).pantogram_check();
	choices["s2"] = pantogram_s2(s2).pantogram_check();
	choices["s3"] = pantogram_s3(s3).pantogram_check();

	string url = "choice.php?whichchoice=1270&pwd&option=1";
	foreach key in $strings[m, e, s1, s2, s3] {
		 url += "&" + key + "=" + choices[key];
	}
	visit_url("inv_use.php?pwd&whichitem=9573");
	visit_url(url);
}

void pantogram_summon(stat m, element e, string s1, string s2, string s3) {
	pantogram_summon(m, e, s1, s2, s3, true);
}

void pantogram_summon(string s1, string s2, string s3) {
	pantogram_summon($stat[none], $element[hot], s1, s2, s3);
}

void pantogram_summon() {
	string s1;
	if(my_path() == "Standard" && have(bac)) {
		s1 = "skill";
	} else if(!in_DG()) {
		s1 = "mp";
	} else {
		s1 = "hp";
	}
	string s2;
	if(have(por)) {
		s2 = "high meat";
	} else if(have($item[taco shell])) {
		s2 = "low meat";
	} else if(my_primestat() == mus || in_DG()) {
		s2 = "wepdmg";
	} else {
		s2 = "speldmg";
	}

	pantogram_summon(s1, s2, "-com");
} 