#include "nw_i0_spells"

const int FX_EQUIP = -9004;

void SpellResistanceFix(object oPC, string s2DA = "iprp_srcost")
{
	object oITEM;
	int nEQUIP;
	int nSR;
	int nMAX;
	int nTYPE;
	int nTABLE;
	int nCACHE = GetNum2DARows(s2DA);
	itemproperty iPROP;
	while (nEQUIP < 18)
	{
		oITEM = GetItemInSlot(nEQUIP, oPC);
		if (GetItemHasItemProperty(oITEM, ITEM_PROPERTY_SPELL_RESISTANCE) == TRUE)
		{
			iPROP = GetFirstItemProperty(oITEM);
			while (GetIsItemPropertyValid(iPROP))
			{
				nTYPE = GetItemPropertyType(iPROP);
				if (nTYPE == ITEM_PROPERTY_SPELL_RESISTANCE)
				{
					nTABLE = GetItemPropertyCostTableValue(iPROP);
					nSR = StringToInt(Get2DAString(s2DA, "Value", nTABLE));
					if (nSR > nMAX)	nMAX = nSR;
				}
				iPROP = GetNextItemProperty(oITEM);
			}
		}
		nEQUIP = nEQUIP + 1;
	}
	if (nMAX < 1) return;
	effect eSR = EffectSpellResistanceIncrease(nMAX);
	eSR = SupernaturalEffect(eSR);
	eSR = SetEffectSpellId(eSR, FX_EQUIP);
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSR, oPC);
}

int CheckRequirements(object oPC, object oITEM, int nTYPE)
{
	int nLVL = GetLocalInt(oITEM, "level");
	if (nLVL < 1) return TRUE;
	string sFEED;
	if (nTYPE == BASE_ITEM_ARMOR)
	{
		if (GetHitDice(oPC) >= nLVL) return TRUE;
		sFEED = "You need to be level " + IntToString(nLVL) + " to be able to wear this armor";
		SetLocalString(oPC, "EQUIP_FEEDBACK", sFEED);
		return FALSE;
	}
	string sCLASS_A = GetLocalString(oITEM, "class");
	int nCLASS_A;
	if (sCLASS_A == "fighter") nCLASS_A = CLASS_TYPE_FIGHTER;
	else if (sCLASS_A == "ranger") nCLASS_A = CLASS_TYPE_RANGER;
	else if (sCLASS_A == "wizard") nCLASS_A = CLASS_TYPE_WIZARD;
	else if (sCLASS_A == "rogue") nCLASS_A = CLASS_TYPE_ROGUE;
	if (GetLevelByClass(nCLASS_A, oPC) >= nLVL) return TRUE;
	if (nCLASS_A < 1) return TRUE;
	string sCLASS_B = GetLocalString(oITEM, "class1");
	int nCLASS_B;
	if (sCLASS_B == "fighter") nCLASS_B = CLASS_TYPE_FIGHTER;
	else if (sCLASS_B == "ranger") nCLASS_B = CLASS_TYPE_RANGER;
	else if (sCLASS_B == "wizard") nCLASS_B = CLASS_TYPE_WIZARD;
	else if (sCLASS_B == "rogue") nCLASS_B = CLASS_TYPE_ROGUE;
	if (GetLevelByClass(nCLASS_B, oPC) >= nLVL) return TRUE;
	string sCLASS_C = GetLocalString(oITEM, "class2");
	int nCLASS_C;
	if (sCLASS_C == "fighter") nCLASS_C = CLASS_TYPE_FIGHTER;
	else if (sCLASS_C == "ranger") nCLASS_C = CLASS_TYPE_RANGER;
	else if (sCLASS_C == "wizard") nCLASS_C = CLASS_TYPE_WIZARD;
	else if (sCLASS_C == "rogue") nCLASS_C = CLASS_TYPE_ROGUE;
	if (GetLevelByClass(nCLASS_C, oPC) >= nLVL) return TRUE;
	sFEED = "You need to have at least " + IntToString(nLVL) + " levels in " + sCLASS_A + "/" + sCLASS_B + "/" + sCLASS_C + " class to be able to wear this weapon.";
	SetLocalString(oPC, "EQUIP_FEEDBACK", sFEED);	
	return FALSE;
}

void BeginHandlingEquipment(object oPC, object oITEM, int nUNEQUIP = FALSE)
{
	if (nUNEQUIP == FALSE)
	{
		int nTYPE = GetBaseItemType(oITEM);
		if (CheckRequirements(oPC, oITEM, nTYPE) == FALSE)
		{
			AssignCommand(oPC, ClearAllActions(TRUE));
			AssignCommand(oPC, ActionUnequipItem(oITEM));
			string sFEED = GetLocalString(oPC, "EQUIP_FEEDBACK");;
			SendMessageToPC(oPC, sFEED);
			DeleteLocalString(oPC, "EQUIP_FEEDBACK");
			return;
		}
	}
	RemoveEffectsFromSpell(oPC, FX_EQUIP);
	DelayCommand(0.0f, SpellResistanceFix(oPC));
}