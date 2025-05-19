class BionautFireball : Actor
{
 Default
 {
   Radius 6;
   Height 8;
   Speed 10;
   FastSpeed 20;
   Damage 3;
   Projectile;
   +RANDOMIZE
   +RIPPER
   SeeSound "imp/attack";
   DeathSound "imp/shotx";
 }
 States
 {
 Spawn:
   FIRE AB 4 BRIGHT;
   Loop;
 Death:
   FIRE CDE 6 BRIGHT;
   Stop;
 }
}

class FlameWisp : Actor {
    Default
    {
        Radius 6;
        Height 8;
        Speed 5;
        FastSpeed 10;
        Damage 1;
        Projectile;
        +RANDOMIZE
        +RIPPER
        SeeSound "imp/attack";
        //DeathSound "imp/shotx";
    }
    States
    {
    Spawn:
        PUFF AB 4 BRIGHT;
        Loop;
    Death:
        PUFF CD 6 BRIGHT;
        Stop;
    }
}