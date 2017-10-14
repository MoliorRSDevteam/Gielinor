#include "tb_questinclude"
#include "tb_questbook"
#include "tb_persistents"
void main(string sQuestType, string sQuestTypeName, string sGUI)
{
	oPC = OBJECT_SELF;
	if (GetLocalInt(oPC, "qboxesloaded") == 0)
	{//FIX FOR: a repopulating bug. I don't know why but this script runs and bugs when the player first spawns
		SetLocalInt(oPC, "qboxesloaded", 1);return; 
	}
	SetupQuestBook();
	// Set up some variables, grab the journal screen and lets start populating it!
	int iCount = 0;
	string sQuestCount = "sQuestCount";
	//string sQuest = "sQuest";
	//int iSecondCount = 111;
	string sQuestTitle = "sQuestTitle";
	string sPointsTitle = "Quest Points: ";
	int qNum;
	SetLocalString(oPC, "SGUI", sGUI);
	ClearListBox(oPC, sGUI, "JOURNAL_LIST");
	int journQuests = 1;
	for (qNum = 1; qNum <= journQuests; qNum++)
	{
		RunQBook(QIDToTag(qNum));
		if (sTitle == ""){break;}
		numQuests = journQuests;
		journQuests ++;
		completedQuests += (GetLocalInt(oPC, questTag) == 999);
		//SendMessageToPC(oPC, "qs: " + );
		SetLocalInt(oPC, "QBOXSELECTED", qNum);
		AddListBoxRow(oPC, sGUI, "JOURNAL_LIST", "ROW_" + IntToString(qNum), "JOURNAL_TEXT0=" + sTitle, "", "", "");
		sTitle = "";
	}
	int boxSelected = GetLocalInt(oPC, "qSelected");
	SetListBoxRowSelected(oPC, sGUI, "JOURNAL_LIST", "ROW_"+IntToString(boxSelected+1));
	//SendMessageToPC(oPC, "get a box " + IntToString(boxSelected+1));
	/* attempt at using previous scroll and selection
	SetScrollBarValue(OBJECT_SELF, "SCREEN_JOURNAL", "SB", boxSelected);
	*/
	int questPoints = TBGetPersistentInt(oPC, "TBquestpoints", 1);
	//tempPoints = (tempPoints == 0) ? GetPersistentInt(oPC, "questpoints") : tempPoints;
	sPointsTitle += IntToString(questPoints);
	
	// Clean up Previous Screen details
	SetGUIObjectText(oPC, sGUI, "title", -1, "");
	SetGUIObjectText(oPC, sGUI, "questdetails", -1, "");
	SetGUIObjectText(oPC, sGUI, "REWARDS", -1, "");//"rewards"				
	SetGUITexture(oPC, sGUI, "TYPE1", "");			
	SetGUITexture(oPC, sGUI, "TYPE2", "");
	
	//Base stuff
	sQuestCount = IntToString(completedQuests) + " of " + IntToString(numQuests) + " " + sQuestTypeName + " Completed";
	SetGUIObjectText(oPC, sGUI, "counttitle", -1, sQuestCount);	
	SetGUIObjectText(oPC, sGUI, "pointstitle", -1, sPointsTitle);	
	SetGUIObjectText(oPC, sGUI, "MAINTITLE", -1, sQuestTypeName);								
	if (sQuestType == "0")
		SetGUITexture(oPC, sGUI, "JOURNAL_ICON", journalIcon);
	//SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS1", -1, "offerrewards");
	//SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS2", -1, "offerrewards2");
	//SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS3", -1, "offerrewards3");
	//SetGUITexture(oPC, sGUI, "OFFERED_ICON1", "qj_icon.tga");
	//SetGUITexture(oPC, sGUI, "OFFERED_ICON2", "qj_icon.tga");			
	//SetGUITexture(oPC, sGUI, "OFFERED_ICON3", "qj_icon.tga");	
	/*
	// Add some more info and apply the icon and details to the GUI.
	else if (sQuestType == "1")
		SetGUITexture(oPC, sGUI, "JOURNAL_ICON", "spellbook_icon.tga");			
	else if (sQuestType == "2")
		SetGUITexture(oPC, sGUI, "JOURNAL_ICON", "char_icon.tga");			
	else if (sQuestType == "3")
		SetGUITexture(oPC, sGUI, "JOURNAL_ICON", "store_icon.tga");	
	*/
}