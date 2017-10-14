#include "tb_bank_include"
#include "tb_persistents"

void main(int numActions)
{
	object oPC = GetPCSpeaker();
	//handles actions 'X' input
	if (numActions == -1) {numActions = StringToInt(GetLocalString(OBJECT_SELF, GetName(oPC)+"message")); SetLocalInt(oPC, "xnum", numActions);}
	if (numActions == -2) {numActions = GetLocalInt(oPC, "xnum");}
	
	object oItem;
	int token = GetLocalInt(oPC, "customtoken");
	int bankslot = GetLocalInt(oPC, "bankslot");
	int itemCount;
	int itemStackable;
	string tokenItemTag = GetLocalString(oPC, IntToString(token)+"banktoken");
	string itemname;
	int ix;
	
	//test if stackable before note
	object oStackTest = CreateItemOnObject(tokenItemTag, OBJECT_SELF, 2);
	itemStackable = (GetItemStackSize(oStackTest) == 2);
	DestroyObject(oStackTest);
	
	//search for noted items first
	
	for (ix = 1; ix <= numActions; ix++)
	{
		itemCount = GetLocalInt(oPC, IntToString(bankslot)+"itemdepositedcount");
		if (itemCount > 0)
		{
			SetLocalInt(oPC, IntToString(bankslot)+"itemdepositedcount", itemCount-1);
			if (GetLocalInt(oPC, "notedtoggle") == 1 && !itemStackable)//
			{
				object oTempItem = CreateItemOnObject(tokenItemTag, OBJECT_SELF, 1);
				oItem = CreateItemOnObject(NOTES_TAG, OBJECT_SELF, 1);
				//SetLocalString(oItem, "itemtag", tokenItemTag);
				//SetLocalString(oItem, "itemname", GetName(oTempItem));
				SetFirstName(oItem, "Noted " + GetName(oTempItem));
				SetCampaignString("molior", GetName(oItem)+"itemtag", tokenItemTag); //If you split a stack of notes they lose vars
				DestroyObject(oTempItem);
				ActionGiveItem(oItem, oPC, 0);
			}
			else 
			{
				oItem = CreateItemOnObject(tokenItemTag, oPC, 1, tokenItemTag, 0);
				ActionGiveItem(oItem, oPC, 0);
			}
			itemname = GetName(oItem);
			itemCount--;
		}
		else break; //out of items to withdraw
	}
	//SetCustomToken( 1001, "");
	//save persistents
	TBSetPersistentString(oPC, IntToString(bankslot)+"itemdepositedtag", GetLocalString(oPC, IntToString(bankslot)+"itemdepositedtag"));
	TBSetPersistentInt(oPC, IntToString(bankslot)+"itemdepositedcount", GetLocalInt(oPC, IntToString(bankslot)+"itemdepositedcount"));
	//SendMessageToPC(oPC, IntToString(ix-1)+"depositedtag: " + TBGetPersistentString(oPC, IntToString(ix)+"itemdepositedtag"));
	//SendMessageToPC(oPC, IntToString(ix-1)+"depositedcount: " + IntToString(TBGetPersistentInt(oPC, IntToString(ix)+"itemdepositedcount")));
	SendMessageToPC(oPC, "Bank Records: " + IntToString(GetLocalInt(oPC, IntToString(bankslot)+"itemdepositedcount")) + " of " + itemname);
}