//-----------------------------------------------------------------------
// <copyright file="gui_cityrespawn.nss" company="Molior RS">
// Copyright (c) Molior RS. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------
//    - heavily edited to include death penalties.

// Get Up after KnockOut
void ResurrectPlayer(object oPC)
{
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_S), oPC);
	SignalEvent(oPC, EventSpellCastAt(oPC, SPELL_RESURRECTION, FALSE));
	DelayCommand(0.0f, AssignCommand(oPC, JumpToObject(GetObjectByTag("WP_RESPAWN1"))));
	DelayCommand(0.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, RoundsToSeconds(3)));
	DelayCommand(0.0f, ExportSingleCharacter(oPC));
}

void ApplyPenalty(object oPC, object oGRAVE)
{
	//XP Loss. PC cannot lose a level.
	int nXP = GetXP(oPC);
	int nSUBRACE = GetSubRace(oPC);
	int nCACHE = GetNum2DAColumns("racialsubtypes"); //Cache the 2DA
	int nECL = StringToInt(Get2DAString("racialsubtypes", "ECL", nSUBRACE));
	int nLVL = GetTotalLevels(oPC, FALSE) + nECL;
	int nXP_LOSS = nLVL * 100;
	nCACHE = GetNum2DAColumns("exptable"); //Cache the 2DA
	int nXP_MIN = StringToInt(Get2DAString("exptable", "XP", nLVL - 1));
	int nXP_NEW = nXP - nXP_LOSS;
	if (nXP_NEW < nXP_MIN) nXP_NEW = nXP_MIN;
	if (nXP_NEW < nXP) SetXP(oPC, nXP_NEW);
	
	//Gold Loss. A cap of 10,000 gold taken from PC.
	int nGP_LOSS = GetGold(oPC) / 10;
	if (nGP_LOSS > 10000) nGP_LOSS = 10000;
	AssignCommand(oGRAVE, TakeGoldFromCreature(nGP_LOSS, oPC, FALSE, TRUE));
	
	//Item Loss. All items are placed on the gravestone.
	SendMessageToPC(oPC, "You have lost all your unequipped non-plot items. To retrieve them, return to the spot where you died and use the gravestone that bears your name.");
	SetDescription(oGRAVE, "Here lies " + GetName(oPC) + ".");
	SetLocalObject(oGRAVE, "GRAVE_PC", oPC);
	int nCOUNT;
	location lGRAVE = GetLocation(oGRAVE);
	object oINVALID = OBJECT_INVALID;
	object oITEM = GetFirstItemInInventory(oPC);
	while (oITEM != oINVALID)
	{
		nCOUNT = nCOUNT + 1;
		if ((GetPlotFlag(oITEM) == FALSE) && (GetItemCursedFlag(oITEM) == FALSE))
		{
			AssignCommand(oGRAVE, ActionTakeItem(oITEM, oPC, FALSE));
		}
		oITEM = GetNextItemInInventory(oPC);
	}
	
	DelayCommand(0.0f, ResurrectPlayer(oPC));
}

void main()
{
	object oPC = OBJECT_SELF;
	// reset StandardFactions, should remain consistent with the Faction table.
	// can use constants in the FactionTable for custom factions, i believe
	SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 60, oPC);
	SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 70, oPC);
	SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPC);
	object oGRAVE = CreateObject(OBJECT_TYPE_PLACEABLE, "gravestone", GetLocation(oPC), TRUE, "grave_" + GetBicFileName(oPC));
	DelayCommand(0.0f, ApplyPenalty(oPC, oGRAVE));
}