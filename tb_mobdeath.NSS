//called from deathscript
#include "tb_quest_progressquest"

void main()
{
	object oPC = GetLastKiller();
	object oTarget = OBJECT_SELF;
	
	//objectives
	
	//SendMessageToPC(oPC, "sending "+ GetTag(OBJECT_SELF) + " to "+ GetName(oPC));
	ProgressObjectiveAll(oPC, "killcreature", GetTag(OBJECT_SELF));
	
	//for quest bosses
	string questTag = GetLocalString(oTarget, "questtag");
	if (questTag != "")// && GetLocalInt(oPC, questTag) == questInt
	{
		string feedback;
		int qUp;
		if (questTag == VAMPIRE_SLAYER_TAG){qUp=-2;}
		if (questTag == DEMON_SLAYER_TAG){qUp=-2;}
		if (qUp == 1) {AssignCommand(oPC, ProgressQuest(oPC, questTag));}
		if (qUp == -2){AssignCommand(oPC, FinishQuest(oPC, questTag));}
		LEG_COMMON_DisplayInfoBox(oPC, feedback);
	}
}