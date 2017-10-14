// tb_cooking
/*
    This script checks to see if the PC has an item in their inventory
        rawTag = tag of raw food
		sCookedTemplate = templateResRef of cooked food
		quantity = how many to cook
		foodlevel = min level to cook
		burnFire = level stops burning on fires (-1 for range only)
		burnRange = level stops burning on ranges
		burnLumRange = level stops burning on lumbridge castle range
		burnGuantlet = level stops burning with cooking guantlets
		xp = xp gain
*/

#include "tb_loops"
#include "tb_spawndespawn"
#include "tb_skillsandxp"

const string COOK_SOUND = "al_cv_firepit1";
const string ANIM_COOKFIRE = "fishnet";
const string ANIM_COOKRANGE = "cookrange";
//Tags
const string FIRE_TAG = "bonfire";
const string RANGE_TAG = "oven";
const string LUMMYRANGE_TAG = "lumoven";
const string COOKING_GUANTLETS_TAG = "cookingguantlets";
const string BURNTMEAT_TAG = "burntmeat";

const float BASEBURNCHANCE = 55.0;

object oPC;
int quantity;
string rawItem;
string cookedTemplate;
string anim;
string rangetag;
location loc;
int xp;
int foodlevel;
int stopsburning;
int level;

void WaitForCook(float delay, float curtime);
void StartCooking();
void EndCooking(); //you either moved on or finished all the items
void Cook();
void GiveCooked();
void DestroyItems(object oTarget, string sItem, int nNumItems);
float nCookTime = 3.2f;

void main(string rawTag, string sCookedTemplate, int _quantity, int foodLevel, int nXp, int burnFire = 0, int burnRange = 0, int burnLumRange = 0, int burnGuantlet = 0)
{
	oPC = GetPCSpeaker();
	rangetag = GetTag(OBJECT_SELF);
	//SendMessageToPC(oPC, "<color=white>" + "Triston: Cooking v1");
	if (GetLocalInt(oPC, "iscooking") == 1) //a cooking loop is already firing
	{
		return;
	}
	SetLocalString(oPC, "activity", "cooking"); //activity switch aborts loops in all other activities
	level = GetSkillRank(SKILL_COOKING, oPC);
	if (burnFire == -1)
	{
		SendMessageToPC(oPC, "<color=white>" + "You can't cook that on a fire.");
	}
	stopsburning = burnFire;
	anim = (rangetag == FIRE_TAG) ? ANIM_COOKFIRE : ANIM_COOKRANGE;
	stopsburning = (rangetag == RANGE_TAG) ? burnRange : stopsburning;
	stopsburning = (rangetag == LUMMYRANGE_TAG) ? burnLumRange : stopsburning;
	stopsburning = (GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC)) == COOKING_GUANTLETS_TAG) ? burnGuantlet : stopsburning;
	rawItem = rawTag;
	cookedTemplate = sCookedTemplate;
	xp = nXp;
	quantity = _quantity;
	loc = GetLocation(oPC);
	foodlevel = foodLevel;
	StartCooking();
}

void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

void StartCooking()
{
	AssignCommand(oPC, PlaySound(COOK_SOUND, TRUE));
	WaitForCook(nCookTime, nCookTime);
}

void WaitForCook(float time, float curtime)
{
	float step = 0.5f;
	object nearestfire = GetNearestObjectByTag(FIRE_TAG,oPC);
	int isfire = (rangetag == FIRE_TAG) ? GetIsObjectValid(nearestfire) : FALSE;
	//abort if we're done, lose our fire, or run out of items
	if ((rangetag == FIRE_TAG && !isfire) || 
		!GetIsObjectValid(GetItemPossessedBy(oPC,rawItem)))
	{
		EndCooking();
		return;
	}
	else if (curtime <= 0.0f)
	{
		quantity--;
		
		/**** ****/
		float result = BASEBURNCHANCE - ((IntToFloat(level) - IntToFloat(foodlevel)) * 
						(BASEBURNCHANCE / (IntToFloat(stopsburning) - IntToFloat(foodlevel))));
		float random = IntToFloat(Random(100));				
		
		SendMessageToPC(oPC, "<color=white>" + "DEBUG:" + " Random: " + FloatToString(random) + 
														" Result: " + FloatToString(result));
		
		if (result <= random) 
		{
			SendMessageToPC(oPC, "<color=white>" + "You cook successfully.");
			Cook();
		}
		else //burn
		{
			SendMessageToPC(oPC, "<color=white>" + "You burned your food.");
			CreateItemOnObject(BURNTMEAT_TAG, oPC, 1);
			DestroyItems(oPC, rawItem, 1);
		}
		StartCooking();
	}
	else if (GetDistanceBetweenLocations(GetLocation(oPC), loc) < 0.3f && GetLocalString(oPC, "activity") == "cooking")
	{
		SetLocalInt(oPC, "iscooking", 1);
		if (quantity <= 0)
		{
			EndCooking();
			return;
		}
		DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, anim, 0)));
		DelayCommand(step, AssignCommand(oPC, WaitForCook(time, curtime-step)));
	}
	else
	{
		EndCooking();
		//SendMessageToPC(oPC, "<color=white>" + "Current Activity: " + GetLocalString(oPC, "activity"));
	}
}

void Cook()
{
	DestroyItems(oPC, rawItem, 1);
	DelayCommand(0.1f, AssignCommand(oPC, GiveCooked()));
	GiveXP(oPC, "cooking", xp);
}

void GiveCooked()
{
	CreateItemOnObject(cookedTemplate, oPC, 1);
}

void EndCooking()
{
	CloseLoops(oPC);
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