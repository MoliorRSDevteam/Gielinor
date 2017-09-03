int StartingConditional()
{
	object oPC = GetPCSpeaker();
	object oESSENCE = GetItemPossessedBy(oPC, "player_essence");
	string sMOB = GetLocalString(oESSENCE, "SLAYER_TAG");
	if (sMOB == "") return TRUE;
	else return FALSE;
}