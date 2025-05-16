version "4.14.1"

#include "bionaut-scripts/doctor.zs"
#include "bionaut-scripts/mana-weapon.zs"

class NewZombie : ZombieMan replaces ZombieMan {
    Default {
        Scale 0.25;
        Radius 5;
        Height 14;
        Speed 10;
        DropItem "Chainsaw";
    }
}

class NewChainsaw : Chainsaw replaces Chainsaw {
    default {
        Scale 2;
        Inventory.PickupMessage "Wowza yowza! A chainsaw!";
    }

    States {
        Fire:
            TNT1 A 0 A_Light2;
            SAWG AB 4 Bright A_Saw;
            SAWG B 0 A_ReFire;
            TNT1 A 0 A_Explode;
            Goto Ready;
    }
}

class CoolShotgun : Shotgun {
    default {
		Weapon.AmmoUse 0;
        Weapon.SlotNumber 3;
    }

    States {
        Fire:
            TNT1 A 0 Bright 
            {
                A_Recoil(0.5);
                vel.z += 0.75;
            }
            SHTG A 1 Bright A_FireShotgun;
            SHTG A 0 A_ReFire;
            Goto Ready;
    }
}