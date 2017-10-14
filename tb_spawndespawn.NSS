/*
__called from below__
leg_all_mastermod_itemunacquire
tb_firemaking (ashes)
*/

#include "ginc_param_const"
/*
	ref = template_resref of the item
	loc = location to spawn
*/

const int DEFAULT_DESPAWN_TIME = 300;//10; //10 seconds

void Spawn(string ref, location loc, int despawntime = DEFAULT_DESPAWN_TIME);
void Despawn(object oItem, int despawntime = DEFAULT_DESPAWN_TIME);
void LoopDespawn(object oItem, int despawntime);
void Spawn(string ref, location loc, int despawntime)
{
	object item = CreateObject(GetObjectTypes("I"), ref, loc);
	Despawn(item, despawntime);
}
void Despawn(object oItem, int despawntime)
{
	SetLocalInt(oItem, "despawning", TRUE);
	LoopDespawn(oItem, despawntime);
}
void LoopDespawn(object oItem, int despawntime)
{
	int step = 1;
	if (GetLocalInt(oItem, "despawning") == TRUE)
	{
		if (despawntime <= 0)
		{
			DestroyObject(oItem);
		}
		DelayCommand(IntToFloat(step), LoopDespawn(oItem, despawntime-step));
	}
}