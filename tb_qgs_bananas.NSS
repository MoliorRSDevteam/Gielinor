int StartingConditional()
{
	object oPC = GetPCSpeaker();
	int bananas = GetLocalInt(oPC, "BananaCrateCount");
	string sBananas = IntToString(bananas);
	sBananas = (bananas == 5) ? "Full" : sBananas;
	string sHasrum;
	sHasrum = (GetLocalInt(oPC, "BananaCrateHasRum") == 1) ? "\n\n*There's a bottle of rum stashed in here too*" : sHasrum;
	sHasrum = (GetLocalInt(oPC, "BananaCrateHasRum") == 1 && bananas == 0) ? "\n\n*There's a bottle of rum stashed in here too, but it's pretty obvious*" : sHasrum;
	sHasrum = (GetLocalInt(oPC, "BananaCrateShipped") == 1) ? "\n\n*My rum is gone!*" : sHasrum;
	SetCustomToken(1001, sBananas);
	SetCustomToken(1002, sHasrum);
	return 1;
}