int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int nMatch = GetListenPatternNumber();
	if (nMatch == 1)
	{
		string val = GetMatchedSubstring(0);
		SetLocalString(OBJECT_SELF, GetName(oPC)+"message", val);
	}
    string messageheard = GetLocalString(OBJECT_SELF, GetName(oPC)+"message");
    // Check if amount spoken is valid
    if (messageheard != "") 
	{
		SetCustomToken(1001, messageheard);
		return 1;
	}
		else return 0;
}