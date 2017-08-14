// tb_give_xp based on ga_give_xp
/*	harvest your veggies!!!
 *	local string item
 */
#include "ginc_item"
const string LOOT_ANIM = "kneeltalk";//"harvest";

void main()
{
 	object oPC = GetLastUsedBy();
	object placeable = OBJECT_SELF;
	string item = GetLocalString(placeable, "item");
	string justone = GetLocalString(placeable, "justone");
	string anim = GetLocalString(placeable, "anim");
	anim = (anim == "") ? LOOT_ANIM : anim;
	if (ListInventory(oPC) >= 128)
	{
		SendMessageToPC(oPC, "<color=white>" + "You don't have enough space for that.");
		return;
	}
	if (justone == "true" && GetItemInInventory(item, oPC) != OBJECT_INVALID)
	{
		SendMessageToPC(oPC, "Nothing interesting.");
		return;
	}
	float respawntime = GetLocalFloat(placeable, "respawntime");
	PlayCustomAnimation(oPC, anim, 0);
	CreateItemOnObject(item, oPC, 1);
	if (respawntime > 0.0)
	{
		AddScriptParameterFloat(respawntime);
		ExecuteScriptEnhanced("tb_destroyrespawn", placeable, TRUE);
	}
}