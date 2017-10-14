// tb_smithing
/*
    This script fires when using rc altars
        _essensetag = tag of the smithing material
		_runetag = tag of item we're making
		_nXP = xp per smith
*/

#include "tb_skillsandxp"
#include "nw_i0_plot"

const string ESSENCE_TAG = "runeessence";
const string ANIM_RC = "WORSHIP";
const string RC_SOUND = "as_mg_frstmagic1";

int multiplier = 1;
int level;

void DestroyItems(object oTarget, string sItem, int nNumItems);
void GiveItems(object oPC, string itemtag, int quantity);
void SetMultiplier();
void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

void main()
{
	object oPC = GetPlaceableLastClickedBy();
	SetLocalString(oPC, "activity", "runecrafting");
	string runetag = GetLocalString(OBJECT_SELF, "runetag");
	float xp = GetLocalFloat(OBJECT_SELF, "xp");
	int quantity = GetNumItems(oPC, ESSENCE_TAG);
	level = GetSkillRank(SKILL_RUNECRAFTING, oPC);
	int reqlvl = GetLocalInt(OBJECT_SELF, "reqlvl");
	if (level < reqlvl)
	{
		SendMessageToPC(oPC, "<color=white>" + "You need level "+IntToString(reqlvl)+" Runecrafting to craft those.");
		return;
	}
	if (quantity == 0)
	{
		SendMessageToPC(oPC, "<color=white>" + "You don't seem to have any essence to bind.");
		return;
	}
	DelayCommand(0.4, AssignCommand(oPC, PlaySound(RC_SOUND)));
	AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, ANIM_RC, 0));
	DestroyItems(oPC, ESSENCE_TAG, quantity);
	SetMultiplier();
	quantity *= multiplier;
	SendMessageToPC(oPC, "<color=white>" + "You craft "+IntToString(multiplier)+"x the runes.");
	GiveXP(oPC, "runecrafting", FloatToInt(xp*quantity));
	DelayCommand(0.2, GiveItems(oPC, runetag, quantity));
}

void SetMultiplier()
{
	multiplier = (multiplier == 0) ? 1 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "2x")) ? 2 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "3x")) ? 3 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "4x")) ? 4 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "5x")) ? 5 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "6x")) ? 6 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "7x")) ? 7 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "8x")) ? 8 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "9x")) ? 9 : multiplier;
	multiplier = (level >= GetLocalInt(OBJECT_SELF, "10x")) ? 10 : multiplier;
}

void GiveItems(object oPC, string itemtag, int quantity)
{
	int i = 1;
	while ( i <= quantity )
	{
		CreateItemOnObject( itemtag, oPC, 1, itemtag, 0 );
		i++;
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