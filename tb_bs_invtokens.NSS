#include "tb_bank_include"

//Made this a condition to insure tokens setup properly even through lagg
int StartingConditional(string itemselectscript)
{
    // Set the banker to listen
	object oPC = GetPCSpeaker();
    object oItem;
	int ix;
	int iy = 1001; //itemid and customtoken
	string tagsfound = ""; //for unique names checking
	SetLocalString(oPC, "tokenselectscript", itemselectscript);
	SetCustomToken(1000, "	  " + IntToString(GetLocalInt(oPC, "goldbanked")));
	for (ix = 1; ix <= INV_SPACES; ix++)
	{
		oItem = (ix == 1) ? GetFirstItemInInventory(oPC) : GetNextItemInInventory(oPC);
		DeleteLocalObject(oPC, "invtoken"+IntToString(iy));
		if (oItem != OBJECT_INVALID && GetTag(oItem) != "destroyed" && !TestStringAgainstPattern(tagsfound,GetTag(oItem)))
		{
			SetLocalObject(oPC, "invtoken"+IntToString(iy), oItem);
			//GetNumItems(oPC, GetTag(oItem))
			SetCustomToken( iy, "	  " + GetName(oItem)); //tokens 1001...1128
			if (GetTag(oItem) != NOTES_TAG){tagsfound += (GetTag(oItem) + "|");}
		}
		else
		{
			//SendMessageToPC(oPC, "ga_deleted"+IntToString(iy)+": " + GetName(oItem));
			SetCustomToken( iy, "");
		}
		iy++;
	}
	return 1;
}