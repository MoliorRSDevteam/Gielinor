#include "tb_bank_include"
#include "tb_persistents"

//Made this a condition to insure tokens setup properly even through lagg
int StartingConditional()
{
    // Set the banker to listen
	object oPC = GetPCSpeaker();
    object oItem;
	string sItemTag;
	string tokeninfo;
	int itemCount;
	int ix;
	int iy = 1001; //itemid
	//now for actual bank setup
	SetCustomToken(1000, "	  " + IntToString(GetLocalInt(oPC, "goldbanked")));
	for (ix = 1; ix <= BANK_SPACES; ix++)
	{
		tokeninfo = " #"+IntToString(ix)+"> ";
		sItemTag = GetLocalString(oPC, IntToString(ix)+"itemdepositedtag");
		itemCount = GetLocalInt(oPC, IntToString(ix)+"itemdepositedcount");
		oItem = CreateItemOnObject(sItemTag, OBJECT_SELF);
		SetLocalString(oPC, IntToString(iy) + "banktoken", sItemTag);
		//SendMessageToPC(oPC, IntToString(iy) + ") " + sItemTag + " " + GetName(oItem));
		if (itemCount > 0)
		{
			//SetCustomToken(iy, "  " + IntToString(itemCount) + "	  " + GetName(oItem) );
			tokeninfo += ("	  " + IntToString(itemCount) + " " + GetName(oItem) );
		}
		else
		{
			DeleteLocalString(oPC, IntToString(ix)+"itemdepositedtag");
			DeleteLocalInt(oPC, IntToString(ix)+"itemdepositedcount");
			DeleteLocalString(oPC, IntToString(iy) + "banktoken");
			//SetCustomToken( iy, "");
		}
		SetCustomToken( iy, tokeninfo);
		iy++;
		DestroyObject(oItem);
	}
	return 1;
}