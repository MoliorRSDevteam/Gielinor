/* 
 *	duration - match with a duration or animation
 		5.0s -	(Meditate)
*/
object oPC = GetPCSpeaker();
void SetVisible()
{
	SetWeaponVisibility(oPC, 1);
}
void main(float duration)
{
	SetWeaponVisibility(oPC, 0);
	DelayCommand(duration, SetVisible());
}