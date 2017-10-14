#include "ginc_item"
#include "tb_bank_include"
#include "tb_persistents"

int itemCount = 0;
int numactions = 0;
int breakDepositLoop = 0;
int bankslot = 0;
int ret;
string itemname;
string sError;

void DepositItem(object oPC, object oItem);


//Made this a condition to insure tokens setup properly even through lagg
void main(int numActions)
{
	object oPC = GetPCSpeaker();
	//handles actions 'X' input
	if (numActions == -1) {numActions = StringToInt(GetLocalString(OBJECT_SELF, GetName(oPC)+"message")); SetLocalInt(oPC, "xnum", numActions);}
	if (numActions == -2) {numActions = GetLocalInt(oPC, "xnum");}
	
	numactions = numActions;
	int token = GetLocalInt(oPC, "customtoken");
	object oItem = GetLocalObject(oPC, "invtoken"+IntToString(token));
	string notesTag = GetLocalString(oItem, "itemtag");
	string itemTag = GetTag(oItem);
	
	//SetLocalInt(oPC, "itemid", itemid); //pass itemid to tb_ga_invtokens
	//SendMessageToPC(oPC, "ga on: " + IntToString(itemid));
	int ix;
	numactions = (numactions > GetItemStackSize(oItem)) ? GetItemStackSize(oItem) : numactions;
	for (ix = 1; ix <= numActions; ix++)
	{
		if (breakDepositLoop == 1) break;
		if (itemTag != NOTES_TAG)
		{
			oItem = GetItemInInventory(itemTag, oPC);
		}
		if (GetIsObjectValid(oItem))
		{
			//SendMessageToPC(oPC, "campVar: " + GetCampaignString("molior", GetName(oItem)+"itemtag"));
			SetLocalString(oItem, "itemtag", GetCampaignString("molior", GetName(oItem)+"itemtag"));
			//SendMessageToPC(oPC, "found item: "+ GetTag(oItem));
			DepositItem(oPC, oItem);
		} else break;
		if (sError != "") {SendMessageToPC(oPC, sError);return;}
	}
	//SendMessageToPC(oPC, "Stacksize: " + IntToString(GetItemStackSize(oItem)));
	if (bankslot > 0)
	{
		//save persistents
		TBSetPersistentString(oPC, IntToString(bankslot)+"itemdepositedtag", GetLocalString(oPC, IntToString(bankslot)+"itemdepositedtag"));
		TBSetPersistentInt(oPC, IntToString(bankslot)+"itemdepositedcount", GetLocalInt(oPC, IntToString(bankslot)+"itemdepositedcount"));
		//SendMessageToPC(oPC, IntToString(ix-1)+"depositedtag: " + TBGetPersistentString(oPC, IntToString(ix)+"itemdepositedtag"));
		//SendMessageToPC(oPC, IntToString(ix-1)+"depositedcount: " + IntToString(TBGetPersistentInt(oPC, IntToString(ix)+"itemdepositedcount")));
		SendMessageToPC(oPC, "Bank Records: " + IntToString(itemCount) + " of " + itemname);
	}
}
void DepositItem(object oPC, object oItem)
{
	//object oItem = GetItemPossessedBy(oPC, itemTag);
	int ix;
	bankslot = 0;
	string itemTag = GetTag(oItem);
	itemname = GetName(oItem);
	itemTag = (itemTag == NOTES_TAG) ? GetLocalString(oItem, "itemtag") : itemTag;
	//SendMessageToPC(oPC, "Searching for a bank slot to stack on...");
	for (ix = 1; ix <= BANK_SPACES; ix++)
	{ //search for an item already in bank we can stack on
		if (GetLocalString(oPC, IntToString(ix)+"itemdepositedtag") == itemTag)
		{
			bankslot = ix;
			itemCount = GetLocalInt(oPC, IntToString(ix)+"itemdepositedcount") + 1;
			break;
		}
	}
	if (bankslot == 0)
	{ //didn't find so search for an empty slot for our item in the bank
		//SendMessageToPC(oPC, "Searching for an empty bank slot...");
		for (ix = 1; ix <= BANK_SPACES+1; ix++) //+1 for bank space check in next function
		{
			if (GetLocalString(oPC, IntToString(ix)+"itemdepositedtag") == "")
			{
				bankslot = ix;
				itemCount = 1;
				break;
			}
		}
		//if (bankslot == 0) {SendMessageToPC(oPC, "Could not find a bank slot.");}
	}
	if (bankslot > BANK_SPACES) //the actual bank space check
	{
		sError = "Your bank is full. Could ask for more spaces.";
		//SendMessageToPC(oPC, "1"+sError);
		return;
	}
	if (bankslot > BANK_SPACES)
	{
		ret = 1;
		return;
	}
	if (bankslot >= 0)
	{ //deposit if we have a slot
			if (GetTag(oItem) == NOTES_TAG)
			{
				itemTag = GetLocalString(oItem, "itemtag");
			}
			if (GetItemStackSize(oItem) > 1)
			{
				itemCount += numactions - 1;
				if (GetItemStackSize(oItem) - numactions == 0)
				{
						SetTag(oItem, "destroyed");
						ActionTakeItem(oItem, oPC, 0);
				}
				SetItemStackSize(oItem, GetItemStackSize(oItem)-numactions);
				breakDepositLoop = 1;
			}
			else
			{
				if (GetTag(oItem) == NOTES_TAG)
				{
					itemCount = GetLocalInt(oPC, IntToString(ix)+"itemdepositedcount") + 1;
					breakDepositLoop = 1;
				}
				//SendMessageToPC(oPC, IntToString(itemCount) + GetLocalString(oItem, "itemtag")+" i "+GetTag(oItem) + IntToString(breakDepositLoop));
				SetTag(oItem, "destroyed");
				ActionTakeItem(oItem, oPC, 0);
			}
			SetLocalInt(oPC, IntToString(bankslot)+"itemdepositedcount", itemCount);
			SetLocalString(oPC, IntToString(bankslot)+"itemdepositedtag", itemTag);
	}
}