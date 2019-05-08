script "newDG.ash"

import <utils.ash>
import <bastille.ash>
import <pantogram.ash>
import <fortune.ash>

if(DG()) {

	if(!get_property("_newDGskills").to_boolean()) {
		visit_url("choice.php?whichchoice=1343&option=1");
		visit_url("main.php");
		if(user_confirm("If you have the maximum HP for all the DG skills, click yes. If not, please click no to allocate skills manually.")) {
			if(user_confirm("Do you want the muscle-equalizing skill? Scaling fights = easier, but requires reset if you have level 13 muscle test.")) {
				visit_url("choice.php?whichchoice=1342&option=2&pwd=" + my_hash() + "&sk[]=10&sk[]=11&sk[]=12&sk[]=13&sk[]=14&sk[]=15&sk[]=16&sk[]=17&sk[]=18&sk[]=22&sk[]=23&sk[]=24&sk[]=25&sk[]=26&sk[]=27&sk[]=28&sk[]=30&sk[]=31&sk[]=32&sk[]=33&sk[]=34&sk[]=35&sk[]=36&sk[]=37&sk[]=38");
				visit_url("choice.php?whichchoice=1342&option=1&pwd=" + my_hash());
				set_property("_newDGskills", "true");
			} else {
				visit_url("choice.php?whichchoice=1342&option=2&pwd=" + my_hash() + "&sk[]=10&sk[]=11&sk[]=12&sk[]=13&sk[]=14&sk[]=16&sk[]=17&sk[]=18&sk[]=22&sk[]=23&sk[]=24&sk[]=25&sk[]=26&sk[]=27&sk[]=28&sk[]=30&sk[]=31&sk[]=32&sk[]=33&sk[]=34&sk[]=35&sk[]=36&sk[]=37&sk[]=38");
				visit_url("choice.php?whichchoice=1342&option=1&pwd=" + my_hash());
				set_property("_newDGskills", "true");
			}

		} else {
			set_property("_newDGskills", "true");
			abort("Please allocate your skills manually, confirm, rest for millennia and then re-run.");
		}
	}

// Stuffies
if(get_clan_rumpus() contains "Mr. Klaw \"Skill\" Crane Game") {
	while(get_property("_klawSummons").to_int() < 3) {
		print("Collecting rumpus stuffies.", "blue");
		visit_url("clan_rumpus.php?action=click&spot=3&furni=3");
	}
}

	if(have($item[Clan VIP Lounge key])) {
		while(get_property("_deluxeKlawSummons").to_int() < 3) {
			print("Collecting VIP stuffies.", "blue");
			visit_url("clan_viplounge.php?action=klaw");
		}
	}

	// Toot Oriole stolen from Bale
	if(!get_property("_tootLetter").to_boolean()) {
		print("Collecting the Toot Oriole letter.", "blue");
		visit_url("tutorial.php?action=toot&pwd");
		item tootletter = $item[letter from King Ralph XI];
		if(my_path() == "Actually Ed the Undying") {
			tootletter = $item[letter to Ed the Undying];
		}
		if(have(tootletter)) {
			print("Using the Toot Oriole letter.", "blue");
			use(1, tootletter);
		}
		set_property("_tootLetter", "true");
	}
		
	// Collect stones
	if(have(sack)) {
		print("Collecting stones.", "blue");
		use(1, sack);
		if(have(por)) {
			print("You received " + amt(bac) + " bacontones, " + amt(ham) + " hamethysts and " + amt(por) + " porquoises (precioussss).", "blue");
		} else {
			print("You received " + amt(bac) + " bacontones, " + amt(ham) + " hamethysts but OMG no porquoises! Drop to casual! ", "red");
		}	
	}
	
	// PANTOGRAM
	if(pantogram_can_summon()) {
		
		if(knoll_available() && amt(por) < 1) {
			print("Buying a taco shell for Pantogram because we have no porquoises (Gollum! GOLLUM!).", "blue");
			buyUntil(1, $item[taco shell]);
		}
		
		// Pantogram
		pantogram_summon();
		
	}
	
	wield(pantogram_pants);
	if(user_confirm("Safety check that your porquoise is safely in your pantogram pants.")) {
	} else {
		abort("Please do your pantogram pants manually.");
	}
	
	autosell(amt(por), por);
	autosell(amt(bac), bac);
	autosell(amt(ham), ham);
		
	// Buy and set the radio
	if(knoll_available() && amt($item[Detuned Radio]) == 0) {
		print("Buying and using a detuned radio.", "blue");
		buyUntil(1, $item[Detuned Radio]);
		change_mcd(10);
	}
	
	// FantasyRealm
	if(get_property("frAlways").to_boolean() && !get_property("_lyleHat").to_boolean()) {
		print("Collecting Lyle FantasyRealm hat.", "blue");
		item lyleHat;
		if(my_primestat() == $stat[muscle]) {
			// Lyle hat
			cli_execute("make FantasyRealm Warrior's Helm");
			item lyleHat = $item[FantasyRealm Warrior's Helm];
			
			/* Mummery Muscle substats on the XO Skeleton
			if(my_familiar() != $familiar[XO Skeleton]) {
				cli_execute("mummery muscle");
			}*/
		} else if(my_primestat() == $stat[mysticality]) {
			cli_execute("make FantasyRealm Mage's Hat");
			item lyleHat = $item[FantasyRealm Mage's Hat];
		} else if(my_primestat() == $stat[moxie]) {
			cli_execute("make FantasyRealm Rogue's Mask");
			item lyleHat = $item[FantasyRealm Rogue's Mask];			
		}
		wield(lyleHat);
		set_property("_lyleHat", "true");
	}
	foreach junk in $items[club necklace, diamond necklace, heart necklace, spade necklace, rubber WWBD? bracelet, rubber WWJD? bracelet, rubber WWSPD? bracelet, rubber WWtNSD? bracelet,
	stuffed angry cow, stuffed astral badger, stuffed baby gravy fairy, stuffed Cheshire bitten, stuffed cocoabo, stuffed flaming gravy fairy, stuffed frozen gravy fairy, stuffed hand turkey,
	stuffed MagiMechTech MicroMechaMech,stuffed mind flayer, stuffed scary death orb, stuffed sleazy gravy fairy, stuffed snowy owl, stuffed spooky gravy fairy, stuffed stinky gravy fairy,
	stuffed undead elbow macaroni, Newbiesport&trade; tent]
		autosell(amt(junk), junk);
	
	if(have_effect($effect[Ceaseless Snarling]) < 1) {
		use_skill(1, $skill[Ceaseless Snarl]);
	}
	
	wield($item[vampyric cloake]);
	if(have($item[January's Garbage Tote])) {
		cli_execute("fold tinsel tights");
		wield($item[tinsel tights]);
	} else {
		wield($item[old sweatpants]);
	}
	wield($item[latte lovers member's mug]);
	wield(saber);
	wield($slot[acc1], $item[Kremlin's Greatest Briefcase]);
	if(wield($slot[acc2], $item[astral belt])) {
	} else {
		wield($slot[acc2], $item[astral mask]);
	}
	if(wield($slot[acc3], $item[Draftsman's driving gloves])) {
	} else {
		wield($item[Lil' Doctor&trade; bag]);
	}
	
	if(avail($item[seal tooth])) {
		while(avail($item[worthless trinket])) {
			buyUntil(1, $item[chewing gum on a string]);
			use(1, $item[chewing gum on a string]);
		}
		cli_execute("hermit seal tooth");
	}
	
	// Bastille
	print("Using bastille now so we don't die while looking for a goblin. RIP possible 1 turn of buff.", "blue");
	bastilleBatallion(1, 2, 3, 0);
	
	if(!avail($item[continuum transfunctioner])) {
	print("Acquiring the continuum transfunctioner.", "blue");
		visit_url("council.php");
		visit_url("place.php?whichplace=forestvillage&action=fv_mystic");
		run_choice(1);
		run_choice(1);
		run_choice(1);
	}
	
	// Set SongBoom song to meat
	if(have($item[SongBoom&trade; BoomBox]) && get_property("boomBoxSong") != "Total Eclipse of Your Meat") {
		print("Setting and adding a change counter for the SongBoom BoomBox.", "blue");
		cli_execute("boombox meat");
		cli_execute("counters add " + (10 - get_property("_boomBoxFights").to_int()) + " BoomBox reward");
	}
	
	print("Please manually put KGB onto ML and collect 3 safety cigars.", "red");
	
	if(user_confirm("First go to the outskirts of cobb's knob with 80ML, cast dark feast and then ensorcel on any goblin, then click yes.")) {
	} else {
		abort("First go to the outskirts of cobb's knob, cast dark feast and then ensorcel on any goblin, then rerun.");
	}
	// Set SongBoom song to meat
	if(have($item[SongBoom&trade; BoomBox])) {
	if(get_property("_boomBoxFights").to_int() != 9) {
		print("It would appear you were unlucky. Recalibrating the BoomBox counter.", "blue");
		stop_counter("BoomBox reward");
		cli_execute("counters add " + (10 - get_property("_boomBoxFights").to_int()) + " BoomBox reward");
	}
	
	if(have(saber) && !get_property("_saberUpgrade").to_boolean()) {
			visit_url("main.php?action=may4");
		if(user_confirm("Do you want the +ML saber upgrade?")) {
			print("Setting the saber to +ML.", "blue");
			run_choice(2);
		} else if(user_confirm("Do you want the +res saber upgrade?")) {
			print("Setting the saber to +res.", "blue");
			run_choice(3);
		} else {
			print("Please pick your saber upgrade manually. Weirdo.", "red");
		}
		set_property("_saberUpgrade", "true");
	}
	
	// Horsery
	if(to_boolean(get_property("horseryAvailable"))) {
		print("Taking the dark horse for meat and +NC.", "blue");
		if(get_property("_horsery") != "dark horse") {
			string temp = visit_url("place.php?whichplace=town_right&action=town_horsery");
			temp = visit_url("choice.php?pwd=&whichchoice=1266&option=2");
		}
	}
	
	
	// Consults
	print("Obtaining Fortune Teller buff and items.", "blue");
	if(!to_boolean(get_property("_clanFortuneBuffUsed"))) {
		cli_execute("fortune buff mys");
	}
		while(clanmateConsult(""));
	}
	
	// Counters
	if(get_property("voteAlways").to_boolean()) {
		print("Setting some vote wanderer counters.", "blue");
		cli_execute("counters add " + to_string((12 - (total_turns_played() % 11)) % 11) + " Democratic Wanderer");
		set_property("trackVoteMonster", "true");
	}

	// Miscellaneous
	visit_url("place.php?whichplace=arcade&action=arcade_plumber", false);
	
	if(have_effect($effect[Glittering Eyelashes]) < 1) {
		buyUntil(1, $item[glittery mascara]);
		use(1, $item[glittery mascara]);
	}


}