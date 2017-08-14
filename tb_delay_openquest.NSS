/*@Triston
	makes pc uncommandable then opens leg quest
*/

object oPC = GetPCSpeaker();
void FireQuest()
{
	SetCommandable(1, oPC);
	ExecuteScript("leg_quest_openquest", OBJECT_SELF);
}
void main()
{
	float delay = 0.6f;
	SetCommandable(0, oPC);
	DelayCommand(delay, FireQuest());
}