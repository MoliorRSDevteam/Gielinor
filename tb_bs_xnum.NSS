//Made this a condition to pass stored x number
int StartingConditional()
{
    // Set the banker to listen
	object oPC = GetPCSpeaker();
    SetCustomToken(1001, IntToString(GetLocalInt(oPC, "xnum")));
	return 1;
}