#include "profession_include"

//The Main Differences are with the profession_production script used in convos are the following:
//1 - arguments HAVE TO BE STRINGS. UI in NWN2 can only take STRING variables as arguments.
//2 - POOLS have to be specified by TAGS, if any. (for example with Furnace).
//3 - The Skill requirement as to be specified as well in the arguments
//4 - POOLS and REQs have been added as arguments BEFORE sOUTPUT, so it should be easier to copy from convo.
//Refer to the fletching xml to see how it was implemented on the "OnLeftClick=UIObject_Misc_ExecuteServerScript" lines.

void main(string sPOOL, string sREQ, string sOUTPUT, string sMULT, string sSKILL, string sXP, string sTAG_A, string sQTY_A, string sTAG_B, string sQTY_B, string sSUCCESS_CHANCE, string sFAIL_PRODUCT, string sQTY_O)
{
	object oPC = OBJECT_SELF;
	if (sOUTPUT == "woodenhandle")
	{
		int nQUEST = GetJournalEntry("25", oPC);
		if ((nQUEST !=8) || (nQUEST != 11))
		{
			SendMessageToPC(oPC, "You must have completed the quest 'Scheme of Schematics' to be able to produce this item.");
			return;
		}
	}
	object oINVALID = OBJECT_INVALID;
	object oPOOL = oINVALID;
	if (sPOOL != "")
	{
		oPOOL = GetNearestObjectByTag(sPOOL, oPC);
		string sNAME_POOL = GetName(oPOOL);
		if (oPOOL == oINVALID)
		{
			SendMessageToPC(oPC, "You must be closer to a " + sNAME_POOL + " to be able to produce this item.");
			return;
		}
		float fDIST = GetDistanceBetween(oPC, oPOOL);
		if (fDIST > 20.0)
		{
			SendMessageToPC(oPC, "You must be closer to a " + sNAME_POOL + " to be able to produce this item.");
			return;
		}
	}
	string sANIM = "craft01";
	string sSOUND;
	int nSKILL = StringToInt(sSKILL);
	switch (nSKILL)
	{
		case SKILL_CRAFTING: sSOUND = "Crafting"; sANIM = "craft01"; break;
		case SKILL_SMITHING: sSOUND = "Smithing"; sANIM = "forge01"; break;
		case SKILL_RUNECRAFTING: sSOUND = "Runecrafting"; sANIM = "worship "; break;
		case SKILL_CONSTRUCTION: sSOUND = "Construction"; sANIM = "forge02"; break;
		case SKILL_COOKING: sSOUND = "Cooking"; sANIM = "cooking01"; break;
		case SKILL_FLETCHING: sSOUND = "Fletching"; sANIM = "craft01"; break;
		case SKILL_PRAYER: sSOUND = "Prayer"; sANIM = "worship"; break;
		default: return;
	}
	int nREQ = StringToInt(sREQ);
	if (GetSkillRank(nSKILL, oPC) < nREQ)
	{
		SendMessageToPC(oPC, "You must have at least " + sREQ + " ranks in " + sSOUND + " to be able to produce this item.");
		return;
	}
	if (sPOOL == "furnace") sANIM = "forge02";
	SetLocalString(oPC, "INPUT_TAG_A", sTAG_A);
	SetLocalString(oPC, "INPUT_TAG_B", sTAG_B);
	SetLocalString(oPC, "OUTPUT_TAG", sOUTPUT);
	SetLocalString(oPC, "FAIL_TAG", sFAIL_PRODUCT);
	SetLocalInt(oPC, "PROF_SKILL", nSKILL);
	SetLocalInt(oPC, "INPUT_QTY_A", StringToInt(sQTY_A));
	SetLocalInt(oPC, "INPUT_QTY_B", StringToInt(sQTY_B));
	SetLocalInt(oPC, "SUCCESS_CHANCE", StringToInt(sSUCCESS_CHANCE));
	SetLocalInt(oPC, "OUTPUT_XP", StringToInt(sXP));
	SetLocalInt(oPC, "OUTPUT_MULT", StringToInt(sMULT));
	SetLocalInt(oPC, "OUTPUT_QTY", StringToInt(sQTY_O));
	BeginProfessionLoop(oPC, oPOOL, sSOUND, sANIM);
}