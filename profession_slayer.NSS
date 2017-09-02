/*
	Script to be used in conversation for handling the slayer profession.
	sMONSTER: The tag of the monster for the slayer task.
	nQTY: How many sMONSTERs have to be killed for the task to be completed.
	nXP: How much XP the task grants when completed.
*/

void main(string sMONSTER, int nQTY, int nXP)
{
	object oPC = GetPCSpeaker();
	object oESSENCE = GetItemPossessedBy(oPC, "player_essence");
	SetLocalString(oESSENCE, "SLAYER_TAG", sMONSTER);
	SetLocalInt(oESSENCE, "SLAYER_TOTAL", nQTY);
	SetLocalInt(oESSENCE, "SLAYER_EXP", nXP);
}