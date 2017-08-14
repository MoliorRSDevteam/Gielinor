/**/
#include "tb_animpc"
#include "tb_magic"
#include "ginc_item"

const string ENCHANT_SOUND = "as_mg_frstmagic1";
const int ENCHANT_ANIM = 107;

object oPC = GetPCSpeaker();
string enchantTag;
string productTag;

void PlayCustomLoopingAnimation(object oObject, string sAnimationName, float fSpeed);
void PlayCustomOneShotAnimation(object oObject, string sAnimationName, float fSpeed);
void Swap();

void Swap()
{
	object prodItem = CreateItemOnObject(enchantTag, oPC, 1);
	if (enchantTag == "ringofdueling")
	{
		SetItemCharges(prodItem, 5);
	}
}

void main(string itemTag, string productTag)
{
	//object oPC = GetPCSpeaker();
	oPC = GetPCSpeaker();
	if (GetItemInInventory(itemTag, oPC) == OBJECT_INVALID)
	{
		SendMessageToPC(oPC, "<color=white>" + "You don't have an item to cast that on.");
		return;
	}
	enchantTag = productTag;
	SetVariables(oPC, GetLocalInt(oPC, "spellint"));
	TakeRunes(oPC);
	DelayCommand(0.1f, Swap());
	DestroyObject(GetItemPossessedBy(oPC, itemTag));
	TBPlayCustomAnimation(oPC, ENCHANT_ANIM, 1, 0.2f, 1, 1.0);
	DelayCommand(0.5, AssignCommand(oPC, PlaySound(ENCHANT_SOUND, TRUE)));
	DelayCommand(0.5f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectNWN2SpecialEffectFile("fx_will_o_wisp"), oPC, 1.0f));
	DelayCommand(1.5f, DeleteLocalString(oPC, "enchantment"));
}