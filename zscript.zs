version "4.14.1"

class NewZombie : ZombieMan replaces ZombieMan {
    Default {
        Scale 0.25;
        DropItem "Chainsaw";
        // Inventory.PickupMessage "Wowza yowza! A chainsaw!";
    }
}

class NewChainsaw : Chainsaw replaces Chainsaw {
    default {
        Scale 2;
    }
}

class NewShotgun : Shotgun replaces Shotgun {
    default {
		Weapon.AmmoUse 0;
    }

    States {
        Fire:
            SHTG A 3;
            SHTG A 7 A_FireShotgun;
            // SHTG BC 5;
            // SHTG D 4;
            // SHTG CB 5;
            // SHTG A 3;
            SHTG A 7 A_ReFire;
            Goto Ready;
    }
}