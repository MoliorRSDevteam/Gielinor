/**/
#include "tb_skillsandxp"
#include "ginc_item"

void CreateItemsOnObject( string sTemplate, object oTarget, int nItems=1 );
int ClassLevel(int nClass, int levelCheck, object oTarget);
void main(object oPC, int quest)
{
	string item;
	switch(quest)
	{
		case 1005: //Tutorial Island
			CreateItemOnObject("hammer", oPC, 1);
			CreateItemOnObject("tinderbox", oPC, 1);
			CreateItemOnObject("smallnet", oPC, 1);
			CreateItemOnObject("bronzeaxe", oPC, 1);
			CreateItemOnObject("bronzesword", oPC, 1);
			CreateItemOnObject("bronzedagger", oPC, 1);
			CreateItemOnObject("woodenshield", oPC, 1);
			CreateItemOnObject("shortbow", oPC, 1);
			CreateItemOnObject("airrune", oPC, 25);
			CreateItemOnObject("mindrune", oPC, 25);
			CreateItemOnObject("bronzearrows", oPC, 25);
			CreateItemOnObject("bronzepickaxe", oPC, 1);
			break;
		case 1006: //Cook's Assistant
			GiveXP( oPC, "cooking", 300, 1, 1 );
			CreateItemsOnObject("sardine", oPC, 20);
			break;
		case 1007: //The Blood Ritual
			CreateItemOnObject("sacrificialblackdagger", oPC, 1);
			CreateItemOnObject("amuletofnecromancy", oPC, 1);
			break;
		case 1008: //Initiation of the Kinshra
			GiveXP( oPC, "cooking", 500, 1, 1 );
			GiveXP( oPC, "mining", 500, 1, 1 );
			GiveXP( oPC, "smithing", 500, 1, 1 );
			break;
		case 1009: //Restless Ghost
			GiveXP( oPC, "prayer", 1125, 1, 1 );
			break;
		case 1010: //Ernest the Chicken
			CreateItemsOnObject("egg", oPC, 20);
			CreateItemOnObject("feathers", oPC, 300);
			break;
		case 1014: //Goblin Diplomacy
			GiveXP( oPC, "crafting", 200, 1, 1 );
			CreateItemOnObject("goldbar", oPC, 1);
			break;
		case 1015: //Imp Catcher
			GiveXP( oPC, "runecrafting", 875, 1, 1 );
			CreateItemOnObject("amuletofaccuracy", oPC, 1);
			break;
		case 1017: //Pirates Treasure Part II
			CreateItemOnObject("emerald", oPC, 1);
			CreateItemOnObject("goldring", oPC, 1);
			break;
		case 1018: //Dorics Quest
			GiveXP( oPC, "mining", 1800, 1, 1);
			break;
		case 1042: //Rune Mysteries Part II
			GiveXP( oPC, "runecrafting", 500, 1, 1 );
			CreateItemOnObject("bookofenchanting", oPC, 1);
		case 1021: //Demon slayer part IV
			CreateItemOnObject("silverlightsword", oPC, 1);
			break;
		case 1023: //Vampyre Slayer Part II
			//plugin gives xp
			break;
		case 1028: //Prince Ali Rescue Part V
			//finished quest check in guard convo for free entry
			break;
		case 1029: //Risky Business
			CreateItemOnObject("shroudedbody", oPC, 1);
			break;
		case 1030: //Initiation of the White Knights
			GiveXP( oPC, "cooking", 500, 1, 1 );
			GiveXP( oPC, "mining", 500, 1, 1 );
			GiveXP( oPC, "smithing", 500, 1, 1 );
			break;
		case 1031: //Sheep Shearer
			GiveXP( oPC, "crafting", 300, 1, 1 );
			break;
		case 1032: //Witch's Potion
			GiveXP( oPC, "runecrafting", 325, 1, 1 );
			break;
		case 1034: //A Helping Hand Part II
			GiveXP( oPC, "smithing", 12725, 1, 1 );
			break;
		case 1035: //The Patriarch
		//	Access to Blurite smithing. Blurite smithing. Runite and Blurite ore veins.
			break;
		case 1036: //Champion of South Misthalin
			CreateItemOnObject("lumbridgeheraldcape", oPC, 1);
			break;
		case 1037: //Champion of Asgarnia
			CreateItemOnObject("faladorheraldcape", oPC, 1);
			break;
		case 1038: //Champion of North Misthalin
			CreateItemOnObject("varrockheraldcape", oPC, 1);
			break;
		case 1039: //Becoming a Champion
			break;
	}
	//SaveDB(oPC, 1);
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
int ClassLevel(int nClass, int levelCheck, object oTarget)
{
    //object oTarget = GetTarget(sTarget, oPC);
	return (GetLevelByClass(nClass, oTarget) > levelCheck);
}