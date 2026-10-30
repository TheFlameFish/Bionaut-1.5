class LaundryMachine:Actor
{
    Default
    {
        Health 100;
        Radius 20;
        Height 50;
        Speed 12;
        Monster;

        BounceType "Grenade";
    }
    States
    {
        Spawn:
            TROO AB 10 A_lookEx(label: "Awaken");
            loop;
        Awaken:
            TROO A 50 A_StartSound("LaundryAlarm");
            goto Rush;
        Rush:
            TROO A 1 A_LaundryRush(20);
            goto Chase;
        Chase:
            TROO AB 1 A_CheckFloor("Rush");
            TNT1 A 0 A_LaundryCheckhit();
            Loop;
        Hit:
            TNT1 A 0 A_DamageTarget(25);
            TNT1 A 0 A_LaundryRush(-15);
            TROO A 30;
            goto Chase;

    }
        
    virtual void A_LaundryRush(Double Speed) 
    {
		Vector3 dir = (target.pos - self.pos).Unit();
        self.vel = dir*Speed;
        self.vel.z += 5;
        a_facetarget();
	}
    
    Virtual void A_LaundryCheckhit()
    {
        Console.Printf("%d",Distance3D(target)<= 128);
        if (Distance3D(target) <= 128)
        {
            SetState(FindState("Hit"));
        }
    }
}