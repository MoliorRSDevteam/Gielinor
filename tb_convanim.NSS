//tb_anims
/*

*/


void ReallyPlayCustomAnimation(object oObject, string sAnimationName, int nLooping, float fSpeed = 1.0f)
{
	PlayAnimation(0, 1.0f, 0.01f);
 	PlayCustomAnimation(oObject, sAnimationName, nLooping, fSpeed);
}

void main(string anim)
{
	object oPC = GetPCSpeaker();
	DelayCommand(0.2f, AssignCommand(oPC, ReallyPlayCustomAnimation(oPC, anim, 0)));
}