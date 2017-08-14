#include "leg_all_masterinclude"

//Database const
const int LOCKOUT_TIME = 600;//10 mins

void SaveDB(object oPC, int forcesave = 0);

void SaveDB(object oPC, int forcesave)
{
	//The time this player will have to wait before his skills can be updated
	/* So the player-server database transactions won't be taxing
	 * Concept: 50 people update every 5 seconds is 10 updates a second on average  WAY too much.
	  			So think of the number of players when considering time
	 * My standard: 255 players(assuming they're all skilling) are updating once every
	 				5 minutes. 255/300 seconds is .83 updates per second tops on a nwn2 server.
	 * Tested and Confirmed (12/4/2015)
	*/
	//Update the database every x-seconds (like tb_savexp)
	int updatetime = (forcesave == 0) ? LOCKOUT_TIME : 0; // # of seconds
	updatetime = updatetime/5; //legends timestamp is 5 seconds per tick
	int gametime = LEG_COMMON_TimeStamp();
	int accesstime = GetLocalInt(oPC, "TB_SkillSystem_dbaccesstime");
	if (gametime-accesstime >= updatetime)
	{
		DeleteLocalInt(oPC, "TB_SkillSystem_dbaccesstime");
	}
	if (GetLocalInt(oPC, "TB_SkillSystem_dbaccesstime") == 0)
	{
		//module saves info to database
		string sPlayerExitScript = GetLocalString(GetModule(), "LEG_CUSTOM_ONAREAEXIT");
		if (sPlayerExitScript != "")
		    ExecuteScript(sPlayerExitScript, oPC);
		
		//locks you out of the database for an amount of time
		
		SetLocalInt(oPC, "TB_SkillSystem_dbaccesstime", gametime);
	}
	else
	{
		
	}
}