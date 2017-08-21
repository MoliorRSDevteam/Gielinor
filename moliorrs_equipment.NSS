#include "nw_i0_spells"

const int FX_EQUIP = -9004;

void SpellResistanceFix(object oPC, string s2DA = "iprp_srcost", string sCOL = "Value")
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
					nSR = StringToInt(Get2DAString(s2DA, sCOL, nTABLE));
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

int CheckRequirements(object oPC, object oITEM)
{
	int nLVL = GetLocalInt(oITEM, "level");
	if (nLVL < 1) return TRUE;
	string sFEED;
	string sCLASS;
	string sVAR = "class";
	int nCLASS;
	int nCOUNT;
	while (nCOUNT < 3)
	{
		if (nCOUNT > 0) sVAR = "class" + IntToString(nCOUNT);
		sCLASS = GetLocalString(oITEM, sVAR);
		if (sCLASS == "fighter") nCLASS = CLASS_TYPE_FIGHTER;
		else if (sCLASS == "ranger") nCLASS = CLASS_TYPE_RANGER;
		else if (sCLASS == "wizard") nCLASS = CLASS_TYPE_WIZARD;
		else if (sCLASS == "rogue") nCLASS = CLASS_TYPE_ROGUE;
		else break;
		if (GetLevelByClass(nCLASS, oPC) >= nLVL) return TRUE;
		sFEED = sFEED + sCLASS + " ";
		nCOUNT = nCOUNT + 1;
	}
	if (nCOUNT > 0) sFEED = "You need to have at least " + IntToString(nLVL) + " levels as " + sFEED;
	else if (GetHitDice(oPC) < nLVL) sFEED = "You need to be level " + IntToString(nLVL) + " ";
	else return TRUE; 
	sFEED = sFEED + "to be able to wear this item.";
	SetLocalString(oPC, "EQUIP_FEEDBACK", sFEED);	
	return FALSE;
}

void BeginHandlingEquipment(object oPC, object oITEM, int nUNEQUIP = FALSE)
{
	if (nUNEQUIP == FALSE)
	{
		if (CheckRequirements(oPC, oITEM) == FALSE)
		{
			AssignCommand(oPC, ClearAllActions(TRUE));
			AssignCommand(oPC, ActionUnequipItem(oITEM));
			string sFEED = GetLocalString(oPC, "EQUIP_FEEDBACK");
			SendMessageToPC(oPC, sFEED);
			DeleteLocalString(oPC, "EQUIP_FEEDBACK");
			return;
		}
	}
	RemoveEffectsFromSpell(oPC, FX_EQUIP);
	DelayCommand(0.0f, SpellResistanceFix(oPC));
}