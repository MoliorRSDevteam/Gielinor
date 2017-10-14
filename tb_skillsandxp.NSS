/* @Triston 10/11/15 Skilling System
 * Stores the xp on player and updates levels
 * (11/23/2015) included persistent vars for server
 * (12/03/2015) included popup info on levelup
 * (12/04/2015) Legends team made us persistent
 	-tb_savexp and tb_loadxp
*/

#include "tb_animpc"
#include "tb_database"
#include "ginc_param_const"

//Triston: Skill Constant
const int SKILL_AGILITY = 5;
const int SKILL_FISHING = 30;
const int SKILL_COOKING = 31;
const int SKILL_FIREMAKING = 32;
const int SKILL_SMITHING = 33;
const int SKILL_WOODCUTTING = 34;
const int SKILL_MINING = 35;
const int SKILL_RUNECRAFTING = 36;
const int SKILL_CRAFTING = 37;
const int SKILL_PRAYER = 38;
const int SKILL_FLETCHING = 39;
const int SKILL_SLAYER = 40;
const int SKILL_FARMING = 41;
const int SKILL_THIEVING = 42;
const int SKILL_HUNTER = 43;
const int SKILL_CONSTRUCTION = 44;

const int XP_RATE = 1; // Skill XP Multiplier

//for skilling scripts
int GetLevel(int xp);

void UpdateLevel(object oPC, int level, int skillnum, string skill);


void PlayJingle(object oPC, string sound, float length)
{
    //object oArea = GetArea(oPC);
	object fx = CreateObject(GetObjectTypes("V"), "fx_gem_energy_blue", GetLocation(oPC));
	//muted everyone's music and ambients in server
	//MusicBackgroundStop(oArea); 
	//AmbientSoundStop(oArea);
	DelayCommand(0.5, AssignCommand(oPC, PlaySound(sound, TRUE)));
	//length += 0.5;
	//DelayCommand(length, MusicBackgroundPlay(oArea));
	//DelayCommand(length, AmbientSoundPlay(oArea));
	DelayCommand(1.0, DestroyObject(fx));
}

void GiveXP(object oPC, string skill, int xp, int multiplier = XP_RATE, int forcesave = 0)
{
	int newXp;
	//SendMessageToPC(oPC, "<color=white>" + "XPMultiplier: " + IntToString(XP_RATE) + "x; XPDrop: " + IntToString(xp*multiplier));
	
	//Remaining skills
	//Agility, Herblore, 	Ranged, Thieving,
	//Magic, Fletching,  Slayer, Farming
	//Construction, Hunter  Attack, Hitpoints,
	//Strength, Defense,
	if (skill == "fishing")
	{
		newXp = GetLocalInt(oPC, "fishingxp") + xp*multiplier;
		SetLocalInt(oPC, "fishingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FISHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalFishing: " + IntToString(newXp));
	}
	if (skill == "cooking")
	{
		newXp = GetLocalInt(oPC, "cookingxp") + xp*multiplier;
		SetLocalInt(oPC, "cookingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_COOKING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalCooking: " + IntToString(newXp));
	}
	if (skill == "firemaking")
	{
		newXp = GetLocalInt(oPC, "firemakingxp") + xp*multiplier;
		SetLocalInt(oPC, "firemakingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FIREMAKING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalFiremaking: " + IntToString(newXp));
	}
	if (skill == "woodcutting")
	{
		newXp = GetLocalInt(oPC, "woodcuttingxp") + xp*multiplier;
		SetLocalInt(oPC, "woodcuttingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_WOODCUTTING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalWoodcutting: " + IntToString(newXp));
	}
	if (skill == "mining")
	{
		newXp = GetLocalInt(oPC, "miningxp") + xp*multiplier;
		SetLocalInt(oPC, "miningxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_MINING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalMining: " + IntToString(newXp));
	}
	if (skill == "smithing")
	{
		newXp = GetLocalInt(oPC, "smithingxp") + xp*multiplier;
		SetLocalInt(oPC, "smithingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_SMITHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalSmithing: " + IntToString(newXp));
	}
	if (skill == "prayer")
	{
		newXp = GetLocalInt(oPC, "prayerxp") + xp*multiplier;
		SetLocalInt(oPC, "prayerxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_PRAYER, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalPrayer: " + IntToString(newXp));
	}
	if (skill == "runecrafting")
	{
		newXp = GetLocalInt(oPC, "runecraftingxp") + xp*multiplier;
		SetLocalInt(oPC, "runecraftingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_RUNECRAFTING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalRunecrafting: " + IntToString(newXp));
	}
	if (skill == "crafting")
	{
		newXp = GetLocalInt(oPC, "craftingxp") + xp*multiplier;
		SetLocalInt(oPC, "craftingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_CRAFTING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalCrafting: " + IntToString(newXp));
	}
	if (skill == "fletching")
	{
		newXp = GetLocalInt(oPC, "fletchingxp") + xp*multiplier;
		SetLocalInt(oPC, "fletchingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalFletching: " + IntToString(newXp));
	}
	if (skill == "slayer")
	{
		newXp = GetLocalInt(oPC, "slayerxp") + xp*multiplier;
		SetLocalInt(oPC, "slayerxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalSlayer: " + IntToString(newXp));
	}
	if (skill == "farming")
	{
		newXp = GetLocalInt(oPC, "farmingxp") + xp*multiplier;
		SetLocalInt(oPC, "farmingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalFarming: " + IntToString(newXp));
	}
	if (skill == "herblore")
	{
		newXp = GetLocalInt(oPC, "herblorexp") + xp*multiplier;
		SetLocalInt(oPC, "herblorexp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalHerblore: " + IntToString(newXp));
	}
	if (skill == "thieving")
	{
		newXp = GetLocalInt(oPC, "thievingxp") + xp*multiplier;
		SetLocalInt(oPC, "thievingxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalThieving: " + IntToString(newXp));
	}
	if (skill == "hunter")
	{
		newXp = GetLocalInt(oPC, "hunterxp") + xp*multiplier;
		SetLocalInt(oPC, "hunterxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalHunter: " + IntToString(newXp));
	}
	if (skill == "construction")
	{
		newXp = GetLocalInt(oPC, "constructionxp") + xp*multiplier;
		SetLocalInt(oPC, "constructionxp", newXp);
		UpdateLevel(oPC, GetLevel(newXp), SKILL_FLETCHING, skill);
		SendMessageToPC(oPC, "<color=white>" + "XPTotalConstruction: " + IntToString(newXp));
	}
			
		//debatable
			//summoning
	
	SaveDB(oPC, forcesave);
}

void UpdateLevel(object oPC, int level, int skillnum, string skill)
{
	if (level > GetSkillRank(skillnum, oPC))
	{
		SetBaseSkillRank(oPC, skillnum, level, FALSE);
		//Throw info on all the player's new activities for this skill into one string
		string sInfo = "";
		string metalName = "Bronze ";
		string xRune = "";
		switch (skillnum)
		{
			case SKILL_WOODCUTTING :
				PlayJingle(oPC, "Woodcutting_Level_up_2", 5.5);
				skill = "Woodcutting";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				//Axes
				sInfo += (level == 6) ? "You can now use; Steel Axes.\n" : "";
				sInfo += (level == 21) ? "You can now use; Mithril Axes.\n" : "";
				sInfo += (level == 31) ? "You can now use; Adamant Axes.\n" : "";
				sInfo += (level == 41) ? "You can now use; Rune Axes.\n" : "";
				sInfo += (level == 61) ? "You can now use; Dragon Axes.\n" : "";
				sInfo += "\n\n";
				//Logs
				sInfo += (level == 15) ? "You can now cut; Oak stumps.\n" : "";
				sInfo += (level == 30) ? "You can now cut; Willow stumps.\n" : "";
				sInfo += (level == 45) ? "You can now cut; Maple stumps.\n" : "";
				sInfo += (level == 60) ? "You can now cut; Yew stumps.\n" : "";
				sInfo += (level == 75) ? "You can now cut; Magic stumps.\n" : "";
				break;
			case SKILL_SMITHING :
				PlayJingle(oPC, "Smithing_Level_up", 4.0);
				skill = "Smithing";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				//Smelting
				sInfo += (level == 8) ? "You can now smelt; Blurite bars.\n" : "";
				sInfo += (level == 10) ? "You can now smelt; Iron bars.\n" : "";
				sInfo += (level == 20) ? "You can now smelt; Silver bars.\n" : "";
				sInfo += (level == 20) ? "You can now smelt; Steel bars.\n" : "";
				sInfo += (level == 30) ? "You can now smelt; Mithril bars.\n" : "";
				sInfo += (level == 40) ? "You can now smelt; Gold bars.\n" : "";
				sInfo += (level == 40) ? "You can now smelt; Adamant bars.\n" : "";
				sInfo += (level == 50) ? "You can now smelt; Rune bars.\n" : "";
				sInfo += (level == 65) ? "You can now repair the Odium & Malediction ward" : "";
				//Smithing
				metalName = (level >= 10) ? "Iron " : metalName;
				metalName = (level >= 20) ? "Steel " : metalName;
				metalName = (level >= 30) ? "Mithril " : metalName;
				metalName = (level >= 40) ? "Adamant " : metalName;
				metalName = (level >= 50) ? "Rune " : metalName;
				//					Bronze		  Iron			 Steel			Mithril		   Adamant		  Rune
				sInfo += (level == 				  10 || level == 20 || level == 30 || level == 40 || level == 50) ? "You can now smith; "+metalName+"Daggers." : "";
				sInfo += (level == 				  10 || level == 20 || level == 30 || level == 40 || level == 50) ? "You can now smith; "+metalName+"Axes." : "";
				sInfo += (level ==  2 || level == 11 || level == 21 || level == 31 || level == 41 || level == 51) ? "You can now smith; "+metalName+"Maces." : "";
				sInfo += (level ==  2 || level == 11 || level == 21 || level == 31 || level == 41 || level == 51) ? "You can now smith; "+metalName+"Medium Helmets." : "";
				sInfo += (level ==  3 || level == 12 || level == 22 || level == 32 || level == 42 || level == 52) ? "You can now smith; "+metalName+"Swords." : "";
				sInfo += (level ==  3 || level == 12 || level == 22 || level == 32 || level == 42 || level == 52) ? "You can now smith; "+metalName+"Scimitars." : "";
				sInfo += (level ==  4 || level == 13 || level == 23 || level == 33 || level == 43 || level == 53) ? "You can now smith; "+metalName+"Longswords." : "";
				sInfo += (level ==  4 || level == 13 || level == 23 || level == 33 || level == 43 || level == 53) ? "You can now smith; "+metalName+"Helmets." : "";
				sInfo += (level ==  5 || level == 14 || level == 24 || level == 34 || level == 44 || level == 54) ? "You can now smith; "+metalName+"Square Shields." : "";
				sInfo += (level ==  6 || level == 15 || level == 25 || level == 35 || level == 45 || level == 55) ? "You can now smith; "+metalName+"Warhammers." : "";
				sInfo += (level == 	7 || level == 16 || level == 26 || level == 36 || level == 46 || level == 56) ? "You can now smith; "+metalName+"Battleaxes." : "";
				sInfo += (level == 	8 || level == 17 || level == 27 || level == 37 || level == 47 || level == 57) ? "You can now smith; "+metalName+"Chainbodies." : "";
				sInfo += (level == 	9 || level == 18 || level == 28 || level == 38 || level == 48 || level == 58) ? "You can now smith; "+metalName+"Kite Shields." : "";
				sInfo += (level == 10 || level == 19 || level == 29 || level == 39 || level == 49 || level == 59) ? "You can now smith; "+metalName+"2h Swords." : "";
				sInfo += (level == 10 || level == 20 || level == 30 || level == 40 || level == 50 || level == 60) ? "You can now smith; "+metalName+"Plate Armor." : "";
				sInfo += "\n\n";
				break;
			case SKILL_RUNECRAFTING :
				PlayJingle(oPC, "Runecrafting_Level_up_2", 6.0);
				skill = "Runecrafting";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				//multiples
				if (level == 14 || level == 35 || level == 44)
				{//these match with normals and would have caused a bug
					sInfo += (level == 14) ? "You can now craft; 2x Mind runes.\n" : "";
					sInfo += (level == 35) ? "You can now craft; 2x Fire runes.\n" : "";
					sInfo += (level == 44) ? "You can now craft; 5x Air runes.\n" : "";
				}
				else 
				{//the rest of the table
					xRune = (level == 11 || 			   level == 19 || level == 26 || 				level == 46 || level == 59 || level == 74 || level == 82 || level == 91) ? "2x " : xRune;
					xRune = (level == 28 || level == 38 || level == 52 || level == 70 || level == 92) ? "3x " : xRune;
					xRune = (level == 33 || level == 42 || level == 57 || level == 78) ? "4x " : xRune;
					xRune = (				level == 56 || level == 76) ? "5x " : xRune;
					xRune = (level == 55 || level == 70 || level == 95) ? "6x " : xRune;
					xRune = (level == 66 || level == 84) ? "7x " : xRune;
					xRune = (level == 77 || level == 98) ? "8x " : xRune;
					xRune = (level == 88) ? "9x " : xRune;
					xRune = (level == 99) ? "10x " : xRune;
				}
				//normals
				sInfo += (level == 2)  ? "You can now craft; "+xRune+"Mind runes.\n" : "";
				sInfo += (level == 5)  ? "You can now craft; "+xRune+"Water runes.\n" : "";
				sInfo += (level == 9)  ? "You can now craft; "+xRune+"Earth runes.\n" : "";
				sInfo += (level == 14) ? "You can now craft; "+xRune+"Fire runes.\n" : "";
				sInfo += (level == 20) ? "You can now craft; "+xRune+"Body runes.\n" : "";
				sInfo += (level == 27) ? "You can now craft; "+xRune+"Cosmic runes.\n" : "";
				sInfo += (level == 35) ? "You can now craft; "+xRune+"Chaos runes.\n" : "";
				sInfo += (level == 40) ? "You can now craft; "+xRune+"Astral runes.\n" : "";
				sInfo += (level == 44) ? "You can now craft; "+xRune+"Nature runes.\n" : "";
				sInfo += (level == 54) ? "You can now craft; Law runes.\n" : "";
				sInfo += (level == 65) ? "You can now craft; Death runes.\n" : "";
				sInfo += "\n\n";
				break;
			case SKILL_PRAYER :
				PlayJingle(oPC, "Prayer_Level_up_1", 6.0);
				skill = "Prayer";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				sInfo += (level == 4)  ? "You have unlocked; Burst of Strength.\n" : "";
				sInfo += (level == 8)  ? "You have unlocked; Sharp Eye.\n" : "";
				sInfo += (level == 9)  ? "You have unlocked; Mystic Will.\n" : "";
				sInfo += (level == 13) ? "You have unlocked; Superhuman Strength.\n" : "";
				sInfo += (level == 26) ? "You have unlocked; Hawk Eye.\n" : "";
				sInfo += (level == 27) ? "You have unlocked; Mystic Lore.\n" : "";
				sInfo += (level == 31) ? "You have unlocked; Ultimate Strength.\n" : "";
				sInfo += (level == 44) ? "You have unlocked; Eagle Eye.\n" : "";
				sInfo += (level == 45) ? "You have unlocked; Mystic Might.\n" : "";
				sInfo += "\n\n";
				break;
			case SKILL_MINING :
				PlayJingle(oPC, "Mining_Level_up", 6.0);
				skill = "Mining";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				//Pickaxes
				sInfo += (level == 21)  ? "You can now use; Steel Pickaxes.\n" : "";
				sInfo += (level == 31) ? "You can now use; Mithril Pickaxes.\n" : "";
				sInfo += (level == 41) ? "You can now use; Adamant Pickaxes.\n" : "";
				sInfo += (level == 51) ? "You can now use; Rune Pickaxes.\n" : "";
				sInfo += (level == 61) ? "You can now use; Dragon Pickaxes.\n" : "";
				//Ores
				sInfo += (level == 10) ? "You can now mine; Blurite ore.\n" : "";
				sInfo += (level == 10) ? "You can now mine; Iron ore.\n" : "";
				sInfo += (level == 20) ? "You can now mine; Silver ore.\n" : "";
				sInfo += (level == 20) ? "You can now mine; Coal ore.\n" : "";
				sInfo += (level == 30) ? "You can now mine; Gold ore.\n" : "";
				sInfo += (level == 30) ? "You can now mine; Mithril ore.\n" : "";
				sInfo += (level == 40) ? "You can now mine; Adamantine ore.\n" : "";
				sInfo += (level == 50) ? "You can now mine; Runite ore.\n" : "";
				sInfo += "\n\n";
				break;
			case SKILL_FIREMAKING :
				PlayJingle(oPC, "Firemaking_Level_up_1", 5.0);
				skill = "Firemaking";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				sInfo += (level == 15) ? "You can now burn; Oak logs.\n" : "";
				sInfo += (level == 20) ? "You can now light torches.\n" : "";
				sInfo += (level == 30) ? "You can now burn; Willow logs.\n" : "";
				sInfo += (level == 45) ? "You can now burn; Maple logs.\n" : "";
				sInfo += (level == 60) ? "You can now burn; Yew logs.\n" : "";
				sInfo += (level == 75) ? "You can now burn; Magic logs.\n" : "";
				sInfo += "\n\n";
				break;
			case SKILL_FISHING :
				PlayJingle(oPC, "Fishing_Level_up_2", 5.0);
				skill = "Fishing";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				sInfo += (level == 5) ? "You can now catch; Sardines.\n" : "";
				sInfo += (level == 10) ? "You can now catch; Herring.\n" : "";
				sInfo += (level == 15) ? "You can now catch; Anchovies.\n" : "";
				sInfo += (level == 16) ? "You can now catch; Mackerel.\n" : "";
				sInfo += (level == 20) ? "You can now catch; Trout.\n" : "";
				sInfo += (level == 23) ? "You can now catch; Cod.\n" : "";
				sInfo += (level == 25) ? "You can now catch; Pike.\n" : "";
				sInfo += (level == 30) ? "You can now catch; Salmon.\n" : "";
				sInfo += (level == 35) ? "You can now catch; Tuna.\n" : "";
				sInfo += (level == 40) ? "You can now catch; Lobster.\n" : "";
				sInfo += (level == 46) ? "You can now catch; Bass.\n" : "";
				sInfo += (level == 50) ? "You can now catch; Swordfish.\n" : "";
				sInfo += (level == 62) ? "You can now catch; Monkfish.\n" : "";
				sInfo += (level == 76) ? "You can now catch; Shark.\n" : "";
				sInfo += "\n\n";
				break;
			case SKILL_CRAFTING :
				PlayJingle(oPC, "Crafting_Level_up_1", 7.0);
				skill = "Crafting";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				//Spinning
				sInfo += (level == 10) ? "You have unlocked; Bowstring.\n" : "";
				//Pottery
				sInfo += (level == 7)  ? "You have unlocked; Pie dish.\n" : "";
				sInfo += (level == 8)  ? "You have unlocked; Bowl.\n" : "";
				//Armor
				sInfo += (level == 7)  ? "You have unlocked; Leather boots.\n" : "";
				sInfo += (level == 9)  ? "You have unlocked; Cowl.\n" : "";
				sInfo += (level == 11) ? "You have unlocked; Leather vambraces.\n" : "";
				sInfo += (level == 14) ? "You have unlocked; Leather body.\n" : "";
				sInfo += (level == 28) ? "You have unlocked; Hard leather body.\n" : "";
				sInfo += (level == 38) ? "You have unlocked; Coif.\n" : "";
				sInfo += (level == 41) ? "You have unlocked; Studded body.\n" : "";
				sInfo += (level == 57) ? "You have unlocked; Green d'hide vambraces.\n" : "";
				sInfo += (level == 63) ? "You have unlocked; Green d'hide body.\n" : "";
				//RS3 armor
				sInfo += (level == 10)  ? "You have unlocked; Imphide gloves.\n" : "";
				sInfo += (level == 11)  ? "You have unlocked; Imphide boots.\n" : "";
				sInfo += (level == 12)  ? "You have unlocked; Imphide hood.\n" : "";
				sInfo += (level == 14)  ? "You have unlocked; Imphide robes.\n" : "";
				sInfo += (level == 20)  ? "You have unlocked; Spidersilk gloves.\n" : "";
				sInfo += (level == 21)  ? "You have unlocked; Spidersilk boots.\n" : "";
				sInfo += (level == 22)  ? "You have unlocked; Spidersilk hood.\n" : "";
				sInfo += (level == 24)  ? "You have unlocked; Spidersilk robes.\n" : "";
				sInfo += (level == 30)  ? "You have unlocked; Carapace gloves.\n" : "";
				sInfo += (level == 31)  ? "You have unlocked; Carapace boots.\n" : "";
				sInfo += (level == 33)  ? "You have unlocked; Carapace helm.\n" : "";
				sInfo += (level == 35)  ? "You have unlocked; Carapace torso.\n" : "";
				//Gems
				sInfo += (level == 20) ? "You have unlocked; Sapphire.\n" : "";
				sInfo += (level == 27) ? "You have unlocked; Emerald.\n" : "";
				sInfo += (level == 34) ? "You have unlocked; Ruby.\n" : "";
				sInfo += (level == 43) ? "You have unlocked; Diamond.\n" : "";
				sInfo += (level == 55) ? "You have unlocked; Dragonstone.\n" : "";
				sInfo += (level == 67) ? "You have unlocked; Onyx.\n" : "";
				//Jewellery
				sInfo += (level == 16) ? "You can now make; Holy Symbol.\n" : "";
				sInfo += (level == 5)  ? "You can now make; Gold Rings.\n" : "";
				sInfo += (level == 6)  ? "You can now make; Gold Necklaces.\n" : "";
				sInfo += (level == 8)  ? "You can now make; Gold amulets.\n" : "";
				sInfo += (level == 20) ? "You can now make; Sapphire Rings.\n" : "";
				sInfo += (level == 22) ? "You can now make; Sapphire Necklaces.\n" : "";
				sInfo += (level == 24) ? "You can now make; Sapphire Amulets.\n" : "";
				sInfo += (level == 27) ? "You can now make; Emerald Rings.\n" : "";
				sInfo += (level == 29) ? "You can now make; Emerald Necklaces.\n" : "";
				sInfo += (level == 31) ? "You can now make; Emerald Amulets.\n" : "";
				sInfo += (level == 34) ? "You can now make; Ruby Rings.\n" : "";
				sInfo += (level == 40) ? "You can now make; Ruby Necklaces.\n" : "";
				sInfo += (level == 50) ? "You can now make; Ruby Amulets.\n" : "";
				sInfo += (level == 43) ? "You can now make; Diamond Rings.\n" : "";
				sInfo += (level == 56) ? "You can now make; Diamond Necklaces.\n" : "";
				sInfo += (level == 70) ? "You can now make; Diamond Amulets.\n" : "";
				sInfo += (level == 55) ? "You can now make; Dragonstone Rings.\n" : "";
				sInfo += (level == 72) ? "You can now make; Dragonstone Necklaces.\n" : "";
				sInfo += (level == 80) ? "You can now make; Dragonstone Amulets.\n" : "";
				sInfo += (level == 67) ? "You can now make; Onyx Rings.\n" : "";
				sInfo += (level == 82) ? "You can now make; Onyx Necklaces.\n" : "";
				sInfo += (level == 90) ? "You can now make; Onyx Amulets.\n" : "";
				sInfo += "\n\n";
				break;
			case SKILL_COOKING :
				PlayJingle(oPC, "Cooking_Level_up_1", 3.5);
				skill = "Cooking";
				sInfo += "Congratulations! you've just advanced a "+skill+" level!\n\n";
				sInfo += "Your "+skill+" level is now "+IntToString(level)+"!\n\n";
				//fish
				sInfo += (level == 5)  ? "You can now cook; Raw Herring.\n" : "";
				sInfo += (level == 10) ? "You can now cook; Raw Mackerel.\n" : "";
				sInfo += (level == 15) ? "You can now cook; Raw Trout.\n" : "";
				sInfo += (level == 18) ? "You can now cook; Raw Cod.\n" : "";
				sInfo += (level == 20) ? "You can now cook; Raw Pike.\n" : "";
				sInfo += (level == 25) ? "You can now cook; Raw Salmon.\n" : "";
				sInfo += (level == 30) ? "You can now cook; Raw Tuna.\n" : "";
				sInfo += (level == 40) ? "You can now cook; Raw Lobster.\n" : "";
				sInfo += (level == 43) ? "You can now cook; Raw Bass.\n" : "";
				sInfo += (level == 45) ? "You can now cook; Raw Swordfish.\n" : "";
				sInfo += (level == 62) ? "You can now cook; Raw Monkfish.\n" : "";
				sInfo += (level == 80) ? "You can now cook; Raw Shark.\n" : "";
				sInfo += "\n\n";
				break;
		}
		SendMessageToPC(oPC, "<color=white>" + "Your " + skill + " level is now " + IntToString(level)+"!");
		
		//Display combined info in the closing of the update
		if (sInfo != "")
		{
			LEG_COMMON_DisplayInfoBox(oPC, sInfo, 0, 0, 2);
		}
		sInfo = ""; //resetting the skills feedback info
	}
}

int GetLevel(int xp)
{
	int level;
	if (xp >= 13034431)
	{
		level = 99;
	}else if (xp >= 11805606)
	{
		level = 98;
	}else if (xp >= 10692629)
	{
		level = 97;
	}else if (xp >=  9684577)
	{
		level = 96;
	}else if (xp >= 8771558 )
	{
		level = 95;
	}else if (xp >= 7944614)
	{
		level = 94;
	}else if (xp >= 7195629)
	{
		level = 93;
	}else if (xp >= 6517253)
	{
		level = 92;
	}else if (xp >= 5902831)
	{
		level = 91;
	}else if (xp >= 5346332)
	{
		level = 90;
	}else if (xp >= 4842295)
	{
		level = 89;
	}else if (xp >= 4386776)
	{
		level = 88;
	}else if (xp >= 3972294)
	{
		level = 87;
	}else if (xp >= 3597792)
	{
		level = 86;
	}else if (xp >= 3258594)
	{
		level = 85;
	}else if (xp >= 2951373)
	{
		level = 84;
	}else if (xp >= 2673114)
	{
		level = 83;
	}else if (xp >= 2421087)
	{
		level = 82;
	}else if (xp >= 2192818)
	{
		level = 81;
	}else if (xp >= 1986068)
	{
		level = 80;
	}else if (xp >= 1798808)
	{
		level = 79;
	}else if (xp >= 1629200)
	{
		level = 78;
	}else if (xp >= 1475781)
	{
		level = 77;
	}else if (xp >= 1336443)
	{
		level = 76;
	}else if (xp >= 1210421)
	{
		level = 75;
	}else if (xp >= 1096278)
	{
		level = 74;
	}else if (xp >= 992895)
	{
		level = 73;
	}else if (xp >=899257)
	{
		level = 72;
	}else if (xp >= 814445)
	{
		level = 71;
	}else if (xp >= 737627)
	{
		level = 70;
	}else if (xp >= 668051)
	{
		level = 69;
	}else if (xp >= 605032)
	{
		level = 68;
	}else if (xp >= 547953)
	{
		level = 67;
	}else if (xp >= 496254)
	{
		level = 66;
	}else if (xp >= 449428)
	{
		level = 65;
	}else if (xp >= 407015)
	{
		level = 64;
	}else if (xp >= 368599)
	{
		level = 63;
	}else if (xp >= 333804)
	{
		level = 62;
	}else if (xp >= 302288)
	{
		level = 61;
	}else if (xp >= 273742)
	{
		level = 60;
	}else if (xp >= 247886)
	{
		level = 59;
	}else if (xp >= 224466)
	{
		level = 58;
	}else if (xp >= 203254)
	{
		level = 57;
	}else if (xp >= 184040)
	{
		level = 56;
	}else if (xp >= 166636)
	{
		level = 55;
	}else if (xp >= 150872)
	{
		level = 54;
	}else if (xp >= 136594)
	{
		level = 53;
	}else if (xp >= 123660)
	{
		level = 52;
	}else if (xp >= 111945)
	{
		level = 51;
	}else if (xp >= 101333)
	{
		level = 50;
	}else if (xp >= 91721)
	{
		level = 49;
	}else if (xp >= 83014)
	{
		level = 48;
	}else if (xp >= 75127)
	{
		level = 47;
	}else if (xp >= 67983)
	{
		level = 46;
	}else if (xp >= 61512)
	{
		level = 45;
	}else if (xp >= 55649)
	{
		level = 44;
	}else if (xp >= 50339)
	{
		level = 43;
	}else if (xp >= 45529)
	{
		level = 42;
	}else if (xp >= 41171)
	{
		level = 41;
	}else if (xp >= 37224)
	{
		level = 40;
	}else if (xp >= 33648)
	{
		level = 39;
	}else if (xp >= 30408)
	{
		level = 38;
	}else if (xp >= 27473)
	{
		level = 37;
	}else if (xp >= 24815)
	{
		level = 36;
	}else if (xp >= 22406)
	{
		level = 35;
	}else if (xp >= 20224)
	{
		level = 34;
	}else if (xp >= 18247)
	{
		level = 33;
	}else if (xp >= 16456)
	{
		level = 32;
	}else if (xp >= 14833)
	{
		level = 31;
	}else if (xp >= 13363)
	{
		level = 30;
	}else if (xp >= 12031)
	{
		level = 29;
	}else if (xp >= 10824)
	{
		level = 28;
	}else if (xp >= 9730)
	{
		level = 27;
	}else if (xp >= 8790)
	{
		level = 26;
	}else if (xp >= 7842)
	{
		level = 25;
	}else if (xp >= 7028)
	{
		level = 24;
	}else if (xp >= 6291)
	{
		level = 23;
	}else if (xp >= 5624)
	{
		level = 22;
	}else if (xp >= 5018)
	{
		level = 21;
	}else if (xp >= 4470)
	{
		level = 20;
	}else if (xp >= 3973)
	{
		level = 19;
	}else if (xp >= 3523)
	{
		level = 18;
	}else if (xp >= 3115)
	{
		level = 17;
	}else if (xp >= 2746)
	{
		level = 16;
	}else if (xp >= 2411)
	{
		level = 15;
	}else if (xp >= 2107)
	{
		level = 14;
	}else if (xp >= 1833)
	{
		level = 13;
	}else if (xp >= 1584)
	{
		level = 12;
	}else if (xp >= 1358)
	{
		level = 11;
	}else if (xp >= 1154)
	{
		level = 10;
	}else if (xp >= 969)
	{
		level = 9;
	}else if (xp >= 801)
	{
		level = 8;
	}else if (xp >= 650)
	{
		level = 7;
	}else if (xp >= 512)
	{
		level = 6;
	}else if (xp >= 388)
	{
		level = 5;
	}else if (xp >= 276)
	{
		level = 4;
	}else if (xp >= 174)
	{
		level = 3;
	}
	else if (xp >= 83)
	{
		level = 2;
	}else if (xp >= 0)
	{
		level = 1;
	}
	return level;
}