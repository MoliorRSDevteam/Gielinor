void main()
{
	if (GetLocalInt(OBJECT_SELF, "EXTINCT") == FALSE) DisplayGuiScreen(GetLastUsedBy(), "OVENMENU", FALSE, "ovenorfire.xml");
}