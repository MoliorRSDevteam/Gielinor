// HAM Deacon

void main()
{
         object oNPC = OBJECT_SELF;
         string s;
         int c = GetLocalInt(oNPC, "Counter"); // read the counter

         switch(c) // display the corresponding line
         { 
                      case 0 : s = "That stone shipment should have arrived a week ago..."; break;
                      case 1 : s = "Its been a long day..."; break;
					  case 2 : s = "Lets get a move on boys, this wall isnt going to build itself!"; break;
					
         }

        c++; // increment counter
        if (c > 2) c = 0; // loop back when all lines exhausted
        SetLocalInt(oNPC, "Counter", c); // store the counter
		SpeakString(s);
        ExecuteScript("nw_c2_default1", oNPC); // execute NWN2 default script
        }