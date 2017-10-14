//::////////////////////////////////////
//:: MoliorRS OnItemActivate Script ////
//::////////////////////////////////////

#include "nw_i0_spells"
#include "x2_inc_switches"
#include "profession_include"

void RenewFire(object oFIRE, int nLIGHT, string sFLAME, float fDUR)
{
	effect eFLAME = EffectSilence();
	eFLAME = EffectLinkEffects(eFLAME, EffectVisualEffect(nLIGHT));
	eFLAME = EffectLinkEffects(eFLAME, EffectNWN2SpecialEffectFile(sFLAME));
	eFLAME = SupernaturalEffect(eFLAME);
	eFLAME = SetEffectSpellId(eFLAME, -10);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFLAME, oFIRE, fDUR);
}

void UseLogs(object oPC, object oLOG, object oFIRE)
{
	if (GetLocalObject(oFIRE, "FIRE_OWNER") != oPC)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You may add logs only to bonfires you created.");
		return;
	}
	else if (GetLocalInt(oFIRE, "EXTINCT") == TRUE)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You may add logs only to bonfires that are still burning.");
		return;
	}
	float fDUR;
	int nXP;
	int nLVL;
	int nLIGHT = VFX_DUR_LIGHT_YELLOW_20;
	string sLOG = GetTag(oLOG);
	int nTYPE = StringToInt(GetStringRight(sLOG, 2));
	string sFLAME = "fx_bonfire";
	switch (nTYPE)
	{
		case 01: nLVL = 1; nXP = 40; fDUR = 45.0; break; //Normal Logs
		case 02: nLVL = 15; nXP = 60; fDUR = 60.0; break; //Oak Logs
		case 03: nLVL = 30; nXP = 90; fDUR = 90.0; break; //Willow Logs
		case 04: nLVL = 45; nXP = 135; fDUR = 120.0; break; //Maple Logs
		case 05: nLVL = 60; nXP = 203; fDUR = 240.0; break; //Yew Logs
		case 06: nLVL = 75; nXP = 304; fDUR = 480.0; nLIGHT = VFX_DUR_LIGHT_BLUE_20; sFLAME = "fx_nshore_bonfire"; break; //Magic Logs
		default: return;
	}
	if (GetSkillRank(SKILL_FIREMAKING, oPC) < nLVL)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need to have " + IntToString(nLVL) + " levels in Firemaking to make a fire out of " + GetName(oLOG) + ".");
		return;
	}
	GiveCraftXP(oPC, SKILL_FIREMAKING, nXP);
	int nSTACK = GetItemStackSize(oLOG);
	if (nSTACK > 1) SetItemStackSize(oLOG, nSTACK - 1);
	else DestroyObject(oLOG);
	location lPC = GetLocation(oPC);
	ReallyPlaySound(lPC, "Firemaking");
	RemoveEffectsFromSpell(oFIRE, -10);
	DelayCommand(0.0f, RenewFire(oFIRE, nLIGHT, sFLAME, fDUR));
}

void UseTinderbox(object oPC, object oLOG)
{
	if (GetItemPossessor(oLOG) != oPC) return;
	string sLOG = GetTag(oLOG);
	if (GetStringLeft(sLOG, 4) != "logs") return;
	float fDUR;
	int nXP;
	int nLVL;
	int nLIGHT = VFX_DUR_LIGHT_YELLOW_20;
	int nTYPE = StringToInt(GetStringRight(sLOG, 2));
	string sFLAME = "fx_bonfire";
	switch (nTYPE)
	{
		case 01: nLVL = 1; nXP = 40; fDUR = 45.0; break; //Normal Logs
		case 02: nLVL = 15; nXP = 60; fDUR = 60.0; break; //Oak Logs
		case 03: nLVL = 30; nXP = 90; fDUR = 90.0; break; //Willow Logs
		case 04: nLVL = 45; nXP = 135; fDUR = 120.0; break; //Maple Logs
		case 05: nLVL = 60; nXP = 203; fDUR = 240.0; break; //Yew Logs
		case 06: nLVL = 75; nXP = 304; fDUR = 480.0; nLIGHT = VFX_DUR_LIGHT_BLUE_20; sFLAME = "fx_nshore_bonfire"; break; //Magic Logs
		default: return;
	}
	int nCOUNT;
	int nFOUND;
	object oINVALID = OBJECT_INVALID;
	object oFIRE = GetObjectByTag("bonfire");
	while (oFIRE != oINVALID)
	{
		if (GetLocalObject(oFIRE, "FIRE_OWNER") == oPC)
		{
			nFOUND = TRUE;
			break;
		}
		nCOUNT = nCOUNT + 1;
		oFIRE = GetObjectByTag("bonfire", nCOUNT);
	}
	if (nFOUND == TRUE)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You already have set a bonfire somewhere. Either use logs on it to renew the flame or wait for it to disappear.");
		return;
	}
	if (GetSkillRank(SKILL_FIREMAKING, oPC) < nLVL)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need to have " + IntToString(nLVL) + " levels in Firemaking to make a fire out of " + GetName(oLOG) + ".");
		return;
	}
	GiveCraftXP(oPC, SKILL_FIREMAKING, nXP);
	int nSTACK = GetItemStackSize(oLOG);
	if (nSTACK > 1) SetItemStackSize(oLOG, nSTACK - 1);
	else DestroyObject(oLOG);
	location lPC = GetLocation(oPC);
	oFIRE = CreateObject(OBJECT_TYPE_PLACEABLE, "bonfire", lPC, TRUE);
	ReallyPlaySound(lPC, "Firemaking");	
	effect eFLAME = EffectVisualEffect(nLIGHT);
	eFLAME = EffectLinkEffects(eFLAME, EffectNWN2SpecialEffectFile(sFLAME));
	eFLAME = SupernaturalEffect(eFLAME);
	eFLAME = SetEffectSpellId(eFLAME, -10);
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFLAME, oFIRE, fDUR);
	SetLocalObject(oFIRE, "FIRE_OWNER", oPC);
	SetCustomHeartbeat(oFIRE, 5000);
}

void UseShears(object oPC, string sTARGET)
{
	if (GetLocalInt(oPC, "SHEARS") == TRUE) SendMessageToPC(oPC, "You need to wait 10 seconds before you can use this item again.");
	else if (sTARGET == "sheep")
	{
		SetLocalInt(oPC, "SHEARS", TRUE);
		if (d100() > 49) CreateItemOnObject("ballofwool", oPC);
		else SendMessageToPC(oPC, "You failed to collect a ball of wool. (50% chance)");
		DelayCommand(10.0, DeleteLocalInt(oPC, "SHEARS"));
	}
}

void BuryBones(object oPC, string sITEM)
{
	int nXP = 5;
	if (GetStringLeft(sITEM, 3) == "big") nXP = 15;
	else if (GetStringLeft(sITEM, 6) == "dragon") nXP = 72;
	GiveCraftXP(oPC, SKILL_PRAYER, nXP);
}

void PrayerPotion(object oPC, string sITEM)
{
	object oESSENCE = GetLocalObject(oPC, "PLAYER_ESSENCE");
	if (oESSENCE == OBJECT_INVALID)
	{
		oESSENCE = GetItemPossessedBy(oPC, "player_essence");
		SetLocalObject(oPC, "PLAYER_ESSENCE", oESSENCE);
	}
	int nRESTORE = StringToInt(GetStringRight(sITEM, 2));
	int nPRAY = GetSkillRank(SKILL_PRAYER, oPC, TRUE);
	int nPOINTS = GetLocalInt(oESSENCE, "PRAYER_POINTS");
	int nNEW = nPOINTS + nRESTORE;
	if (nNEW > nPRAY) nNEW = nPRAY;
	SetLocalInt(oESSENCE, "PRAYER_POINTS", nNEW);
}

void main()
{
	object oMOD = GetModule();
	object oPC = GetItemActivator();
	object oITEM = GetItemActivated();
	object oTARGET = GetItemActivatedTarget();
	string sITEM = GetTag(oITEM);
	string sTARGET = GetTag(oTARGET);
	
	//Healing from Food and other tag based scripts
	float fHEAL = GetLocalFloat(oITEM, "healAmt");
	if (fHEAL > 0.0)
	{
		int nHEAL = FloatToInt(fHEAL);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHEAL), oPC, 0.0);
	}
	else if (GetStringLeft(sITEM, 4) == "logs") UseLogs(oPC, oITEM, oTARGET);
	else if (sITEM == "tinderbox") UseTinderbox(oPC, oTARGET);
	else if (sITEM == "shears") UseShears(oPC, sTARGET);
	else if (GetStringRight(sITEM, 5) == "bones") BuryBones(oPC, sITEM);
	else if (GetStringLeft(sITEM, 14) == "potion_prayer_") PrayerPotion(oPC, sITEM);
	else
	{
		// Auto-Generated by Legends Master Configurator 1.92
		ExecuteScript("leg_all_mastermod_itemactivated", oMOD);
		ExecuteScript("itemconvo", oITEM);
	}

	//Default NWN2 tag based scripts
	if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
	{
		SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);
		int nRet = ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oITEM), oMOD);
		if (nRet == X2_EXECUTE_SCRIPT_END) return;
	}
}