// tb_fishing
/*
    This script handles hss method for fishing spots through placeable leftclick
        --stored variables-- 
		waytag - the tag of the waypoint the player will stand
		type - string of either fly/rod/net/cage spot
*/

//Based on original i_hss_fish_rod_ac on activate item event script

#include "hss_fishing_inc"
#include "hss_fishing_net"

void MoveToSpot(object oPC, object oWay);
void main()
{
	object oPC = GetClickingObject();
	oPC = (oPC == OBJECT_INVALID) ? GetPlaceableLastClickedBy() : oPC;
	
	object oWay = GetNearestObjectByTag(GetLocalString(OBJECT_SELF, "waytag"), OBJECT_SELF);
	object oItem;
	string spottype = GetLocalString(OBJECT_SELF, "type");
	int level = GetSkillRank(SKILL_FISHING, oPC);
	int levelreq = StringToInt(GetLocalString(OBJECT_SELF, "level"));
	//Clear the PCs actions.
	AssignCommand(oPC, ClearAllActions());  
	//for the fishing script to check if we've left our spot
	SetLocalObject(oPC, "oWay", oWay);
	//pull the last fishing spot. Spot is used for elevation in water splashing effect and checking if still fishing
	oSpot = GetLocalObject(oPC, "fishingspot");
	//Tells every script our current activity is fishing
	
	
	//	SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "isfishing: " + IntToString(GetLocalInt(oPC, "isfishing")));
	//check req level
	string minlvl = IntToString(GetLocalInt(OBJECT_SELF, "minlevel"));
	if (level < levelreq)
	{
		SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need at least level " + 
		IntToString(levelreq) + " fishing to fish here.");
		return;
	}
	
	if (GetLocalInt(oPC, "isfishing") == 1) //a fishing loop is already firing
	{
		//SendMessageToPC(oPC, "DEBUG: Am I spot?: " + IntToString(oSpot == OBJECT_SELF));
		if (oSpot == OBJECT_SELF)
		{
			//aborts if player is I'm already his fishing spot
			return;
		}
		//already fishing
		EndFishing();
		//return;
	}
	SetLocalString(oPC, "activity", "fishing"); //activity switch aborts loops in all other activities
	
	//the fishing spot wasn't us so we're changing it
	oSpot = OBJECT_SELF;
	SetLocalObject(oPC, "fishingspot", OBJECT_SELF);
	
	if (spottype == "net" || spottype == "net1") //net-shrimp net1-monkfish
	{
    	oItem = GetItemPossessedBy(oPC, FISHING_NET_TAG);
		if (GetIsObjectValid(oItem))
		{
				MoveToSpot(oPC, oWay);
				HSS_DoNet(oPC, oWay, oItem, spottype);
		}
		else
		{
			SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need a fishing net to fish here.");
			return;
		}
	} else if (spottype == "bignet") //bignet-mackeril
	{
    	oItem = GetItemPossessedBy(oPC, BIG_FISHING_NET_TAG);
		if (GetIsObjectValid(oItem))
		{
				MoveToSpot(oPC, oWay);
				HSS_DoNet(oPC, oWay, oItem, spottype);
		}
		else
		{
			SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need a big fishing net to fish here.");
			return;
		}
	} else if (spottype == "bait" || spottype == "bait1") //bait-sardines bait1-pike
	{
    	oItem = GetItemPossessedBy(oPC, FISHING_ROD_TAG);//GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		if (GetIsObjectValid(oItem))
		{
				MoveToSpot(oPC, oWay);
				HSS_DoCast(oPC, oItem, oWay, spottype);
		}
		else
		{
			SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need a fishing rod and bait to fish here.");
			return;
		}
	} else if (spottype == "lure") //lure-trout
	{
    	//oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    	oItem = GetItemPossessedBy(oPC, FLY_FISHING_ROD_TAG);
		if (GetIsObjectValid(oItem))
		{
				MoveToSpot(oPC, oWay);
				HSS_DoCast(oPC, oItem, oWay, spottype);
		}
		else
		{
			SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need a fly fishing rod and feathers to fish here.");
			return;
		}
	} else if (spottype == "cage") //cage-lobster
	{
    	oItem = GetItemPossessedBy(oPC, LOBSTER_POT_TAG);
		if (GetIsObjectValid(oItem))
		{
				MoveToSpot(oPC, oWay);
				HSS_DoNet(oPC, oWay, oItem, spottype);
		}
		else
		{
			SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need a lobster pot to fish here.");
			return;
		} 
	} else if (spottype == "harpoon" || spottype == "harpoon1") //harpoon-tuna/sword harpoon1-shark
	{
    	oItem = GetItemPossessedBy(oPC, HARPOON_TAG);//GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
		if (GetIsObjectValid(oItem))
		{
				MoveToSpot(oPC, oWay);
				HSS_DoNet(oPC, oWay, oItem, spottype);
		}
		else
		{
			SendMessageToPC(oPC, HSS_FEEDBACK_COLOUR + "You need a harpoon to fish here.");
			return;
		}
	}
}

void MoveToSpot(object oPC, object oWay)
{
	//clear out the queue, so no casting spam.
	AssignCommand(oPC, ClearAllActions());
	AssignCommand(oPC, ActionMoveToObject(oWay, TRUE, 0.0));
}