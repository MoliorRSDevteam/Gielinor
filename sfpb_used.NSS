//::///////////////////////////////////////////////
//:: Persistent Banking
//:: sfpb_used
//:://////////////////////////////////////////////
/*
    Written By by Clangeddin
*/
//////////////////////////////////////////////////

#include "nw_i0_spells"

void main()
{
    object oPC = GetLastUsedBy();
	
	// End script if any of these conditions are met
	if (GetIsOwnedByPlayer(oPC) == FALSE) return;
    if (GetIsPC(oPC) == FALSE) return;
	if (GetIsDM(oPC) == TRUE) return;
	if (GetIsDMPossessed(oPC) == TRUE) return;
	if (GetIsPossessedFamiliar(oPC) == TRUE) return;

	string sDATA = "bank_items";
	object oChest = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC);
	
	object oStorer = GetNearestObjectByTag(sID, oPC);
	if (oStorer != OBJECT_INVALID)
	{
		SendMessageToPC(oPC, "Storage Saved.");
		StoreCampaignObject(sDATA, sID, oStorer, oPC);
		RemoveRosterMemberFromParty(sID, oPC);
		RemoveRosterMember(sID);
		RemoveSpecificEffect(EFFECT_TYPE_CUTSCENEIMMOBILIZE, oPC);
		return;
	}
	
	effect eFX = EffectCutsceneImmobilize();
	eFX = SupernaturalEffect(eFX);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFX, oPC);
	SendMessageToPC(oPC, "You can now access your persistent storage. To save and dismiss it, use the chest again.");
	oStorer = RetrieveCampaignObject(sDATA, sID, GetLocation(oChest), OBJECT_INVALID, oPC);
    if (oStorer == OBJECT_INVALID)
	{
		oStorer = CreateObject(OBJECT_TYPE_CREATURE, "sfpb_storage", GetLocation(oChest), FALSE, sID);
		SetFirstName(oStorer, GetFirstName(oPC) + "'s Storage");
	}
	AddRosterMemberByCharacter(sID, oStorer);
	AddRosterMemberToParty(sID, oPC);
	SetIsRosterMemberSelectable(sID, FALSE);
}