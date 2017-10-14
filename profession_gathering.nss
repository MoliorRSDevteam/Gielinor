#include "profession_include"

void main()
{
	object oPC = GetLastUsedBy();
	if (GetLocalInt(oPC, "PROF_SKILL") > 0) return;
	object oPOOL = OBJECT_SELF;
	string sTOOL = GetLocalString(oPOOL, "TOOL");
	string sADD = GetLocalString(oPOOL, "ADD");
	string sWARN = HSS_FEEDBACK_COLOUR + GetLocalString(oPOOL, "WARN");
	int nEQUIP;
	int nLVL = GetLocalInt(oPOOL, "LEVEL");
	int nSKILL = GetLocalInt(oPOOL, "SKILL");
	string sANIM;
	string sPROF;
	switch (nSKILL)
	{
		case SKILL_FISHING:	
			sPROF = "Fishing";
			sANIM = "fishrod";
			if (sADD == "") sANIM = "fishnet";
			break;
		case SKILL_MINING:
			sPROF = "Mining";
			sANIM = "*1attack01";
			nEQUIP = TRUE;
			break;
		case SKILL_WOODCUTTING: 
			sPROF = "Woodcutting";
			sANIM = "*1attack02";
			nEQUIP = TRUE;
			break;
		default: SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "An error occurred: the resource node is not linked to any gathering profession."); return;
	}
	SetLocalString(oPC, "PROF_SOUND", sPROF);
	int nSKILLRANK = GetSkillRank(nSKILL, oPC);
	if (nSKILLRANK < nLVL)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need at least " + IntToString(nLVL) + " levels in " + sPROF + " to gather resources from this node.");
		return;
	}
	object oINVALID = OBJECT_INVALID;
	object oTOOL = GetItemPossessedBy(oPC, sTOOL);
	if (nEQUIP == TRUE)
	{
		oTOOL = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		if (GetTag(oTOOL) != sTOOL)
		{
			oTOOL = oINVALID;
			sWARN = sWARN + " (The item has to be equipped)";
		}
	}
	object oADD = GetItemPossessedBy(oPC, sADD);
	if ((sTOOL != "") && (oTOOL == oINVALID)) SendMessageToPC(oPC, sWARN);
	else if ((sADD != "") && (oADD == oINVALID)) SendMessageToPC(oPC, sWARN);
	else 
	{
		ReallyPlaySound(GetLocation(oPC), sPROF);
		float fTOOL = IntToFloat(GetLocalInt(oTOOL, "QUALITY") * 2);
		float fMASTER = IntToFloat(nSKILLRANK - nLVL);
		if (fMASTER > 20.0) fMASTER = 20.0;
		float fDIV = 5.0;
		if (nSKILL = SKILL_FISHING) fDIV = 1.25;
		fMASTER = fMASTER / fDIV;
		float fLOOP = 20.0 - fTOOL - fMASTER;
		if (fLOOP < 4.0) fLOOP = 4.0;
		SetLocalInt(oPC, "PROF_SKILL", nSKILL);
		SetLocalFloat(oPC, "PROF_LOOP", fLOOP);
		BeginProfessionLoop(oPC, oPOOL, "Fishing", sANIM);
	}
}