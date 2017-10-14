int StartingConditional(int itemid)
{
	return (GetLocalObject(GetPCSpeaker(), "invtoken"+IntToString(itemid)) != OBJECT_INVALID);
}