#include "tb_persistents"
int StartingConditional(string sQuestID, string sTarget = "$PC")
{
    object oTarg = GetTarget(sTarget, TARGET_OBJECT_SELF);
	return TBGetPersistentInt(oTarg, "QuestID_" + sQuestID + "_NPC", 1);
}