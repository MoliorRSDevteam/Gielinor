//::///////////////////////////////////////////////
//:: Persistent Banking
//:: sfpb_used
//:://////////////////////////////////////////////
/*
    Written By by Clangeddin
*/
//////////////////////////////////////////////////

#include "nw_i0_spells"

void InitializeBank(object oPC, object oSTORAGE, string sID)
{
	effect eFX = EffectCutsceneImmobilize();
	eFX = SupernaturalEffect(eFX);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFX, oPC);
	location lPC = GetLocation(oPC);
	oSTORAGE = RetrieveCampaignObject("bank_items", sID, lPC, OBJECT_INVALID, oPC);
    if (oSTORAGE == OBJECT_INVALID)
	{
		oSTORAGE = CreateObject(OBJECT_TYPE_CREATURE, "sfpb_storage", lPC, FALSE, sID);
		SetFirstName(oSTORAGE, GetFirstName(oPC) + "'s Storage");
	}
	AddRosterMemberByCharacter(sID, oSTORAGE);
	AddRosterMemberToParty(sID, oPC);
	SetIsRosterMemberSelectable(sID, FALSE);
	SetOwnersControlledCompanion(oPC, oSTORAGE);
	DisplayGuiScreen(oPC, "SCREEN_INVENTORY", FALSE, "inventoryscreen.xml");
}

void main()
{
    object oPC = GetLastUsedBy();
	
	// End script if any of these conditions are met
	if (GetIsOwnedByPlayer(oPC) == FALSE) return;
    if (GetIsPC(oPC) == FALSE) return;
	if (GetIsDM(oPC) == TRUE) return;
	if (GetIsDMPossessed(oPC) == TRUE) return;
	if (GetIsPossessedFamiliar(oPC) == TRUE) return;
    string sID = GetPCPlayerName(oPC);
	object oSTORAGE = GetObjectFromRosterName(sID);
	if (oSTORAGE != OBJECT_INVALID) return;
	
	CloseGUIScreen(oPC, "SCREEN_INVENTORY");
	RemoveSpecificEffect(EFFECT_TYPE_POLYMORPH, oPC);
	DelayCommand(0.5f, InitializeBank(oPC, oSTORAGE, sID));
}