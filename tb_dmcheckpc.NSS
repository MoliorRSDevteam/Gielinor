int StartingConditional()
{
	object oPC = GetPCSpeaker();
	return (oPC == GetLocalObject(OBJECT_SELF, "myDM"));
}