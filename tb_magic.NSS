/*Triston (12/04/15)
 *called from magic GUI
	*spells
	* 0 - Lumbridge Home Teleport
	  1 - Varrock Teleport
	  2 - 
*/

#include "tb_include"
#include "tb_skillsandxp"
#include "ginc_param_const"
#include "ginc_debug"
#include "tb_teleport"
#include "nw_i0_plot"
#include "tb_animpc"

const string TELEPORT_ANIM = "worship";
const string TELEPORT_SOUND = "as_mg_telepin1";
const string LUMBRIDGESPAWN_WAYPOINT_TAG = "lumbridgeloderc";
const string VARROCK_WAYPOINT_TAG = "varrockloderc";
const string LUMBRIDGE_WAYPOINT_TAG = "lumbridgeloderc";
const string FALADOR_WAYPOINT_TAG = "faladorloderc";
//primary
const int    PRIMARY_MULTIPLIER = 1;
const string MIND_TAG = "mindrune";
const string BODY_TAG = "bodyrune";
const string LAW_TAG = "lawrune";
const string COSMIC_TAG = "cosmicrune";
//secondary
const int    SECONDARY_MULTIPLIER = 1;
const string AIR_TAG = "airrune";
const string EARTH_TAG = "earthrune";
const string FIRE_TAG = "firerune";
const string WATER_TAG = "waterrune";

string teleportTag;
string enchantment;
string spellname;
int level;
int mindcost;
int bodycost;
int lawcost;
int cosmiccost;
int aircost;
int earthcost;
int firecost;
int watercost;

void Teleport(object oPC, string sDestTag);
void TeleJump(object oPC, string sDestTag)
{
	SetCommandable(TRUE, oPC);
	TBTeleport(oPC, sDestTag);
}
void TakeRunes(object oPC)
{
	DestroyItems(oPC, MIND_TAG, mindcost);
	DestroyItems(oPC, BODY_TAG, bodycost);
	DestroyItems(oPC, LAW_TAG, lawcost);
	DestroyItems(oPC, COSMIC_TAG, cosmiccost);
	DestroyItems(oPC, AIR_TAG, aircost);
	DestroyItems(oPC, EARTH_TAG, earthcost);
	DestroyItems(oPC, FIRE_TAG, firecost);
	DestroyItems(oPC, WATER_TAG, watercost);
}
void SetVariables(object oPC, int spell)
{
	//SendMessageToPC(oPC, "<color=white>" + "You cast a spell. #" + IntToString(spell));
	//GetNumItems(oPC, AIR_TAG);
	switch (spell)
	{
//Teleports
		case 0:
			level = 1;
			teleportTag = LUMBRIDGE_WAYPOINT_TAG;
			spellname = "Lumbridge Home Teleport";
			DestroyItems(oPC, karamjarum);
			break;
		case 1:
			level = 25;
			teleportTag = VARROCK_WAYPOINT_TAG;
			spellname = "Varrock Teleport";
			lawcost = 2;
			aircost = 30;
			firecost = 10;
			DestroyItems(oPC, karamjarum);
			break;
		case 2:
			level = 31;
			teleportTag = LUMBRIDGE_WAYPOINT_TAG;
			spellname = "Lumbridge Teleport";
			lawcost = 2;
			aircost = 30;
			earthcost = 10;
			DestroyItems(oPC, karamjarum);
			break;
		case 3:
			level = 37;
			teleportTag = FALADOR_WAYPOINT_TAG;
			spellname = "Falador Teleport";
			lawcost = 2;
			aircost = 30;
			watercost = 10;
			DestroyItems(oPC, karamjarum);
			break;
//Enchantments
		case 50:
			level = 7;
			enchantment = "sapphire";
			spellname = "Enchant Sapphire";
			cosmiccost = 2;
			watercost = 10;
			break;
		case 51:
			level = 27;
			enchantment = "emerald";
			spellname = "Enchant Emerald";
			cosmiccost = 2;
			aircost = 10;
			break;
		case 52:
			level = 49;
			enchantment = "ruby";
			spellname = "Enchant Ruby";
			cosmiccost = 2;
			firecost = 50;
			break;
		case 53:
			level = 57;
			enchantment = "diamond";
			spellname = "Enchant Diamond";
			cosmiccost = 2;
			earthcost = 100;
			break;
		case 54:
			//level = 0;
			//enchantment = "dragonstone";
			//spellname = "Enchant Dragonstone";
			//cosmiccost = 1;
			//earthcost = 15;
			//watercost = 15;
			break;
		case 55:
			//level = 0;
			//enchantment = "onyx";
			//spellname = "Enchant Onyx";
			//cosmiccost = 1;
			//earthcost = 15;
			//firecost = 15;
			break;
	}
	spellname = (spellname == "") ? "unavailable" : spellname;
	//SendMessageToPC(oPC, "<color=white>" + "Your spell was "+spellname);
}
void Teleport(object oPC, string sDestTag)
{
	object fx = CreateObject(GetObjectTypes("V"), "fx_gem_energy_green", GetLocation(oPC));
	AssignCommand(oPC, ClearAllActions(TRUE));
	PlayCustomAnimation(oPC, TELEPORT_ANIM, 0);
	SetCommandable(FALSE, oPC);
	PlaySound(TELEPORT_SOUND, TRUE);
	DelayCommand(0.8, DestroyObject(fx));
	DelayCommand(0.8, AssignCommand(oPC, TeleJump(oPC, sDestTag)));
}
/*
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
*/
/*Triston (12/04/15)
 *called from magic GUI
	*spells
	* 0 - Lumbridge Home Teleport
	  1 - Varrock Teleport
	  2 - 
*/
/*
const string TELEPORT_SOUND = "as_mg_telepin1";
void main(int spell)
{
	object oPC = OBJECT_SELF;
	
	AssignCommand(oPC, PlaySound(TELEPORT_SOUND, TRUE));
	string spellname;
	
	SendMessageToPC(oPC, "<color=white>" + "You cast a spell. #" + IntToString(spell));
	
	switch (spell)
	{
		case 0:
			spellname = "Lumbridge Home Teleport";
			break;
		case 1:
			spellname = "Varrock Teleport";
			break;
		case 2:
			spellname = "Lumbridge Teleport";
			break;
		case 3:
			spellname = "Falador Teleport";
			break;
	}
	SendMessageToPC(oPC, "<color=white>" + "Your spell was "+spellname);
}
*/