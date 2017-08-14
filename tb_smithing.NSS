// tb_smithing
/*-
    This script checks to see if the PC has an item in their inventory
        _bar = tag of the smithing material
		_item = tag of item we're making
		_barsused = quantity of material used per item
		_quantity = quantity of items we're smithing
		_nXP = xp per smith
*/

#include "tb_loops"
#include "tb_skillsandxp"
#include "nw_i0_plot"


const string ANIM_SMITH = "FORGE01";
const string SMITH_SOUND = "as_cv_smithhamr1";

object oPC;
string item;
string bar;
int xp;
int barspersmith;
int quantity;
location loc;
float nSmithTime = 6.0;

void StartSmithing();
void EndSmithing(); //you either moved on or finished all the items
void WaitForSmith(float time, float curtime = 1000.0);
void Smith();
void GiveSmithed();
void DestroyItems(object oTarget, string sItem, int nNumItems);

void main(string _bartag, string _itemtag, int _barsused, int _quantity, int _nXp)
{
	oPC = GetPCSpeaker();
	if (GetLocalInt(oPC, "issmithing") == 1) //a smithing loop is already firing
	{ //closing all smithing scripts and starting this one
		return;
	}
	SetLocalString(oPC, "activity", "smithing"); //activity switch aborts loops in all other activities
	item = _itemtag;
	bar = _bartag;
	xp = _nXp;
	barspersmith = _barsused;
	quantity = _quantity;
	loc = GetLocation(oPC);
	StartSmithing();
}

void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nsmithing, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nsmithing, fSpeed);
}

void StartSmithing()
{
	string hammertag = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
	if (hammertag != "hammer")
	{
		object oHammer = GetItemPossessedBy(oPC, "hammer");
		AssignCommand(oPC, ActionEquipItem(oHammer, INVENTORY_SLOT_RIGHTHAND));
		if (oHammer == OBJECT_INVALID)
		{
			EndSmithing();
			SendMessageToPC(oPC, "<color=white>" + "You don't seem to have a hammer ready.");
			return;
		}
		//test carrying pickaxe in left hand and another item in right
		else if (GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC) != oHammer)
		{
			AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)));
			AssignCommand(oPC, ActionEquipItem(oHammer, INVENTORY_SLOT_RIGHTHAND));
		}
	}
	DelayCommand(0.01, WaitForSmith(nSmithTime, nSmithTime));
	AssignCommand(oPC, PlaySound(SMITH_SOUND));
}

void WaitForSmith(float time, float curtime)
{
	float step = 0.5f;
	//abort if we're done or don't have enough bars

	if (curtime <= 0.0f)
	{
		quantity--;
		Smith();
		StartSmithing();
	}
	else if (GetDistanceBetweenLocations(GetLocation(oPC), loc) <= 0.01 && GetLocalString(oPC, "activity") == "smithing")
	{
		SetLocalInt(oPC, "issmithing", 1);
		if (quantity <= 0)
		{
			EndSmithing();
			return;
		}
		else if (GetNumItems(oPC, bar) < barspersmith)
		{
			EndSmithing();
			SendMessageToPC(oPC, "<color=white>" + "You've run short on materials to smith with.");
			return;
		}
		DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, ANIM_SMITH, 0)));
		DelayCommand(step, AssignCommand(oPC, WaitForSmith(time, curtime-step)));
	}
	else
	{
		//SendMessageToPC(oPC, "<color=white>" + "Current Activity: " + GetLocalString(oPC, "activity"));
		EndSmithing();
	}
}

void Smith()
{
	SendMessageToPC(oPC, "<color=white>" + "You smith successfully.");
	DestroyItems(oPC, bar, barspersmith);
	DelayCommand(0.1f, AssignCommand(oPC, GiveSmithed()));
	GiveXP(oPC, "smithing", xp);
}

void GiveSmithed()
{
	CreateItemOnObject(item, oPC, 1);
}

void EndSmithing()
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