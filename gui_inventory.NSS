#include "nw_i0_spells"

void DoStats(object oPC, object oCONTROL)
{
	string sSCREEN = "SCREEN_INVENTORY";
	if (GetResRef(oCONTROL) == "sfpb_storage")
	{
		SetGUIObjectHidden(oPC, sSCREEN, "CHARACTER_DATA", TRUE);
		SetGUIObjectHidden(oPC, sSCREEN, "MENU_PAGES", TRUE);
		return;
	}
	
	SetGUIObjectText(oPC, sSCREEN, "FISHING", 		-1, IntToString(GetSkillRank(30, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "COOKING", 		-1, IntToString(GetSkillRank(31, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "FIREMAKING",	-1, IntToString(GetSkillRank(32, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "SMITHING", 		-1, IntToString(GetSkillRank(33, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "WOODCUTTING",	-1, IntToString(GetSkillRank(34, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "MINING", 		-1, IntToString(GetSkillRank(35, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "RUNECRAFTING", 	-1, IntToString(GetSkillRank(36, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "CRAFTING", 		-1, IntToString(GetSkillRank(37, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "PRAYER", 		-1, IntToString(GetSkillRank(38, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "HERBLORE", 		-1, IntToString(GetSkillRank(41, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "THIEVING", 		-1, IntToString(GetSkillRank(42, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "FLETCHING", 	-1, IntToString(GetSkillRank(43, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "SLAYER", 		-1, IntToString(GetSkillRank(44, oPC, TRUE)));
	SetGUIObjectText(oPC, sSCREEN, "FARMING", 		-1, IntToString(GetSkillRank(46, oPC, TRUE)));
}

void FinalizeStorageSave(object oPC, object oBANK, string sID)
{
	ExportSingleCharacter(oPC);
	int nCHECK = StoreCampaignObject("bank_items", sID, oBANK, oPC);
	if (nCHECK == 1) SendMessageToPC(oPC, "Item storage saved.");
	else SendMessageToPC(oPC, "An error occurred. The item storage was not saved.");
	RemoveRosterMemberFromParty(sID, oPC);
	RemoveRosterMember(sID);
}

void BeginStorageSave(object oPC, object oCONTROL)
{
	string sID = GetPCPlayerName(oPC);
	object oBANK = GetObjectFromRosterName(sID);
	if (oBANK == OBJECT_INVALID) return;
	
	oPC = SetOwnersControlledCompanion(oCONTROL, oPC);
	RemoveSpecificEffect(EFFECT_TYPE_POLYMORPH, oPC);
	RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEIMMOBILIZE, oPC);
	DelayCommand(0.0f, FinalizeStorageSave(oPC, oBANK, sID));
}

void main(string sCOMMAND)
{
	object oPC = OBJECT_SELF;
	object oCONTROL = GetControlledCharacter(oPC);
	if (sCOMMAND == "ADD") DoStats(oPC, oCONTROL);
	else if (sCOMMAND == "REMOVE") BeginStorageSave(oPC, oCONTROL);	
}