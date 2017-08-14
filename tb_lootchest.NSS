void main()
{
	object oPC = GetLastOpenedBy();
	CreateItemOnObject(GetLocalString(OBJECT_SELF, "loot"), oPC);
}