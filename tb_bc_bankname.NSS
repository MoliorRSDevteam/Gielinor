int StartingConditional()
{
	string bankname = GetLocalString(OBJECT_SELF, "bankname");
	bankname = (bankname == "") ? "Bank of MoliorRS" : bankname;
	SetCustomToken(1001, bankname);
	return 1;
}