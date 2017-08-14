#include "tb_persistents"
void main()
{
	object oPC = GetLastDamager(OBJECT_SELF);
	string spot = GetLocalString(OBJECT_SELF, "spot");
	int duel = (GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) != OBJECT_INVALID);
	int righthand = GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
	int bow = (righthand == (BASE_ITEM_SHORTBOW || BASE_ITEM_LONGBOW || BASE_ITEM_LIGHTCROSSBOW
		|| BASE_ITEM_HEAVYCROSSBOW));
	if (GetTag(OBJECT_SELF) == "PLC_MR_ARCHYT1" && bow == 0) return;
	if (GetTag(OBJECT_SELF) == "PLC_MR_PDUMMY01" && bow == 1) return;
	int givexp = 0;
	givexp = (spot == "lumranged" && TBGetPersistentInt(oPC, "qrangetrain") == 999) ? 1 : givexp;
	if (givexp){GiveXPToCreature(oPC, 2);}
	if (GetLocalInt(oPC, "rangertimechallenge") == 1)
	{
		if (GetLocalInt(OBJECT_SELF, "targ") == 1 && GetLocalInt(oPC, "RTCtarg1") == 0)
		{
				SendMessageToPC(oPC, "Target 1 hit!");
				SetLocalInt(oPC, "RTCtarg1", 1);
		}
		if (GetLocalInt(OBJECT_SELF, "targ") == 2 && GetLocalInt(oPC, "RTCtarg2") == 0)
		{
				SendMessageToPC(oPC, "Target 2 hit!");
				SetLocalInt(oPC, "RTCtarg2", 1);
		}
		if (GetLocalInt(OBJECT_SELF, "targ") == 3 && GetLocalInt(oPC, "RTCtarg3") == 0)
		{
				SendMessageToPC(oPC, "Target 3 hit!");
				SetLocalInt(oPC, "RTCtarg3", 1);
		}
		if (duel && GetLocalInt(OBJECT_SELF, "targ") == 4 && GetLocalInt(oPC, "RTCtarg4") == 0)
		{
				SendMessageToPC(oPC, "Target 4 hit!");
				SetLocalInt(oPC, "RTCtarg4", 1);
		}
	}
}