/*
	1) Put it in the "On Death Script" slot of the intended creature.
	2) Set the following local variables on said creature:
     QUEST_ID (String) - The ID of the quest to progress
     QUEST_STEP (Int) - The step of the quest to progress to.
     QUEST_XP (Int) - Optional. The one-time XP bonus related to the quest.
     QUEST_QP (Int) - Optional. The one-time QP bonus related to the quest.
	 QUEST_WP (String) - Optional. The tag of destination waypoint (if any) after you have killed the creature.
*/

void TeleportEveryone(object oPC, object oMOB, object oINVALID = OBJECT_INVALID)
{
	string sWP = GetLocalString(oMOB, "QUEST_TP");
	object oWP = GetObjectByTag(sWP);
	if (oWP == oINVALID) return;
	object oPARTY = GetFirstFactionMember(oPC, FALSE);
	while (oPARTY != oINVALID)
	{
		AssignCommand(oPARTY, JumpToObject(oWP));
		oPARTY = GetNextFactionMember(oPC, FALSE);
	}
}

void main()
{
	object oMOB = OBJECT_SELF;
	object oPC = GetLastKiller();
	string sQUEST = GetLocalString(oMOB, "QUEST_ID");
	int nSTEP = GetLocalInt(oMOB, "QUEST_STEP");
	int nXP = GetLocalInt(oMOB, "QUEST_XP");
	int nQP = GetLocalInt(oMOB, "QUEST_QP");
	AddScriptParameterString(sQUEST);
	AddScriptParameterInt(nSTEP);
	AddScriptParameterInt(nXP);
	AddScriptParameterInt(nQP);
	AddScriptParameterInt(FALSE); //Not from Conversation
	AddScriptParameterInt(TRUE); //Check all party members by default
	ExecuteScriptEnhanced("quest_action", oPC);	
	DelayCommand(0.0f, TeleportEveryone(oPC, oMOB));
}