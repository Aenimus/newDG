script "Ascension Tools.ash"

// SHORTCUTS
element hot		=	$element[hot];
element cold	=	$element[cold];
element spooky	=	$element[spooky];
element sleaze	=	$element[sleaze];
element stench 	=	$element[stench];
element el	=	$element[hot];
stat	mus		=	$stat[muscle];
stat	mys		=	$stat[mysticality];
stat	mox		=	$stat[moxie];
stat	ps	=	my_primestat();
item sack = $item[pork elf goodies sack];
item bac = $item[baconstone];
item ham = $item[hamethyst];
item por = $item[porquoise];
item pantogram = $item[portable pantogram];
item pantogram_pants = $item[pantogram pants];
item saber = $item[Fourth of May Cosplay Saber];
item bastille = $item[Bastille Battalion control rig];



// DEFINITIONS
// buyUntil (Cheesecookie)
boolean buyUntil(int num, item it, int maxprice) {
	num -= item_amount(it);
	if(num > 0) {
		return buy(num, it, maxprice) < num;
	}
	return true;
}

boolean buyUntil(int num, item it) {
	return buyUntil(num, it, 500);
}

// Fancy Gausie things
string plural(item it, int q) {
	if (q == 1) return "1 " + it.to_string();
	return q + " " + it.plural;
}

// Item check
boolean have(item it) {
	return it.item_amount() > 0;
}

boolean avail(item it) {
	return it.available_amount() > 0;
}

int amt(item it) {
	return item_amount(it);
}

// Equip checked item
boolean wield(item it) {
	if(!have(it)) {
		return false;
	}
	return equip(it);
}

boolean wield(slot where, item it) {
	if(!have(it)) {
		return false;
	}
	return equip(it);
}

boolean in_DG() {
	if(my_path() == "Dark Gyffte") {
		return true;
	}
	return false;
}
	
boolean DG() {
	if(in_DG() && my_daycount() == 1 && in_hardcore()) {
		return true;
	}
	return false;
}