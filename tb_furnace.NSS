// tb_smithing
/*
    This script checks to see if the PC has an item in their inventory
        item = the item produced
			0 = bronze		Bar smelting
			1 = blurite
			2 = iron			//script checks for ringofforging
			3 = silver
			4 = elemental
			5 = steel
			6 = gold
			7 = mithril
			8 = adamant
			9 = rune
			
		quantity = how many to make
*/

#include "tb_loops"
#include "tb_skillsandxp"
#include "nw_i0_plot"

const int BLURITE_SMELT_CHANCE = 5; //percent
const string ANIM_SMELT = "smelt";
const string SMELT_SOUND = "al_cv_fireplace1";
//MISC TAGS
const string GOLDSMITH_GUANTLETS_TAG = "goldsmithguantlets";
const string RING_OF_FORGING_TAG = "ringofforging";
//ORE TAGS
const string COPPER_ORE_TAG = "copperore";
const string TIN_ORE_TAG = "tinore";
const string COAL_ORE_TAG = "coalore";
const string BLURITE_ORE_TAG = "bluriteore";
const string IRON_ORE_TAG = "ironore";
const string SILVER_ORE_TAG = "silverore";
const string ELEMENTAL_ORE_TAG = "";
const string GOLD_ORE_TAG = "goldore";
const string MITHRIL_ORE_TAG = "mithrilore";
const string ADAMANT_ORE_TAG = "adamantiteore";
const string RUNITE_ORE_TAG = "runiteore";
//BAR TAGS
const string BRONZE_BAR_TAG = "bronzebar";
const string BLURITE_BAR_TAG = "bluritebar";
const string IRON_BAR_TAG = "ironbar";
const string SILVER_BAR_TAG = "silverbar";
const string ELEMENTAL_BAR_TAG = "";
const string STEEL_BAR_TAG = "steelbar";
const string GOLD_BAR_TAG = "goldbar";
const string MITHRIL_BAR_TAG = "mithrilbar";
const string ADAMANT_BAR_TAG = "adamantbar";
const string RUNITE_BAR_TAG = "runebar";
//BAR XP
const int BRONZE_BAR_XP = 6;
const int BLURITE_BAR_XP = 8;
const int IRON_BAR_XP = 13;
const int SILVER_BAR_XP = 14;
const int ELEMENTAL_BAR_XP = 8;
const int STEEL_BAR_XP = 18;
const int GOLD_BAR_XP = 23;
const int MITHRIL_BAR_XP = 30;
const int ADAMANT_BAR_XP = 38;
const int RUNITE_BAR_XP = 50;

object oPC;
int prodNum;
int quantity;
string producttag;
string mat1tag;
string mat2tag;
int mat1used;
int mat2used;
string mouldtag;
string xptype = "smithing";
int xp;
int hasRingOfForging;
float nSmeltTime = 3.5f;
location loc;

void StartSmelting();
void EndSmelting(); //you either moved on or finished all the items
void WaitForSmelt(float time, float curtime);
void GiveForged();
void SetupVars(int prodNum);
void DestroyItems(object oTarget,string sItem,int nNumItems);
void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

void main(int product, int _quantity)
{
	oPC = GetPCSpeaker();
	if (GetLocalInt(oPC, "issmelting") == 1) //a smelting loop is already firing
	{ //closing all smelt scripts and starting this one
		return;
	}
	SetLocalString(oPC, "activity", "smelting"); //activity switch aborts loops in all other activities
	loc = GetLocation(oPC);
	quantity = _quantity;
	prodNum = product;
	SendMessageToPC(oPC, "<color=white>" + "You begin smelting.");
	StartSmelting();
}

void StartSmelting()
{
	SetupVars(prodNum);
	AssignCommand(oPC, PlaySound(SMELT_SOUND, TRUE));
	WaitForSmelt(nSmeltTime, nSmeltTime);
}

void WaitForSmelt(float time, float curtime)
{
	//SendMessageToPC(oPC, "<color=white>" + "Time: " + FloatToString(time-curtime));
	float step = 0.5f;
	if (GetNumItems(oPC, mat1tag) < mat1used || GetNumItems(oPC, mat2tag) < mat2used)
	{
		EndSmelting();
		SendMessageToPC(oPC, "<color=white>" + "You've run short on materials to smelt.");
		return;
	}
	else if (curtime <= 0.0f)
	{
		quantity--;
		int roll = d100();
		int level = GetSkillRank(SKILL_SMITHING, oPC);
		if (level > 45) level = 45;
		int levelbonus = level-15;
		int spot = 50+levelbonus;
		DestroyItems(oPC, mat1tag, mat1used);
		DestroyItems(oPC, mat2tag, mat2used);
		if (producttag == IRON_BAR_TAG && roll > spot && hasRingOfForging == 0)
		{
			SendMessageToPC(oPC, "<color=white>" + "You've ruined your iron bar.");
		}
		else if (producttag == BLURITE_BAR_TAG && roll < BLURITE_SMELT_CHANCE)
		{
			SendMessageToPC(oPC, "<color=white>" + "You've ruined your blurite bar.");
		}
		else
		{
			SendMessageToPC(oPC, "<color=white>" + "You smelt successfully.");
			DelayCommand(0.1f, AssignCommand(oPC, GiveForged()));
			GiveXP(oPC, xptype, xp);
		}
		StartSmelting();
	}
	else if (GetDistanceBetweenLocations(GetLocation(oPC), loc) < 0.3f && GetLocalString(oPC, "activity") == "smelting")
	{
		SetLocalInt(oPC, "issmelting", 1);
		if (quantity <= 0)
		{
			EndSmelting();
			return;
		}
		DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, ANIM_SMELT, 0)));
		DelayCommand(step, AssignCommand(oPC, WaitForSmelt(time, curtime-step)));
	}
	else
	{
		EndSmelting();
		//SendMessageToPC(oPC, "<color=white>" + "Current Activity: " + GetLocalString(oPC, "activity"));
	}
}

void GiveForged()
{
	CreateItemOnObject(producttag, oPC, 1);
}

void EndSmelting()
{
	CloseLoops(oPC);
	//DeleteLocalString(oPC, "activity");
}


void SetupVars(int prodNum)
{
	string leftringtag = GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
	string rightringtag = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
	string glovestag = GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
	switch(prodNum)
	{
		case 0: //bronzebar
			producttag = BRONZE_BAR_TAG;
			mat1tag = COPPER_ORE_TAG;
			mat2tag = TIN_ORE_TAG;
			mat1used = 1;
			mat2used = 1;
			xp = BRONZE_BAR_XP;
			break;
		case 1: //bluritebar
			producttag = BLURITE_BAR_TAG;
			mat1tag = BLURITE_ORE_TAG;
			mat1used = 1;
			xp = ADAMANT_BAR_XP;
			break;
		case 2: //ironbar
			producttag = IRON_BAR_TAG;
			mat1tag = IRON_ORE_TAG;
			mat1used = 1;
			hasRingOfForging = (leftringtag == RING_OF_FORGING_TAG || rightringtag == RING_OF_FORGING_TAG);
			xp = IRON_BAR_XP;
			break;
		case 3: //silverbar
			producttag = SILVER_BAR_TAG;
			mat1tag = SILVER_ORE_TAG;
			mat1used = 1;
			xp = SILVER_BAR_XP;
			break;
		case 4: //elementalbar
			producttag = ELEMENTAL_BAR_TAG;
			mat1tag = ELEMENTAL_ORE_TAG;
			mat2tag = COAL_ORE_TAG;
			mat1used = 1;
			mat2used = 4;
			xp = ELEMENTAL_BAR_XP;
			break;
		case 5: //steelbar
			producttag = STEEL_BAR_TAG;
			mat1tag = IRON_ORE_TAG;
			mat2tag = COAL_ORE_TAG;
			mat1used = 1;
			mat2used = 2;
			xp = STEEL_BAR_XP;
			break;
		case 6: //goldbar
			producttag = GOLD_BAR_TAG;
			mat1tag = GOLD_ORE_TAG;
			mat1used = 1;
			xp = (glovestag == GOLDSMITH_GUANTLETS_TAG) ? FloatToInt(GOLD_BAR_XP*2.5) : GOLD_BAR_XP;
			break;
		case 7: //mithrilbar
			producttag = MITHRIL_BAR_TAG;
			mat1tag = MITHRIL_ORE_TAG;
			mat2tag = COAL_ORE_TAG;
			mat1used = 1;
			mat2used = 4;
			xp = MITHRIL_BAR_XP;
			break;
		case 8: //adamantitebar
			producttag = ADAMANT_BAR_TAG;
			mat1tag = ADAMANT_ORE_TAG;
			mat2tag = COAL_ORE_TAG;
			mat1used = 1;
			mat2used = 6;
			xp = ADAMANT_BAR_XP;
			break;
		case 9: //runitebar
			producttag = RUNITE_BAR_TAG;
			mat1tag = RUNITE_ORE_TAG;
			mat2tag = COAL_ORE_TAG;
			mat1used = 1;
			mat2used = 8;
			xp = RUNITE_BAR_XP;
			break;
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