/*
	1) Put it in the "On Death Script" slot of the intended creature.
	2) Set the following local variables on said creature:
     QUEST_ID (String) - The ID of the quest to progress
     QUEST_STEP (Int) - The step of the quest to progress to.
     QUEST_XP (Int) - Optional. The one-time XP bonus related to the quest.
     QUEST_QP (Int) - Optional. The one-time QP bonus related to the quest.
*/

void main()
{
	// Auto-Generated by Legends Spawn Plugin 1.93
	ExecuteScript("leg_all_masterdeath", OBJECT_SELF);
	
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
}
