void main()
{
	if (GetLocalInt(OBJECT_SELF, "EXTINCT") == FALSE) BeginConversation("conv_cooking", GetLastUsedBy(), TRUE);
}