#include "ginc_item"
#include "tb_persistents"

void main()
{
	object oPC = GetPCSpeaker();
	int gold = GetGold(oPC);
	int banked = GetLocalInt(oPC, "goldbanked");
	int amount = StringToInt(GetLocalString(OBJECT_SELF, GetName(oPC)+"message"));
	SetLocalInt(oPC, "xnum", amount);
	
	if (amount != 0) //no 0s, bye stupid. gtfo my database
	{
		amount = (amount > gold) ? gold : amount; //set to all if over
		TakeGoldFromCreature(amount, oPC);
		banked += amount;
		SetLocalInt(oPC, "goldbanked", banked);
		TBSetPersistentInt(oPC, "goldbanked", banked);
		SetCustomToken(1001, IntToString(banked));
	}
}