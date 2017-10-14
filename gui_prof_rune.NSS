#include "profession_include"

void RuneTeleport(object oPC, int nINPUT)
{
	int nXP;
	int nREQ;
	string sRUNE;
	string sLOC;
	switch (nINPUT)
	{
		case 1: nXP = 35; nREQ = 25; sLOC = "Varrock"; sRUNE = "Fire"; break;
		case 2: nXP = 41; nREQ = 31; sLOC = "Lumbridge"; sRUNE = "Earth"; break;
		case 3: nXP = 48; nREQ = 37; sLOC = "Falador"; sRUNE = "Water"; break;
		default: return;
	}
	string sTXT;
	int nRANK = GetSkillRank(SKILL_RUNECRAFTING, oPC);
	if (nRANK < nREQ)
	{
		sTXT = "You need " + IntToString(nREQ) + " ranks in Runecrafting to be able to teleport to that location";
		SendMessageToPC(oPC, sTXT);
		return;
	}
	location lPC = GetLocation(oPC);
	object oINVALID = OBJECT_INVALID;
	object oPLAYER = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_ASTRONOMIC, lPC);
	while (oPLAYER != oINVALID)
	{
		if ((GetIsPC(oPLAYER) == TRUE) && (GetIsEnemy(oPLAYER, oPC) == TRUE))
		{
			sTXT = "You may not teleport while a hostile player is nearby.";
			SendMessageToPC(oPC, sTXT);
			return;
		}
		oPLAYER = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_ASTRONOMIC, lPC);
	}
	SetLocalInt(oPC, "RUNE_UI", 1);
	SetLocalInt(oPC, "TELEPORT_XP", nXP);
	SetLocalString(oPC, "TELEPORT_DEST", GetStringLowerCase(sLOC) + "loderc");
	SetLocalString(oPC, "TELEPORT_COST", GetStringLowerCase(sRUNE) + "rune");
	sTXT = "Teleporting to " + sLOC + " will cost you 1 Law Rune, 3 Air Runes and 1 " + sRUNE + " Rune. Are you sure about it?";
	DisplayMessageBox(oPC, 0, sTXT, "gui_prof_rune", "", TRUE);
}

void RuneEnchant(object oPC, int nINPUT)
{
	object oITEM = GetPlayerCurrentTarget(oPC);
	string sTXT;
	if (GetItemPossessor(oITEM) != oPC)
	{
		sTXT = "You may only enchant items in your inventory (select by targeting item with right click).";
		SendMessageToPC(oPC, sTXT);
		return;
	}
	int nXP;
	int nREQ;
	int nRUNE_A;
	int nRUNE_B;
	string sRUNE_A;
	string sRUNE_B;
	string sMAT;
	switch (nINPUT)
	{
		case 1: nXP = 17; nREQ = 7; sMAT = "Sapphire"; sRUNE_A = "Water"; sRUNE_B = "Mind"; nRUNE_A = 1; nRUNE_B = 1; break;
		case 2: nXP = 37; nREQ = 27; sMAT = "Emerald"; sRUNE_A = "Air"; sRUNE_B = "Nature"; nRUNE_A = 3; nRUNE_B = 1; break;
		case 3: nXP = 59; nREQ = 49; sMAT = "Ruby"; sRUNE_A = "Fire"; sRUNE_B = "Blood"; nRUNE_A = 5; nRUNE_B = 1; break;
		case 4: nXP = 67; nREQ = 57; sMAT = "Diamond"; sRUNE_A = "Earth"; sRUNE_B = "Law"; nRUNE_A = 10; nRUNE_B = 2; break;
		default: return;
	}
	int nRANK = GetSkillRank(SKILL_RUNECRAFTING, oPC);
	if (nRANK < nREQ)
	{
		sTXT = "You need " + IntToString(nREQ) + " ranks in Runecrafting to be able to perform that type of enchantment";
		SendMessageToPC(oPC, sTXT);
		return;
	}
	if ((GetLocalInt(oITEM, "ENCHANTABLE") != 1))
	{
		sTXT = "This item cannot be enchanted.";
		SendMessageToPC(oPC, sTXT);
		return;
	}
	if (GetStringLeft(GetTag(oITEM), GetStringLength(sMAT)) != GetStringLowerCase(sMAT))
	{
		sTXT = "You can only enchant items of the corresponding material (Sapphire on Sapphire, Emerald on Emerald, ecc...)";
		SendMessageToPC(oPC, sTXT);
		return;
	}
	string sCOST = IntToString(nRUNE_A) + " " + sRUNE_A + " runes and 1 Cosmic Rune.";
	if (GetBaseItemType(oITEM) == BASE_ITEM_BOLT) sCOST = IntToString(nRUNE_B) + " " + sRUNE_B + " runes, " + sCOST;
	sTXT = "Enchanting " + GetName(oITEM) + " will cost you " + sCOST + " Are you sure about it?";
	SetLocalObject(oPC, "ENCHANT_INPUT", oITEM);
	SetLocalString(oPC, "ENCHANT_RUNEA_TAG", GetStringLowerCase(sRUNE_A) + "rune");
	SetLocalString(oPC, "ENCHANT_RUNEB_TAG", GetStringLowerCase(sRUNE_B) + "rune");
	SetLocalInt(oPC, "ENCHANT_RUNEA_QTY", nRUNE_A);
	SetLocalInt(oPC, "ENCHANT_RUNEB_QTY", nRUNE_B);
	SetLocalInt(oPC, "RUNE_UI", 2);
	DisplayMessageBox(oPC, 0, sTXT, "gui_prof_rune", "", TRUE);
}

void RuneExecute(object oPC)
{
	int nFAIL;
	int nTYPE = GetLocalInt(oPC, "RUNE_UI");
	if (nTYPE == 1) //Teleporting
	{
		string sCOST = GetLocalString(oPC, "TELEPORT_COST");
		if (GetItemQuantity(oPC, sCOST) < 1) nFAIL = TRUE;
		else if (GetItemQuantity(oPC, "lawrune") < 1) nFAIL = TRUE;
		else if (GetItemQuantity(oPC, "airrune") < 3) nFAIL = TRUE;
		if (nFAIL == TRUE)
		{
			SendMessageToPC(oPC, "You do not possess the required runes.");
			return;
		}
		int nXP = GetLocalInt(oPC, "TELEPORT_XP");
		string sDEST = GetLocalString(oPC, "TELEPORT_DEST");
		GiveCraftXP(oPC, SKILL_RUNECRAFTING, nXP);
		RemoveItems(oPC, sCOST, 1);
		RemoveItems(oPC, "lawrune", 1);
		RemoveItems(oPC, "airrune", 3);
		DelayCommand(0.0f, AssignCommand(oPC, JumpToObject(GetObjectByTag(sDEST))));
	}
	else if (nTYPE == 2) //Enchanting
	{
		if (GetInventoryNum(oPC) >= 128)
		{
			SendMessageToPC(oPC, "Your inventory is full.");
			return;
		}
		string sRUNE_A = GetLocalString(oPC, "ENCHANT_RUNEA_TAG");
		string sRUNE_B = GetLocalString(oPC, "ENCHANT_RUNEB_TAG");
		int nRUNE_A = GetLocalInt(oPC, "ENCHANT_RUNEA_QTY");
		int nRUNE_B = GetLocalInt(oPC, "ENCHANT_RUNEB_QTY");
		int nTOT = 1;
		object oINPUT = GetLocalObject(oPC, "ENCHANT_INPUT");
		if (GetBaseItemType(oINPUT) == BASE_ITEM_BOLT) nTOT = 15;
		if (GetItemQuantity(oPC, "cosmicrune") < 1) nFAIL = TRUE;
		else if (GetItemQuantity(oPC, sRUNE_A) < nRUNE_A) nFAIL = TRUE;
		else if ((nTOT == 15) && (GetItemQuantity(oPC, sRUNE_B) < nRUNE_B)) nFAIL = TRUE;
		if (nFAIL == TRUE)
		{
			SendMessageToPC(oPC, "You do not possess the required runes.");
			return;
		}
		string sOUTPUT = GetTag(oINPUT) + "e";
		if (nTOT == 1) DestroyObject(oINPUT);
		else
		{
			int nSTACK = GetItemStackSize(oINPUT);
			if (nSTACK > 15) SetItemStackSize(oINPUT, nSTACK - 15);
			else if (nSTACK == 15) DestroyObject(oINPUT);
			else
			{
				SendMessageToPC(oPC, "You need at least 15 bolts in a single stack to enchant them.");
				return;
			}
		}			
		RemoveItems(oPC, "cosmicrune", 1);
		RemoveItems(oPC, sRUNE_A, nRUNE_A);
		if (nTOT == 15) RemoveItems(oPC, sRUNE_B, nRUNE_B);
		CreateItemOnObject(sOUTPUT, oPC, nTOT);
	}
}

void main(string sCOMMAND, string sINPUT)
{
	object oPC = OBJECT_SELF;
	int nINPUT = StringToInt(sINPUT);
	if (sCOMMAND == "TELEPORT") RuneTeleport(oPC, nINPUT);
	else if (sCOMMAND == "ENCHANT") RuneEnchant(oPC, nINPUT);
	else RuneExecute(oPC);
}