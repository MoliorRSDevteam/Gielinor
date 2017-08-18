#include "profession_include"

void PopulateItems(object oPC, int nINPUT_TOTAL, int nINPUT_MAXSTACK, int nOUTPUT_MAXSTACK, int nICON, string sFIRST, string sLAST, string sINPUT_REF, string sOUTPUT_REF, string sOUTPUT_TAG)
{
	object oOUTPUT;
	int nOUTPUT_TOTAL = nINPUT_TOTAL;
	int nOUTPUT_STACK = nOUTPUT_MAXSTACK;
	while (nOUTPUT_TOTAL > 0)
	{
		if (nOUTPUT_TOTAL < nOUTPUT_MAXSTACK) nOUTPUT_STACK = nOUTPUT_TOTAL;
		oOUTPUT = CreateItemOnObject(sOUTPUT_REF, oPC, nOUTPUT_STACK, sOUTPUT_TAG, FALSE);
		if (sOUTPUT_REF == "noted_item")
		{
			SetLocalInt(oOUTPUT, "NOTE_MAXSTACK", nINPUT_MAXSTACK);
			SetLocalString(oOUTPUT, "NOTE_REF", sINPUT_REF);	
			SetItemIcon(oOUTPUT, nICON);
			SetFirstName(oOUTPUT, "<c=orange>" + sFIRST);
			SetLastName(oOUTPUT, sLAST + "*</c>");
		}
		SetIdentified(oOUTPUT, TRUE);
		nOUTPUT_TOTAL = nOUTPUT_TOTAL - nOUTPUT_MAXSTACK;
	}
}

void ConvertItems(object oPC, object oINPUT, int nINV, int nALL, string s2DA = "baseitems", string sCOL = "Stacking")
{
	int nICON;
	string sFIRST;
	string sLAST;
	int nCACHE = GetNum2DARows(s2DA);
	string sINPUT_REF = GetResRef(oINPUT);
	string sINPUT_TAG = GetTag(oINPUT);
	int nINPUT_STACK = GetItemStackSize(oINPUT);
	int nINPUT_TYPE = GetBaseItemType(oINPUT);
	string sINPUT_MAXSTACK = Get2DAString(s2DA, sCOL, nINPUT_TYPE);
	int nINPUT_MAXSTACK = StringToInt(sINPUT_MAXSTACK);
	int nOUTPUT_MAXSTACK;
	string sOUTPUT_REF;
	string sOUTPUT_TAG = sINPUT_TAG;
	if (sINPUT_REF == "noted_item")
	{
		if (nALL == TRUE)
		{
			SendMessageToPC(oPC, "The convert all functionality is not available for noted items. You can only convert them one stack at a time.");
			return;
		}
		sOUTPUT_REF = GetLocalString(oINPUT, "NOTE_REF");
		nOUTPUT_MAXSTACK = GetLocalInt(oINPUT, "NOTE_MAXSTACK");
		if (nOUTPUT_MAXSTACK < 1) nOUTPUT_MAXSTACK = 1;
	}
	else
	{		
		if (nINPUT_MAXSTACK >= 9999)
		{
			SendMessageToPC(oPC, "This function can be used only for items that have a maximum stack size lower than 9999.");
			return;
		}
		nICON = GetItemIcon(oINPUT);
		sFIRST = GetFirstName(oINPUT);
		sLAST = GetLastName(oINPUT);
		sOUTPUT_REF = "noted_item";
		nOUTPUT_MAXSTACK = 10000;
	}
	int nINPUT_TOTAL = nINPUT_STACK;
	int nITEMS = (nINPUT_TOTAL / nOUTPUT_MAXSTACK);
	if (nINV + nITEMS > 127)
	{
		SendMessageToPC(oPC, "You are attempting to convert too many items. Please use a smaller stack.");
		return;
	}
	if (nALL = TRUE)
	{
		object oINVALID = OBJECT_INVALID;
		object oITEM = GetFirstItemInInventory(oPC);
		while (oITEM != oINVALID)
		{
			if (GetTag(oITEM) == sINPUT_TAG)
			{
				if (GetResRef(oITEM) == sINPUT_REF)
				{
					if (oITEM != oINPUT)
					{
						nINPUT_TOTAL = nINPUT_TOTAL + GetItemStackSize(oITEM);
						DestroyObject(oITEM);
					}
				}
			}
			oITEM = GetNextItemInInventory(oPC);
		}
	}
	DestroyObject(oINPUT);
	DelayCommand(0.0f, PopulateItems(oPC, nINPUT_TOTAL, nINPUT_MAXSTACK, nOUTPUT_MAXSTACK, nICON, sFIRST, sLAST, sINPUT_REF, sOUTPUT_REF, sOUTPUT_TAG));
}

void main(int nALL = FALSE)
{
	object oPC = GetPCSpeaker();
	object oINPUT = GetPlayerCurrentTarget(oPC);
	if (GetItemPossessor(oINPUT) != oPC)
	{
		SendMessageToPC(oPC, "Please target one of the items in your possession first.");
		return;
	}
	if (GetPlotFlag(oINPUT) == TRUE)
	{
		SendMessageToPC(oPC, "Plot items are not eligible for this service.");
		return;
	}
	if (GetItemCursedFlag(oINPUT) == TRUE)
	{
		SendMessageToPC(oPC, "Cursed items are not eligible for this service.");
		return;
	}
	if (GetIdentified(oINPUT) == FALSE)
	{
		SendMessageToPC(oPC, "You must identify an item before noting it.");
		return;
	}
	int nINV = GetInventoryNum(oPC);
	if (nINV > 126)
	{
		SendMessageToPC(oPC, "You must have at least two free slots in your inventory to use this service (this is necessary to avoid potential item losses).");
		return;
	}
	DelayCommand(0.0f, ConvertItems(oPC, oINPUT, nINV, nALL));
}