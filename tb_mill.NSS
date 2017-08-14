#include "nw_i0_plot"
void DestroyItems(object oTarget,string sItem,int nNumItems);
void main()
{
	object oPC = GetLastUsedBy();
	string part = GetLocalString(OBJECT_SELF, "part");
	string areaName = GetName(GetArea(OBJECT_SELF));
	if (part == "hopper")
	{
		if (GetNumItems(oPC, "wheat") == 0 || GetLocalInt(oPC, areaName+"millhopper") == 1)
		{
			SendMessageToPC(oPC, "<color=white>" + "You've already put wheat into the mill.");
			return;
		}
		DestroyItems(oPC, "wheat", 1);
		SetLocalInt(oPC, areaName + "millhopper", 1);
		SendMessageToPC(oPC, "<color=white>" + "You put wheat into the hopper.");
	} else if (part == "lever")
	{
		if (GetLocalInt(oPC, areaName+"millhopper") == 0)
		{
			return;
		}
		ExecuteScript("x2_plc_used_act", OBJECT_SELF);
		SetLocalInt(oPC, areaName + "milllever", 1);
		SendMessageToPC(oPC, "<color=white>" + "You pull the lever and hear the wheat grind.");
	} else if (part == "flourbin")
	{
		if (GetLocalInt(oPC, areaName+"milllever") == 0)
		{
			SendMessageToPC(oPC, "<color=white>" + "There's no flour available.");
			return;
		} else if (GetNumItems(oPC, "emptypot") == 0)
		{
			SendMessageToPC(oPC, "<color=white>" + "You need an empty pot to collect the flour.");
			return;
		}
		SetLocalInt(oPC, areaName + "millhopper", 0);
		SetLocalInt(oPC, areaName + "milllever", 0);
		DestroyItems(oPC, "emptypot", 1);
		CreateItemOnObject("potofflour", oPC, 1);
		SendMessageToPC(oPC, "<color=white>" + "You collect the flour using the empty pot.");
	}
}
void DestroyItems(object oTarget,string sItem,int nNumItems)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);
	
    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            int nRemainingToDestroy = nNumItems - nCount;
			int nStackSize = GetItemStackSize(oItem);
			
			if(nStackSize <= nRemainingToDestroy)
			{
				DestroyObject(oItem,0.1f);
				nCount += nStackSize;
			}
            else
			{
				int nNewStackSize = nStackSize - nRemainingToDestroy;
				SetItemStackSize(oItem, nNewStackSize);
				break;
			}
        }
        oItem = GetNextItemInInventory(oTarget);
    }
   return;
}