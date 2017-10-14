/*
	*obtain items
	*deliver items
	*speak to an npc
	*loot a placeable (tb_qplaceable)
	*put an item in something
	kill something
	examine a placeable
	escort this npc
	eavesdrop
	discover a place
	use item, get item (mob)
	fake objective
	loot a creature drop
	destroy a placeable
	use item get item (place)
*/

#include "tb_include"
#include "leg_quest_include"

//colors
string CWhite(string txt){ return COLOUR_WHITE+txt+"</color>";}
string CLGrey(string txt){ return COLOUR_LIGHT_GREY+txt+"</color>";}
string CGrey(string txt){ return COLOUR_GREY+txt+"</color>";}
string CDGrey(string txt){ return COLOUR_DARK_GREY+txt+"</color>";}
string CBlack(string txt){ return COLOUR_BLACK+txt+"</color>";}
string CLRed(string txt){ return COLOUR_LIGHT_RED+txt+"</color>";}
string CLGreen(string txt){ return COLOUR_LIGHT_GREEN+txt+"</color>";}
string CLBlue(string txt){ return COLOUR_LIGHT_BLUE+txt+"</color>";}
string CLYellow(string txt){ return COLOUR_LIGHT_YELLOW+txt+"</color>";}
string CLPurple(string txt){ return COLOUR_LIGHT_PURPLE+txt+"</color>";}
string CLCyan(string txt){ return COLOUR_LIGHT_CYAN+txt+"</color>";}
string CRed(string txt){ return COLOUR_RED+txt+"</color>";}
string CGreen(string txt){ return COLOUR_GREEN+txt+"</color>";}
string CBlue(string txt){ return COLOUR_BLUE+txt+"</color>";}
string CYellow(string txt){ return COLOUR_YELLOW+txt+"</color>";}
string CPurple(string txt){ return COLOUR_PURPLE+txt+"</color>";}
string CCyan(string txt){ return COLOUR_CYAN+txt+"</color>";}
string COrange(string txt){ return COLOUR_ORANGE+txt+"</color>";}
string CDarkRed(string txt){ return COLOUR_DARK_RED+txt+"</color>";}
string CDarkGreen(string txt){ return COLOUR_DARK_GREEN+txt+"</color>";}
string CDarkBlue(string txt){ return COLOUR_DARK_BLUE+txt+"</color>";}
string CDarkYellow(string txt){ return COLOUR_DARK_YELLOW+txt+"</color>";}
string CDarkPurple(string txt){ return COLOUR_DARK_PURPLE+txt+"</color>";}
string CDarkCyan(string txt){ return COLOUR_DARK_CYAN+txt+"</color>";}

// /////////////////////////////////////////////////////////////////////////////////////////////////////
// QUEST VARS
// /////////////////////////////////////////////////////////////////////////////////////////////////////

//legends vars
object oPC;
string sGUI;
string sGUIFile;
string sColor;
string sTitle;
//string sTypeIcon = "tb_q_iicon";
string sRewards;
//vars
string questDifficulty;
int questPoints;
string tagExt;
int showObj;
int obj1;
int obj2;
int obj3;
int obj4;
int obj5;
int obj6;
int obj7;
int curObj;
//journal
string journalIcon = "tb_q_jicon.tga";
string sQIcon = "tb_q_iicon.tga";
string sJournalText;
string questReqs;
int numQuests;
int completedQuests;
//popups
string questgui;
string sCongrats = "Congratulations!";// = "Silver Sword";
string sCompletedIcon = "tb_q_questribbon.tga";// = "raid.tga";
//string sQuestPoints;// = "Gold sword Sword";
string txt1, txt2, txt3;
string sMainText;
string sObjectives;
string questTag;
int questID;
int playerstep;
int spacesneeded;

//Not Used
string sDescription3;// = ";o Diamond Sword";
	string sIcon2;// = "solo_hard.tga";
	string sIcon3;// = "solo_normal.tga";

void SetDifficulty(string qDiff)
{
	questDifficulty = qDiff;
	if (qDiff == "novice")
	{
		//sTypeIcon = "solo_normal.tga";
		sTitle = CGreen(sTitle);
		//sTypeIcon = "solo_normal.tga";
	} 
	if (qDiff == "intermediate")
	{
		sTitle = CYellow(sTitle);
	}
	if (qDiff == "experienced")
	{
		sTitle = COrange(sTitle);
	}
	if (qDiff == "master")
	{
		sTitle = CRed(sTitle);
	}
	if (qDiff == "grandmaster")
	{
		sTitle = CPurple(sTitle);
	}
}
const int TAKE_ITEMS = 1;
//Identifiers
int FinishTakeItems(object oPC, string itemTag, int numItems);
// /////////////////////////////////////////////////////////////////////////////////////////////////////
// SYSTEM FUNCTIONS
// /////////////////////////////////////////////////////////////////////////////////////////////////////
void TakeOnFinish(object oPC, string actTag, int actIndex, string itemTag, int numItems)
{
	//SendMessageToPC(GetFirstPC(), GetName(oPC)+ "set take on finish");
	string params = IntToString(TAKE_ITEMS) + "," + itemTag + "," + IntToString(numItems);
	SetLocalString(oPC, "TBObj"+actTag+IntToString(actIndex), params);
}
void DoFinishAction(object oPC, string actTag, int actIndex)
{
	//SendMessageToPC(GetFirstPC(), GetName(oPC)+"doing take on finish");
	string params = GetLocalString(oPC, "TBObj"+actTag+IntToString(actIndex));
	//if (params == "") { GetPersistentString(oPC, "TBObj"+"TBObj"+sObjTag+sObjIndex); params = SetLocalString(oPC, "TBObj"+sObjTag+sObjIndex, params); }
	if (params != "")
	{
		SplitString(params);
		switch (StringToInt(subS1))
		{
			case TAKE_ITEMS:
				DestroyItems(oPC, subS2, StringToInt(subS3));
		}
	}
}