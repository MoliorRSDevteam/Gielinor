object oPC = GetPCSpeaker();
void CountDown(int count)
{
	int targetsdone = (GetLocalInt(oPC, "RTCtarg1") == 1 && GetLocalInt(oPC, "RTCtarg2") == 1 && GetLocalInt(oPC, "RTCtarg3") == 1 && GetLocalInt(oPC, "RTCtarg4") == 1);
	if (targetsdone)
	{
		SendMessageToPC(oPC, "All targets cleared!");
		SetLocalInt(oPC, "rangertimechallenge", 3); //won
		//clear targets hit
		SetLocalInt(oPC, "RTCtarg1", 0);
		SetLocalInt(oPC, "RTCtarg2", 0);
		SetLocalInt(oPC, "RTCtarg3", 0);
		SetLocalInt(oPC, "RTCtarg4", 0);
		SpeakString("Hey, not bad!");
		return;
	}
	if (count <= 0)
	{
		SendMessageToPC(oPC, "Times up!");
		//evaluate results
		if (!targetsdone)
		{
			SetLocalInt(oPC, "rangertimechallenge", 2); //lost
		}
		//clear targets hit
		SetLocalInt(oPC, "RTCtarg1", 0);
		SetLocalInt(oPC, "RTCtarg2", 0);
		SetLocalInt(oPC, "RTCtarg3", 0);
		SetLocalInt(oPC, "RTCtarg4", 0);
		SpeakString("Ah, tough luck!");
		return; //ends countdown
	}
	//continues countdown
	SendMessageToPC(oPC, "Countdown: " + IntToString(count));
	DelayCommand(1.0, CountDown(count-1));
}
void main()
{
	if(GetLocalInt(oPC, "rangertimechallenge") != 0)
		return;
	
	CreateItemOnObject("longbow", oPC, 1);
	CreateItemOnObject("bronzearrow", oPC, 20);
	CreateItemOnObject("bronzelongsword", oPC, 1);
	CreateItemOnObject("bronzelongsword", oPC, 1);
		
	SendMessageToPC(oPC, "Hit all three targets...");
	SendMessageToPC(oPC, "NPCx bet against you."); //when npcs are added do this kinda stuff
	DelayCommand(0.3, SpeakString("Ready..."));
	DelayCommand(1.2, SpeakString("Set.."));
	DelayCommand(2.1, SpeakString("Go!"));
	DelayCommand(3.0, CountDown(30));
}