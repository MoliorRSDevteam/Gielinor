#include "profession_include"

void main(int nALL = FALSE)
{
	object oPC = GetPCSpeaker();
	object oITEM = GetPlayerCurrentTarget(oPC);
	if (GetItemPossessor(oITEM) != oPC)
	{
		SendMessageToPC(oPC, "Please target one of the items in your possession first.");
		return;
	}
	if (GetPlotFlag(oITEM) == TRUE)
	{
		SendMessageToPC(oPC, "Plot items are not eligible for this service.");
		return;
	}
	if (GetItemCursedFlag(oITEM) == TRUE)
	{
		SendMessageToPC(oPC, "Cursed items are not eligible for this service.");
		return;
	}
	int nINV = GetInventoryNum(oPC);
	if (nINV > 126)
	{
		SendMessageToPC(oPC, "You must have at least two free slots in your inventory to use this service, in order to avoid potential item losses.");
		return;
	}
	object oOUTPUT;
	string sREF = GetResRef(oITEM);
	string sTAG = GetTag(oITEM);
	int nTYPE = GetBaseItemType(oITEM);
	int nCACHE = GetNum2DARows("baseitems");
	string sMAX = Get2DAString("baseitems", "Stacking", nTYPE);
	int nMAX_I = StringToInt(sMAX);
	int nSTACK = GetItemStackSize(oITEM);
	if (sREF == "noted_item")
	{
		sREF = GetLocalString(oITEM, "NOTE_REF");
		oOUTPUT = CreateItemOnObject(sREF, oPC, 1, sTAG);
		nTYPE = GetBaseItemType(oOUTPUT);
		sMAX = Get2DAString("baseitems", "Stacking", nTYPE);
		int nMAX_O = StringToInt(sMAX);
		int nOUTPUT = nMAX_O;
		if (nMAX_O > nSTACK) nOUTPUT = nSTACK;
		if (nOUTPUT > 1)
		{
			DestroyObject(oOUTPUT, 0.0f, FALSE);
			oOUTPUT = CreateItemOnObject(sREF, oPC, nOUTPUT, sTAG);
		}
		if (nSTACK > nOUTPUT) SetItemStackSize(oITEM, nSTACK - nOUTPUT, FALSE);
		else DestroyObject(oITEM, 0.0f, FALSE);
		if (nALL != TRUE) return;
		nINV = nINV + 1;
		nSTACK = nSTACK - nOUTPUT;
		while (nSTACK > 0)
		{
			if (nINV > 126)
			{
				SendMessageToPC(oPC, "Full Inventory.");
				return;
			}
			if (nOUTPUT > nSTACK) nOUTPUT = nSTACK;
			oOUTPUT = CreateItemOnObject(sREF, oPC, nOUTPUT, sTAG);
			if (nSTACK > nOUTPUT) SetItemStackSize(oITEM, nSTACK - nOUTPUT, FALSE);
			else DestroyObject(oITEM, 0.0f, FALSE);
			nINV = nINV + 1;
			nSTACK = nSTACK - nOUTPUT;
		}
		return;
	}
	if (nMAX_I > 9999)
	{
		SendMessageToPC(oPC, "This function can be used only for items that have a maximum stack size lower than 10000.");
		return;
	}
	DestroyObject(oITEM, 0.0f, FALSE);
	if (nALL == TRUE)
	{
		object oINVALID = OBJECT_INVALID;
		object oINV = GetFirstItemInInventory(oPC);
		while (oINV != oINVALID)
		{
			if ((oINV != oITEM) && (GetResRef(oINV) == sREF) && (GetTag(oINV) == sTAG))
			{
				nSTACK = nSTACK + GetItemStackSize(oINV);
				DestroyObject(oINV, 0.0f, FALSE);
			}
			oINV = GetNextItemInInventory(oPC);
		}
	}
	while (nSTACK > 0)
	{
		oOUTPUT = CreateItemOnObject("noted_item", oPC, nSTACK, sTAG);
		SetLocalString(oOUTPUT, "NOTE_REF", sREF);
		SetItemIcon(oOUTPUT, GetItemIcon(oITEM));
		SetFirstName(oOUTPUT, "<c=orange>" + GetName(oITEM) + "*");
		nSTACK = nSTACK - 10000;
	}
}