// =============================================================
//
//    File: row_mod_respawn
//    Desc: Rowell's Player Respawns Script
//  Author: Michael Marzilli
//    Site: http://www.engliton.org
//
// Created: Nov 06, 2006
// Updated: Nov 06, 2006
// Version: 1.0.0
//
//   Usage: Place this script in the OnPlayerRespawn Event in the Module
//
// =============================================================

#include "row_inc_functions"


void ApplyPenalty(object oDead) {
    int nXP   = GetXP(oDead);
    int nHD   = GetLevel(oDead);
	int nGold = GetGold(oDead);
    int nMin  = ((nHD * (nHD - 1)) / 2) * 1000;
	int nPenalty;
	int nGoldToTake;

	// CALCULATE XP CHANGE
	if (iDeathPenaltyXP > 0) {
		nPenalty = iDeathPenaltyXP * nHD;
	}
	if (fDeathPenaltyXP > 0.0) {
	    nPenalty = nXP - FloatToInt(fDeathPenaltyXP * IntToFloat(nXP - nMin)); 
	}
    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);

	
	// CALCULATE GP CHANGE
	if (iDeathPenaltyGP > 0) {
		nGoldToTake = iDeathPenaltyGP * nHD;
		if (nGoldToTake > nGold)
			nGoldToTake = nGold;
	}
	if (fDeathPenaltyGP > 0.0) {
	    nGoldToTake = FloatToInt(fDeathPenaltyGP * nGold);
	}
    // * a cap of 10 000gp taken from you
    if (nGoldToTake > 10000)
        nGoldToTake = 10000;
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));

	
    // MAKE NOTIFICATIONS AND SUCH	
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));

}


void main() {
	object oPC = GetLastRespawnButtonPresser();
	
	// THIS LINE IS TO HANDLE A BUG IN v1.0, v1.01, v1.02
	// WHERE THE OnPlayerRespawn EVENT WAS ONLY FIRING THE SCRIPT "gui_death_respawn_self"
	if (oPC == OBJECT_INVALID)
		oPC = GetLocalObject(GetModule(), "LAST_RESPAWN_BUTTON_PRESSER");
		
	// IF THE oPC OBJECT IS STILL INVALID, THEN  gui_death_respawn_self  IS NOT BEING CALLED FOR SOME REASON
	if (oPC == OBJECT_INVALID)
		return;
	
	if (!iNWNdebug)
		ApplyPenalty(oPC);
		
	Row_PlayerRaise(TRUE, oPC);

		
	// INSERT YOUR OWN CODE BELOW
	// ===================================================================================
	

}
 
 