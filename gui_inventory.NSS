#include "nw_i0_spells"

void DoStats(object oPC, object oCONTROL)
{	
	if (GetResRef(oCONTROL) != "sfpb_storage") return;
	
	string sSCREEN = "SCREEN_INVENTORY";
	SetGUIObjectHidden(oPC, sSCREEN, "CHARACTER_DATA", TRUE);
	SetGUIObjectHidden(oPC, sSCREEN, "MENU_PAGES", TRUE);
	SetGUIObjectHidden(oPC, sSCREEN, "BANK_BUTTON", FALSE);
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

void SwitchInventory(object oPC, object oCONTROL)
{
	object oSWITCH = oPC;
	if (GetResRef(oCONTROL) != "sfpb_storage")
	{
		string sID = GetPCPlayerName(oPC);
		oSWITCH = GetObjectFromRosterName(sID);
	}
	object oNEW = SetOwnersControlledCompanion(oCONTROL, oSWITCH);
}

void TransferItem(object oPC, object oCONTROL)
{
	string sID = GetPCPlayerName(oPC);
	object oBANK = GetObjectFromRosterName(sID);
	if (oBANK == OBJECT_INVALID)
	{
		SendMessageToPC(oPC, "Error: Persistent chest not found.");
		return;
	}
	object oITEM = GetPlayerCurrentTarget(oCONTROL);
	if (GetItemPossessor(oITEM) != oCONTROL)
	{
		SendMessageToPC(oPC, "Error: Targeted object is not a transferable item. Right click on the item you wish to transfer.");
		return;
	}
	object oTAKE = oBANK;
	if (GetResRef(oCONTROL) == "sfpb_storage") oTAKE = GetOwnedCharacter(oCONTROL);
	AssignCommand(oCONTROL, ActionGiveItem(oITEM, oTAKE, FALSE));
}
void main(string sCOMMAND)
{
	object oPC = OBJECT_SELF;
	object oCONTROL = GetControlledCharacter(oPC);
	int nCOMMAND = StringToInt(sCOMMAND);
	switch (nCOMMAND)
	{		
		case 1: DoStats(oPC, oCONTROL); break;
		case 2: BeginStorageSave(oPC, oCONTROL); break;
		case 3: SwitchInventory(oPC, oCONTROL); break;
		case 4: TransferItem(oPC, oCONTROL); break;
	}
}