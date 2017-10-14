#include "tb_questinclude"
#include "tb_questbook"
#include "tb_persistents"
#include "tb_skillsandxp"
#include "tb_magic"

// //////////////////////////////////////////////////
// LEG_COMMON_DisplayInfoBox
// //////////////////////////////////////////////////
void GiveRewards(object oPC, string questTag);
void ProgressQuest(object oPC, string questTag)
{
	RunQBook(questTag);
	TBSetPersistentInt(oPC, questTag, GetLocalInt(oPC, questTag)+1);
	LEG_COMMON_DisplayInfoBox(oPC, "Quest Updated: " + sTitle);
	PlaySound("gui_journaladd");
}
void FinishQuest(object oPC, string questTag = "", int legID = -1)
{
	questTag = (questTag == "") ? LegIDToQTag(legID) : questTag;
	if (GetLocalInt(oPC,questTag) == 999)return; //some reason we've completed this already
	RunQBook(questTag);
	GiveRewards(oPC, questTag);
	int ix;
	for (ix = 1; ix < 100; ix++)
	{
		DoFinishAction(oPC, questTag, ix);
	}
	if (legID == -1) //not uing legends
	{
		//close the gui
		CloseGUIScreen(oPC, "leg_quest_finish");
		// Tell our hearty adventurer what we've just done.
		LEG_COMMON_DisplayInfoBox(oPC, "Quest Complete: " + sTitle);
		PlaySound("gui_quest_done");
	}
	//Set the journal variable to finish number
	//SendMessageToPC(oPC, questTag+"Quest step: " + IntToString(GetLocalInt(oPC, questTag)));
	//Triston save persistent quest
	TBSetPersistentInt(oPC, questTag, 999);
	//SendMessageToPC(oPC, questTag+"Quest step: " + IntToString(GetLocalInt(oPC, questTag)));
	//Triston save persistent quest points
	TBSetPersistentInt(oPC, "TBquestpoints", TBGetPersistentInt(oPC, "TBquestpoints", 1)+questPoints);
	//SetPersistentInt(oPC, "questpoints", GetPersistentInt(oPC, "questpoints")+questPoints);
}
void CreateItemsOnObject( string sTemplate, object oTarget, int nItems=1 );
int ClassLevel(int nClass, int levelCheck, object oTarget);
void GiveRewards(object oPC, string questTag)
{
	string item;
/*	
const string QUEST_BOOK = "TBquestbook";
const string TUTORIAL_ISLAND_TAG = "qtutorialisland";
const string COOKS_ASSISTANT_TAG = "qcooksassistant";
const string RESTLESS_GHOST_TAG = "qrestlessghost";
const string BLOOD_RITUAL_TAG = "qbloodritual";
const string IMP_CATCHER_TAG = "qimpcatcher";
const string SHEEP_SHEARER_TAG = "qsheepshearer";
const string DORICS_QUEST_TAG = "qdoricsquest";
const string WITCHS_POTION_TAG = "qwitchspotion";
const string ERNEST_THE_CHICKEN_TAG = "qernestthechicken";
const string GOBLIN_DIPLOMACY_TAG = "qgoblindiplomacy";
const string RUNE_MYSTERIES_TAG = "qrunemysteries";
const string PRINCE_ALIS_RESCUE_TAG = "qprinceali";
const string PIRATES_TREASURE_TAG = "qpiratestreasure";
const string VAMPIRE_SLAYER_TAG = "qvampireslayer";
const string DEMON_SLAYER_TAG = "qdemonslayer";
*/
	if (questTag == TUTORIAL_ISLAND_TAG)
	{ //Tutorial Island
	/*
			CreateItemOnObject("hammer", oPC, 1);
			CreateItemOnObject("tinderbox", oPC, 1);
			CreateItemOnObject("smallnet", oPC, 1);
			CreateItemOnObject("bronzeaxe", oPC, 1);
			CreateItemOnObject("bronzesword", oPC, 1);
			CreateItemOnObject("bronzedagger", oPC, 1);
			CreateItemOnObject("woodenshield", oPC, 1);
			CreateItemOnObject("shortbow", oPC, 1);
			CreateItemOnObject("bronzearrows", oPC, 25);
			CreateItemOnObject("bronzepickaxe", oPC, 1);
	*/
			CreateItemOnObject("airrune", oPC, 25);
			CreateItemOnObject("mindrune", oPC, 25);
			DelayCommand(0.8, Teleport(oPC, "backfromtutorialislandwoo"));
	}
	if (questTag == COOKS_ASSISTANT_TAG)
	{//1qp
		GiveXP( oPC, "cooking", 300, 1, 1 );
		CreateItemsOnObject("sardine", oPC, 4);
	}
	if (questTag == RESTLESS_GHOST_TAG)
	{//1qp
		GiveXP( oPC, "prayer", 1125, 1, 1 );
	}
	if (questTag == BLOOD_RITUAL_TAG)
	{//1qp
		CreateItemOnObject("sacrificialblackdagger", oPC, 1);
		CreateItemOnObject("amuletofnecromancy", oPC, 1);
	}
	if (questTag == IMP_CATCHER_TAG)
	{//1qp
		GiveXP( oPC, "runecrafting", 875, 1, 1 );
		CreateItemOnObject("amuletofaccuracy", oPC, 1);
	}
	if (questTag == SHEEP_SHEARER_TAG)
	{//1qp
		GiveXP( oPC, "crafting", 300, 1, 1 );
		GiveGoldToCreature(oPC, 60);
	}
	if (questTag == DORICS_QUEST_TAG)
	{//1qp
		GiveXP( oPC, "mining", 1800, 1, 1);
		GiveGoldToCreature(oPC, 180);
	}
	if (questTag == WITCHS_POTION_TAG)
	{//1qp
		GiveXP( oPC, "runecrafting", 325, 1, 1 );
	}
	if (questTag == ERNEST_THE_CHICKEN_TAG)
	{//4qp
		CreateItemsOnObject("egg", oPC, 3);
		CreateItemOnObject("feather", oPC, 300);
	}
	if (questTag == GOBLIN_DIPLOMACY_TAG)
	{//5qp
		GiveXP( oPC, "crafting", 200, 1, 1 );
		CreateItemOnObject("goldbar", oPC, 1);
	}
	if (questTag == RUNE_MYSTERIES_TAG)
	{//1qp
	//Runecrafting skill
		GiveXP( oPC, "runecrafting", 500, 1, 1 );
		CreateItemOnObject("airtalisman", oPC, 1);
	}
	if (questTag == PIRATES_TREASURE_TAG)
	{//1qp
	//Runecrafting skill
		CreateItemOnObject("oneeyedhectorstreasure", oPC, 1);
	}
	if (questTag == PRINCE_ALIS_RESCUE_TAG)
	{//1qp
		GiveGoldToCreature(oPC, 700);
	}
	if (questTag == VAMPIRE_SLAYER_TAG)
	{//1qp
		GiveXPToCreature(oPC, 4825);
	}
	//if (questTag == DEMON_SLAYER_TAG)
	if (questTag == DRAGON_SLAYER_TAG)
	{//1qp
		
	}
	/*
	if (questTag == "")
		{ //Tutorial Island
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
		}
		case 1006: //Cook's Assistant
			GiveXP( oPC, "cooking", 300, 1, 1 );
			CreateItemsOnObject("sardine", oPC, 4);
			break;
		case 1007: //The Blood Ritual
			CreateItemOnObject("sacrificialblackdagger", oPC, 1);
			CreateItemOnObject("amuletofnecromancy", oPC, 1);
			break;
		case 1008: //Initiation of the Kinshra
			GiveXP( oPC, "cooking", 500, 1, 1 );
			GiveXP( oPC, "mining", 500, 1, 1 );
			GiveXP( oPC, "smithing", 500, 1, 1 );
			item = (ClassLevel(7, 1, oPC) || ClassLevel(8, 1, oPC)) ? "blackleatherbody" : "";
			item = (ClassLevel(4, 1, oPC)) ? "blackchainbody" : item;
			item = (ClassLevel(10, 1, oPC)) ? "blackknightrobes" : item;
			CreateItemOnObject(item, oPC, 1);
			break;
		case 1009: //Restless Ghost
			GiveXP( oPC, "prayer", 1125, 1, 1 );
			break;
		case 1010: //Ernest the Chicken
			CreateItemsOnObject("egg", oPC, 20);
			CreateItemOnObject("feather", oPC, 300);
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
			item = (ClassLevel(7, 1, oPC) || ClassLevel(8, 1, oPC)) ? "whiteleatherbody" : "";
			item = (ClassLevel(4, 1, oPC)) ? "whitechainbody" : item;
			item = (ClassLevel(10, 1, oPC)) ? "whiteknightrobes" : item;
			CreateItemOnObject(item, oPC, 1);
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
	*/
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