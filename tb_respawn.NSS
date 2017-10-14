void ActionCreateSpawn(int objType, string sCreature, location lLoc)
{
	//objType = (objType == 0) ? OBJECT_TYPE_CREATURE : objType;
	CreateObject(objType, sCreature, lLoc);
}
void main()
{//int objType, string tag, float delay
	object oMod = GetModule();
    int nDOA = GetLocalInt(oMod,"DOA");
    location lLoc = GetLocalLocation(oMod,"Location");
    float fDelay = GetLocalFloat(oMod,"Float");
    int objType = GetLocalInt(oMod,"OBJ_TYPE");
    DelayCommand(fDelay,ActionCreateSpawn(objType, GetLocalString(oMod,IntToString(nDOA)+"ResRef"),lLoc));
	//ClearAll(oMod);
}