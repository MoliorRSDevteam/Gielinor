void main(int tokenVal)
{
	object oPC = GetPCSpeaker();
	//DeleteLocalObject(oPC, "invtoken"+IntToString(1001));
	object oItem = GetLocalObject(oPC, "invtoken"+IntToString(tokenVal));
	//SendMessageToPC(oPC, "fired");
	//SendMessageToPC(oPC, "token " + GetName(GetLocalObject(oPC, "invtoken"+IntToString(tokenVal))));
	SetLocalInt(oPC, "customtoken", tokenVal);
	SetCustomToken(1001, GetName(oItem));
}