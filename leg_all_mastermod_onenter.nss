void main()
{
	// Grab the PC
	object oPC = GetEnteringObject();

	// Player has logged in.  Run the quest LOGIN script.
	if (GetLocalInt(GetModule(), "LEG_QUEST_ACTIVE"))
		ExecuteScript("leg_quest_loggedin", oPC);
	

}