script aen_fortune.ash

// Clan Fortune Teller (Cheesecookie)
int changeClan(int toClan);			//Returns new clan ID (or old one if it failed)
int changeClan();					//To BAFH

int changeClan(string clanName) {
	int toClan = 0;
	boolean canReturn = false;
	string page = visit_url("clan_signup.php");
	matcher clan_matcher = create_matcher("<option value=(\\d\\d\\d+)>(.*?)</option>", page);
	while(clan_matcher.find()) {
		if(clan_matcher.group(1) == get_clan_id())
		{
			canReturn = true;
		}
		if(clan_matcher.group(2) ≈ clanName)
		{
			toClan = to_int(clan_matcher.group(1));
		}
		print("Found clan " + clan_matcher.group(1) + " and name: " + clan_matcher.group(2));
	}

	if(toClan == 0) {
		print("Do not have a whitelist to destination clan; cannot change clans.");
		return 0;
	}
	if(!canReturn) {
		print("Do not have a whitelist to our own clan; cannot change clans.");
		return 0;
	}

	int oldClan = get_clan_id();
	if(toClan == oldClan) {
		print("Already in this clan; no need to try to change (" + toClan + ".)", "red");
		return oldClan;
	}

	visit_url("showclan.php?pwd=&recruiter=1&action=joinclan&apply=Apply+to+this+Clan&confirm=on&whichclan=" + toClan, true);

	if(get_clan_id() == oldClan) {
		print("Clan change failed", "red");
	}
	return get_clan_id();
}

int changeClan(int toClan) {
	int oldClan = get_clan_id();
	if(toClan == oldClan) {
		print("Already in this clan, no need to try to change (" + toClan + ")", "red");
		return oldClan;
	}

	string page = visit_url("clan_signup.php");
	if(!contains_text(page, "option value=" + oldClan + ">")) {
		print("Do not have a whitelist to our own clan; cannot change clans.");
		return 0;
	}
	if(!contains_text(page, "option value=" + toClan + ">")) {
		print("Do not have a whitelist to our own clan; cannot change clans.");
		return 0;
	}

	page = visit_url("showclan.php?pwd=&recruiter=1&action=joinclan&apply=Apply+to+this+Clan&confirm=on&whichclan=" + toClan, true);

	if(get_clan_id() == oldClan) {
		print("Clan change failed.", "red");
	}
	return get_clan_id();
}

int changeClan() {
	return changeClan(90485);
}

// Function here; while(clanmateConsult("")); in script

boolean clanmateConsult(string who) {

	# who is ignored.
	if(item_amount($item[Clan VIP Lounge Key]) == 0) {
		return false;
	}

	if(!is_unrestricted($item[Clan Carnival Game])) {
		return false;
	}

	if(get_property("_clanFortuneConsultUses").to_int() >= 3) {
		return false;
	}

#	string page = visit_url("clan_viplounge.php");
#	if(!contains_text(page, "lovetester"))
#	{
#		set_property("_clanFortuneConsultUses", 3);
#		return false;
#	}
#	set_property("_clanFortuneConsultUses", get_property("_clanFortuneConsultUses").to_int() + 1);

	int oldClan = get_clan_id();
	changeClan();
	if(oldClan == get_clan_id()) {
		set_property("_clanFortuneConsultUses", 42069);
		return false;
	}

	int player = 3038166;
	string name = get_player_name(player);
	boolean needWait = true;

	while(get_property("_clanFortuneConsultUses").to_int() < 2) {
		string temp = visit_url("clan_viplounge.php?preaction=lovetester", false);
		temp = visit_url("choice.php?pwd=&whichchoice=1278&option=1&which=1&whichid=3038166&q1=a&q2=b&q3=c");

		if(contains_text(temp, "You can't consult Madame Zatara about your relationship with anyone else today.")) {
			print("No more available clanmate consults.", "red");
			set_property("_clanFortuneConsultUses", 3);
			needWait = false;
			break;
		}
		if(contains_text(temp, "You enter your answers and wait for " + name + " to answer, so you can get your results!")) {
			print("Waiting for answer.", "green");
			break;
		}
		if(contains_text(temp, "You're already waiting on your results with " + name + ".")) {
			print("Results pending from prior request...", "blue");
		}
		else if(contains_text(temp, "You can only consult Madame Zatara about someone in your clan.")) {
			print(name + " Clanmate unavailable. Waiting.", "blue");
		}

		wait(5);
	}

	while(get_property("_clanFortuneConsultUses").to_int() == 2) {
		string temp = visit_url("clan_viplounge.php?preaction=lovetester", false);
		temp = visit_url("choice.php?pwd=&whichchoice=1278&option=1&which=1&whichid=3038166&q1=pizza&q2=batman&q3=thick");

		if(contains_text(temp, "You can't consult Madame Zatara about your relationship with anyone else today.")) {
			print("Clanmate consults exhausted.", "red");
			set_property("_clanFortuneConsultUses", 3);
			needWait = false;
			break;
		}
		if(contains_text(temp, "You enter your answers and wait for " + name + " to answer, so you can get your results!")) {
			print("Waiting for answer.", "green");
			break;
		}
		if(contains_text(temp, "You're already waiting on your results with " + name + ".")) {
			print("Results pending from prior request...", "blue");
		}
		else if(contains_text(temp, "You can only consult Madame Zatara about someone in your clan.")) {
			print(name + " unavailable. Waiting.", "blue");
		}

		wait(5);
	}

	changeClan(oldClan);
	if(needWait) {
		wait(10);
	}
	return true;
}