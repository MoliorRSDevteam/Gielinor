/*
	- ** will match zero or more characters
	- *w one or more whitespace
	- *n one or more numeric
	- *p one or more punctuation
	- *a one or more alphabetic
	- | is or
	- ( and ) can be used for blocks
	
	- setting a creature to listen for "**" will match any string
	- telling him to listen for "**funk**" will match any string that contains the word "funk".
	- "**(bash|open|unlock)**(chest|door)**" will match strings like "open the door please" or "he just bashed that chest!" 
*/
void main(string pattern)
{
    // Set the npc to listen
    DeleteLocalString(OBJECT_SELF, GetName(GetPCSpeaker())+"message");
	SetListening(OBJECT_SELF, TRUE);
    SetListenPattern(OBJECT_SELF, pattern, 1); //i.e. "*n"
}