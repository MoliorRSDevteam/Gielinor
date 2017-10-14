#include "tb_questinclude"
#include "tb_questbook"

void FireGUI();
void DontMove()
{
	
}
void DoMain();
void main(string sQuestTag, string popup, int popupID = 0)//, int onSelectInt = 0)
{
	string failmessage;
	object oNPC = OBJECT_SELF;
	float delay = GetLocalFloat(OBJECT_SELF, "delayopenquest");
	DeleteLocalFloat(OBJECT_SELF, "delayopenquest");
	oPC = GetPCSpeaker();
	oPC = (oPC == OBJECT_INVALID) ? GetLocalObject(OBJECT_SELF, "LASTPC") : oPC;
	if (!GetIsPC(oPC))
	{
		PrintString("TB: Convo could not find PC, aborting");
		return;
	}
	SetupQuestBook();
	questID = QTagToID(sQuestTag);
	failmessage += (questID == 0) ? "ERROR: Invalid Quest Tag '" + sQuestTag + "' with convo on "+GetName(oNPC)+"\n" : "";
	int checkpopups = (popup == "offer" || popup == "continue" || popup == "finish");
	//SendMessageToPC(oPC, "check popup " + IntToString(checkpopups));
	failmessage += (!checkpopups) ? "ERROR: Invalid Quest Popup '" + popup + "' with convo on "+GetName(oNPC)+"\n" : "";
	if (oPC == OBJECT_INVALID){failmessage += "Could not find PC, using first";oPC = GetFirstPC();}
	SetLocalObject(oNPC, "LASTPC", oPC);
	SetLocalObject(oPC, "QNPC", oNPC);
	//SetLocalInt(oPC, "acceptQuestInt", onSelectInt);
	SetLocalInt(oPC, "curQuestID", questID);
	SetLocalString(oNPC, "questTag"+IntToString(questID), sQuestTag);
	playerstep = popupID;
	if (popup == "offer"){playerstep = -2;}
	if (popup == "continue"){}
	if (popup == "finish"){playerstep = -1;sRewards = "Rewards: \n\n";}
	SetLocalString(oPC, "QPopupGUI", popup);
	
	//Quest ID sets up quest panels
	if (failmessage != "") {SendMessageToPC(oPC, failmessage);return;}
	DelayCommand(delay, DoMain());
}
void DoMain()
{
	RunQBook(QIDToTag(questID));
	SetLocalInt(oPC, "qSelected", questID-1); //selects quest in journal
	//SendMessageToPC(oPC, "do " + IntToString(GetLocalInt(oPC, "qSelected")));
	//SendMessageToPC(GetFirstPC(), "questtag "+questTag);
	//SendMessageToPC(GetFirstPC(), "popup "+questgui);
	//SendMessageToPC(GetFirstPC(), "popup id "+IntToString(playerstep));
	//SendMessageToPC(oPC, "debug: "+questTag);
	SetLocalInt(oPC, "QPointSetter", questPoints);
	SetLocalString(oPC, "questtitle", sTitle);
	FireGUI();
}
void FireGUI()
{
	questgui = GetLocalString(oPC, "QPopupGUI");
	//Rest coded
	if (questgui == "offer")
	{
		sGUI = "leg_quest_offer";
		sGUIFile = "tb_quest_offer.xml";
	}
	if (questgui == "continue")
	{
		sGUI = "leg_quest_continue";
		sGUIFile = "tb_quest_continue.xml";
	}
	if (questgui == "finish")
	{
		sGUI = "leg_quest_finish"; //buttons don't work ~ fixed
		sGUIFile = "tb_quest_finish.xml";
	}
	sMainText += (showObj == 0 || showObj == 1) ? "\n\n"+sObjectives : "";
	SetCommandable(0, oPC);
	//sRewards = (sRewards == "") ? "hi "+sObjectives : sRewards;
	//GUI screen shows up okay, but blank with default gold and shiny red apples
	DisplayGuiScreen(oPC, sGUI, FALSE, sGUIFile);
	//Title text now shows up
	SetGUIObjectText(oPC, sGUI, "title", -1, sTitle);
	//Now a small icon next to the title, a picture of a man
	//SetGUITexture(oPC, sGUI, "TYPE1", sQIcon);//sTypeIcon						
	//Now a text body appears! Amazing!
	SetGUIObjectText(oPC, sGUI, "quest", -1, sMainText);//+"\n\n"+sObjectives);
	//We've got our local:1, let's hold off on this and test it.
	//SetLocalGUIVariable(oPC, sGUI, 1, "hello");
	//Our textual rewards of Gold and whatever	
	SetGUIObjectText(oPC, sGUI, "REWARDS", -1, sRewards);
	//We got names for our rewards!
	SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS1", -1, CYellow(sCongrats));
	SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS2", -1, COrange("Quest Points: " + IntToString(questPoints)));
	//SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS3", -1, sDescription3);
	//got images for our rewards
	SetGUITexture(oPC, sGUI, "OFFERED_ICON1", sCompletedIcon);
	//SetGUITexture(oPC, sGUI, "OFFERED_ICON2", sIcon2);
	//SetGUITexture(oPC, sGUI, "OFFERED_ICON3", sIcon3);
}
	//who cares
	//SetGUIObjectText(oPC, sGUI, "BribeButton", -1, IntToString(iBribe) + " GP");
	
	/*
	// Now open the GUI.  The GUI could be an Offer, a Continue or a Finish call based on what we asked this
	// function to do.  Pass all the information we pulled from the database off to the appropriate GUI file
	// that was passed to this function.
	DisplayGuiScreen(oPC, sGUI, FALSE, sGUIFile);			
	SetGUIObjectText(oPC, sGUI, "title", -1, sColor + sTitle + "</color>");
	SetGUITexture(oPC, sGUI, "TYPE1", sTypeIcon);						
	SetGUIObjectText(oPC, sGUI, "quest", -1, sMainText);
	SetLocalGUIVariable(oPC, sGUI, 1, sQuestID);
	SetLocalGUIVariable(oPC, sGUI, 2, IntToString(iNPCPosition));
	SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS1", -1, sDescription1);
	SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS2", -1, sDescription2);
	SetGUIObjectText(oPC, sGUI, "OFFER_REWARDS3", -1, sDescription3);
	SetGUITexture(oPC, sGUI, "OFFERED_ICON1", sIcon1);
	SetGUITexture(oPC, sGUI, "OFFERED_ICON2", sIcon2);			
	SetGUIObjectText(oPC, sGUI, "BribeButton", -1, IntToString(iBribe) + " GP");
	*/