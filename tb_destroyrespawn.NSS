// ga_destroy
/*
    @ Triston Barker
	@ tb_destroyWithRespawn(float delay = 5.0f)
	This script destroys an object and respawns after delay
	Calls another Script named 'respawn'
        fDelay      = The delay before respawning the object(s), default(5 seconds)
		
	NOTE: Make sure prefabs have a distinct ResRef
	NOTE: Won't work with creatures unless they can somehow provide parmeters
	
	Created 12/27/14
	Update 1: 
*/

void PrepForDestruction(object oTarget)
{
	SetPlotFlag(oTarget,FALSE);
    SetImmortal(oTarget,FALSE);
    AssignCommand(oTarget,SetIsDestroyable(TRUE,FALSE,FALSE));
}
// Destroy self object
void DestroyMe(object oObject)
{
	PrepForDestruction(oObject);
	DestroyObject (oObject);
}
void main(float delay)
{
		//GetObjectType(object oTarget);
	//set location
	SetLocalLocation(OBJECT_SELF,"LOC",GetLocation(OBJECT_SELF));
	//ondeath
	float fDelaySpawn = delay;//delay;
	fDelaySpawn = delay;
    object oMod = GetModule();
    int nDOA = GetLocalInt(oMod,"DOA")+1;
    SetLocalInt(oMod,"DOA",nDOA);
    SetLocalString(oMod,IntToString(nDOA)+"ResRef",GetResRef(OBJECT_SELF));
    SetLocalLocation(oMod,"Location",GetLocalLocation(OBJECT_SELF,"LOC"));
    SetLocalFloat(oMod,"Float",fDelaySpawn);
    //ExecuteScript("respawn",oMod);
	int objType = GetObjectType(OBJECT_SELF);
	SetLocalInt(oMod,"OBJ_TYPE",objType);
    DestroyMe(OBJECT_SELF);
	ExecuteScript("tb_respawn",oMod);
}