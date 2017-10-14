// tb_give_xp based on ga_give_xp
/*
    This gives the player some experience in runescape skills
		nXP     = The amount of experience given to the PC
        skill	= The skill to apply the xp to listed below
			0 = "fishing",
			1 = "cooking"
			2 = "firemaking" 
			3 = "woodcutting"
			4 = "mining" 
			5 = "smithing"
			6 = "prayer" 
			7 = "runecrafting"
			8 = "crafting"
			9 = "fletching"
        bAllPartyMembers = If set to 1 it gives XP to all the PCs in the party (MP only)
*/
// FAB 9/30
// MDiekmann 4/9/07 -- using GetFirst and NextFactionMember() instead of GetFirst and NextPC(), changed nAllPCs to bAllPartyMembers

#include "tb_skillsandxp"

void main(int nXP, int skill, int bAllPartyMembers = 0)
{
	string skillname = "fishing";
	switch (skill)
	{
		case 0:
	    	skillname = "fishing";
			break;
		case 1:
	    	skillname = "cooking";
			break;
		case 2:
	    	skillname = "firemaking";
			break;
		case 3:
	    	skillname = "woodcutting";
			break;
		case 4:
	    	skillname = "mining";
			break;
		case 5:
	    	skillname = "smithing";
			break;
		case 6:
	    	skillname = "prayer";
			break;
		case 7:
	    	skillname = "runecrafting";
			break;
		case 8:
	    	skillname = "crafting";
			break;
		case 9:
	    	skillname = "fletching";
			break;
		case 10:
	    	skillname = "farming";
			break;
		case 11:
	    	skillname = "herblore";
			break;
		case 12:
	    	skillname = "thieving";
			break;
		case 13:
	    	skillname = "hunter";
			break;
		case 14:
	    	skillname = "construction";
			break;
	}
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
    if ( bAllPartyMembers == 0 ) GiveXP(oPC, skillname, nXP );
    else
    {
        object oTarg = GetFirstFactionMember(oPC);
        while(GetIsObjectValid(oTarg))
        {
            GiveXP( oTarg, skillname, nXP );
            oTarg = GetNextFactionMember(oPC);
        }
    }
}