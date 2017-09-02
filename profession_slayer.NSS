/*
	Script to be used in conversation for handling the slayer profession.
	sMONSTER: The tag of the monster for the slayer task.
	nQTY: How many sMONSTERs have to be killed for the task to be completed.
	nXP: How much XP the task grants when completed.
	NOTE: Set sMONSTER to "DELETE_EVERYTHING", if you wish to abandon current task.
*/

void main(string sMONSTER, int nQTY, int nXP)
{
	object oPC = GetPCSpeaker();
	object oESSENCE = GetItemPossessedBy(oPC, "player_essence");
	if (sMONSTER == "DELETE_EVERYTHING")
	{
		DeleteLocalInt(oESSENCE, "SLAYER_KILLS");
		DeleteLocalInt(oESSENCE, "SLAYER_TOTAL");
		DeleteLocalInt(oESSENCE, "SLAYER_EXP");
		DeleteLocalString(oESSENCE, "SLAYER_TAG");
		SendMessageToPC(oPC, "Slayer Task Abandoned.");
		return;
	}
	SetLocalString(oESSENCE, "SLAYER_TAG", sMONSTER);
	SetLocalInt(oESSENCE, "SLAYER_TOTAL", nQTY);
	SetLocalInt(oESSENCE, "SLAYER_EXP", nXP);
}