#include "tb_bank_include"

void main(int token)
{
	object oPC = GetPCSpeaker();
	object oItem;
	SetLocalInt(oPC, "customtoken", token);
	
	//search bank
	int ix;
	int itemCount;
	string tokenItemTag = GetLocalString(oPC, IntToString(token)+"banktoken");
	for (ix = 1; ix <= BANK_SPACES; ix++)
	{
		if (GetLocalString(oPC, IntToString(ix)+"itemdepositedtag") == tokenItemTag)
		{ //we've found our item
			SetLocalInt(oPC, "bankslot", ix);
			oItem = CreateItemOnObject(tokenItemTag, OBJECT_SELF);
			SetCustomToken(1001, GetName(oItem));
			DestroyObject(oItem);
			break;
		}
	}
}