#include "ginc_item"
#include "tb_persistents"

void main()
{
	object oPC = GetPCSpeaker();
	
	int banked = GetLocalInt(oPC, "goldbanked");
	int amount = StringToInt(GetLocalString(OBJECT_SELF, GetName(oPC)+"message"));
	SetLocalInt(oPC, "xnum", amount);
	
	if (amount != 0) //no 0s, bye stupid. gtfo my database
	{
		amount = (amount > banked) ? banked : amount; //set to all if over
		GiveGoldToCreature(oPC, amount);
		banked -= amount;
		SetLocalInt(oPC, "goldbanked", banked);
		TBSetPersistentInt(oPC, "goldbanked", banked);
		SetCustomToken(1001, IntToString(banked));
	}
}