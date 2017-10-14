#include "tb_bank_include"
#include "tb_persistents"

void main()
{
    // Set the banker to listen
	object oPC = GetPCSpeaker();
    int ix;
	//make sure bank persistents are loaded in
	if (GetLocalInt(oPC, "bankloaded") == 0)
	{
		SetLocalInt(oPC, "goldbanked", TBGetPersistentInt(oPC, "goldbanked"));
		SendMessageToPC(oPC, "BankLoaded: " + IntToString(GetLocalInt(oPC, "bankloaded")));
		for (ix = 1; ix < BANK_SPACES; ix++)
		{
			SetLocalInt(oPC, IntToString(ix)+"itemdepositedcount", TBGetPersistentInt(oPC, IntToString(ix)+"itemdepositedcount"));
			SetLocalString(oPC, IntToString(ix)+"itemdepositedtag", TBGetPersistentString(oPC, IntToString(ix)+"itemdepositedtag"));
			//SendMessageToPC(oPC, IntToString(ix)+"depositedtag: " + GetLocalString(oPC, IntToString(ix)+"itemdepositedtag"));
			//SendMessageToPC(oPC, IntToString(ix)+"depositedcount: " + IntToString(GetLocalInt(oPC, IntToString(ix)+"itemdepositedcount")));
		}
		SetLocalInt(oPC, "bankloaded", 1);
		SendMessageToPC(oPC, "BankLoaded: " + IntToString(GetLocalInt(oPC, "bankloaded")));
	}
}