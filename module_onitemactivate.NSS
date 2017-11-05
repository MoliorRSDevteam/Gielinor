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
	object oESSENCE = GetItemPossessedBy(oPC, "player_essence");
	int nRESTORE = StringToInt(GetStringRight(sITEM, 2));
	int nPRAY = GetSkillRank(SKILL_PRAYER, oPC, TRUE);
	int nPOINTS = GetLocalInt(oESSENCE, "PRAYER_POINTS");
	int nNEW = nPOINTS + nRESTORE;
	if (nNEW > nPRAY) nNEW = nPRAY;
	SetLocalInt(oESSENCE, "PRAYER_POINTS", nNEW);
}

void AdjustPlant(object oPLANT, string sNAME, float fTIME, int nXP)
{
	SetFirstName(oPLANT, sNAME + " (planted)");
	SetLocalInt(oPLANT, "PLANT_STAGE", 1);
	SetLocalInt(oPLANT, "PLANT_XP", nXP);
	SetLocalFloat(oPLANT, "PLANT_TIME", fTIME);
}

void PlantSeed(object oPC, object oITEM, string sITEM)
{
	object oAREA = GetArea(oPC);
	if (GetIsAreaInterior(oAREA) == TRUE)
	{
		SendMessageToPC(oPC, "Seeds may not be planted in underground or interior areas.");
		return;
	}
	string sSEED = GetStringRight(sITEM, 3);
	string sBLUEPRINT;
	string sNAME;
	float fTIME = 600.0;
	int nFARM;
	int nSEED = StringToInt(sSEED);
	switch (nSEED)
	{
		//Allotments
		case 100: sNAME = "Potato";		sBLUEPRINT = "cabbage";		nFARM = 1;	break;
		case 101: sNAME = "Onion";		sBLUEPRINT = "onion";		nFARM = 5;	break;
		case 102: sNAME = "Cabbage";	sBLUEPRINT = "cabbage";		nFARM = 7; 	break;
		case 103: sNAME = "Tomato";		sBLUEPRINT = "cabbage";		nFARM = 12;	break;
		case 104: sNAME = "Sweetcorn";	sBLUEPRINT = "cabbage";		nFARM = 20;	break;
		case 105: sNAME = "Strawberry";	sBLUEPRINT = "cabbage";		nFARM = 31;	break;
		case 106: sNAME = "Watermelon";	sBLUEPRINT = "cabbage";		nFARM = 47;	break;
		
		//Flowers
		case 205: sNAME = "Limpwurt";	sBLUEPRINT = "cabbage";		nFARM = 26; break;
		
		//Herbs
		case 300: sNAME = "Guam";		sBLUEPRINT = "cabbage"; 	nFARM = 9;	fTIME = 1800.0; break;
		case 301: sNAME = "Marrentil";	sBLUEPRINT = "cabbage";		nFARM = 14;	fTIME = 1800.0; break;
		case 302: sNAME = "Tarromin";	sBLUEPRINT = "cabbage";		nFARM = 19;	fTIME = 1800.0; break;
		case 303: sNAME = "Harralander";sBLUEPRINT = "cabbage";		nFARM = 26;	fTIME = 1800.0; break;
		case 305: sNAME = "Ranarr";		sBLUEPRINT = "cabbage";		nFARM = 32;	fTIME = 1800.0; break;
		
		//Hops (Not Implemented yet)
		case 400: sNAME = "Barley";		sBLUEPRINT = "cabbage";		nFARM = 3;	break;
		
		//Bushes
		case 500: sNAME = "Redberry";	sBLUEPRINT = "cabbage";		nFARM = 10; break;
		case 501: sNAME = "Cadava";		sBLUEPRINT = "cabbage";		nFARM = 22; break;
		
		//Trees
		case 600: sNAME = "Oak Tree";		sBLUEPRINT = "oakstump";	nFARM = 15;	fTIME = 3600.0; break;
		case 601: sNAME = "Willow Tree";	sBLUEPRINT = "willowstump";	nFARM = 30; fTIME = 3600.0; break;
		case 602: sNAME = "Maple Tree";		sBLUEPRINT = "maplestump";	nFARM = 45; fTIME = 3600.0; break;
		case 603: sNAME = "Yew Tree";		sBLUEPRINT = "yewstump";	nFARM = 60; fTIME = 3600.0; break;
		case 604: sNAME = "Magic Tree";		sBLUEPRINT = "magicstump";	nFARM = 75; fTIME = 3600.0; break;
		
		default: return;
	}
	if (GetSkillRank(SKILL_FARMING, oPC) < nFARM)
	{
		SendMessageToPC(oPC, "You must have at least " + IntToString(nFARM) + "ranks in Farming to be able to plant that seed.");
		return;
	}
	int nTIME = FloatToInt(fTIME);
	int nXP = nFARM * 10 * (nTIME / 60);
	int nSTACK = GetItemStackSize(oITEM);
	if (nSTACK > 1) SetItemStackSize(oITEM, nSTACK - 1);
	else DestroyObject(oITEM);
	object oPLANT = CreateObject(OBJECT_TYPE_PLACEABLE, sBLUEPRINT, GetLocation(oPC), FALSE, sNAME);
	DelayCommand(0.0f, AdjustPlant(oPLANT, sNAME, fTIME, nXP));
}

void Compost(object oPC, object oITEM, object oPLANT)
{
	int nSTAGE = GetLocalInt(oPLANT, "PLANT_STAGE");
	if (nSTAGE != 1)
	{
		SendMessageToPC(oPC, "Composts may be used only on plants that are not growing yet.");
		return;
	}
	int nSUPER = GetLocalInt(oITEM, "SUPER");
	float fTIME = GetLocalFloat(oPLANT, "PLANT_TIME");
	if (nSUPER == 1) fTIME = fTIME / 2.0;
	SetLocalInt(oPLANT, "PLANT_STAGE", 2);
	DelayCommand(fTIME, SetLocalInt(oPLANT, "PLANT_STAGE", 3));
	FloatingTextStringOnCreature("This plant is now growing. It will take " + FloatToString(fTIME, 18, 0) + " seconds before it can be harvested.", oPC, FALSE);
	int nITEM = GetItemStackSize(oITEM);
	if (nITEM > 1) SetItemStackSize(oITEM, nITEM - 1);
	else DestroyObject(oITEM);
}

void PlantCure(object oPC, object oITEM, object oPLANT)
{
	if (GetLocalInt(oPLANT, "PLANT_STAGE") != 4)
	{
		SendMessageToPC(oPC, "Plant Cures may be used only on ill plants.");
		return;
	}
	int nITEM = GetItemStackSize(oITEM);
	if (nITEM > 1) SetItemStackSize(oITEM, nITEM - 1);
	else DestroyObject(oITEM);
	int nXP = GetLocalInt(oPLANT, "PLANT_XP");
	GiveCraftXP(oPC, SKILL_FARMING, nXP);
	if (GetLocalInt(oPLANT, "PLANT_STUMP") == TRUE)
	{
		SendMessageToPC(oPC, "The tree stump may now be harvested.");
		DeleteLocalInt(oPLANT, "PLANT_STAGE");
		return;
	}
	string sITEM = GetLocalString(oPLANT, "PLANT_ITEM");
	if (sITEM == "") sITEM = GetTag(oPLANT);
	CreateItemOnObject(sITEM, oPC);
	DestroyObject(oPLANT);
}

void Henchman(object oPC, string sITEM)
{
	string sTYPE = GetStringRight(sITEM, 3);
	int nTYPE = StringToInt(sTYPE);
	string sHENCH;
	switch (nTYPE) //Add the ResRef of the various henchmen here. Make sure it has three digits (ie 002, 003, ecc.)
	{
		case 001: sHENCH = "alkharidbodyguard"; break;
		default: return;
	}
	object oHENCH = GetHenchman(oPC);
	if (oHENCH != OBJECT_INVALID)
	{
		RemoveHenchman(oPC, oHENCH);
		DestroyObject(oHENCH);
		if (GetTag(oHENCH) == sHENCH) return;
	}
	oHENCH = CreateObject(OBJECT_TYPE_CREATURE, sHENCH, GetLocation(oPC));
	DelayCommand(0.0f, AddHenchman(oPC, oHENCH));
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
	else if (GetStringLeft(sITEM, 9) == "henchman_") Henchman(oPC, sITEM);
	else if (GetStringLeft(sITEM, 5) == "seed_") PlantSeed(oPC, oITEM, sITEM);
	else if (GetStringRight(sITEM, 7) == "compost") Compost(oPC, oITEM, oTARGET);
	else if (sITEM == "plantcure") PlantCure(oPC, oITEM, oTARGET);
	else if (GetStringLeft(sITEM, 4) == "logs") UseLogs(oPC, oITEM, oTARGET);
	else if (sITEM == "tinderbox") UseTinderbox(oPC, oTARGET);
	else if (sITEM == "shears") UseShears(oPC, sTARGET);
	else if (GetStringRight(sITEM, 5) == "bones") BuryBones(oPC, sITEM);
	else if (GetStringLeft(sITEM, 14) == "potion_prayer_") PrayerPotion(oPC, sITEM);
	else if (sITEM == "knife") DisplayGuiScreen(oPC, "SCREEN_FLETCHM_1", FALSE, "fletchingmenu.xml");
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