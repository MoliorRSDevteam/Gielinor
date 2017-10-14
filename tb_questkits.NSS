#include "tb_skillsandxp"
void CreateItemsOnObject( string sTemplate, object oTarget, int nItems=1 );
void main(int quest)
{
	object oPC = GetLastUsedBy();
	//int quest = GetLocalInt(OBJECT_SELF, "quest");
	switch(quest)
	{
		case 0: //Cook's Assistant
			CreateItemOnObject("egg", oPC, 1);
			CreateItemOnObject("potofflour", oPC, 1);
			CreateItemOnObject("bucketofmilk", oPC, 1);
			break;
		case 1: //The Blood Ritual
			break;
		case 2: //Initiation of the Kinshra
			break;
		case 3: //Restless Ghost
			break;
		case 4: //Ernest the Chicken
			CreateItemOnObject("rubbertube", oPC, 1);
			CreateItemOnObject("poisonousfishfood", oPC, 1);
			break;
		case 5: //Goblin Diplomacy
			CreateItemOnObject("bluegoblinmail", oPC, 1);
			CreateItemOnObject("orangegoblinmail", oPC, 1);
			CreateItemOnObject("browngoblinmail", oPC, 1);
			break;
		case 6: //Imp Catcher
			CreateItemOnObject("redbead", oPC, 1);
			CreateItemOnObject("yellowbead", oPC, 1);
			CreateItemOnObject("whitebead", oPC, 1);
			CreateItemOnObject("blackbead", oPC, 1);
			break;
		case 7: //Pirates Treasure Part II
			CreateItemsOnObject("banana", oPC, 10);
			break;
		case 8: //Dorics Quest
			CreateItemsOnObject("copperore", oPC, 4);
			CreateItemsOnObject("clay", oPC, 6);
			CreateItemsOnObject("ironore", oPC, 2);
			break;
		case 9: //Rune Mysteries Part II
			break;
		case 10: //Vampyre Slayer Part II
			break;
		case 11: //Risky Business
			break;
		case 12: //Initiation of the White Knights
			break;
		case 13: //Sheep Shearer
			CreateItemsOnObject("ballofwool", oPC, 20);
			break;
		case 14: //Witch's Potion
			CreateItemOnObject("rattail", oPC, 1);
			CreateItemOnObject("eyeofnewt", oPC, 1);
			CreateItemOnObject("burntmeat", oPC, 1);
			CreateItemOnObject("onion", oPC, 1);
			break;
		case 15: //A Helping Hand Part II
			break;
		case 16: //The Patriarch
			break;
		case 17: //Champion of South Misthalin
			break;
		case 18: //Champion of Asgarnia
			break;
		case 19: //Champion of North Misthalin
			break;
		case 20: //Becoming a Champion
			break;
		case 21: //TBA
			break;
		case 22: //Demon slayer part IV
			break;
		case 23: //Prince Ali Rescue Part V
			CreateItemsOnObject("ballofwool", oPC, 7);
			CreateItemOnObject("softclay", oPC, 1);
			CreateItemOnObject("pinkskirt", oPC, 1);
			CreateItemsOnObject("beer", oPC, 3);
			CreateItemOnObject("yellowdye", oPC, 1);
			CreateItemOnObject("redberries", oPC, 1);
			CreateItemOnObject("potofflour", oPC, 1);
			CreateItemOnObject("ashes", oPC, 1);
			CreateItemOnObject("bucketofwater", oPC, 1);
			CreateItemOnObject("bronzebar", oPC, 1);
			break;
	}
}
void CreateItemsOnObject( string sTemplate, object oTarget, int nItems=1 )
{
	int i = 1;
	while ( i <= nItems )
	{
		CreateItemOnObject( sTemplate, oTarget, 1 );
		i++;
	}
}