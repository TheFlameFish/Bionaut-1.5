class BionautFireball : Actor
{
 Default
 {
   Radius 6;
   Height 8;
   Speed 10;
   FastSpeed 20;
   Damage 2;
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
    int life;

    Default
    {
        Radius 6;
        Height 8;
        Speed 5;
        FastSpeed 10;
        DamageFunction clamp(Random(-3,1), 0, 1);
        Projectile;
        +RANDOMIZE
        +RIPPER
        SeeSound "imp/attack";
        //DeathSound "imp/shotx";
    }

    States
    {
    Spawn:
        PUFF AB 4 BRIGHT {
          life++;
          if (life > 15) {
            return ResolveState("Death");
          }
          return ResolveState(null);
        }
        Loop;
    Death:
        PUFF CD 6 BRIGHT;
        Stop;
    }
}