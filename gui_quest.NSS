const int QUEST_LIMIT = 50;

//nTYPE: 1 for name, 2 for area, 3 for level and anything else for group size.
string GetRelevantQuestInfo(int nQUEST, int nTYPE)
{
	string sNAME;
	string sDESC;
	string sREQU;
	switch (nQUEST)
	{
		case 1: 
			sNAME = "Cook's Assistant";
			sDESC = "The Lumbridge Castle cook is in a mess. It is the Duke of Lumbridge's birthday and the cook is making the cake.";
			sREQU = "None";
			break;
		case 2: 
			sNAME = "Tutorial Island";
			sDESC = "Learn the skills, combat, quests and more to Molior RS.";
			sREQU = "This is only a tutorial and provides no extra benefits for actually completing.";
			break;
		case 3: 
			sNAME = "Restless Ghost";
			sDESC = "A ghost is haunting Lumbridge graveyard. The priest of the Lumbridge church of Saradomin needs help to find out how to get rid of it.";
			sREQU = "None";
			break;
		case 4: 
			sNAME = "Imp Catcher";
			sDESC = "The Wizard Grayzag has summoned hundreds of little imps. They have stolen a lot of things belonging to the Wizard Mizgog including his magic beads.";
			sREQU = "None";
			break;
		case 5: 
			sNAME = "Goblin Diplomacy";
			sDESC = "There's a disturbance in the Goblin Camp, west of Lumbridge. Help the goblins solve their dispute so the world doesn't have to worry about rioting goblins.";
			sREQU = "None";
			break;
		case 6: 
			sNAME = "Witch's Potion";
			sDESC = "Become one with your darker side. Tap into your hidden depths of magical potential by making a potion with the help of Hetty the Rimmington witch.";
			sREQU = "None";
			break;
		case 7: 
			sNAME = "Sheep Shearer";
			sDESC = "Fred the Farmer's sheep are getting mighty woolly. He will pay you to shear them.";
			sREQU = "None";
			break;
		case 8: 
			sNAME = "Doric's Quest";
			sDESC = "Doric the dwarf is happy to let you use his anvils but first he would like you to run an errand for him.";
			sREQU = "10 Mining";
			break;
		case 9: 
			sNAME = "Rune Mysteries";
			sDESC = "Duke Horacio of Lumbridge has found a strange talisman. He needs it delivered to Wizards' Tower for research.";
			sREQU = "None";
			break;
		case 10: 
			sNAME = "Ernest the Chicken";
			sDESC = "Veronica is very worried. Her fiancé went into the big spooky manor house to ask for directions. An hour later and he's still not out yet.";
			sREQU = "Survive an encounter with a level 7 Skeleton";
			break;
		case 11: 
			sNAME = "Prince Ali Rescue";
			sDESC = "Prince Ali of Al Kharid has been kidnapped by the scheming Lady Keli.";
			sREQU = "None";
			break;
		case 12: 
			sNAME = "Pirate's Treasure";
			sDESC = "Redbeard Frank knows the location of pirate treasure, but he'll only part with the knowledge for a bottle of Karamja rum.";
			sREQU = "None";
			break;
		case 13: 
			sNAME = "Demon Slayer";
			sDESC = "A mighty demon is being summoned to destroy the city of Varrock. You find out you are the one destined to stop him (or at least try).";
			sREQU = "None";
			break;
		case 14: 
			sNAME = "Vampire Slayer";
			sDESC = "The people of Draynor Village live in constant terror. Their numbers are dwindling for unknown reasons.";
			sREQU = "None";
			break;
		case 15: 
			sNAME = "The Dormant Curse";
			sDESC = "Miners have gone missing in the depth of mines in Camdozaal.";
			sREQU = "20 Smithing, 10 Mining, 15 Woodcutting";
			break;
		case 16: 
			sNAME = "The Knight's Sword";
			sDESC = "Squire Asrol is looking for the perfect birthday present for his master.";
			sREQU = "10 Smithing, 10 Cooking";
			break;
		case 17: 
			sNAME = "Romeo and Juliet";
			sDESC = "Romeo and Juliet are desperately in love, but Juliet's father doesn't approve. Help them to find a way to get married and live happily ever after.";
			sREQU = "None";
			break;
		case 18: 
			sNAME = "Herald of Misthalin";
			sDESC = "The Kingdom of Misthalin are looking for a new herald.";
			sREQU = "None";
			break;
		case 19: 
			sNAME = "Herald of Asgarnia";
			sDESC = "The Kingdom of Asgarnia are looking for a new herald.";
			sREQU = "None";
			break;
		case 20: 
			sNAME = "The Dragon Slayer";
			sDESC = "Prove yourself a true champion. Kill the mighty dragon of Bredon and earn the right to buy and wear the Rune plate.";
			sREQU = "Herald of Asgarnia, Herald of Misthalin.";
			break;
		case 21: 
			sNAME = "Lost City";
			sDESC = "Can you find the legendary lost city of Zanaris?";
			sREQU = "31 Crafting, 36 Woodcutting.";
			break;
		case 22: 
			sNAME = "Chosen Path";
			sDESC = "The undead attack day and night against the wilderness wall close to Edgeville. Kingdoms across the land have joined up to hold the line.";
			sREQU = "None, aimed at low levels.";
			break;
		case 23: 
			sNAME = "The Acheron Rock";
			sDESC = "The truth about rune essence has been revealed and I must aid the tower wizards.";
			sREQU = "Rune Mysteries Quest, 28 Runecrafting.";
			break;
		case 24: 
			sNAME = "Risky Business";
			sDESC = "The VTAM corporation are expanding their business. It would be a good opportunity to invest to earn some money.";
			sREQU = "This quest is designed for rogues, as stealth is a key element. Though any other class can complete it.";
			break;
		case 25: 
			sNAME = "Scheme of Schematics";
			sDESC = "Doric is trying to recover his schematics to craft pickaxes. He needs your help to get it.";
			sREQU = "Dorics' Quest, 15 Fletching.";
			break;
		case 26: 
			sNAME = "The Cult of Scorpia";
			sDESC = "Citizens are being lured into joining a cult, worshipping Scorpia. Those who join up are never seen again.";
			sREQU = "Prince Ali Rescue, Romeo and Juliet, 42 Cooking.";
			break;
		case 27: 
			sNAME = "A Bargain for Profit";
			sDESC = "Lucam has been contracted by the Emir of Al-Kharid to excavate a mine north of Al-Kharid in search of gems.";
			sREQU = "Prince Ali Rescue, 30 Mining.";
			break;
		case 28: 
			sNAME = "The Tourist Trap";
			sDESC = "South of Al Kharid a new desert pass has opened up, leading to the dangers of the Kharid desert.";
			sREQU = "10 Fletching, 20 Smithing";
			break;
		case 29: 
			sNAME = "The Golem";
			sDESC = "Deep in the desert sand, the ruins of the once great city of Uzer, a lone survivor—an ancient clay golem—forever paces back and forth.";
			sREQU = "20 Crafting, 20 Thieving";
			break;
		case 30: 
			sNAME = "Death Plateau";
			sDESC = "The Burthorpe Captain of the Guards is missing his scouts, he needs the know what happened and to find a safe passage through the plateau.";
			sREQU = "None";
			break;
		case 31: 
			sNAME = "Troll Stronghold";
			sDESC = "Trolls have begun to muster their forces in the North, I should speak to the Captain of the Guard.";
			sREQU = "Death Plateau, spiked boots, the ability to fight a Troll General";
			break;
	}
	if (nTYPE == 1) return sNAME;
	else if (nTYPE == 2) return sDESC;
	else return sREQU;
}

void main(string sCOMMAND, string sINPUT)
{
	object oPC = OBJECT_SELF;
	string sSCREEN = "SCREEN_JOURNAL";
	if (sCOMMAND == "UPDATE")
	{
		object oITEM = GetItemPossessedBy(oPC, "player_essence");
		int nQP = GetLocalInt(oITEM, "QUEST_POINTS");
		string sQP = "Quest Points: " + IntToString(nQP);
		SetGUIObjectText(oPC, sSCREEN, "QUEST_POINTS", -1, sQP);
		ClearListBox(oPC, sSCREEN, "INACTIVE_LISTBOX");
		int nROW;
		int nQUEST = 1;
		string sQUEST;
		string sNAME;
		string sDESC;
		string sREQU;
		string sLIST;
		string sROW;
		while (nQUEST <= QUEST_LIMIT)
		{
			sQUEST = IntToString(nQUEST);
			sNAME = GetRelevantQuestInfo(nQUEST, 1);
			if ((sNAME != "") && (GetJournalEntry(sQUEST, oPC) <= 0))
			{
				nROW = nROW + 1;
				sROW = IntToString(nROW);
				sDESC = GetRelevantQuestInfo(nQUEST, 2);
				sREQU = GetRelevantQuestInfo(nQUEST, 3);
				sLIST = "INACTIVE_NAME=" + sNAME + ";" + "INACTIVE_DESCRIPTION=" + sDESC + ";" + "INACTIVE_REQUIREMENTS=" + sREQU;
				AddListBoxRow(oPC, sSCREEN, "INACTIVE_LISTBOX", sROW, sLIST, "", "", "");
			}
			nQUEST = nQUEST + 1;
		}
	}
	else if (sCOMMAND == "INACTIVE")
	{
		if (sINPUT == "ON")
		{
			SetGUIObjectHidden(oPC, sSCREEN, "INACTIVE_PAGE", FALSE);
			SetGUIObjectHidden(oPC, sSCREEN, "INACTIVE_LISTBOX", FALSE);
		}
		else if (sINPUT == "OFF")
		{
			SetGUIObjectHidden(oPC, sSCREEN, "INACTIVE_PAGE", TRUE);
			SetGUIObjectHidden(oPC, sSCREEN, "INACTIVE_LISTBOX", TRUE);
		}
	}
}