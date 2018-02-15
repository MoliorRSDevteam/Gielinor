#include "profession_include"

void HarvestPlant(object oPC, object oPLANT)
{
	int nXP = GetLocalInt(oPLANT, "PLANT_XP");
	GiveCraftXP(oPC, SKILL_FARMING, nXP);
	if (GetLocalInt(oPLANT, "PLANT_STUMP") == TRUE)
	{
		SendMessageToPC(oPC, "The tree stump may now be harvested.");
		DeleteLocalInt(oPLANT, "PLANT_STAGE");
		return;
	}
	int nSKILL = GetSkillRank(SKILL_FARMING, oPC);
	int nREQ = GetLocalInt(oPLANT, "PLANT_REQ");
	int nITEMS = 1 + (nSKILL - nREQ) / 2;
	if (nITEMS > 30) nITEMS = 30;
	else if (nITEMS < 1) nITEMS = 1;
	string sITEM = GetLocalString(oPLANT, "PLANT_ITEM");
	object oITEM = CreateItemOnObject(sITEM, oPC, nITEMS);
	DestroyObject(oPLANT);
}

void AdjustPlant(object oPLANT, string sNAME, float fTIME, int nXP, int nFARM, int nTREE)
{
	SetFirstName(oPLANT, sNAME + " (planted)");
	SetLocalInt(oPLANT, "PLANT_STAGE", 1);
	SetLocalInt(oPLANT, "PLANT_XP", nXP);
	SetLocalInt(oPLANT, "PLANT_REQ", nFARM);
	SetLocalFloat(oPLANT, "PLANT_TIME", fTIME);
	if (nTREE == TRUE) SetLocalInt(oPLANT, "PLANT_STUMP", TRUE);
	else SetLocalString(oPLANT, "PLANT_ITEM", GetStringLowerCase(sNAME));
}

//Retrieve the proper plant that has to spawn (looks, exp, items, ecc...)
//Found in "table_farming.nss"
void RetrieveProperPlant(object oPC, object oITEM, int nSEED)
{
	float fTIME = 600.0;
	int nFARM;
	string sNAME; //The name of the plant. The resref of item awarded (if any) is generally the lower case of this string.
	string sPLANT; //The resref of the placeable spawned that represents the plant iself. (How it looks like)
	switch (nSEED)
	{
		//Allotments
		case 100: sNAME = "Potatoe";	sPLANT = "cabbage";		nFARM = 1;	break;
		case 101: sNAME = "Onion";		sPLANT = "onion";		nFARM = 5;	break;
		case 102: sNAME = "Cabbage";	sPLANT = "cabbage";		nFARM = 7; 	break;
		case 103: sNAME = "Tomato";		sPLANT = "cabbage";		nFARM = 12;	break;
		case 104: sNAME = "Sweetcorn";	sPLANT = "cabbage";		nFARM = 20;	break;
		case 105: sNAME = "Strawberry";	sPLANT = "cabbage";		nFARM = 31;	break;
		case 106: sNAME = "Watermelon";	sPLANT = "cabbage";		nFARM = 47;	break;
		
		//Flowers
		case 205: sNAME = "Limpwurt";	sPLANT = "cabbage";		nFARM = 26; break;
		
		//Herbs
		case 300: sNAME = "Guam";		sPLANT = "cabbage"; 	nFARM = 9;	fTIME = 1800.0; break;
		case 301: sNAME = "Marrentil";	sPLANT = "cabbage";		nFARM = 14;	fTIME = 1800.0; break;
		case 302: sNAME = "Tarromin";	sPLANT = "cabbage";		nFARM = 19;	fTIME = 1800.0; break;
		case 303: sNAME = "Harralander";sPLANT = "cabbage";		nFARM = 26;	fTIME = 1800.0; break;
		case 305: sNAME = "Ranarr";		sPLANT = "cabbage";		nFARM = 32;	fTIME = 1800.0; break;
		
		//Hops (Not Implemented yet)
		case 400: sNAME = "Barley";		sPLANT = "cabbage";		nFARM = 3;	break;
		
		//Bushes
		case 500: sNAME = "Redberries";		sPLANT = "cabbage";		nFARM = 10; break;
		case 501: sNAME = "Cadavaberries";	sPLANT = "cabbage";		nFARM = 22; break;
		
		//Trees
		case 600: sNAME = "Oak Tree";		sPLANT = "oakstump";	nFARM = 15;	fTIME = 3600.0; break;
		case 601: sNAME = "Willow Tree";	sPLANT = "willowstump";	nFARM = 30; fTIME = 3600.0; break;
		case 602: sNAME = "Maple Tree";		sPLANT = "maplestump";	nFARM = 45; fTIME = 3600.0; break;
		case 603: sNAME = "Yew Tree";		sPLANT = "yewstump";	nFARM = 60; fTIME = 3600.0; break;
		case 604: sNAME = "Magic Tree";		sPLANT = "magicstump";	nFARM = 75; fTIME = 3600.0; break;
		
		default: return;
	}
	
	if (GetSkillRank(SKILL_FARMING, oPC) < nFARM)
	{
		SendMessageToPC(oPC, "You need level " + IntToString(nFARM) + "in Farming to be able to plant that seed.");
		return;
	}
	
	int nSTACK = GetItemStackSize(oITEM);
	if (nSTACK > 1) SetItemStackSize(oITEM, nSTACK - 1);
	else DestroyObject(oITEM);
	
	int nTREE;
	if (nTREE > 599) nTREE = TRUE;
	int nTIME = FloatToInt(fTIME);
	int nXP = nFARM * 10 * (nTIME / 60);
	object oPLANT = CreateObject(OBJECT_TYPE_PLACEABLE, sPLANT, GetLocation(oPC), FALSE, sNAME);
	DelayCommand(0.0f, AdjustPlant(oPLANT, sNAME, fTIME, nXP, nFARM, nTREE));
}