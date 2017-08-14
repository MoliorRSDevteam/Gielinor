void main()
{
	object oSOUND = OBJECT_SELF;
	string sSOUND = GetTag(oSOUND);
	int n2D = GetLocalInt(oSOUND, "2D");
	AssignCommand(oSOUND, ClearAllActions());
	AssignCommand(oSOUND, PlaySound(sSOUND, n2D));
	AssignCommand(oSOUND, SetIsDestroyable(TRUE, FALSE));
	DestroyObject(oSOUND, 0.5);
}